var attractionresourcename = "rtx_spawnableattractions";

function closeMain() {
	$("body").css("display", "none");
}

function openMain() {
	$("body").css("display", "block");
}

$(".closebumpercarsbuy").click(function(){
	$.post('https://'+attractionresourcename+'/closebumper', JSON.stringify({}));
});

$(".closeattractionposfinish").click(function(){
	$.post('https://'+attractionresourcename+'/closeattractionoffsets', JSON.stringify({}));
});

function AttractionCreatorPrepareInterface() {
  let reformated1 = document.getElementById("cameraspeeddata");
  var value = (reformated1.value-reformated1.min)/(reformated1.max-reformated1.min)*100
  reformated1.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'  
  let reformated2 = document.getElementById("lookspeedxdata");
  var value = (reformated2.value-reformated2.min)/(reformated2.max-reformated2.min)*100
  reformated2.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'  
  let reformated3 = document.getElementById("lookspeedydata");
  var value = (reformated3.value-reformated3.min)/(reformated3.max-reformated3.min)*100
  reformated3.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'  
  let reformated4 = document.getElementById("translatesnapdata");
  var value = (reformated4.value-reformated4.min)/(reformated4.max-reformated4.min)*100
  reformated4.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'  
  let reformated5 = document.getElementById("rotationsnapdata");
  var value = (reformated5.value-reformated5.min)/(reformated5.max-reformated5.min)*100
  reformated5.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'  
}

AttractionCreatorPrepareInterface();

document.getElementById("cameraspeeddata").oninput = function() {
  var value = (this.value-this.min)/(this.max-this.min)*100
  this.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'
};

document.getElementById("lookspeedxdata").oninput = function() {
  var value = (this.value-this.min)/(this.max-this.min)*100
  this.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'
};

document.getElementById("lookspeedydata").oninput = function() {
  var value = (this.value-this.min)/(this.max-this.min)*100
  this.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'
};

document.getElementById("translatesnapdata").oninput = function() {
  var value = (this.value-this.min)/(this.max-this.min)*100
  this.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'
};

document.getElementById("rotationsnapdata").oninput = function() {
  var value = (this.value-this.min)/(this.max-this.min)*100
  this.style.background = 'linear-gradient(to right, #ff66ff 0%, #ff66ff ' + value + '%, #ccccc8 ' + value + '%, #ccccc8 100%)'
};

