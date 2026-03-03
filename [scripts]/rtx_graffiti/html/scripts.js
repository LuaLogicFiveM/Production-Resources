var graffitiresourcename = "rtx_graffiti";

$(document).ready(function() {
  function showGraffitiMenu() {
    $("body").css("display", "flex");
    $("#graffiti-menu-container").fadeIn(300);
  }

  function hideGraffitiMenu() {
	  $("body").css("display", "none");
    $("#graffiti-menu-container").fadeOut(300);
  }

  $("#menu-close-btn").click(function() {
    hideGraffitiMenu();
    $("body").css("display", "none");
    $.post(`https://${graffitiresourcename}/closeeditor`);
  });

  $("#draw-option").click(function() {
    hideGraffitiMenu();
    $.post(`https://${graffitiresourcename}/selectedtype1`);
  });

  $("#text-option").click(function() {
    hideGraffitiMenu();
    $.post(`https://${graffitiresourcename}/selectedtype2`);
  });

  $("#image-option").click(function() {
    hideGraffitiMenu();
    $.post(`https://${graffitiresourcename}/selectedtype3`);
  });

  window.addEventListener('message', function(event) {
    const item = event.data;
    
    if (item.message === "showGraffitiMenu") {
     $('#draw-option').hide();
	 $('#text-option').hide();
	 $('#image-option').hide();
	 if (item.drawtype === true) {
		 $('#draw-option').show();
	 }     
     if (item.texttype === true) {
		 $('#text-option').show();
	 }     
     if (item.imagetype === true) {
		 $('#image-option').show();
	 }     	 
      showGraffitiMenu();
    }
	
	if (item.message == "updateinterfacedata") {
		graffitiresourcename = item.graffitiresourcenamedata;
		let root = document.documentElement;
		root.style.setProperty('--color', item.interfacecolordata);	
	}	
    
  });
});