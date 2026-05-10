const RECONNECT_DELAY = 5000;   // Initial delay between reconnect attempts (ms)
const MAX_RECONNECT_DELAY = 30000;  // Maximum backoff ceiling (ms)
const CONNECTION_TIMEOUT = 10000;  // Time to wait for onopen before forcing retry (ms)
let CONNECTION_STRING;
let PROXY_TARGET = 'http://127.0.0.1:30120';
const DEBUG_MODE = GetConvar('reaper_ws_debug', 'false') === 'true';

// Supported event names for the listener API
const EVENTS = ['connect', 'error', 'close', 'message', 'reconnect_attempt'];

/**
 * Creates a new WebSocket proxy instance with its own connection state,
 * reconnection logic, and event listener registry.
 *
 * @returns {{ on, off, connect, disconnect, setSession, isConnected }}
 */
const createProxy = () => {
    // Connection State
    let ws = null;
    let reconnectDelay = RECONNECT_DELAY;
    let reconnectTimeout = null;
    let connectionTimeout = null;
    let connected = false;
    let sessionId = null;
    let reconnectAttempts = 0;

    // Event Listener Registry
    const listeners = Object.fromEntries(EVENTS.map(e => [e, []]));

    // Logging Helpers
    const log = (...args) => { if (DEBUG_MODE) console.log(`[WS Proxy]`, ...args); };
    const logError = (...args) => console.error(`[WS Proxy]`, ...args);

    // Event Emitter

    /**
     * Dispatches an event to all registered listeners.
     * Errors thrown inside a listener are caught and logged so they never
     * disrupt the proxy or other listeners.
     */
    const emit = (event, ...args) => {
        for (const cb of listeners[event]) {
            try {
                cb(...args);
            } catch (err) {
                logError(`Listener threw on "${event}":`, err.message || err);
            }
        }
    };

    /**
     * Registers a listener for the given event.
     * @param {'connect'|'error'|'close'|'message'} event
     * @param {Function} callback
     */
    const on = (event, callback) => {
        if (!listeners[event]) {
            logError(`on() called with unknown event "${event}". Valid events: ${EVENTS.join(', ')}`);
            return;
        }

        if (typeof callback !== 'function') {
            logError(`on() expects a function, received ${typeof callback}`);
            return;
        }

        listeners[event].push(callback);
    };

    /**
     * Removes a previously registered listener.
     * @param {'connect'|'error'|'close'|'message'} event
     * @param {Function} callback  — Must be the same reference passed to on().
     */
    const off = (event, callback) => {
        if (!listeners[event]) return;
        listeners[event] = listeners[event].filter(cb => cb !== callback);
    };

    // Internal Helpers
    // Clears any pending timers and resets connection state.
    const cleanup = () => {
        if (connectionTimeout) {
            clearTimeout(connectionTimeout);
            connectionTimeout = null;
        }

        connected = false;
        ws = null;
    };

    // Schedules a reconnection attempt
    const scheduleReconnect = () => {
        if (reconnectTimeout) return;

        reconnectAttempts++;
        log(`Reconnecting in ${reconnectDelay / 1000}s... (attempt ${reconnectAttempts})`);
        emit('reconnect_attempt', { attempt: reconnectAttempts, delay: reconnectDelay });

        reconnectTimeout = setTimeout(() => {
            reconnectTimeout = null;
            connect();
        }, reconnectDelay);

        // Exponential backoff capped at MAX_RECONNECT_DELAY
        reconnectDelay = Math.min(reconnectDelay * 2, MAX_RECONNECT_DELAY);
    };

    // Connection
    // Opens a new WebSocket connection, tearing down any existing one first.
    const connect = () => {
        cleanup();

        const url = `${CONNECTION_STRING}?session=${sessionId || ''}`;
        log(`Connecting to ${url}`);

        try {
            ws = new WebSocket(url);
        } catch (err) {
            logError('Failed to create WebSocket:', err.message || err);
            scheduleReconnect();
            return;
        }

        // Capture reference so stale socket events are ignored
        const socket = ws;
        const isStale = () => socket !== ws;

        // Safety net — force a retry if onopen never fires
        connectionTimeout = setTimeout(() => {
            if (!isStale() && !connected) {
                logError('Connection timed out');
                try { socket.close(); } catch (_) { /* socket may already be dead */ }
                cleanup();
                scheduleReconnect();
            }
        }, CONNECTION_TIMEOUT);

        // Socket Event Handlers
        socket.onopen = () => {
            if (isStale()) return;

            connected = true;

            if (connectionTimeout) {
                clearTimeout(connectionTimeout);
                connectionTimeout = null;
            }

            log('Connection established');

            reconnectDelay = RECONNECT_DELAY;
            reconnectAttempts = 0;
            emit('connect');
        };

        socket.onmessage = async (event) => {
            if (isStale()) return;

            let request;

            try {
                request = JSON.parse(event.data);
            } catch (err) {
                logError('Failed to parse incoming message:', err.message);
                return;
            }

            log(`Request: ${request.method} ${request.url}`);

            try {
                // Merge incoming headers with the original client IP
                const headers = { ...request.headers };
                if (request.ip) headers['X-Forwarded-For'] = request.ip;

                const response = await fetch(`${PROXY_TARGET}/ReaperV4${request.url}`, {
                    method: request.method,
                    headers: headers,
                    body: request.body != null
                        ? (typeof request.body === 'string' ? request.body : JSON.stringify(request.body))
                        : undefined
                });

                const body = await response.text();

                // Check again after async — socket may have been replaced during fetch
                if (isStale()) return;

                socket.send(JSON.stringify({
                    requestId: request.requestId,
                    status: response.status,
                    headers: response.headers,
                    body
                }));

                log(`Response: ${response.status} for ${request.url}`);
            } catch (err) {
                logError(`Proxy request failed for ${request.method} ${request.url}:`, err.message);
            }

            emit('message', event);
        };

        socket.onerror = (error) => {
            if (isStale()) return;
            log('Connection error:', error.message || error);
            emit('error', error);
            cleanup();
            scheduleReconnect();
        };

        socket.onclose = () => {
            if (isStale()) return;
            log('Connection closed');
            emit('close');
            cleanup();
            scheduleReconnect();
        };
    };

    // Use this for a clean shutdown — the proxy will NOT attempt to reconnect.
    const disconnect = () => {
        if (reconnectTimeout) {
            clearTimeout(reconnectTimeout);
            reconnectTimeout = null;
        }

        if (ws) {
            try { ws.close(); } catch (_) { /* ignore */ }
        }

        cleanup();
        log('Disconnected');
    };

    // Reconnects only if the socket is not currently connected.
    const reconnect = () => {
        if (connected) return;
        disconnect();
        reconnectDelay = RECONNECT_DELAY;
        reconnectAttempts = 0;
        connect();
    };

    // Public API
    const setSession = (id) => { sessionId = id; };
    const setConnectionString = (url) => { CONNECTION_STRING = url; };
    const setProxyTarget = (url) => { PROXY_TARGET = url; };
    const isConnected = () => connected;

    return { on, off, connect, disconnect, reconnect, setSession, setConnectionString, setProxyTarget, isConnected };
};

// Register exports
exports("SetupProxy", (settings) => {
    // Only the owning resource may create a proxy
    if (GetInvokingResource() !== GetCurrentResourceName()) return 0;
    return createProxy();
});
