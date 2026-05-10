
var current = ''

let previousVehInfo = {};
let defaultHandling = {};

let uiFields = {};

let vehInfo = {};
let presetToShare = 0
let activePreset = 0
let activeSelectIcon = null;
let presetToDelete = null;

let mainbg = document.querySelector('.mainbg');

$(function () {
    window.addEventListener('message', function (event) {
        var data = event.data;

        if (data.type == "buildUI") {
            if (data.handlingData) {
                advanced()
              for (let v of data.handlingData) {
                createInputGroup(v.handlingID, v.min, v.max, v.popup, v.section)
              }
            }
            if (data.tunerData) {
               simple() 
              uiFields = data.tunerData
              for (let v of uiFields) {
                 createInputGroup(v.handlingID, v.min, v.max, v.popup, v.section, 1.0)
              }
            }
            if (!data.tunerData || !data.handlingData) {
                $(".modeToggle").css("display", "none")
            }
        }

        if (data.type == "enableui") {
            document.body.style.display = data.enable ? "block" : "none";
            previousVehInfo = data.vehdata;
            defaultHandling = data.default;
            setTimeout(() => {
                updateInputValues(previousVehInfo);
            }, 0);
            activePreset = 0
        }

        if (data.type == "updatedata") {
            previousVehInfo = { ...data.vehdata };
        }

        if (data.type == "presetsenable") {
            $(".loaded-presets").html(event.data.presets);
        }

        if (data.type == "updateui") {
            
           
            if (data.resetpreset) {
                activePreset = 0
            }

            if (Object.keys(previousVehInfo).length > 0 ) {
             const changes = getChanges(previousVehInfo, data.vehdata);
             updateChangesContainer(changes);
            } 
           
            previousVehInfo = { ...data.vehdata };
            setTimeout(() => {
                updateInputValues(previousVehInfo);
            }, 0);
          
        }

        if (data.type == "dyno") {
            $("#dyno").css("display", "block")
            $('.hp-data').empty()
            $('.tq-data').empty()
            $('.hp-data').append(data.hp)
            $('.tq-data').append(data.tq)
        }

        if (data.type == "dynooff") {
            $("#dyno").css("display", "none")
            $('.hp-data').empty()
            $('.tq-data').empty()
        }

        if (data.action === "reloadUISettings") {
            loadUISettings();
        }

    });

    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://wizating_laptop/escape');
        }
    };

    window.oncontextmenu = (e) => {
        e.preventDefault()
        $.post('http://wizating_laptop/escape');
    }
   
    document.querySelectorAll('.header h2').forEach((title) => {
        const textLength = title.textContent.length;
        if (textLength > 23) {
            title.style.fontSize = ' 0.35em'; 
            title.style.letterspacing = ' 0.2em'; 

        } else if (textLength > 20) {
            title.style.fontSize = ' 0.5em';
            title.style.letterspacing = ' 0.3em'; 
        }
    });

    document.querySelector('.loaded-presets').addEventListener('click', (event) => {
        const deleteButton = event.target.closest('.delete-preset');
        const selectButton = event.target.closest('.select-preset');
        const shareButton = event.target.closest('.share-preset');
        if (deleteButton) {
            const preset = event.target.closest('.preset');
            openDeleteConfirmationPopup(preset);
        }
        if (selectButton) {
            if (activeSelectIcon) {
                activeSelectIcon.classList.remove('active-select');
            }
            event.target.classList.add('active-select');
            activeSelectIcon = event.target;
            const preset = selectButton.closest('.preset');
            const presetId = preset.getAttribute('id');
            if (activePreset != presetId) {
                $.post("http://wizating_laptop/selectpreset", JSON.stringify({ id: presetId }));
                activePreset = presetId
            }
        }
        if (shareButton) {
                const preset = shareButton.closest('.preset');
            const presetId = preset.getAttribute('id');
            openSharePopup(preset, presetId);
        }
    });
});


function openSharePopup(preset, presetId) {
    presetToShare = presetId;
    const presetName = preset.querySelector('.preset-name').textContent;
    const presetNamePlaceholder = document.getElementById('placeholderShare');
    presetNamePlaceholder.textContent = presetName;
    const popup = document.getElementById('sharePopup');
    popup.style.display = 'flex';
}



