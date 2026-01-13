let currentStationIndex = null;
let isOpen = false;
let currentLocales = {};

window.addEventListener('message', function(event) {
    const data = event.data;
    
    if (data.action === 'open') {
        if (data.data && !data.data.error) {
            if (data.locales) {
                currentLocales = data.locales;
                applyLocales(data.locales);
            }
            if (data.theme) {
                applyTheme(data.theme);
            }
            openUI(data.data);
        } else {
            console.error('Error opening UI:', data.data?.error);
        }
    } else if (data.action === 'close') {
        closeUI();
    }
});

function applyLocales(locales) {
    const titleEl = document.getElementById('ui-title');
    const vehicleLabelEl = document.getElementById('ui-vehicle-label');
    const vehicleWeightLabelEl = document.getElementById('ui-vehicle-weight-label');
    const itemsWeightLabelEl = document.getElementById('ui-items-weight-label');
    const totalWeightLabelEl = document.getElementById('ui-total-weight-label');
    const refreshBtnEl = document.getElementById('refresh-btn');
    
    if (titleEl && locales.title) titleEl.textContent = locales.title;
    if (vehicleLabelEl && locales.vehicle) vehicleLabelEl.textContent = locales.vehicle;
    if (vehicleWeightLabelEl && locales.vehicle_weight) vehicleWeightLabelEl.textContent = locales.vehicle_weight;
    if (itemsWeightLabelEl && locales.items_weight) itemsWeightLabelEl.textContent = locales.items_weight;
    if (totalWeightLabelEl && locales.total_weight) totalWeightLabelEl.textContent = locales.total_weight;
    if (refreshBtnEl && locales.refresh) refreshBtnEl.textContent = locales.refresh;
}

function applyTheme(theme) {
    if (theme.primaryColor) {
        document.documentElement.style.setProperty('--primary-color', theme.primaryColor);
    }
    if (theme.secondaryColor) {
        document.documentElement.style.setProperty('--secondary-color', theme.secondaryColor);
    }
    if (theme.backgroundColor) {
        document.documentElement.style.setProperty('--background-color', theme.backgroundColor);
    }
    if (theme.textColor) {
        document.documentElement.style.setProperty('--text-color', theme.textColor);
    }
    if (theme.accentColor) {
        document.documentElement.style.setProperty('--accent-color', theme.accentColor);
    }
}

function openUI(vehicleData) {
    if (isOpen) return;
    
    isOpen = true;
    const container = document.getElementById('weight-container');
    container.classList.remove('hidden');
    
    if (vehicleData.stationIndex !== undefined) {
        currentStationIndex = vehicleData.stationIndex;
    }
    
    updateUI(vehicleData);
}

function closeUI() {
    if (!isOpen) return;
    
    isOpen = false;
    const container = document.getElementById('weight-container');
    container.classList.add('hidden');
    
    currentStationIndex = null;
}

function updateUI(vehicleData) {
    if (!vehicleData) return;
    
    const vehicleNameEl = document.getElementById('vehicle-name');
    if (vehicleData.vehicleName) {
        vehicleNameEl.textContent = vehicleData.vehicleName;
    } else {
        vehicleNameEl.textContent = currentLocales.vehicle_unknown || 'Unknown';
    }
    
    const baseWeightEl = document.getElementById('base-weight');
    const itemsWeightEl = document.getElementById('items-weight');
    const totalWeightEl = document.getElementById('total-weight');
    
    baseWeightEl.textContent = formatWeight(vehicleData.baseWeight || 0);
    itemsWeightEl.textContent = formatWeight(vehicleData.itemsWeight || 0);
    totalWeightEl.textContent = formatWeight(vehicleData.totalWeight || 0);
}

function formatWeight(weight) {
    return weight.toFixed(2).replace('.', ',') + ' kg';
}

document.getElementById('close-btn').addEventListener('click', function() {
    fetch(`https://${GetParentResourceName()}/close`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
    closeUI();
});

document.getElementById('refresh-btn').addEventListener('click', function() {
    if (currentStationIndex !== null) {
        fetch(`https://${GetParentResourceName()}/requestWeight`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                stationIndex: currentStationIndex
            })
        });
    }
});

document.addEventListener('keydown', function(event) {
    if (event.key === 'Escape' && isOpen) {
        fetch(`https://${GetParentResourceName()}/close`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
        });
        closeUI();
    }
});

function GetParentResourceName() {
    let resourceName = 'js-weightstation';
    try {
        const path = window.location.pathname;
        const match = path.match(/\/nui\/([^\/]+)/);
        if (match) {
            resourceName = match[1];
        } else {
            const scripts = document.getElementsByTagName('script');
            for (let i = 0; i < scripts.length; i++) {
                if (scripts[i].src) {
                    const scriptMatch = scripts[i].src.match(/\/resources\/([^\/]+)\//);
                    if (scriptMatch) {
                        resourceName = scriptMatch[1];
                        break;
                    }
                }
            }
        }
    } catch (e) {
        console.error('Error getting resource name:', e);
    }
    return resourceName;
}