window.addEventListener('message', function (event) {

	var item = event.data;
	if (item.message == "infonotifyshow") {
		document.getElementsByClassName("infonotifytext")[0].innerHTML = item.infonotifytext;
		openMain();
		$("#infonotifyshow").show();	
	}
	
	if (item.message == "bumpercarsbuyshow") {
		openMain();
		var inputhandler = document.getElementById("bumpercarstimesliderdata");
		inputhandler.setAttribute("max", item.bumpermaxminutesdata);	
		inputhandler.setAttribute("min", item.bumperminminutesdata);	
		$("#gymentrypricesliderdata").val(item.bumperminminutesdata); 
		document.getElementById("bumpercarstimeminutedata").innerHTML = item.bumperminminutesdata;
		document.getElementById("bumpercarspricedata").innerHTML = item.bumperpricedata;
		$("#bumpercarmainshow").hide();	
		$("#ferrisshow").hide();	
		$("#shooterendshow").hide();	
		$("#shootershow").hide();		
		$("#attractionshow").hide();
		$("#parkattractionshow").hide();
		$("#bumpercarsbuyshow").show();		
	}	
	
	if (item.message == "bumperbuyupdateprice") {
		document.getElementById("bumpercarspricedata").innerHTML = item.bumperpricedata;	
	}	

	if (item.message == "bumpercarsshow") {
		openMain();
		if (item.bumperdriver == true) {
			$("#bumpercartimetextshow").show();	
		} else {	
			$("#bumpercartimetextshow").hide();	
		}	
		document.getElementById("bumpercarleavetextkey").innerHTML = item.bumperleavekeydata;
		$("#bumpercarsbuyshow").hide();	
		$("#ferrisshow").hide();	
		$("#shooterendshow").hide();	
		$("#shootershow").hide();		
		$("#attractionshow").hide();
		$("#parkattractionshow").hide();	
		$("#bumpercarmainshow").show();		
	}	
	
	if (item.message == "bumperupdatetime") {
		document.getElementById("bumpercartimetextdata").innerHTML = item.bumpertimedata;	
	}	

	if (item.message == "ferrisshow") {
		openMain();
		$("#bumpercarsbuyshow").hide();	
		$("#bumpercarmainshow").hide();		
		$("#attractionshow").hide();
		$("#parkattractionshow").hide();
		$("#ferrisshow").show();		
	}		
	
	if (item.message == "shootershow") {
		openMain();
		$("#bumpercarsbuyshow").hide();	
		$("#bumpercarmainshow").hide();	
		$("#ferrisshow").hide();	
		$("#shooterendshow").hide();	
		$("#attractionshow").hide();
		$("#parkattractionshow").hide();
		$("#shootershow").show();	
		document.getElementById("shootershottextdata").innerHTML = item.shootsdata;	
		document.getElementById("shootermissestextdata").innerHTML = item.missdata;	
		document.getElementById("shootertimetextdata").innerHTML = item.timedata;	
	}	

	if (item.message == "shooterhit") {
		document.getElementById("shootertexthitdata").innerHTML = item.hittext;	
		$("#shootertexthitshow").fadeIn("fast");
		setTimeout(function() {
			$("#shootertexthitshow").fadeOut("fast");
		}, 1000);		
	}	

	if (item.message == "shooterendshow") {
		openMain();
		$("#bumpercarsbuyshow").hide();	
		$("#bumpercarmainshow").hide();	
		$("#ferrisshow").hide();	
		$("#shootershow").hide();			
		$("#attractionshow").hide();
		$("#shooterendshow").show();	
		document.getElementById("shooterendshootstextdata").innerHTML = item.shootsdata;	
		document.getElementById("shooterendmissestextdata").innerHTML = item.missdata;	
		$("#shooterendshow").fadeIn("slow");
		setTimeout(function() {
			$("#shooterendshow").fadeOut("slow");
		}, 2500);		
	}

	if (item.message == "attractionhow") {
		openMain();
		$("#bumpercarsbuyshow").hide();	
		$("#bumpercarmainshow").hide();	
		$("#ferrisshow").hide();	
		$("#shootershow").hide();			
		$("#shooterendshow").hide();
		$("#parkattractionshow").hide();
		if (item.attractionanimchange == true) {
			$("#attractionanimtextshow").show();	
		} else {	
			$("#attractionanimtextshow").hide();	
		}			
		$("#attractionshow").show();
	}			
	
	if (item.message == "hide") {
		$("#infonotifyshow").hide();	
	}	
	
	if (item.message == "hidebumperpay") {
		$("#bumpercarsbuyshow").hide();	
	}	
	
	if (item.message == "hidebumpercars") {
		$("#bumpercarmainshow").hide();	
	}		
	
	if (item.message == "hideferris") {
		$("#ferrisshow").hide();	
	}		

	if (item.message == "hideattraction") {
		$("#attractionshow").hide();	
	}		
	
	if (item.message == "hideshooter") {
		$("#shootershow").hide();	
	}		
	
	if (item.message == "attractioncreatorcreatorshow") {		
		$("#cameraspeeddata").val(""); 
		$("#lookspeedxdata").val(""); 
		$("#lookspeedydata").val(""); 
		$("#translatesnapdata").val(""); 
		$("#rotationsnapdata").val(""); 
		AttractionCreatorPrepareInterface();
		$("#posmoretranslate").addClass("active");
		$("#posmorerotation").removeClass("active");
		$("#spacebuttonworld").addClass("active");
		$("#spacebuttonlocal").removeClass("active");		
		$("#attractionshow").hide();
		$("#attractionposfinishshow").hide();	
		$("#attractionposshow").show();	
		openMain();
	}		
	
	if (item.message == "attractionposfinishshow") {
		var offsetdataattractioncreator = 
		'	{\n' +
		'		attractiontype = "' + item.attractioncreatortypedata + '",\n' +
		'		coords = ' + item.attractioncreatorposcoordsdata + ',\n' +
		'		rotation = ' + item.attractioncreatorposrotationdata + ',\n' +
		'		ticket = false,\n' +
		'	},';
		$(".attractionposfinishcopytextdata").val(offsetdataattractioncreator); 
		$("#attractionshow").hide();
		$("#attractionposshow").hide();
		$("#attractionposfinishshow").show();	
		openMain();
	}			
	
	if (item.message == "updateinterfacedata") {
		attractionresourcename = item.themeparkspawnresourcenamedata;
		let root = document.documentElement;
		root.style.setProperty('--color', item.interfacecolordata);	
	}	
	
	if (item.message == "updateattractiontype") {
		document.getElementsByClassName("posattractioncreatorypedatatext")[0].innerHTML = item.attractioncreatortypedata;
	}	
	
	if (item.message == "hidecreator") {
		$("#attractionposfinishshow").hide();			
		closeMain();
	}
	
});