function closeSharePopup() {
    const popup = document.getElementById('sharePopup');
    popup.style.display = 'none';
    presetToShare = null;
}

function openDeleteConfirmationPopup(preset) {
    presetToDelete = preset;
    const presetName = preset.querySelector('.preset-name').textContent;
    const presetNamePlaceholder = document.getElementById('placeholderDelete');
    presetNamePlaceholder.textContent = presetName;
    const popup = document.getElementById('deleteConfirmationPopup');
    popup.style.display = 'flex';
}

function closeDeleteConfirmationPopup() {
    const popup = document.getElementById('deleteConfirmationPopup');
    popup.style.display = 'none';
    presetToDelete = null;
}

function confirmDelete() {
    if (presetToDelete) {
        const presetId = presetToDelete.getAttribute('id');
        presetToDelete.remove();
        $.post("http://wizating_laptop/deletepreset", JSON.stringify({ id: presetId }));
    }
    closeDeleteConfirmationPopup();
}

function activateDefault() {
    $.post("http://wizating_laptop/removetune", JSON.stringify({ id: current }));
}

function save() {
    if (!previousVehInfo) return;
    let handlingData = {}
    for (const [key, _] of Object.entries(previousVehInfo)) {
        const handlingFloat = document.getElementById(key);
        if (handlingFloat) {
            handlingData[key] = $(`#${key}`).val()
        }
    }
    $.post('http://wizating_laptop/save', JSON.stringify({ handlingData: handlingData }));
}

function saveSimple(section) {
    if (!previousVehInfo || !uiFields) return;
    let handlingData = {};
    for (const [_, data] of Object.entries(uiFields)) {
        if (data.section === `#${section}`) {
            var handlingID = data.handlingID
            const inputElement = document.getElementById(handlingID);
            if (inputElement) {
                handlingData[handlingID] = $(`#${handlingID}`).val();
            }
        }
    }

    if (Object.keys(handlingData).length > 0) {
        $.post('http://wizating_laptop/saveTuner', JSON.stringify({ handlingData: handlingData, section: section }));
    }
}

function changeTabAdv(tabName) {
    $("#brakes").css("display", "none")
    $("#suspension").css("display", "none")
    $("#presets").css("display", "none")
    $("#traction").css("display", "none")
    $("#power").css("display", "none")
    if (tabName) {
        $(`#${tabName}`).css("display", "block")
    }
}

function changeTab(tabName) {
    $("#race").css("display", "none")
    $("#cruise").css("display", "none")
    $("#drift").css("display", "none")
    $("#drag").css("display", "none")
    $("#presets").css("display", "none")
    if (tabName) {
        $(`#${tabName}`).css("display", "block")
    }
}

function advanced() {
    $(".simple").css("display", "none")
    $(".advanced").css("display", "grid")
    changeTab()
    changeTabAdv('traction')

}

function simple() {
    $(".advanced").css("display", "none")
    $(".simple").css("display", "grid")
    changeTabAdv()
    changeTab('race')
}

function updateSlider(containerId, newMin, newMax) {
    const container = document.getElementById('slidercontainer-' + containerId);
    if (!container) return;
    const slider = container.querySelector('input[type="range"]');
    const minLabel = container.querySelector('.labels span:first-child');
    const maxLabel = container.querySelector('.labels span:last-child');
    slider.min = newMin;
    slider.max = newMax;
    minLabel.textContent = newMin;
    maxLabel.textContent = newMax;
    slider.value = (newMin + newMax) / 2;
}

function toggleInfoPopup(iconElement) {
    const externalPopup = document.getElementById('externalPopup');
    if (!externalPopup) return;
    const inputGroup = iconElement.closest('.input-group');
    const infoPopup = inputGroup.querySelector('.info-popup');
    if (!infoPopup) return;
    externalPopup.innerHTML = infoPopup.innerHTML;
    if (externalPopup.classList.contains('visible')) {
        return;
    }
    externalPopup.classList.add('visible');
}

