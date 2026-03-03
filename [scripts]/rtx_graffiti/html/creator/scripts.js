window.addEventListener('message', function (event) {

	var item = event.data;
			
	if (item.message == "updateimage") {
        const img = document.getElementById("graffiti");
        img.src = item.newimagedata;
	}	
	if (item.message == "opacitychange") {
        document.body.style.opacity = item.opacityvalue;
	}			
});