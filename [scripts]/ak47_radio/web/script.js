const resourceName = window.GetParentResourceName ? window.GetParentResourceName() : 'ak47_radio';
let translations = {}; // Global object to store translations

// Function to send data to the Lua client script
async function sendNuiMessage(action, data = {}) {
    try {
        await fetch(`https://${resourceName}/${action}`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json; charset=UTF-8' },
            body: JSON.stringify(data)
        });
    } catch (e) {
        // This can be ignored, as it will error in a browser
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const radioState = {
        power: true,
        volume: 75,
        currentChannel: null,
        talkingPlayers: new Set(),
        favorites: [],
        recents: [],
        settings: {
            draggable: false,
            showPlayerList: true,
            uiZoom: 110,
            playerListZoom: 100,
            clickSound: true,
            uiVolume: 1.0,
            lastChannel: null,
            positions: {
                radio: null,
                playerList: null,
            },
            animationIndex: 1,
        }
    };
    var audioPlayer = null;

    // --- Elements ---
    const radioWrapper = document.getElementById('draggable-radio-wrapper');
    const playerListCard = document.getElementById('player-list-card');
    const playerListEl = document.getElementById('player-list');
    const views = document.querySelectorAll('#views-container > div');
    const navButtons = document.querySelectorAll('.nav-btn');
    const currentFrequencyEl = document.getElementById('current-frequency');
    const connectionStatusEl = document.getElementById('connection-status');
    const powerBtn = document.getElementById('power-btn');
    const volumeSlider = document.getElementById('volume-slider');
    const disconnectBtn = document.getElementById('disconnect-btn');
    const dialInput = document.getElementById('dial-input');
    const dialPad = document.querySelector('#dial-pad-view .grid');
    const dialBackspace = document.getElementById('dial-backspace');
    const dialConnect = document.getElementById('dial-connect');
    const dialSave = document.getElementById('dial-save');
    const favoritesListEl = document.getElementById('favorites-list');
    const recentsListEl = document.getElementById('recents-list');
    const dragToggle = document.getElementById('drag-ui');
    const showPlayerListToggle = document.getElementById('show-playerlist');
    const uiZoomSlider = document.getElementById('ui-zoom');
    const playerListZoomSlider = document.getElementById('playerlist-zoom');
    const uiVolumeSlider = document.getElementById('ui-volume');
    const animSelect = document.getElementById('anim-select');
    const clickSoundToggle = document.getElementById('click-sound');
    
    // Callsign elements
    const callsignContainer = document.getElementById('callsign-container');
    const callsignInput = document.getElementById('callsign-input');
    const saveCallsignBtn = document.getElementById('save-callsign');

    // --- Animation & Position Functions ---

    function updateRadioTransform(isClosing = false) {
        const settings = radioState.settings;
        const scale = settings.uiZoom / 100;
        
        // Apply a centering transform only if the position is the default 50%/50% and not a custom one.
        const isDefaultCenter = radioState.settings.positions?.radio?.top === '50%' && radioState.settings.positions?.radio?.left === '50%';
        const centeringTransform = isDefaultCenter ? 'translate(-50%, -50%)' : '';

        const verticalTransform = isClosing ? 'translateY(100vh)' : 'translateY(0)';
        
        radioWrapper.style.transform = `${centeringTransform} ${verticalTransform} scale(${scale})`;
    }

    function openRadio() {
        // Apply positions from the state (which are merged from cache/config)
        if (radioState.settings.positions?.radio) {
            Object.assign(radioWrapper.style, radioState.settings.positions.radio);
        }
        if (radioState.settings.positions?.playerList) {
            // Clear conflicting properties before assigning new ones
            playerListCard.style.left = '';
            playerListCard.style.bottom = '';
            Object.assign(playerListCard.style, radioState.settings.positions.playerList);
        }

        radioWrapper.style.display = 'block';
        updateRadioTransform(true);
        radioWrapper.style.opacity = '0';
        
        void radioWrapper.offsetWidth;

        requestAnimationFrame(() => {
            updateRadioTransform(false);
            radioWrapper.style.opacity = radioState.power ? '1' : '0.5';
        });
    }

    function closeRadio() {
        updateRadioTransform(true);
        radioWrapper.style.opacity = '0';
        
        setTimeout(() => {
            radioWrapper.style.display = 'none';
        }, 400);
    }
    
    // --- NUI Message Listener ---
    window.addEventListener('message', (event) => {
        const { action, ...data } = event.data;

        if (event.data.type === 'playSound') {
            if (event.data.audioname === 'click' && !radioState.settings.clickSound) {
                return;
            }
            if (audioPlayer != null) {
                audioPlayer.pause();
            }
            audioPlayer = new Howl({src: ["audio/" + event.data.audioname + ".ogg"]});
            audioPlayer.volume(radioState.settings.uiVolume);
            audioPlayer.play();
            return;
        }

        switch (action) {
            case 'open':
                let baseSettings = data.defaultSettings || radioState.settings;
                const savedSettings = localStorage.getItem('ak47_radio-settings');
                if (savedSettings) {
                    const parsed = JSON.parse(savedSettings);
                    radioState.settings = { 
                        ...baseSettings, 
                        ...parsed, 
                        positions: { ...baseSettings.positions, ...parsed.positions }
                    };
                } else {
                    radioState.settings = baseSettings;
                }

                if (data.translations) {
                    translations = data.translations;
                    applyTranslations();
                }
                
                if (data.volume !== undefined) {
                    radioState.volume = data.volume;
                }

                if (data.animations) {
                    animSelect.innerHTML = '';
                    data.animations.forEach((anim, index) => {
                        const option = document.createElement('option');
                        option.value = index + 1;
                        option.textContent = anim.label;
                        if ((radioState.settings.animationIndex || 1) == (index + 1)) {
                            option.selected = true;
                        }
                        animSelect.appendChild(option);
                    });
                }

                // Handle callsign logic
                if (data.canChangeCallsign) {
                    callsignContainer.classList.remove('hidden-view');
                    callsignContainer.style.display = 'flex';
                    callsignInput.value = data.callsign || '';
                } else {
                    callsignContainer.classList.add('hidden-view');
                    callsignContainer.style.display = 'none';
                }
              
                openRadio();
                updateUI();

                sendNuiMessage('setAnimation', { index: radioState.settings.animationIndex });
                break;
            case 'close':
                closeRadio();
                break;
            case 'updateChannel':
                radioState.currentChannel = data.channel;
                updateUI();
                if (data.connected && data.channel) {
                    radioState.settings.lastChannel = data.channel;
                    saveSettings();
                    addRecent(data.channel);
                    renderRecents();
                }
                break;
            case 'joinFailed':
                dialInput.value = '';
                break;
            case 'updatePlayerList':
                updatePlayerList(data.players);
                break;
            case 'playerTalking':
                handlePlayerTalking(data.id, data.isTalking);
                break;
            case 'clearLastChannel':
                radioState.settings.lastChannel = null;
                saveSettings();
                break;
            // New case to handle resetting the radio cache
            case 'resetCache':
                localStorage.removeItem('ak47_radio-settings');
                localStorage.removeItem('ak47_radio-favorites');
                localStorage.removeItem('ak47_radio-recents');
                // Close the radio if it's open to apply changes on next open
                if (radioWrapper.style.display !== 'none') {
                    closeRadio();
                }
                break;
        }
    });

    // --- UI Update Functions ---
    function updatePlayerList(players) {
        if (!playerListEl) return;
        playerListEl.innerHTML = ''; 

        if (players && players.length > 0) {
            players.forEach(player => {
                const isTalking = radioState.talkingPlayers.has(player.id);
                const micColor = isTalking ? 'text-green-400' : 'text-white';
                const nameColor = isTalking ? 'text-green-400' : 'text-white';
                const talkingClass = isTalking ? ' talking' : '';
                const playerHtml = `
                    <div class="player-item flex items-center space-x-3${talkingClass}" data-player-id="${player.id}">
                        <i class="ph-fill ph-microphone text-xl ${micColor}"></i>
                        <span class="font-medium ${nameColor} player-name">${player.name}</span>
                    </div>`;
                playerListEl.innerHTML += playerHtml;
            });
        } else {
            playerListEl.innerHTML = `<p class="text-gray-400 text-sm">${translations.ui_channel_empty || 'Channel is empty.'}</p>`;
        }
    }

    function handlePlayerTalking(id, isTalking) {
        const playerItem = document.querySelector(`.player-item[data-player-id="${id}"]`);
        if (!playerItem) return;

        const micIcon = playerItem.querySelector('i');
        const playerNameEl = playerItem.querySelector('.player-name');

        if (isTalking) {
            radioState.talkingPlayers.add(id);
            playerItem.classList.add('talking');
            if(micIcon) {
                micIcon.classList.remove('text-white');
                micIcon.classList.add('text-green-400');
            }
            if(playerNameEl) {
                playerNameEl.classList.remove('text-white');
                playerNameEl.classList.add('text-green-400');
            }
        } else {
            radioState.talkingPlayers.delete(id);
            playerItem.classList.remove('talking');
            if(micIcon) {
                micIcon.classList.remove('text-green-400');
                micIcon.classList.add('text-white');
            }
            if(playerNameEl) {
                playerNameEl.classList.remove('text-green-400');
                playerNameEl.classList.add('text-white');
            }
        }
    }

    function updateUI() {
        radioWrapper.style.opacity = radioState.power ? '1' : '0.5';

        const screenElements = radioWrapper.querySelectorAll('button, input, .slider');
        screenElements.forEach(el => {
            if (el.id !== 'power-btn') el.disabled = !radioState.power;
        });

        if (radioState.power) {
            powerBtn.classList.add('bg-green-500', 'hover:bg-green-600');
            powerBtn.classList.remove('bg-gray-600', 'hover:bg-gray-700');
        } else {
            powerBtn.classList.remove('bg-green-500', 'hover:bg-green-600');
            powerBtn.classList.add('bg-gray-600', 'hover:bg-gray-700');
        }

        currentFrequencyEl.textContent = radioState.currentChannel || '----';
        if (radioState.currentChannel) {
            connectionStatusEl.textContent = translations.ui_connected || 'Connected';
            connectionStatusEl.classList.remove('text-red-400');
            connectionStatusEl.classList.add('text-green-400');
            disconnectBtn.disabled = false;
            disconnectBtn.classList.remove('opacity-50', 'cursor-not-allowed');
        } else {
            radioState.talkingPlayers.clear();
            connectionStatusEl.textContent = translations.ui_disconnected || 'Disconnected';
            connectionStatusEl.classList.remove('text-green-400');
            connectionStatusEl.classList.add('text-red-400');
            disconnectBtn.disabled = true;
            disconnectBtn.classList.add('opacity-50', 'cursor-not-allowed');
        }
        volumeSlider.value = radioState.volume;
        
        dragToggle.checked = radioState.settings.draggable;
        showPlayerListToggle.checked = radioState.settings.showPlayerList;
        playerListCard.style.display = radioState.settings.showPlayerList && radioState.currentChannel ? 'block' : 'none';
        
        uiZoomSlider.value = radioState.settings.uiZoom;
        playerListZoomSlider.value = radioState.settings.playerListZoom;
        updateRadioTransform();
        playerListCard.style.transform = `scale(${radioState.settings.playerListZoom / 100})`;

        // Update new settings UI
        clickSoundToggle.checked = radioState.settings.clickSound;
        uiVolumeSlider.value = radioState.settings.uiVolume * 100;
    }

    // --- Translation Function ---
    function applyTranslations() {
        if (!translations || Object.keys(translations).length === 0) return;
        document.querySelectorAll('[data-translate]').forEach(element => {
            const key = element.getAttribute('data-translate');
            if (translations[key]) {
                element.textContent = translations[key];
            }
        });
    }

    // --- Settings & Cache Persistence ---
    function saveSettings() {
        localStorage.setItem('ak47_radio-settings', JSON.stringify(radioState.settings));
    }

    function saveFavorites() {
        localStorage.setItem('ak47_radio-favorites', JSON.stringify(radioState.favorites));
    }

    function loadFavorites() {
        const saved = localStorage.getItem('ak47_radio-favorites');
        if (saved) {
            radioState.favorites = JSON.parse(saved);
        }
    }

    function saveRecents() {
        localStorage.setItem('ak47_radio-recents', JSON.stringify(radioState.recents));
    }
    
    function loadRecents() {
        const saved = localStorage.getItem('ak47_radio-recents');
        if (saved) {
            radioState.recents = JSON.parse(saved);
        }
    }
    
    // --- Event Listeners Setup ---
    function setupEventListeners() {
        navButtons.forEach(btn => {
            btn.addEventListener('click', () => {
                const viewId = btn.dataset.view;
                switchView(viewId);
                navButtons.forEach(b => b.classList.remove('active'));
                btn.classList.add('active');
            });
        });
        
        powerBtn.addEventListener('click', () => {
            radioState.power = !radioState.power;
            
            if (radioState.power) {
                sendNuiMessage('powerOn');
            } else {
                sendNuiMessage('powerOff');
            }
            
            if (!radioState.power && radioState.currentChannel) {
                sendNuiMessage('leaveChannel');
            } else if (radioState.power && radioState.settings.lastChannel) {
                sendNuiMessage('joinChannel', { channel: radioState.settings.lastChannel });
            }

            updateUI();
        });

        disconnectBtn.addEventListener('click', () => {
            if (radioState.currentChannel) {
                sendNuiMessage('leaveChannel');
                // Clear the last channel when using the disconnect button
                radioState.settings.lastChannel = null;
                saveSettings();
            }
        });
        
        // --- MODIFICATION START: Add event listener for the volume slider ---
        volumeSlider.addEventListener('input', (e) => {
            const volumeValue = parseInt(e.target.value);
            radioState.volume = volumeValue;
            sendNuiMessage('setVolume', { volume: volumeValue });
        });
        // --- MODIFICATION END ---

        dialPad.addEventListener('click', (e) => {
            if (e.target.matches('.dial-pad-btn') && e.target.dataset.key) {
                handleDialKeyPress(e.target.dataset.key);
            }
        });
        dialBackspace.addEventListener('click', () => {
            dialInput.value = dialInput.value.slice(0, -1);
        });
        dialConnect.addEventListener('click', connectToChannel);
        dialSave.addEventListener('click', saveToFavorites);
        dragToggle.addEventListener('change', (e) => {
            radioState.settings.draggable = e.target.checked;
            saveSettings();
        });
        showPlayerListToggle.addEventListener('change', (e) => {
             radioState.settings.showPlayerList = e.target.checked;
             updateUI();
             saveSettings();
        });
        uiZoomSlider.addEventListener('input', (e) => {
            radioState.settings.uiZoom = e.target.value;
            updateRadioTransform();
            saveSettings();
        });
        playerListZoomSlider.addEventListener('input', (e) => {
            radioState.settings.playerListZoom = e.target.value;
            playerListCard.style.transform = `scale(${radioState.settings.playerListZoom / 100})`;
            saveSettings();
        });

        // Add Listeners for new settings
        uiVolumeSlider.addEventListener('input', (e) => {
            radioState.settings.uiVolume = parseInt(e.target.value) / 100;
            saveSettings();
        });
    
        clickSoundToggle.addEventListener('change', (e) => {
            radioState.settings.clickSound = e.target.checked;
            saveSettings();
        });

        animSelect.addEventListener('change', (e) => {
            const val = parseInt(e.target.value);
            radioState.settings.animationIndex = val;
            saveSettings();
            sendNuiMessage('setAnimation', { index: val });
        });

        saveCallsignBtn.addEventListener('click', () => {
            const val = callsignInput.value;
            sendNuiMessage('saveCallsign', { callsign: val });
        });

        setupDraggable(radioWrapper);
        setupDraggable(playerListCard);
        
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                sendNuiMessage('close');
            }
        });
    }

    // --- Helper Functions ---
    function switchView(viewId) { views.forEach(view => { view.id === viewId ? view.classList.remove('hidden-view') : view.classList.add('hidden-view'); }); }

    function connectToChannel() {
        const newChannel = dialInput.value;
        if (newChannel && newChannel !== radioState.currentChannel) {
            sendNuiMessage('joinChannel', { channel: newChannel });
            dialInput.value = '';
            switchView('main-view');
            document.querySelector('.nav-btn.active').classList.remove('active');
            document.querySelector('.nav-btn[data-view="main-view"]').classList.add('active');
        }
    }

    function saveToFavorites() {
        const channel = dialInput.value;
        if (channel && !radioState.favorites.includes(channel)) {
            if (radioState.favorites.length >= 4) radioState.favorites.shift();
            radioState.favorites.push(channel);
            saveFavorites();
            renderFavorites();
            document.querySelector('.nav-btn[data-view="favorites-view"]').click();
        }
    }

    function addRecent(channel) {
        if (radioState.recents.includes(channel)) {
            radioState.recents = radioState.recents.filter(c => c !== channel);
        }
        radioState.recents.unshift(channel);
        if (radioState.recents.length > 4) radioState.recents.pop();
        saveRecents();
    }

    function renderFavorites() {
        favoritesListEl.innerHTML = '';
        if (radioState.favorites.length === 0) {
            favoritesListEl.innerHTML = `<p class="text-gray-400">${translations.ui_no_saved || 'No saved channels.'}</p>`;
            return;
        }
        radioState.favorites.forEach(channel => { favoritesListEl.innerHTML += createChannelListItem(channel, true); });
    }

    function renderRecents() {
        recentsListEl.innerHTML = '';
        if (radioState.recents.length === 0) {
            recentsListEl.innerHTML = `<p class="text-gray-400">${translations.ui_no_recents || 'No recent channels.'}</p>`;
            return;
        }
        radioState.recents.forEach(channel => { recentsListEl.innerHTML += createChannelListItem(channel, false); });
    }

    function createChannelListItem(channel, isFavorite) {
        const removeBtn = isFavorite ? `<button class="remove-fav-btn bg-red-600 p-2 rounded-md hover:bg-red-700" data-channel="${channel}"><i class="ph ph-trash"></i></button>` : '';
        return `<div class="flex items-center justify-between bg-gray-800 p-2 rounded-lg"> <span class="font-bold text-lg">${channel}</span> <div class="space-x-2"> <button class="connect-list-btn bg-green-600 p-2 rounded-md hover:bg-green-700" data-channel="${channel}"><i class="ph ph-phone"></i></button> ${removeBtn} </div> </div>`;
    }

    function addChannelListListeners(listElement) {
        listElement.addEventListener('click', e => {
            const connectBtn = e.target.closest('.connect-list-btn');
            const removeBtn = e.target.closest('.remove-fav-btn');
            if (connectBtn) {
                dialInput.value = connectBtn.dataset.channel;
                connectToChannel();
            }
            if (removeBtn) {
                radioState.favorites = radioState.favorites.filter(c => c !== removeBtn.dataset.channel);
                saveFavorites();
                renderFavorites();
            }
        });
    }

    function handleDialKeyPress(key) {
        const currentValue = dialInput.value;

        if (currentValue.length >= 6) {
            return;
        }

        if (key === '.') {
            if (currentValue.includes('.') || currentValue.length === 0) {
                return;
            }
        }

        dialInput.value += key;
    }

    function setupDraggable(element) {
        let isDragging = false;
        let offsetX, offsetY;
        element.addEventListener('mousedown', (e) => {
            if ((element.id === 'draggable-radio-wrapper' && !radioState.settings.draggable) || e.target.closest('button, input, .slider, .dial-pad-btn, .nav-btn')) {
                return;
            }
            isDragging = true;
            offsetX = e.clientX - element.getBoundingClientRect().left;
            offsetY = e.clientY - element.getBoundingClientRect().top;
            element.style.cursor = 'grabbing';
            if (element.id === 'draggable-radio-wrapper') {
                radioWrapper.style.transform = `scale(${radioState.settings.uiZoom / 100})`;
            }
        });
        document.addEventListener('mousemove', (e) => {
            if (isDragging) {
                element.style.left = `${e.clientX - offsetX}px`;
                element.style.top = `${e.clientY - offsetY}px`;
            }
        });
        document.addEventListener('mouseup', () => {
            if (!isDragging) return;
            isDragging = false;
            element.style.cursor = 'grab';

            const newPosition = { top: element.style.top, left: element.style.left };
            if (element.id === 'draggable-radio-wrapper') {
                radioState.settings.positions.radio = newPosition;
            } else if (element.id === 'player-list-card') {
                radioState.settings.positions.playerList = newPosition;
            }
            saveSettings();
        });
    }

    // --- UI Initialization ---
    function init() {
        radioWrapper.style.display = 'none';
        loadFavorites();
        loadRecents();
        setupEventListeners();
        renderFavorites();
        renderRecents();
        
        // Add these two lines
        addChannelListListeners(favoritesListEl);
        addChannelListListeners(recentsListEl);
    }

    init();
});