function resetSlider(sliderId) {

    const defaultValue = defaultHandling[sliderId];

    if (defaultValue === undefined) {
        console.error(`Default value not found for handling parameter: ${defaultValue}`);
        return;
    }

    const slider = document.getElementById(`${sliderId}S`);
    if (slider) {
        slider.value = defaultValue;
    }

    const inputBox = document.getElementById(sliderId);
    if (inputBox) {
        inputBox.value = defaultValue;
    }

}

function getFirstWord(input) {
    const hyphenIndex = input.indexOf('-');
    return hyphenIndex === -1 ? input : input.substring(0, hyphenIndex);
}

function splitHandlingName(input) {
    const trimmedInput = input.replace(/^f/, '');
    return trimmedInput.replace(/([A-Z])/g, ' $1').trim();
}

function createInputGroup(id, min, max, infoText, section, value) {
    let defaultValue = 0.0

    if (value) {
        defaultValue = value
    } else {
        defaultValue = (parseFloat(min) + parseFloat(max)) / 2;
    }

    const tractionSection = document.querySelector(`${section} .handlinginfo`)

    const inputGroup = document.createElement('div');
    inputGroup.className = 'input-group';

    const header = document.createElement('div');
    header.className = 'header';

    const headerTitle = document.createElement('h2');
    headerTitle.textContent = splitHandlingName(getFirstWord(id));

    const icons = document.createElement('div');
    icons.className = 'icons';

    const resetIcon = document.createElement('i');
    resetIcon.className = 'fas fa-undo';
    resetIcon.onclick = () => resetSlider(`${id}`);

    const infoIcon = document.createElement('i');
    infoIcon.className = 'fas fa-info-circle';
    infoIcon.onclick = () => toggleInfoPopup(infoIcon);

    icons.appendChild(resetIcon);
    icons.appendChild(infoIcon);
    header.appendChild(headerTitle);
    header.appendChild(icons);

    const sliderContainer = document.createElement('div');
    sliderContainer.id = `slidercontainer-${id}`;

    const labels = document.createElement('div');
    labels.className = 'labels';

    const minLabel = document.createElement('span');
    minLabel.id = 'minLabel';
    minLabel.textContent = min;

    const maxLabel = document.createElement('span');
    maxLabel.id = 'maxLabel';
    maxLabel.textContent = max;

    labels.appendChild(minLabel);
    labels.appendChild(maxLabel);

    const slider = document.createElement('input');
    slider.type = 'range';
    slider.min = min;
    slider.max = max;
    slider.step = '0.01';
    slider.value = defaultValue;
    slider.className = 'slider';
    slider.id = `${id}S`;

    const inputBox = document.createElement('div');
    inputBox.className = 'inputbox';

    const numberInput = document.createElement('input');
    numberInput.type = 'number';
    numberInput.className = 'form-control';
    numberInput.value = defaultValue;
    numberInput.id = id;

    inputBox.appendChild(numberInput);

    sliderContainer.appendChild(labels);
    sliderContainer.appendChild(slider);

    const infoPopup = document.createElement('div');
    infoPopup.className = 'info-popup';
    infoPopup.innerHTML = `<p>${infoText}</p>`;

    inputGroup.appendChild(header);
    inputGroup.appendChild(sliderContainer);
    inputGroup.appendChild(inputBox);
    inputGroup.appendChild(infoPopup);

    slider.addEventListener('input', () => {
        numberInput.value = clamp(slider.value, slider.min, slider.max); 
    });

    numberInput.addEventListener('input', () => {
        slider.value = clamp(numberInput.value, slider.min, slider.max);
    });



    tractionSection.appendChild(inputGroup);
}

function clamp(value, min, max) {
  const lower = Math.min(min, max);
  const upper = Math.max(min, max);
  return Math.min(Math.max(value, lower), upper);
}


document.addEventListener('click', (event) => {
    const externalPopup = document.getElementById('externalPopup');
    if (!externalPopup) return;

    if (!event.target.closest('.info-popup') && !event.target.closest('.fa-info-circle')) {
        externalPopup.classList.remove('visible');
    }
});

