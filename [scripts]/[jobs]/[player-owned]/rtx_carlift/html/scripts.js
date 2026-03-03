var liftresourcename = "rtx_carlift";

function closeMain() {
	$("body").css("display", "none");
}
function openMain() {
	$("body").css("display", "block");
}

$(".closelift").click(function(){
    $.post('https://'+liftresourcename+'/quit', JSON.stringify({}));
});

$(".closeliftposfinish").click(function(){
	$.post('https://'+liftresourcename+'/closeliftoffsets', JSON.stringify({}));
});

function CarLiftPrepareInterface() {
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

CarLiftPrepareInterface();

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
	
	if (item.message == "liftshow") {
		$("#liftposshow").hide();
		$("#liftposfinishshow").hide();			
		$('#liftshow').show();	
		openMain();
	}

	if (item.message == "infonotifyshow") {
		document.getElementsByClassName("infonotifytext")[0].innerHTML = item.infonotifytext;
		openMain();
		$("#infonotifyshow").show();	
	}

	if (item.message == "hide") {
		$("#liftshow").hide();	
	}
	
	if (item.message == "hidenotify") {
		$("#infonotifyshow").hide();	
	}	
	
	if (item.message == "updateinterfacedata") {
		liftresourcename = item.liftresourcenamedata;
		let root = document.documentElement;
		root.style.setProperty('--color', item.interfacecolordata);	
	}		
	
	if (item.message == "carliftcreatorshow") {		
		$("#cameraspeeddata").val(""); 
		$("#lookspeedxdata").val(""); 
		$("#lookspeedydata").val(""); 
		$("#translatesnapdata").val(""); 
		$("#rotationsnapdata").val(""); 
		CarLiftPrepareInterface();
		$("#posmoretranslate").addClass("active");
		$("#posmorerotation").removeClass("active");
		$("#spacebuttonworld").addClass("active");
		$("#spacebuttonlocal").removeClass("active");		
		$("#liftshow").hide();
		$("#liftposfinishshow").hide();	
		$("#liftposshow").show();	
		openMain();
	}		
	
	if (item.message == "liftposfinishshow") {
		var offsetdatacarlift = 
		'	{\n' +
		'		coords = ' + item.carliftposcoordsdata + ',\n' +
		'		rotation = ' + item.carliftposrotationdata + ',\n' +
		'		currentheight = 0.0,\n' +
		'		objecthandler = {frame = nil, lift = nil},\n' +
		'		manipulating = false,\n' +
		'		manipulatingplayerid = nil,\n' +
		'		lifttype = ' + item.carliftpostypedata + ',\n' +
		'		buttonuppress = false,\n' +
		'		buttondownpress = false,\n' +
		'		onlyjoballowed = false,\n' +
		'		jobs = {\n' +
		'		},\n' +
		'	},';
		$(".liftposfinishcopytextdata").val(offsetdatacarlift); 
		$("#liftshow").hide();
		$("#liftposshow").hide();
		$("#liftposfinishshow").show();	
		openMain();
	}			
	
	if (item.message == "updatelifttype") {
		document.getElementsByClassName("poscarliftypedatatext")[0].innerHTML = item.carlifttypedata;
	}	
	
	if (item.message == "hide") {
		$("#liftposshow").hide();			
		closeMain();
	}
	
	if (item.message == "hidecreator") {
		$("#liftposfinishshow").hide();			
		closeMain();
	}		
	
    document.onkeyup = function (data) {
        if (open) {
            if (data.which == 27) {
				$.post('https://'+liftresourcename+'/quit', JSON.stringify({}));
            }
        }	
	};
});

$(".buttonup").mousedown(function() {
  $.post('https://'+liftresourcename+'/liftupactivated', JSON.stringify({}));
});

$(".buttonup").mouseup(function() {
  $.post('https://'+liftresourcename+'/liftupdeactivated', JSON.stringify({}));
});

$(".buttondown").mousedown(function() {
  $.post('https://'+liftresourcename+'/liftdownactivated', JSON.stringify({}));
});

$(".buttondown").mouseup(function() {
  $.post('https://'+liftresourcename+'/liftdowndeactivated', JSON.stringify({}));
});

$("#posmoretranslate").click(function () {
	$(this).addClass("active");
	$("#posmorerotation").removeClass("active");
	$.post('https://'+liftresourcename+'/carliftchangemode', JSON.stringify({
		modetype: "translate"
	})); 		
});

$("#posmorerotation").click(function () {
	$(this).addClass("active");
	$("#posmoretranslate").removeClass("active");
	$.post('https://'+liftresourcename+'/carliftchangemode', JSON.stringify({
		modetype: "rotate"
	})); 	
});

$("#spacebuttonworld").click(function () {
	$(this).addClass("active");
	$("#spacebuttonlocal").removeClass("active");
	$.post('https://'+liftresourcename+'/carliftchangespace', JSON.stringify({
		spacetype: "world"
	})); 		
});

$(".poscarlifrighttext").click(function () {
	$.post('https://'+liftresourcename+'/carliftchangetypeplus', JSON.stringify({}));
});

$(".poscarliflefttext").click(function () {
	$.post('https://'+liftresourcename+'/carliftchangetypeminus', JSON.stringify({}));
});

$(".buttoncopy").click(function () {
  var copyText = document.getElementById("liftposfinishcopydata");

  copyText.select();
  copyText.setSelectionRange(0, 99999);
});

$(".createcarliftbutton").click(function () {
	$.post('https://'+liftresourcename+'/carliftoffsetget', JSON.stringify({}));
});

$("#spacebuttonlocal").click(function () {
	$(this).addClass("active");
	$("#spacebuttonworld").removeClass("active");
	$.post('https://'+liftresourcename+'/carliftchangespace', JSON.stringify({
		spacetype: "local"
	})); 	
});

function cameraspeedchange(e) {
	$.post('https://'+liftresourcename+'/carliftspeedchange', JSON.stringify({
		speedtype: "camera",
		speeddata: e.value
	})); 
}

function lookspeedxchange(e) {
	$.post('https://'+liftresourcename+'/carliftspeedchange', JSON.stringify({
		speedtype: "lookx",
		speeddata: e.value
	})); 
}

function lookspeedychange(e) {
	$.post('https://'+liftresourcename+'/carliftspeedchange', JSON.stringify({
		speedtype: "looky",
		speeddata: e.value
	})); 
}

function translatesnapchange(e) {
	$.post('https://'+liftresourcename+'/carliftsnapchange', JSON.stringify({
		snaptype: "translate",
		snapdata: e.value
	})); 
}

function rotationsnapchange(e) {
	$.post('https://'+liftresourcename+'/carliftsnapchange', JSON.stringify({
		snaptype: "rotate",
		snapdata: e.value
	})); 
}