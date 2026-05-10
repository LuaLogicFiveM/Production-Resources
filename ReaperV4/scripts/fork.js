const { writeFileSync, readdirSync, statSync, existsSync } = require('fs');
const path = require('path');

console.log = (...args) => {
    const message = args.map(arg => typeof arg === 'object' ? JSON.stringify(arg) : String(arg)).join(' ');
    process.send({ type: 'log', message });
}

const callbacks = new Map();
const createCallback = (name, callback) => { callbacks.set(name, callback); };

process.on('message', async (data) => {    
    switch(data.type) {
        case 'callback':
            const cb = callbacks.get(data.callback_name);

            if (cb) {
                process.send({ type: 'callback', id: data.id, result: await cb(data.data) });
            } else console.log(`No callback found for ${data.callback_name}`);
        
            break;
    }
});

// Register Callbacks
createCallback('writeFileSync', async (data) => {
    const { path, data: fileData, options } = data;
    try {
        writeFileSync(path, fileData, options);
        return true;
    } catch (err) {
        return false;
    }
});