function updateInputValues(previousVehInfo) {

    if (!previousVehInfo) return;
    for (const [key, value] of Object.entries(previousVehInfo)) {
        const inputElement = document.getElementById(key);
        if (inputElement) {
            inputElement.value = value;

        }


        const sliderElement = document.getElementById(`${key}S`);
        if (sliderElement) {
            sliderElement.value = value;
        }
    }
}

document.addEventListener('DOMContentLoaded', () => {
    const searchInput = document.getElementById('presetSearch');
    const loadedPresets = document.querySelector('.loaded-presets');
    const mainbg = document.querySelector('.mainbg');
    const scaleBtn = document.getElementById('scale-btn');
    const scaleOptions = document.getElementById('scale-options');
    const scaleBtns = document.querySelectorAll('.scale-btn');
    const moveBtn = document.getElementById('move-btn');

    if (!searchInput || !loadedPresets) {
        console.error('Search input or presets container not found!');
        return;
    }

    function filterPresets(searchTerm) {
        const presets = loadedPresets.querySelectorAll('.preset');

        presets.forEach((preset) => {
            const presetName = preset.querySelector('.preset-name').textContent.toLowerCase();
            if (presetName.includes(searchTerm.toLowerCase())) {
                preset.style.display = 'block';
            } else {
                preset.style.display = 'none';
            }
        });
    }

    searchInput.addEventListener('input', (event) => {
        const searchTerm = event.target.value.trim();
        filterPresets(searchTerm);
    });

   
    
    let isDraggable = false;
    let currentScale = 1;
    let startX, startY, startLeft, startTop;


    function centerOnResize() {
        const windowWidth = window.innerWidth;
        const windowHeight = window.innerHeight;
        const bgWidth = mainbg.offsetWidth * currentScale;
        const bgHeight = mainbg.offsetHeight * currentScale;
        const centerX = (windowWidth - bgWidth) / 2;
        const centerY = (windowHeight - bgHeight) / 2;
        mainbg.style.transform = `translate(${centerX}px, ${centerY}px) scale(${currentScale})`;
        mainbg.dataset.x = centerX;
        mainbg.dataset.y = centerY;

        $.post('https://wizating_laptop/saveUISettings', JSON.stringify({uiXpos : centerX, uiYpos : centerY, uiSize : currentScale}));
       
    }



   
    scaleBtn.addEventListener('click', function(e) {
        scaleOptions.classList.toggle('show');
        e.stopPropagation();
    });
    
   
    scaleBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            currentScale = parseFloat(this.dataset.scale);
            
        
            const transform = window.getComputedStyle(mainbg).transform;
            if (transform === 'none') {
                mainbg.style.transform = `scale(${currentScale})`;
            } else {
                const matrix = transform.match(/^matrix\((.+)\)$/)[1].split(', ').map(Number);
                const translateX = matrix[4];
                const translateY = matrix[5];
                mainbg.style.transform = `translate(${translateX}px, ${translateY}px) scale(${currentScale})`;
                centerOnResize()
            }
       
            scaleOptions.classList.remove('show');
        });
    });
    
   
    moveBtn.addEventListener('click', function() {
        isDraggable = !isDraggable;
        mainbg.style.cursor = isDraggable ? 'move' : 'default';
        moveBtn.classList.toggle('active');
        if (!isDraggable) {
       
            $.post('https://wizating_laptop/saveUISettings', JSON.stringify({uiXpos : startLeft, uiYpos : startTop}));
        }
    });
    
    
    mainbg.addEventListener('mousedown', function(e) {
        if (!isDraggable) return;
        
        e.preventDefault();
        startX = e.clientX;
        startY = e.clientY;
    
        const transform = window.getComputedStyle(mainbg).transform;
        if (transform !== 'none') {
            const matrix = transform.match(/^matrix\((.+)\)$/)[1].split(', ').map(Number);
            startLeft = matrix[4];
            startTop = matrix[5];
        } else {
            startLeft = 0;
            startTop = 0;
        }
        
        document.addEventListener('mousemove', dragMove);
        document.addEventListener('mouseup', dragEnd);
    });
    
    function dragMove(e) {
        if (!isDraggable) return;
        
        const dx = e.clientX - startX;
        const dy = e.clientY - startY;
        
        mainbg.style.transform = `translate(${startLeft + dx}px, ${startTop + dy}px) scale(${currentScale})`;
    }
    
    function dragEnd() {
        document.removeEventListener('mousemove', dragMove);
        document.removeEventListener('mouseup', dragEnd);
    }
    
    function loadUISettings() {
        console.log("loading data")
        $.post('https://wizating_laptop/loadUISettings', JSON.stringify({}), function(data) {
             currentScale = data.uiSize;
      
             mainbg.style.transform = `translate(${data.uiXpos}px, ${data.uiYpos}px) scale(${currentScale})`;
        });
    }
    loadUISettings()
    window.loadUISettings = loadUISettings;
  
    document.addEventListener('click', function() {
        scaleOptions.classList.remove('show');
    });
    
    
    scaleOptions.addEventListener('click', function(e) {
        e.stopPropagation();
    });


});

