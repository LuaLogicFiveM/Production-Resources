const { readdirSync, statSync, existsSync } = require('fs');
const { extname } = require("path");
const { fork } = require('child_process');

let child;
let requestId = 0;
let callbacks = new Map();

try {
    child = fork(`${GetResourcePath(GetCurrentResourceName())}/scripts/fork.js`, [], {
        detached: true,
        stdio: 'ignore'
    });

    if (child) {
        child.on('exit', (code, signal) => { console.log(`Child process exited with code ${code} and signal ${signal}`); });

        child.on('message', (data) => {
            switch(data.type) {
                case 'callback':
                    // Handle callback message
                    const callback = callbacks.get(data.id);
                    if (callback) {
                        callback(data.result);
                        callbacks.delete(data.id);
                    } else  console.log(`No callback found for id ${data.id}`);

                    break;

                case 'log':
                    // Handle log message
                    console.log(data.message)
                    break;
            }
        });
    }
} catch (error) {
    // console.error('Failed to start child process:', error);
}

const awaitCallback = (callback_name, data) => {
    if (!child) return Promise.reject(new Error('Child process is not available'));

    return new Promise((resolve, reject) => {
        const id = requestId++;
        callbacks.set(id, resolve);
        child.send({ type: 'callback', id: id, callback_name: callback_name, data });

        setTimeout(() => {
            if (callbacks.has(id)) {
                callbacks.delete(id);
                reject(new Error('Request timed out'));
            }
        }, 5000);
    });
}

exports("childStarted", async () => {
    return child == null ? 0 : 1;
})

exports('SaveResourceFile', async (resource_name, file_name, data, dataLen) => {
    try {
        // Make sure the correct resource name is provided
        if (GetResourceState(resource_name) == "missing") return 0;

        // Get resource path
        const resource_path = GetResourcePath(resource_name);
        
        // Write to file
        const result = await awaitCallback('writeFileSync', { path: `${resource_path}/${file_name}`, data, options: { encoding: 'utf-8' } });
        if (!result) return 0;

        return 1
    } catch (error) {
        return 0
    }
});

exports("exit", () => {
    // Verify the invoking resource is the current resource
    if (GetInvokingResource() != GetCurrentResourceName()) return 0;

    // Exit the server
    process.exit();
});

exports("GetFilePaths", async (resource_name, file_path) => {
    // Make sure the correct resource name/path is provided
    if (typeof resource_name != "string" || typeof file_path != "string" || GetResourceState(resource_name) == "missing") return [];

    // Get resource path
    const resource_path = GetResourcePath(resource_name);

    // Format the path/parse path
    const path = `${resource_path}/${file_path}`;

    const result = [];

    try {
        const normalizedPattern = path.replace(/\\/g, "/");
        const basePattern = normalizedPattern.split("/**/")[0];
        const targetFile = normalizedPattern.split("/**/").pop();
        const regex = new RegExp(targetFile.replace(/\*/g, '.*'));

        // Check if the core path exists
        if (!existsSync(basePattern)) return []

        // Check if the provided file path is just a file
        if (statSync(basePattern).isFile()) return [basePattern.replace(resource_path, "")];

        const traverse = (dir_path) => {
            const files = readdirSync(dir_path);
    
            for (const file of files) {
                const stats = statSync(`${dir_path}/${file}`);
    
                if (stats.isDirectory()) {
                    traverse(`${dir_path}/${file}`);
                } else if (file === targetFile || regex.test(file) || targetFile.replace(extname(file), "") == "*") result.push(`${dir_path}/${file}`.replace(resource_path, ""));
            };
        };

        traverse(basePattern);
    } catch (error) {
        // console.log(error)
        return []
    };

    return result;
});