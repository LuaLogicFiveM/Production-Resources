$(document).ready(function() {
  const imageCanvas = document.getElementById('image-graffiti-canvas');
  const imageCtx = imageCanvas.getContext('2d');
  const STORAGE_KEY = 'imageGraffitiTemplates';
  
  let imageStyles = {
    width: 200,
    height: 200,
    rotation: 0,
    filter: 'none',
    filterIntensity: 50,
    bgType: 'color',
    bgColor: '#121212',
    bgOpacity: 0,
    bgPattern: 'grid'
  };
  
  let isDragging = false;
  let dragStartX = 0;
  let dragStartY = 0;
  let imageElements = [];
  let activeImageElement = null;
  let savedTemplates = [];
  let availableImages = [];
  let modalState = {
    resolve: null,
    reject: null,
    currentModal: null
  };

  function loadSavedTemplates() {
    const storedTemplates = JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
    savedTemplates = storedTemplates;
  }

	function populateImageSelect() {
	  const select = $('#image-select');
	  const previewContainer = $('#image-preview-container');
	  const preview = $('#image-preview');
	  const placeholder = $('.image-preview-placeholder');
	  
	  select.empty();
	  select.append('<option value="">Select an image</option>');
	  
	  if (!availableImages || !Array.isArray(availableImages)) {
		console.error('availableImages is not an array:', availableImages);
		return;
	  }
	  
	  availableImages.forEach(image => {
		if (image && image.name && image.label) {
		  const option = $(`<option value="${image.name}">${image.label}</option>`);
		  option.data('path', image.path);
		  select.append(option);
		}
	  });

	  select.change(function() {
		const selectedOption = $(this).find('option:selected');
		if (selectedOption.val() === "") {
		  preview.hide();
		  placeholder.show();
		  return;
		}
		
		const imgPath = selectedOption.data('path');
		if (imgPath) {
		  preview.attr('src', imgPath).on('load', function() {
			placeholder.hide();
			preview.show();
		  }).on('error', function() {
			placeholder.show().text('Preview not available');
			preview.hide();
		  });
		} else {
		  placeholder.show().text('Preview not available');
		  preview.hide();
		}
	  });
	}


  function showModal(modalId) {
    return new Promise((resolve, reject) => {
      modalState.resolve = resolve;
      modalState.reject = reject;
      modalState.currentModal = modalId;
      $(`#${modalId}`).fadeIn(200);
    });
  }

  function hideModal(modalId) {
    $(`#${modalId}`).fadeOut(200);
    modalState.currentModal = null;
  }

  $('#image-modal-confirm-btn').click(() => {
    const value = $('#modal-image-input').val();
    hideModal('image-input-modal');
    if (modalState.resolve) {
      modalState.resolve(value);
    }
  });

  $('#image-modal-cancel-btn').click(() => {
    hideModal('image-input-modal');
    if (modalState.reject) {
      modalState.reject(new Error('User cancelled'));
    }
  });

  $('#image-template-confirm-btn').click(() => {
    const value = $('#image-template-select').val();
    hideModal('image-template-select-modal');
    if (modalState.resolve) {
      modalState.resolve(value);
    }
  });

  $('#image-template-cancel-btn').click(() => {
    hideModal('image-template-select-modal');
    if (modalState.reject) {
      modalState.reject(new Error('User cancelled'));
    }
  });
  
 // Add URL button click handler
$('#image-add-url-btn').click(function() {
  showImageUrlModal();
});

$('#image-url-confirm-btn').click(function() {
  const rawUrl = $('#modal-image-url-input').val().trim();

  // 2. Kontrola formátu URL
  let urlObj;
  try {
    // Přidá http:// pokud chybí schéma
    let fixedUrl = rawUrl;
    if (!rawUrl.match(/^https?:\/\//)) {
      fixedUrl = rawUrl.startsWith('www.') ? `http://${rawUrl}` : `http://${rawUrl}`;
    }
    urlObj = new URL(fixedUrl);
  } catch (e) {
    return;
  }

  // 3. Přísná kontrola přípony
  const allowedExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.webp', '.svg'];
  const path = urlObj.pathname.toLowerCase();
  const hasValidExtension = allowedExtensions.some(ext => path.endsWith(ext));
  
  if (!hasValidExtension) {
    const extensionsList = allowedExtensions.join(', ');
    sendNotification(`URL musí končit na: ${extensionsList}`);
    return;
  }

  $.post(`https://${graffitiresourcename}/graffitiDone2`, JSON.stringify({
    dataurlimage: rawUrl 
  }));
  
  closeImageEditor();
  $('#modal-image-url-input').val('');
  hideModal('image-url-modal');
});
$('#image-url-cancel-btn').click(function() {
  $('#modal-image-url-input').val('');
  hideModal('image-url-modal');
});

function showImageUrlModal() {
  $('#image-url-modal').fadeIn(200);
}

function hideImageUrlModal() {
  $('#image-url-modal').fadeOut(200);
} 

  function initImageCanvas() {
    drawBackgroundOnly();
    imageCtx.fillStyle = 'transparent';
    imageCtx.fillRect(0, 0, imageCanvas.width, imageCanvas.height);
  }

  function drawBackgroundOnly() {
    imageCtx.clearRect(0, 0, imageCanvas.width, imageCanvas.height);
    
    if (imageStyles.bgType === 'color') {
      imageCtx.fillStyle = imageStyles.bgColor;
      imageCtx.globalAlpha = imageStyles.bgOpacity / 100;
      imageCtx.fillRect(0, 0, imageCanvas.width, imageCanvas.height);
      imageCtx.globalAlpha = 1.0;
    } else {
      drawPatternBackground();
    }
  }

  function drawPatternBackground() {
    imageCtx.save();
    imageCtx.globalAlpha = imageStyles.bgOpacity / 100;
    
    switch(imageStyles.bgPattern) {
      case 'grid':
        imageCtx.fillStyle = '#121212';
        imageCtx.fillRect(0, 0, imageCanvas.width, imageCanvas.height);
        break;
      case 'bricks':
        drawBrickPattern();
        break;
      case 'concrete':
        drawConcretePattern();
        break;
      case 'noise':
        drawNoisePattern();
        break;
      case 'metal':
        drawMetalPattern();
        break;
      case 'wood':
        drawWoodPattern();
        break;
    }
    
    imageCtx.restore();
  }

  function drawBrickPattern() {
    const brickWidth = 60;
    const brickHeight = 30;
    const mortar = 2;
    
    imageCtx.fillStyle = '#333333';
    imageCtx.fillRect(0, 0, imageCanvas.width, imageCanvas.height);
    
    imageCtx.fillStyle = '#555555';
    for (let y = 0; y < imageCanvas.height; y += brickHeight + mortar) {
      for (let x = 0; x < imageCanvas.width; x += brickWidth + mortar) {
        const offset = (y / (brickHeight + mortar)) % 2 === 0 ? 0 : brickWidth / 2;
        imageCtx.fillRect(x + offset, y, brickWidth, brickHeight);
      }
    }
  }

  function drawConcretePattern() {
    imageCtx.fillStyle = '#444444';
    imageCtx.fillRect(0, 0, imageCanvas.width, imageCanvas.height);
    
    imageCtx.fillStyle = '#666666';
    for (let i = 0; i < 500; i++) {
      const x = Math.random() * imageCanvas.width;
      const y = Math.random() * imageCanvas.height;
      const size = Math.random() * 3 + 1;
      imageCtx.fillRect(x, y, size, size);
    }
  }

  function drawNoisePattern() {
    const imageData = imageCtx.createImageData(imageCanvas.width, imageCanvas.height);
    const data = imageData.data;
    
    for (let i = 0; i < data.length; i += 4) {
      const value = Math.floor(Math.random() * 60) + 40;
      data[i] = value;
      data[i + 1] = value;
      data[i + 2] = value;
      data[i + 3] = 255;
    }
    
    imageCtx.putImageData(imageData, 0, 0);
  }

  function drawMetalPattern() {
    imageCtx.fillStyle = '#777777';
    imageCtx.fillRect(0, 0, imageCanvas.width, imageCanvas.height);
    
    const plateWidth = 100;
    const plateHeight = 50;
    const plateMargin = 5;
    
    for (let y = 0; y < imageCanvas.height; y += plateHeight + plateMargin) {
      for (let x = 0; x < imageCanvas.width; x += plateWidth + plateMargin) {
        const gradient = imageCtx.createLinearGradient(x, y, x, y + plateHeight);
        gradient.addColorStop(0, '#999999');
        gradient.addColorStop(0.5, '#666666');
        gradient.addColorStop(1, '#999999');
        
        imageCtx.fillStyle = gradient;
        imageCtx.fillRect(x, y, plateWidth, plateHeight);
        
        imageCtx.fillStyle = '#333333';
        imageCtx.beginPath();
        imageCtx.arc(x + 10, y + 10, 3, 0, Math.PI * 2);
        imageCtx.fill();
        imageCtx.beginPath();
        imageCtx.arc(x + plateWidth - 10, y + 10, 3, 0, Math.PI * 2);
        imageCtx.fill();
        imageCtx.beginPath();
        imageCtx.arc(x + 10, y + plateHeight - 10, 3, 0, Math.PI * 2);
        imageCtx.fill();
        imageCtx.beginPath();
        imageCtx.arc(x + plateWidth - 10, y + plateHeight - 10, 3, 0, Math.PI * 2);
        imageCtx.fill();
      }
    }
  }

  function drawWoodPattern() {
    imageCtx.fillStyle = '#8B4513';
    imageCtx.fillRect(0, 0, imageCanvas.width, imageCanvas.height);
    
    imageCtx.strokeStyle = '#A0522D';
    imageCtx.lineWidth = 2;
    
    for (let i = 0; i < 20; i++) {
      const y = Math.random() * imageCanvas.height;
      const startX = Math.random() * 50;
      const endX = imageCanvas.width - Math.random() * 50;
      
      imageCtx.beginPath();
      imageCtx.moveTo(startX, y);
      
      for (let x = startX; x <= endX; x += 10) {
        const offset = Math.random() * 4 - 2;
        imageCtx.lineTo(x, y + offset);
      }
      
      imageCtx.stroke();
    }
  }

  function drawImageElement(element) {
    imageCtx.save();
    imageCtx.translate(element.x + element.width/2, element.y + element.height/2);
    imageCtx.rotate(element.rotation * Math.PI / 180);
    
    let filterString = '';
    if (element.filter !== 'none') {
      const intensity = element.filterIntensity/100;
      switch(element.filter) {
        case 'grayscale':
          filterString = `grayscale(${intensity})`;
          break;
        case 'sepia':
          filterString = `sepia(${intensity})`;
          break;
        case 'invert':
          filterString = `invert(${intensity})`;
          break;
        case 'blur':
          filterString = `blur(${intensity * 5}px)`;
          break;
        case 'hue':
          filterString = `hue-rotate(${intensity * 360}deg)`;
          break;
        case 'brightness':
          filterString = `brightness(${0.5 + intensity * 1.5})`;
          break;
        case 'contrast':
          filterString = `contrast(${0.5 + intensity * 1.5})`;
          break;
        case 'saturate':
          filterString = `saturate(${0.5 + intensity * 1.5})`;
          break;
        case 'vintage':
          filterString = `sepia(${intensity * 0.5}) contrast(${1 + intensity * 0.5}) brightness(${1 - intensity * 0.1})`;
          break;
        case 'pixelate':
          const pixelSize = Math.max(1, Math.floor(intensity * 10));
          const w = element.width;
          const h = element.height;
          
          imageCtx.drawImage(element.image, -w/2, -h/2, w/pixelSize, h/pixelSize);
          
          const tempCanvas = document.createElement('canvas');
          const tempCtx = tempCanvas.getContext('2d');
          tempCanvas.width = w;
          tempCanvas.height = h;
          tempCtx.imageSmoothingEnabled = false;
          tempCtx.drawImage(imageCanvas, 
            element.x + element.width/2 - w/(pixelSize*2), 
            element.y + element.height/2 - h/(pixelSize*2), 
            w/pixelSize, h/pixelSize, 
            0, 0, w, h);
          
          imageCtx.restore();
          imageCtx.drawImage(tempCanvas, 0, 0);
          return;
      }
      imageCtx.filter = filterString;
    }
    
    imageCtx.drawImage(element.image, -element.width/2, -element.height/2, element.width, element.height);
    imageCtx.restore();
  }

  function redrawAllImageElements() {
    drawBackgroundOnly();
    imageElements.forEach(drawImageElement);
  }

  function addImageToCanvas(imageName, x, y) {
    if (!availableImages || !Array.isArray(availableImages)) {
        console.error('availableImages is not properly initialized');
        return;
    }
    
    const selectedImage = availableImages.find(img => img && img.name === imageName);
    if (!selectedImage) {
      sendNotification('Selected image not found');
      return;
    }
    
    const img = new Image();
    img.onload = function() {
      const newImage = {
        name: imageName,
        image: img,
        x: x,
        y: y,
        width: imageStyles.width,
        height: imageStyles.height,
        rotation: imageStyles.rotation,
        filter: imageStyles.filter,
        filterIntensity: imageStyles.filterIntensity
      };
      
      imageElements.push(newImage);
      activeImageElement = newImage;
      redrawAllImageElements();
    };
    img.src = selectedImage.path;
  }

  function sendNotification(message) {
    $.post(`https://${graffitiresourcename}/notify`, JSON.stringify({
      message: message
    }));
  }

  function updateUIWithCurrentStyles() {
    $('#image-width-slider').val(imageStyles.width);
    $('#image-width-value').text(imageStyles.width + 'px');
    $('#image-height-slider').val(imageStyles.height);
    $('#image-height-value').text(imageStyles.height + 'px');
    $('#image-rotation-slider').val(imageStyles.rotation);
    $('#image-rotation-value').text(imageStyles.rotation + '°');
    $('#image-filter-slider').val(imageStyles.filterIntensity);
    $('#image-filter-value').text(imageStyles.filterIntensity + '%');
    $('#image-bg-color-picker').val(imageStyles.bgColor);
    $('#image-bg-opacity-slider').val(imageStyles.bgOpacity);
    $('#image-bg-opacity-value').text(imageStyles.bgOpacity + '%');
    $('#image-bg-pattern-select').val(imageStyles.bgPattern);
    
    $('.image-filter-btn').removeClass('active');
    if (imageStyles.filter !== 'none') {
      $(`#image-${imageStyles.filter}-btn`).addClass('active');
    }
    
    $('.image-bg-option-btn').removeClass('active');
    $(`#image-bg-${imageStyles.bgType}-btn`).addClass('active');
    
    $('#image-bg-color-control').toggle(imageStyles.bgType === 'color');
    $('#image-bg-pattern-control').toggle(imageStyles.bgType === 'pattern');
  }

  function getImageAtPosition(x, y) {
    for (let i = imageElements.length - 1; i >= 0; i--) {
      const element = imageElements[i];
      
      imageCtx.save();
      imageCtx.translate(element.x + element.width/2, element.y + element.height/2);
      imageCtx.rotate(element.rotation * Math.PI / 180);
      
      const localX = x - (element.x + element.width/2);
      const localY = y - (element.y + element.height/2);
      
      const rotatedX = localX * Math.cos(-element.rotation * Math.PI / 180) - localY * Math.sin(-element.rotation * Math.PI / 180);
      const rotatedY = localX * Math.sin(-element.rotation * Math.PI / 180) + localY * Math.cos(-element.rotation * Math.PI / 180);
      
      imageCtx.restore();
      
      if (rotatedX >= -element.width/2 && rotatedX <= element.width/2 && 
          rotatedY >= -element.height/2 && rotatedY <= element.height/2) {
        return element;
      }
    }
    return null;
  }

  async function saveCurrentTemplate() {
    if (imageElements.length === 0) {
      sendNotification('No images to save - add some images first');
      return;
    }
    
    try {
      const templateName = await showModal('image-input-modal');
      $('#modal-image-input').val('');
      
      if (!templateName || templateName.trim() === '') {
        sendNotification('Template name cannot be empty');
        return;
      }
      
      const serializedElements = imageElements.map(el => {
        return {
          name: el.name,
          x: el.x,
          y: el.y,
          width: el.width,
          height: el.height,
          rotation: el.rotation,
          filter: el.filter,
          filterIntensity: el.filterIntensity
        };
      });
      
      const template = {
        name: templateName,
        elements: serializedElements,
        styles: {...imageStyles},
        timestamp: new Date().toISOString()
      };
      
      const existingTemplates = JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
      const existingIndex = existingTemplates.findIndex(t => t.name === templateName);
      
      if (existingIndex >= 0) {
        existingTemplates[existingIndex] = template;
        sendNotification(`Template "${templateName}" updated!`);
      } else {
        existingTemplates.push(template);
        sendNotification(`Template "${templateName}" saved!`);
      }
      
      localStorage.setItem(STORAGE_KEY, JSON.stringify(existingTemplates));
      savedTemplates = existingTemplates;
    } catch (error) {
      // User cancelled
    }
  }

  async function loadTemplate() {
    const storedTemplates = JSON.parse(localStorage.getItem(STORAGE_KEY)) || [];
    savedTemplates = storedTemplates;
    
    if (savedTemplates.length === 0) {
      sendNotification('No templates saved yet');
      return;
    }
    
    try {
      const templateSelect = $('#image-template-select');
      templateSelect.empty();
      savedTemplates.forEach(template => {
        templateSelect.append(`<option value="${template.name}">${template.name}</option>`);
      });
      
      const selectedName = await showModal('image-template-select-modal');
      
      if (!selectedName) return;
      
      const template = savedTemplates.find(t => t.name === selectedName);
      if (!template) {
        sendNotification(`Template "${selectedName}" not found`);
        return;
      }
      
      imageElements = [];
      
      const loadPromises = template.elements.map(async el => {
        const selectedImage = availableImages.find(img => img.name === el.name);
        if (!selectedImage) return;
        
        return new Promise((resolve) => {
          const img = new Image();
          img.onload = function() {
            resolve({
              name: el.name,
              image: img,
              x: el.x,
              y: el.y,
              width: el.width,
              height: el.height,
              rotation: el.rotation,
              filter: el.filter,
              filterIntensity: el.filterIntensity
            });
          };
          img.src = selectedImage.path;
        });
      });
      
      const loadedElements = await Promise.all(loadPromises);
      imageElements = loadedElements.filter(el => el !== undefined);
      
      imageStyles = {...template.styles};
      activeImageElement = null;
      
      updateUIWithCurrentStyles();
      redrawAllImageElements();
      
      sendNotification(`Template "${selectedName}" loaded!`);
    } catch (error) {
     
    }
  }

  $('#image-bring-front-btn').click(function() {
    if (!activeImageElement) {
      sendNotification('Select image to bring to front');
      return;
    }
    
    imageElements = imageElements.filter(el => el !== activeImageElement);
    imageElements.push(activeImageElement);
    redrawAllImageElements();
  });

  $('#image-save-template-btn').click(saveCurrentTemplate);
  $('#image-load-template-btn').click(loadTemplate);

  $('.image-filter-btn').click(function() {
    const filter = $(this).data('filter');
    
    if (imageStyles.filter === filter) {
      imageStyles.filter = 'none';
      $(this).removeClass('active');
    } else {
      imageStyles.filter = filter;
      $('.image-filter-btn').removeClass('active');
      $(this).addClass('active');
    }
    
    if (activeImageElement) {
      activeImageElement.filter = imageStyles.filter;
      redrawAllImageElements();
    }
  });

  $('.image-bg-option-btn').click(function() {
    const bgType = $(this).data('bgtype');
    imageStyles.bgType = bgType;
    
    $('.image-bg-option-btn').removeClass('active');
    $(this).addClass('active');
    
    $('#image-bg-color-control').toggle(bgType === 'color');
    $('#image-bg-pattern-control').toggle(bgType === 'pattern');
    
    redrawAllImageElements();
  });

  $('#image-filter-slider').on('input', function() {
    imageStyles.filterIntensity = $(this).val();
    $('#image-filter-value').text(imageStyles.filterIntensity + '%');
    if (activeImageElement) {
      activeImageElement.filterIntensity = imageStyles.filterIntensity;
      redrawAllImageElements();
    }
  });

  $('#image-width-slider').on('input', function() {
    imageStyles.width = parseInt($(this).val());
    $('#image-width-value').text(imageStyles.width + 'px');
    if (activeImageElement) {
      activeImageElement.width = imageStyles.width;
      redrawAllImageElements();
    }
  });

  $('#image-height-slider').on('input', function() {
    imageStyles.height = parseInt($(this).val());
    $('#image-height-value').text(imageStyles.height + 'px');
    if (activeImageElement) {
      activeImageElement.height = imageStyles.height;
      redrawAllImageElements();
    }
  });

  $('#image-rotation-slider').on('input', function() {
    imageStyles.rotation = $(this).val();
    $('#image-rotation-value').text(imageStyles.rotation + '°');
    if (activeImageElement) {
      activeImageElement.rotation = imageStyles.rotation;
      redrawAllImageElements();
    }
  });

  $('#image-bg-color-picker').on('input', function() {
    imageStyles.bgColor = $(this).val();
    redrawAllImageElements();
  });

  $('#image-bg-opacity-slider').on('input', function() {
    imageStyles.bgOpacity = $(this).val();
    $('#image-bg-opacity-value').text(imageStyles.bgOpacity + '%');
    redrawAllImageElements();
  });

  $('#image-bg-pattern-select').change(function() {
    imageStyles.bgPattern = $(this).val();
    redrawAllImageElements();
  });

  $('#image-add-btn').click(function() {
    const selectedImage = $('#image-select').val();
    if (!selectedImage) {
      sendNotification('Select an image first');
      return;
    }
    
    const rect = imageCanvas.getBoundingClientRect();
    addImageToCanvas(selectedImage, rect.width/2, rect.height/2);
  });

  $('#image-delete-btn').click(function() {
    if (!activeImageElement) {
      sendNotification('No image selected to delete');
      return;
    }
    imageElements = imageElements.filter(el => el !== activeImageElement);
    activeImageElement = null;
    redrawAllImageElements();
  });

  $('#image-clear-btn').click(function() {
    imageCtx.clearRect(0, 0, imageCanvas.width, imageCanvas.height);
    imageElements = [];
    activeImageElement = null;
    drawBackgroundOnly();
  });

  imageCanvas.addEventListener('mousedown', function(e) {
    const rect = imageCanvas.getBoundingClientRect();
    const x = e.clientX - rect.left;
    const y = e.clientY - rect.top;

    const clickedImage = getImageAtPosition(x, y);

    if (clickedImage) {
      activeImageElement = clickedImage;
      isDragging = true;
      dragStartX = x - activeImageElement.x;
      dragStartY = y - activeImageElement.y;
      updateUIWithCurrentStyles();
      e.preventDefault();
      return;
    } else {
      activeImageElement = null;
    }
  });

  imageCanvas.addEventListener('mousemove', function(e) {
    if (!isDragging || !activeImageElement) return;
    
    const rect = imageCanvas.getBoundingClientRect();
    const x = e.clientX - rect.left - dragStartX;
    const y = e.clientY - rect.top - dragStartY;
    
    activeImageElement.x = x;
    activeImageElement.y = y;
    redrawAllImageElements();
  });

  imageCanvas.addEventListener('mouseup', function() {
    isDragging = false;
  });

  imageCanvas.addEventListener('mouseout', function() {
    isDragging = false;
  });

  $('#image-submit-btn').click(function() {
    if (imageElements.length === 0) {
      sendNotification('No images to submit - add some images first');
      return;
    }
    
    const dataURL = imageCanvas.toDataURL();
    $.post(`https://${graffitiresourcename}/graffitiDone`, JSON.stringify({
      dataurlimage: dataURL
    }));	
    closeImageEditor();
  });

  $('#image-close-btn').click(function() {
    closeImageEditor();
  });

  function closeImageEditor() {
    closeImageMain();
    $('.image-graffiti-container').hide();
    $.post(`https://${graffitiresourcename}/closeImageEditor`);
  }

  function closeImageMain() {
    $("body").css("display", "none");
  }

  function openImageMain() {
    $("body").css("display", "block");
  }

  window.addEventListener('message', function(event) {
    const item = event.data;
    
    if (item.message === "imagegraffitishow") {
 	  $('#image-add-url-btn').hide();
     if (item.linkimagesallowed === true) {
		 $('#image-add-url-btn').show();
	 }     
	  openImageMain();
	 $('#image-graffiti-container').fadeIn(300);
      $('#image-editor-container').show();
      initImageCanvas();	
    }
  if (item.message === 'receiveAvailableImages') {
    availableImages = Array.isArray(item.imagesdata) ? item.imagesdata : [];
    populateImageSelect();
    
    if (availableImages.length > 0) {
      $('#image-select').val(availableImages[0].name).trigger('change');
    }
  }    
	
  });
  
  loadSavedTemplates();
  initImageCanvas();
});