function sharePreset() {
    const playerId = document.getElementById('sharePlayerId').value;
    if (playerId) {
        $.post('http://wizating_laptop/sharepreset', JSON.stringify({ targetid: `${playerId}`, presetid: presetToShare }));
        closeSharePopup();
    } else {
        console.log('Please enter a valid Player ID.');
    }
}

function savePreset() {
    const presetName = document.getElementById('presetname').value;
    if (presetName) {

        if (!previousVehInfo) return;
        let handlingData = {}

        handlingData['name'] = `${presetName}`
        
        for (const [key, _] of Object.entries(previousVehInfo)) {
            const handlingFloat = document.getElementById(key);
            if (handlingFloat) {
                handlingData[key] = $(`#${key}`).val()
            }
        }

        $.post('http://wizating_laptop/savepreset', JSON.stringify({ handlingData : handlingData }));
    } else {
        console.log('Please enter a preset name.');
    }
}

function getChanges(oldData, newData) {
    const changes = {};

    for (const [key, newValue] of Object.entries(newData)) {
        const oldValue = oldData[key];

        if (oldValue != newValue && key != "name") {
            changes[key] = {
                oldValue: oldValue,
                newValue: newValue
            };
        }
    }

    return changes;
}

function updateChangesContainer(changes) {
    const changesContainer = document.querySelector("#changes-container");

    changesContainer.innerHTML = '';

    for (const [key, values] of Object.entries(changes)) {
        const changeItem = document.createElement("div");
        changeItem.className = "change-item";

        const keyElement = document.createElement("span");
        keyElement.textContent = `${key}: `;
        keyElement.className = "key";
        changeItem.appendChild(keyElement);

        const oldValueElement = document.createElement("span");
        oldValueElement.textContent = values.oldValue !== undefined ? values.oldValue : "N/A";
        oldValueElement.className = "old-value";
        changeItem.appendChild(oldValueElement);

        const arrowElement = document.createElement("span");
        arrowElement.textContent = " → ";
        arrowElement.className = "arrow";
        changeItem.appendChild(arrowElement);


        const newValueElement = document.createElement("span");
        newValueElement.textContent = values.newValue;
        newValueElement.className = "new-value";
        changeItem.appendChild(newValueElement);


        const revertButton = document.createElement("button");
        revertButton.innerHTML = '<i class="fas fa-trash"></i>';
        revertButton.className = "revert-button";
        revertButton.onclick = () => revertChange(key, values.oldValue, changeItem);
        changeItem.appendChild(revertButton);


        changesContainer.appendChild(changeItem);

        
    }
}

function revertChange(key, oldValue, changeItem) {
    if (!previousVehInfo) return;

    const inputElement = document.getElementById(key);
    if (inputElement) {
        inputElement.value = oldValue;

    }


    const sliderElement = document.getElementById(`${key}S`);
    if (sliderElement) {
        sliderElement.value = oldValue;
    }

    $.post('http://wizating_laptop/setHandlingSingle', JSON.stringify({ float: key, value: oldValue }));
    changeItem.remove();
}



