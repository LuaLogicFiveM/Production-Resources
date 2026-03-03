function closeMainControls() {
$("body").css("display", "none");
}

function openMainControls() {
$("body").css("display", "block");
}

function setPlacementMode(mode) {
  const element = document.getElementById('placement-mode');
  if (mode === 1) {
    element.textContent = 'MANUAL';
    element.style.color = '#ff66ff';
  } else if (mode === 2) {
    element.textContent = 'AUTO';
    element.style.color = '#ff66ff';
  }
}

function setScaleMode(mode) {
  const element = document.getElementById('scale-mode');
  switch(mode) {
    case 1:
      element.textContent = 'COMBINED';
      element.style.color = '#ff66ff';
      break;
    case 2:
      element.textContent = 'X AXIS';
      break;
    case 3:
      element.textContent = 'Y AXIS';
      break;
    default:
      element.textContent = 'COMBINED';
      element.style.color = '#ff66ff';
  }
}

window.addEventListener('message', function(event) {
	const item = event.data;

	if (item.message === "controlsshow") {
		openMain()
		$("#controls-container").show();	
	}
	
	if (item.message === "controlshide") {
		$("#controls-container").hide();	
	}	
	
	if (item.message === "progressshow") {
		openMain()
		if (item.progresstype === 1) {
			$(".spray2-icon").attr("class", "fas fa-spray-can spray2-icon");
			$(".spray2-text").text("Spray in progress");
		} else if (item.progresstype === 2) {
			$(".spray2-icon").attr("class", "fas fa-soap spray2-icon");
			$(".spray2-text").text("Graffiti removal in progress");
		}		
		$("#spray2-container").show();	
	}
	
	if (item.message === "progresshide") {
		$("#spray2-container").hide();	
	}	
	
	if (item.message === "placementmodechange") {
		setPlacementMode(item.placementmodedata);
	}	

	if (item.message === "scalemodechange") {
		setScaleMode(item.scalemodedata);
	}			
});