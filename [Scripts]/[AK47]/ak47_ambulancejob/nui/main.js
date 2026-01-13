let hideHoldTimer = null;

$('#heartbeat').trigger('pause');

function fadeOutAudio() {
    $('#heartbeat').trigger('pause');
}

function play(volume) {
    document.getElementById("heartbeat").currentTime = 0;
    $("#heartbeat").prop("muted", false);
    document.getElementById("heartbeat").volume = volume;
    $('#heartbeat').trigger('play');
}

function updateVolume(volume) {
    document.getElementById("heartbeat").volume = volume;
}

function updatePlaybackSpeed(state) {
    myaudio = document.getElementById("heartbeat");
    if (myaudio) {
        myaudio.playbackRate = state;
    }
    
    const iconPulse = document.querySelector('.icon-pulse');
    if (iconPulse) {
        iconPulse.style.animationDuration = (2.0 / state) + 's';
    }

    const pulseBg = document.querySelector('.pulse-bg');
    if (pulseBg) {
        pulseBg.style.animationDuration = (2.5 / state) + 's';
    }
}

const CONFIG = {
    strings: {
        bleedoutin: 'You will bleed out in ~r~%s minutes %s seconds~s~',
        braindeadin: 'Brain dead in ~r~%s minutes %s seconds~s~',
        respawnavailable: 'Respawn available in ~g~%s minutes %s seconds~s~',
        respawn: 'Hold ~g~[E]~s~ to force respawn',
        respawn2: 'Hold ~g~[E]~s~ to safe respawn',
    }
};

let state = {
    isDead: false,
    bleedOutTimer: 0,
    brainDeadTimer: 0,
    respawnTimer: 0,
    isSafeRespawn: false
};

const ui = {
    app: document.getElementById('app'),
    statusText: document.getElementById('status-text'),
    respawnText: document.getElementById('respawn-text'),
    killerName: document.getElementById('killer-name'),
    weaponName: document.getElementById('weapon-name'),
    holdIndicator: document.getElementById('hold-indicator'),
    distressContainer: document.getElementById('distress-container'),
    circle: document.querySelector('.progress-ring__circle')
};

const circumference = 40 * 2 * Math.PI; 

function parseFiveMText(text) {
    if (!text) return '';
    let formatted = text
        .replace(/~r~/g, '<span class="color-r">')
        .replace(/~g~/g, '<span class="color-g">')
        .replace(/~b~/g, '<span class="color-b">')
        .replace(/~y~/g, '<span class="color-y">')
        .replace(/~s~/g, '</span>');
    return `<span class="color-s">${formatted}</span>`;
}

function formatString(str, ...args) {
    let i = 0;
    return str.replace(/%s/g, () => args[i++] || '');
}

function formatTimerString(template, totalSeconds) {
    const m = Math.floor(totalSeconds / 60);
    const s = totalSeconds % 60;

    if (m === 0) {
        let newTemplate = template.replace('%s minutes ', '');
        return formatString(newTemplate, s);
    } else {
        return formatString(template, m, s);
    }
}

function setCircleProgress(percent) {
    const offset = circumference - (percent / 100) * circumference;
    ui.circle.style.strokeDashoffset = offset;
}

function updateUI() {
    if (state.bleedOutTimer > 0) {
        const rawText = formatTimerString(CONFIG.strings.bleedoutin, state.bleedOutTimer);
        ui.statusText.innerHTML = parseFiveMText(rawText);
    } else {
        if (state.brainDeadTimer > 0) {
            const rawText = formatTimerString(CONFIG.strings.braindeadin, state.brainDeadTimer);
            ui.statusText.innerHTML = parseFiveMText(rawText);
        } else {
            ui.statusText.innerHTML = '';
        }
    }

    if (state.respawnTimer > 0) {
        const rawText = formatTimerString(CONFIG.strings.respawnavailable, state.respawnTimer);
        ui.respawnText.innerHTML = parseFiveMText(rawText);
        
        ui.holdIndicator.classList.add('hidden');
        ui.holdIndicator.classList.remove('opacity-100');
    } else {
        const rawText = state.isSafeRespawn ? CONFIG.strings.respawn2 : CONFIG.strings.respawn;
        ui.respawnText.innerHTML = parseFiveMText(rawText);
    }
}

function updateSkellyVisuals(idPrefix, value) {
    const img = document.getElementById(idPrefix + '-img');
    if (img) {
        img.style.opacity = (value / 100).toFixed(2);
    }

    const valText = document.getElementById(idPrefix + '-val');
    if (valText) {
        valText.innerText = value + '%';
        valText.style.opacity = value > 0 ? '1' : '0';
        if(value > 50) {
            valText.classList.add('text-red-500');
            valText.classList.remove('text-gray-300');
        } else {
            valText.classList.remove('text-red-500');
            valText.classList.add('text-gray-300');
        }
    }
}