function bumpercarstimesliderupdate(e) {
	document.getElementById("bumpercarstimeminutedata").innerHTML = e.value;
	$.post('https://'+attractionresourcename+'/calculatepricebumper', JSON.stringify({
		bumperselectedminutes: e.value
	}));		
}

$(".bumpercarsbuybutton").click(function () {
	$.post('https://'+attractionresourcename+'/payforbumper', JSON.stringify({}));
});

$("#posmoretranslate").click(function () {
	$(this).addClass("active");
	$("#posmorerotation").removeClass("active");
	$.post('https://'+attractionresourcename+'/attractioncreatorchangemode', JSON.stringify({
		modetype: "translate"
	})); 		
});

$("#posmorerotation").click(function () {
	$(this).addClass("active");
	$("#posmoretranslate").removeClass("active");
	$.post('https://'+attractionresourcename+'/attractioncreatorchangemode', JSON.stringify({
		modetype: "rotate"
	})); 	
});

$("#spacebuttonworld").click(function () {
	$(this).addClass("active");
	$("#spacebuttonlocal").removeClass("active");
	$.post('https://'+attractionresourcename+'/attractioncreatorchangespace', JSON.stringify({
		spacetype: "world"
	})); 		
});

$(".posattractionrighttext").click(function () {
	$.post('https://'+attractionresourcename+'/attractioncreatorchangetypeplus', JSON.stringify({}));
});

$(".posattractionlefttext").click(function () {
	$.post('https://'+attractionresourcename+'/attractioncreatorchangetypeminus', JSON.stringify({}));
});

$(".buttoncopy").click(function () {
  var copyText = document.getElementById("attractionposfinishcopydata");

  copyText.select();
  copyText.setSelectionRange(0, 99999);
});

$(".createattractioncreatorbutton").click(function () {
	$.post('https://'+attractionresourcename+'/attractioncreatoroffsetget', JSON.stringify({}));
});

$("#spacebuttonlocal").click(function () {
	$(this).addClass("active");
	$("#spacebuttonworld").removeClass("active");
	$.post('https://'+attractionresourcename+'/attractioncreatorchangespace', JSON.stringify({
		spacetype: "local"
	})); 	
});

function cameraspeedchange(e) {
	$.post('https://'+attractionresourcename+'/attractioncreatorspeedchange', JSON.stringify({
		speedtype: "camera",
		speeddata: e.value
	})); 
}

function lookspeedxchange(e) {
	$.post('https://'+attractionresourcename+'/attractioncreatorspeedchange', JSON.stringify({
		speedtype: "lookx",
		speeddata: e.value
	})); 
}

function lookspeedychange(e) {
	$.post('https://'+attractionresourcename+'/attractioncreatorspeedchange', JSON.stringify({
		speedtype: "looky",
		speeddata: e.value
	})); 
}

function translatesnapchange(e) {
	$.post('https://'+attractionresourcename+'/attractioncreatorsnapchange', JSON.stringify({
		snaptype: "translate",
		snapdata: e.value
	})); 
}

function rotationsnapchange(e) {
	$.post('https://'+attractionresourcename+'/attractioncreatorsnapchange', JSON.stringify({
		snaptype: "rotate",
		snapdata: e.value
	})); 
}