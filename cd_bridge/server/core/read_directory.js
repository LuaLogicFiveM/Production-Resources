const fs = require('fs');
const path = require('path');

function readDirectory(dir_path, extensions) {
    const dir = path.parse(dir_path).dir;
    const files = fs.readdirSync(dir);

    if(files && files.length > 0){
        const filteredFiles = files.filter(file => {
            return extensions.some(ext => file.toLowerCase().endsWith(ext.toLowerCase()));
        });

        for(let i = 0; i < filteredFiles.length; i++) {
            filteredFiles[i] = path.join(dir, filteredFiles[i]);
        }
        return filteredFiles;
    } else return [];

}

global.exports('ReadDirectory', readDirectory);