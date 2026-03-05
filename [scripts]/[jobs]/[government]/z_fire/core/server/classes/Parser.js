/**
 * parser.js - Server-side JSON file manager
 */

const fsPromises = require('fs').promises;
const path = require('path');
const resource_name = GetCurrentResourceName();
const resource_root = GetResourcePath(resource_name);

const parserCache = new Map();

/**
 * Parse Class
 */
class Parse {
    object = null;
    ready;

    constructor(file_to_parse) {
        let cleanPath = file_to_parse.replace(/\\/g, '/');
        if (cleanPath.startsWith('/')) cleanPath = cleanPath.substring(1);

        this.to_parse = cleanPath;
        this.fullPath = path.join(resource_root, this.to_parse);
        this.ready = this.init();
    }

    async init() {
        try {
            const data = await fsPromises.readFile(this.fullPath, 'utf8');
            this.object = JSON.parse(data);
        } catch (err) {
            if (err.code === 'ENOENT') {
                console.log(`[${resource_name}] File not found: ${this.to_parse}. Creating new object.`);
                this.object = {};
            } else {
                console.error(`[${resource_name}] Error reading or parsing ${this.to_parse}:`, err);
                throw err;
            }
        }
    }

    static stringifyBigInt(obj) {
        return JSON.stringify(obj, (_, v) => (typeof v === 'bigint' ? v.toString() : v), 4);
    }

    /**
     * Helper to safely write the file asynchronously
     */
    async saveFile() {
        if (!this.object) return;
        try {
            await fsPromises.writeFile(this.fullPath, Parse.stringifyBigInt(this.object));
        } catch (err) {
            console.error(`[${resource_name}] Failed to save file ${this.to_parse}:`, err);
        }
    }

    path(pathStr, to_update) {
        if (!this.object) return;

        const keys = pathStr.split('.');
        let current = this.object;

        for (let i = 0; i < keys.length - 1; i++) {
            const key = keys[i];
            if (!(key in current) || typeof current[key] !== 'object' || current[key] === null) {
                const nextKey = keys[i + 1];
                current[key] = /^\d+$/.test(nextKey) ? [] : {};
            }
            current = current[key];
        }

        if (to_update === undefined) {
            return current[keys[keys.length - 1]];
        }

        current[keys[keys.length - 1]] = to_update;
    }

    generateId(type) {
        if (!this.object) {
            throw new Error('Parser object not initialized, cannot generate ID.');
        }

        let prefix = '';
        switch (type) {
            case 'incident':
                prefix = 'ic_index_';
                break;
            case 'district':
                prefix = 'district_index_';
                break;
            case 'department':
                prefix = 'department_index_';
                break;
            default:
                throw new Error('Unknown type passed to generateId');
        }

        const existingIndices = Object.keys(this.object)
            .filter((key) => key.startsWith(prefix))
            .map((key) => parseInt(key.replace(prefix, ''), 10))
            .filter((num) => !isNaN(num) && num > 0);

        const maxIndex = existingIndices.length > 0 ? Math.max(...existingIndices) : 0;
        const nextIndex = maxIndex + 1;
        return `${prefix}${nextIndex}`;
    }

    async mutate(pathStr, value, source_user) {
        if (!this.object) return;
        this.path(pathStr, value);
        await this.saveFile();
        emit('z_fire:parser:read:sv', source_user, this.object, this.to_parse);
    }

    async remove(object_id, source_user) {
        if (!this.object || !(object_id in this.object)) return;
        delete this.object[object_id];
        await this.saveFile();
        emit('z_fire:parser:read:sv', source_user, this.object, this.to_parse);
    }

    update(source_user) {
        if (!this.object) return;
        emit('z_fire:parser:read:sv', source_user, this.object, this.to_parse);
    }

    async add(value, source_user) {
        if (!this.object) return;

        try {
            if (this.to_parse.includes('departments')) {
                let departmentData = value.department || value;

                if (typeof departmentData === 'object' && !departmentData.shortCode) {
                    const keys = Object.keys(departmentData);
                    if (keys.length === 1) {
                        departmentData = departmentData[keys[0]];
                    }
                }

                if (!departmentData.shortCode) {
                    return;
                }

                const key = departmentData.shortCode;

                if (!departmentData.id) {
                    departmentData.id = this.generateId('department');
                }

                this.object[key] = departmentData;
            } else if (this.to_parse.includes('incidents')) {
                const incident = value.incident[Object.keys(value.incident)[0]];
                if (!incident) return;
                if (!incident.id) {
                    incident.id = this.generateId('incident');
                }
                this.object[incident.id] = incident;
            } else if (this.to_parse.includes('districts')) {
                const district = value.district;
                if (!district) return;
                const districtId = this.generateId('district');
                district.id = districtId;
                this.object[districtId] = district;
            }
        } catch (err) {
            console.error(`[${resource_name}] Error in add() for ${this.to_parse}:`, err, value);
            return;
        }

        await this.saveFile();
        emit('z_fire:parser:read:sv', source_user, this.object, this.to_parse);
    }
}

/**
 * onNet listener
 */

onNet('z_fire:parser', async (action, data) => {
    const source_user = source;
    const rawFile = data.file_to_parse;

    if (!rawFile) {
        console.error(`[${resource_name}] No 'file_to_parse' provided for action: ${action}`);
        return;
    }

    try {
        let fileToParse = rawFile.replace(/\\/g, '/');
        if (fileToParse.startsWith('/')) fileToParse = fileToParse.substring(1);

        let parser;
        if (parserCache.has(fileToParse)) {
            parser = parserCache.get(fileToParse);
        } else {
            parser = new Parse(fileToParse);
            parserCache.set(fileToParse, parser);
        }

        await parser.ready;

        switch (action) {
            case 'add':
                await parser.add(data.data_to_parse, source_user);
                break;
            case 'mutate':
                await parser.mutate(data.parse_to_path, data.data_to_parse, source_user);
                break;
            case 'remove':
                await parser.remove(data.object_id, source_user);
                break;
            case 'update':
                parser.update(source_user);
                break;
            default:
                console.warn(`[${resource_name}] Unknown parser action: ${action}`);
        }
    } catch (err) {
        console.error(`[${resource_name}] Failed to process parser action '${action}' for '${rawFile}':`, err);
        const fileToParse = rawFile.replace(/\\/g, '/');
        parserCache.delete(fileToParse);
    }
});

/**
 * Resource Start Event
 */

on('onServerResourceStart', (resName) => {
    if (resName !== resource_name) return;

    const filesToLoad = [
        'settings/jsons/districts.json',
        'settings/jsons/incidents.json',
        'settings/jsons/departments.json',
    ];

    console.log(`[${resource_name}] Loading initial JSON files...`);

    filesToLoad.forEach(async (file) => {
        try {
            const normalizedFile = file.replace(/\\/g, '/');

            let parser;
            if (parserCache.has(normalizedFile)) {
                parser = parserCache.get(normalizedFile);
            } else {
                parser = new Parse(normalizedFile);
                parserCache.set(normalizedFile, parser);
            }

            await parser.ready;

            if (parser.object && Object.keys(parser.object).length > 0) {
                emit('z_fire:parser:read:sv', -1, parser.object, normalizedFile);
                console.log(`[${resource_name}] ✓ Loaded ${normalizedFile}`);
            } else {
                console.warn(`[${resource_name}] ? Loaded empty or new file: ${normalizedFile}`);
            }
        } catch (err) {
            console.error(`[${resource_name}] ✗ Failed to load ${file}:`, err);
        }
    });
});