window.addEventListener('message', function(event) {
    var item = event.data;

    if (item.type === "fadeOutAudio") fadeOutAudio();
    if (item.type === "play") play(item.status);
    if (item.type === "updateVolume") updateVolume(item.status);
    if (item.type === "updatePlaybackSpeed") updatePlaybackSpeed(item.status);

    if (item.action === 'showDeathScreen') {
        state.isDead = true;
        state.bleedOutTimer = item.bleedOut || 300;
        state.brainDeadTimer = item.brainDead || 0;
        state.respawnTimer = (item.respawn !== undefined) ? item.respawn : 60;
        state.isSafeRespawn = false; 

        if (item.locales) {
            CONFIG.strings.bleedoutin = item.locales.bleedoutin;
            CONFIG.strings.braindeadin = item.locales.braindeadin;
            CONFIG.strings.respawnavailable = item.locales.respawnavailable;
            CONFIG.strings.respawn = item.locales.respawn;
            CONFIG.strings.respawn2 = item.locales.respawn2;

            if(ui.incapacitated) ui.incapacitated.innerHTML = item.locales.incapacitated;
            if(ui.incidentReport) ui.incidentReport.innerText = item.locales.incident_report;
            if(ui.killedByLabel) ui.killedByLabel.innerText = item.locales.killed_by;
            if(ui.weaponLabel) ui.weaponLabel.innerText = item.locales.weapon;
            if(ui.distressLabel) ui.distressLabel.innerText = item.locales.distress;
        }
        
        ui.killerName.textContent = item.killer || "Unknown";
        ui.weaponName.textContent = item.weapon || "Unknown";

        if (item.skelly) {
            updateSkellyVisuals('skelly-head', item.skelly.head);
            updateSkellyVisuals('skelly-chest', item.skelly.chest);
            updateSkellyVisuals('skelly-larm', item.skelly.larm);
            updateSkellyVisuals('skelly-rarm', item.skelly.rarm);
            updateSkellyVisuals('skelly-lleg', item.skelly.lleg);
            updateSkellyVisuals('skelly-rleg', item.skelly.rleg);
        } else {
            ['head', 'chest', 'larm', 'rarm', 'lleg', 'rleg'].forEach(part => updateSkellyVisuals('skelly-'+part, 0));
        }
        
        ui.distressContainer.classList.add('hidden');
        
        ui.app.style.display = 'flex';
        setTimeout(() => { ui.app.style.opacity = '1'; }, 50);
        updateUI();
    } 
    
    if (item.action === 'hideDeathScreen') {
        ui.app.style.opacity = '0';
        setTimeout(() => {
            ui.app.style.display = 'none';
            state.isDead = false;
        }, 500);
    } 
    
    if (item.action === 'updateTimer') {
        if(item.bleedOut !== undefined) state.bleedOutTimer = item.bleedOut;
        if(item.brainDead !== undefined) state.brainDeadTimer = item.brainDead;
        if(item.respawn !== undefined) state.respawnTimer = item.respawn;
        updateUI();
    }

    if (item.action === 'updateSkelly') {
        if (item.skelly) {
            updateSkellyVisuals('skelly-head', item.skelly.head);
            updateSkellyVisuals('skelly-chest', item.skelly.chest);
            updateSkellyVisuals('skelly-larm', item.skelly.larm);
            updateSkellyVisuals('skelly-rarm', item.skelly.rarm);
            updateSkellyVisuals('skelly-lleg', item.skelly.lleg);
            updateSkellyVisuals('skelly-rleg', item.skelly.rleg);
        }
    }
    
    if (item.action === 'setSafeRespawn') {
        state.isSafeRespawn = item.state;
        updateUI();
    }

    if (item.action === 'showDistress') {
        ui.distressContainer.classList.remove('hidden');
    }

    if (item.action === 'hideDistress') {
        ui.distressContainer.classList.add('hidden');
    }

    if (item.action === 'setProgress') {
        let val = item.value * 100;
        setCircleProgress(val);
        
        if (item.value > 0) {
            if (hideHoldTimer) {
                clearTimeout(hideHoldTimer);
                hideHoldTimer = null;
            }

            ui.holdIndicator.classList.remove('hidden');
            
            if (!ui.holdIndicator.classList.contains('opacity-100')) {
                setTimeout(() => ui.holdIndicator.classList.add('opacity-100'), 10);
            }
        } else {
            if (item.value <= 0.01 && !hideHoldTimer && ui.holdIndicator.classList.contains('opacity-100')) {
                 ui.holdIndicator.classList.remove('opacity-100');
                 
                 hideHoldTimer = setTimeout(() => {
                     ui.holdIndicator.classList.add('hidden');
                     hideHoldTimer = null;
                 }, 300);
            }
        }
    }
});