var yachtresourcename = "rtx_yacht";

let yachtColor = 1;
let lightType = 1;
let lightColor = 1;
let railingColor = "silver";
let flag = 1;
let upperText = "";
let bottomText = "";
let equipment = 1; 

let infurnituremenu = 0;

let infurnitureownmenu = 0;

let yachtPrice = 0;

let lightingPrices = {
    1: 1000, 
    2: 500,
};
let railingPrices = {
    "silver": 500, 
    "gold": 10000,
};

let equipmentPrices = {
    1: 0, 
    2: 25000, 
};

const furnitureNames = {}
const furnitureData = {
    chairs: [
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },	
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },		
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },		
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" },
        { name: "Chair 1", price: "$100" },
        { name: "Chair 2", price: "$150" },
        { name: "Chair 3", price: "$200" }		
    ],
    sofas: [
        { name: "Sofa 1", price: "$500" },
        { name: "Sofa 2", price: "$600" },
        { name: "Sofa 3", price: "$700" }
    ],
    tables: [
        { name: "Table 1", price: "$300" },
        { name: "Table 2", price: "$400" },
        { name: "Table 3", price: "$450" }
    ],
    beds: [
        { name: "Bed 1", price: "$800" },
        { name: "Bed 2", price: "$900" },
        { name: "Bed 3", price: "$1000" }
    ],
    beds2: [
        { name: "Bed 1", price: "$800" },
        { name: "Bed 2", price: "$900" },
        { name: "Bed 3", price: "$1000" }
    ],
    beds3: [
        { name: "Bed 1", price: "$800" },
        { name: "Bed 2", price: "$900" },
        { name: "Bed 3", price: "$1000" }
    ],
    beds4: [
        { name: "Bed 1", price: "$800" },
        { name: "Bed 2", price: "$900" },
        { name: "Bed 3", price: "$1000" }
    ],	
};

const furnitureownData = [];



let currentNotification = null;

function closeMain() {
    $("body").css("display", "none");
}

function openMain() {
    $("body").css("display", "block");
}

function objecteditorcreatorPrepareInterface() {
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

objecteditorcreatorPrepareInterface();

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

function calculateFinalPrice() {
    const lightingPrice = lightingPrices[lightType] || 0;

    const railingPrice = railingPrices[railingColor] || 0;

    const equipmentPrice = equipmentPrices[equipment] || 0;

    const finalPrice = yachtPrice + lightingPrice + railingPrice + equipmentPrice;

    document.querySelector(".final-price h3").innerText = `Final Price: $${finalPrice.toLocaleString()}`;
}

const resetSelection = () => {
    yachtColor = 1;
    lightType = 1;
    lightColor = 1;
    railingColor = "silver";
    flag = 1;
    upperText = "";
    bottomText = "";
    equipment = 1;

    $(".color-picker div, .light-type-picker div, .light-color-picker div, .railing-picker div, .equipment-picker div").removeClass("selected");
    $("#flag-select").prop("selectedIndex", 0);
    $("#upper-text, #bottom-text").val("");

	calculateFinalPrice();
};

const showNotification = (message, type = "warning") => {
    if (currentNotification) {
        currentNotification.remove();
    }

    const notification = $("<div>").addClass(`notification ${type}`);

    const icon = type === "warning" ? "fa-exclamation-circle" : "fa-check-circle";
    notification.html(`<i class="fas ${icon}"></i><span>${message}</span>`);
	
    $("body").append(notification);
    currentNotification = notification;

    setTimeout(() => {
        notification.remove();
        currentNotification = null;
    }, 3000);
};

const validateSelection = () => {
    let isValid = true;

    if (yachtColor === null) {
        showNotification("Please select a yacht color.", "warning");
        isValid = false;
    }
    if (lightType === null) {
        showNotification("Please select a light type.", "warning");
        isValid = false;
    }
    if (lightColor === null) {
        showNotification("Please select a light color.", "warning");
        isValid = false;
    }
    if (railingColor === null) {
        showNotification("Please select a railing color.", "warning");
        isValid = false;
    }
    if (flag === null) {
        showNotification("Please select a flag.", "warning");
        isValid = false;
    }
    if (upperText.trim() === "") {
        showNotification("Please enter the upper text for the yacht name.", "warning");
        isValid = false;
    }
    if (bottomText.trim() === "") {
        showNotification("Please enter the bottom text for the yacht name.", "warning");
        isValid = false;
    }
    if (equipment === null) {
        showNotification("Please select an equipment option.", "warning");
        isValid = false;
    }

    return isValid;
};

function addFurnitureCategory(categoryId, categoryLabel) {
    furnitureData[categoryId] = [];
	furnitureNames[categoryId] = categoryLabel;

    const newButton = $("<button>")
        .addClass("category-button")
        .attr("data-category", categoryId)
        .html(`${categoryLabel}`) 
        .click(function () {
            const category = $(this).data("category");
            showFurnitureList(category);
        });
    $("#furnitureCategories").append(newButton);
}


function addFurniture(categoryId, furnitureId, furnitureLabel, furniturePrice) {
    if (!furnitureData[categoryId]) {
        return;
    }
	
    furnitureData[categoryId].push({
        id: furnitureId,
        name: furnitureLabel,
        price: furniturePrice,
		image: 'img/objects/'+furnitureLabel+'.webp',
    });
}

function addFurnitureOwn(furnitureLabel, furnitureId) {
    furnitureownData.push({
        id: furnitureId,
        name: furnitureLabel,
    });
}

function removeFurnitureItemById(furnitureId) {
    const itemToRemove = $("#furnitureownItems").find(`.furnitureown-item[data-id="${furnitureId}"]`);
    
    if (itemToRemove.length > 0) {
        itemToRemove.remove();
    } else {
    }
}

function addPlayerPermissions(playerId, playerName, permissions) {
    const playersList = $(".playerspermissions-list");

    const playerManagementDiv = $("<div>")
        .addClass("playermanagment")
        .attr("data-player-id", playerId);

    const playerNameSpan = $("<span>").addClass("player-name").text(playerName);

    const permissionsDiv = $("<div>").addClass("permissions");

    const permissionLabels = [
        { name: "yacht_control", text: "Yacht Control", checked: permissions.yacht_control },
        { name: "door_access", text: "Door Access", checked: permissions.door_access },
        { name: "furniture_management", text: "Furniture Management", checked: permissions.furniture_management },
        { name: "storage_access", text: "Storage Access", checked: permissions.storage_access },
        { name: "wardrobe_access", text: "Wardrobe Access", checked: permissions.wardrobe_access },
    ];

    permissionLabels.forEach(permission => {
        const permissionLabel = $("<label>").addClass("switch");
        const permissionCheckbox = $("<input>")
            .attr("type", "checkbox")
            .addClass("permission")
            .attr("data-permission", permission.name)
            .prop("checked", permission.checked)
            .on("change", function () {
                permissions[permission.name] = $(this).prop("checked");
            });
        const permissionSlider = $("<span>").addClass("slider");
        const permissionText = $("<span>").addClass("permission-text").text(permission.text);

        permissionLabel.append(permissionCheckbox, permissionSlider, permissionText);
        permissionsDiv.append(permissionLabel);
    });

    const savePermissionsButton = $("<button>")
        .addClass("save-permissions-button")
        .html('<i class="fas fa-save"></i> Save Permissions')
        .click(() => {
			let yachtControl = permissions.yacht_control || false;
			let doorAccess = permissions.door_access || false;
			let furnitureManagement = permissions.furniture_management || false;
			let storageAccess = permissions.storage_access || false;
			let wardrobeAccess = permissions.wardrobe_access || false;
            $.post(`https://${yachtresourcename}/changepermissions`, JSON.stringify({
                playeriddata: playerId,
				yachtcontroldata: yachtControl,
				dooraccessdata: doorAccess,
				furnituremanagmentdata: furnitureManagement,
				storageaccessdata: storageAccess,
				wardrobeaccessdata: wardrobeAccess,
            }));
        });		

    const deletePlayerButton = $("<button>")
        .addClass("delete-player-button")
        .html('<i class="fas fa-trash"></i> Delete Player')
        .click(() => {
            $.post(`https://${yachtresourcename}/removepermission`, JSON.stringify({
                playeriddata: playerId,
            }));
            playerManagementDiv.remove(); 
        });

    playerManagementDiv.append(playerNameSpan, permissionsDiv, savePermissionsButton, deletePlayerButton);

    playersList.append(playerManagementDiv);
}


window.addEventListener('message', function (event) {

	var item = event.data;
	
	if (item.message == "infonotifyshow") {
		document.getElementsByClassName("infonotifytext")[0].innerHTML = item.infonotifytext;
		openMain();
		$("#infonotifyshow").show();	
	}	
	
	if (item.message == "yachtbuyshow") {
		openMain();
		resetSelection();
		yachtPrice = item.yachtprice;
		lightingPrices[1] = item.yachtlightingprice1;
		lightingPrices[2] = item.yachtlightingprice2;
		railingPrices["silver"] = item.yachtrailingprice1;
		railingPrices["gold"] = item.yachtrailingprice2;
		equipmentPrices[1] = item.yachtequipmentprice1;
		equipmentPrices[2] = item.yachtequipmentprice2;
		calculateFinalPrice();
		$("#yachtbuyshow").show();
	}
	
	if (item.message == "yachtfurnitureshow") {
		showCategories();
		infurnituremenu = 1;
		$("#furnitureCategories").empty();
		$("#furnitureItems").empty();
		openMain();
		$("#furnitureMenu").show();
	}		

	if (item.message == "addfurniturecategory") {
		addFurnitureCategory(item.categoryid, item.categorylabel);
	}	
    if (item.message == "addfurniture") {
        addFurniture(item.categoryid, item.furnitureid, item.furniturelabel, item.furnitureprice);
    }		

	if (item.message == "objecteditorposshow") {		
		$("#cameraspeeddata").val(""); 
		$("#lookspeedxdata").val(""); 
		$("#lookspeedydata").val(""); 
		$("#translatesnapdata").val(""); 
		$("#rotationsnapdata").val(""); 
		objecteditorcreatorPrepareInterface();
		$("#posmoretranslate").addClass("active");
		$("#posmorerotation").removeClass("active");
		$("#spacebuttonworld").addClass("active");
		$("#spacebuttonlocal").removeClass("active");		
		$("#objecteditorposshow").show();	
		$("#buttonsfurnitureeditshow").hide();	
		$("#buttonsfurniturebuyshow").show();	
		openMain();
	}		
	
	if (item.message == "objecteditorownposshow") {		
		$("#cameraspeeddata").val(""); 
		$("#lookspeedxdata").val(""); 
		$("#lookspeedydata").val(""); 
		$("#translatesnapdata").val(""); 
		$("#rotationsnapdata").val(""); 
		objecteditorcreatorPrepareInterface();
		$("#posmoretranslate").addClass("active");
		$("#posmorerotation").removeClass("active");
		$("#spacebuttonworld").addClass("active");
		$("#spacebuttonlocal").removeClass("active");		
		$("#objecteditorposshow").show();	
		$("#buttonsfurnitureeditshow").show();	
		$("#buttonsfurniturebuyshow").hide();	
		openMain();
	}			

	if (item.message == "yachtfurnitureownshow") {
		infurnitureownmenu = 1;
		$("#furnitureownItems").empty();
		openMain();
		$("#furnitureownMenu").show();
	}		

    if (item.message == "addfurnitureown") {
        addFurnitureOwn(item.furnitureobjectname, item.furnitureid);
		const furnitureItem = $("<button>")
			.addClass("furnitureown-item")
			.attr("data-id", item.furnitureid)
			.html(`
				<img src="${item.furnitureimage}" alt="${item.furnitureobjectname}" onerror="this.src='img/default.webp'">
				<div class="furnitureown-name">${item.furnitureobjectname}</div>
			`)
			.click(() => {
				$(".furnitureobjecttextname").text(item.furnitureobjecttextname);
				$.post('https://'+yachtresourcename+'/editfurniture', JSON.stringify({
					furnitureid: item.furnitureid,
				}));
			});

		$("#furnitureownItems").append(furnitureItem);	
    }		

	if (item.message == "yachtmanagmentshow") {
		openMain();
		$("#showYachtActions").show();
		$("#showYachtFurniture").show();
		$("#showYachtManagment").show();
		$("#yachtTransferMenu").hide();
		$("#playersWithPermissionsMenu").hide();
		$("#addPermissionsMenu").hide();
		$("#mainMenuManagment").show();
	}		

	if (item.message == "yachtmanagment2show") {
		openMain();
		$("#showYachtActions").hide();
		$("#showYachtFurniture").show();
		$("#showYachtManagment").hide();
		$("#yachtTransferMenu").hide();
		$("#playersWithPermissionsMenu").hide();
		$("#addPermissionsMenu").hide();
		$("#mainMenuManagment").show();
	}		

	if (item.message == "yachtmanagmenthide") {
		$("#yachtTransferMenu").hide();
		$("#playersWithPermissionsMenu").hide();
		$("#addPermissionsMenu").hide();		
		$("#mainMenuManagment").hide();
	}		

	if (item.message == "removeobjectfromfurniturelist") {
		removeFurnitureItemById(item.furnitureid);
	}
	
	if (item.message == "yachtmanagmentaddpermissionsshow") {
		$(".playersaddnew-list").empty();
		openMain();
		$("#mainMenuManagment").hide();
		$("#addPermissionsMenu").show();
	}		

    if (item.message == "yachtmanagmentaddplayer") {
		const playersList = $(".playersaddnew-list");

		const playerManagementDiv = $("<div>").addClass("playermanagment");
		const playerNameSpan = $("<span>").addClass("player-name").text(item.playername);

		const addPermissionButton = $("<button>")
			.addClass("add-permission-button")
			.html('<i class="fas fa-plus"></i> Add Permissions')
			.click(() => {
				$.post('https://'+yachtresourcename+'/addplayerpermission', JSON.stringify({
					playeriddata: item.playeriddata,
				}));
			});

		playerManagementDiv.append(playerNameSpan, addPermissionButton);

		playersList.append(playerManagementDiv);
    }		

	if (item.message == "yachtmanagmentaddpermissionschangeshow") {
		$(".playerspermissions-list").empty();
		openMain();
		$("#mainMenuManagment").hide();
		$("#yachtTransferMenu").hide();
		$("#addPermissionsMenu").hide();		
		$("#playersWithPermissionsMenu").show();
	}		

    if (item.message == "yachtmanagmentaddplayerchange") {
		addPlayerPermissions(item.playerid, item.playername, {
			yacht_control: item.yachtcontrol,
			door_access: item.dooraccess,
			furniture_management: item.furnituremanagment,
			storage_access: item.storageaccess,
			wardrobe_access: item.wardrobeaccess,
		});
    }		
	
	if (item.message == "yachtmanagmenttransfershow") {
		$(".playerstransfer-list").empty();
		openMain();
		$("#mainMenuManagment").hide();
		$("#yachtTransferMenu").show();
	}		

    if (item.message == "yachtmanagmenttransferaddplayer") {
		const playersList = $(".playerstransfer-list");

		const playerManagementDiv = $("<div>")
			.addClass("playermanagment");

		const playerNameSpan = $("<span>")
			.addClass("player-name")
			.text(item.playername);

		const transferYachtButton = $("<button>")
			.addClass("transfer-yacht-button")
			.html('<i class="fas fa-exchange-alt"></i> Transfer Yacht')
			.click(() => {
				$.post(`https://${yachtresourcename}/transferplayeryacht`, JSON.stringify({
					playeriddata: item.playeriddata,
				}));
			});

		playerManagementDiv.append(playerNameSpan, transferYachtButton);

		playersList.append(playerManagementDiv);
    }		
	
	if (item.message == "hidebuymenu") {
		$("#yachtbuyshow").hide();
	}
	
	if (item.message == "hide") {
		$("#infonotifyshow").hide();	
	}	
	
	if (item.message == "hideobjecteditor") {
		$("#objecteditorposshow").hide();	
	}		
	
	if (item.message == "hidefurnitureshop") {
		infurnituremenu = 0;
		$("#objecteditorposshow").hide();	
		$("#furnitureMenu").hide();	
	}	

	if (item.message == "hideobjecteditor") {
		$("#objecteditorposshow").hide();	
	}		

	if (item.message == "hidefurnitureown") {
		infurnitureownmenu = 0;
		$("#objecteditorposshow").hide();	
		$("#furnitureownMenu").hide();	
	}		

	if (item.message == "hottubseatshow") {
		openMain();
		$("#seatshow").show();
	}	

	if (item.message == "hidehottubseat") {
		$("#seatshow").hide();
	}				
	
	if (item.message == "updateinterfacedata") {
		yachtresourcename = item.yachtresourcenamedata;
		let root = document.documentElement;
		root.style.setProperty('--color', item.interfacecolordata);	
	}		
	document.onkeyup = function (data) {
		if (open) {
			if (data.which == 27) {
				if(infurnituremenu == 1) {		
					$.post('https://'+yachtresourcename+'/yachtfurnitureclose', JSON.stringify({}));
				}		
				if(infurnitureownmenu == 1) {		
					$.post('https://'+yachtresourcename+'/yachtfurnitureeditclose', JSON.stringify({}));
				}					
			}
		}	
	};		
});

$("#posmoretranslate").click(function () {
	$(this).addClass("active");
	$("#posmorerotation").removeClass("active");
	$.post('https://'+yachtresourcename+'/objecteditorcreatorchangemode', JSON.stringify({
		modetype: "translate"
	})); 		
});

$("#posmorerotation").click(function () {
	$(this).addClass("active");
	$("#posmoretranslate").removeClass("active");
	$.post('https://'+yachtresourcename+'/objecteditorcreatorchangemode', JSON.stringify({
		modetype: "rotate"
	})); 	
});

$("#spacebuttonworld").click(function () {
	$(this).addClass("active");
	$("#spacebuttonlocal").removeClass("active");
	$.post('https://'+yachtresourcename+'/objecteditorcreatorchangespace', JSON.stringify({
		spacetype: "world"
	})); 	
});

$(".createobjecteditorcreatorbutton").click(function () {
	$.post('https://'+yachtresourcename+'/furnituresaveobject', JSON.stringify({}));
});

$(".createobjecteditordeletebutton").click(function () {
	$.post('https://'+yachtresourcename+'/furnitureremoveobject', JSON.stringify({}));
});

$("#spacebuttonlocal").click(function () {
	$(this).addClass("active");
	$("#spacebuttonworld").removeClass("active");
	$.post('https://'+yachtresourcename+'/objecteditorcreatorchangespace', JSON.stringify({
		spacetype: "local"
	})); 	
});

$(".createobjecteditorbuybutton").click(function () {
	$.post('https://'+yachtresourcename+'/furniturebuyobject', JSON.stringify({}));
});

function cameraspeedchange(e) {
	$.post('https://'+yachtresourcename+'/objecteditorcreatorspeedchange', JSON.stringify({
		speedtype: "camera",
		speeddata: e.value
	})); 
}

function lookspeedxchange(e) {
	$.post('https://'+yachtresourcename+'/objecteditorcreatorspeedchange', JSON.stringify({
		speedtype: "lookx",
		speeddata: e.value
	})); 
}

function lookspeedychange(e) {
	$.post('https://'+yachtresourcename+'/objecteditorcreatorspeedchange', JSON.stringify({
		speedtype: "looky",
		speeddata: e.value
	})); 
}

function translatesnapchange(e) {
	$.post('https://'+yachtresourcename+'/objecteditorcreatorsnapchange', JSON.stringify({
		snaptype: "translate",
		snapdata: e.value
	})); 
}

function rotationsnapchange(e) {
	$.post('https://'+yachtresourcename+'/objecteditorcreatorsnapchange', JSON.stringify({
		snaptype: "rotate",
		snapdata: e.value
	})); 
}

function showCategories() {
    $("#furnitureList").hide();
    $("#furnitureCategories").show();
    $("#categoryName").text(""); 
}

function showFurnitureList(category) {
    $("#furnitureCategories").hide();
    $("#furnitureList").show();
    $("#furnitureItems").empty(); 

    $("#categoryName").text(furnitureNames[category]);

    furnitureData[category].forEach(item => {
        const furnitureItem = $("<button>")
            .addClass("furniture-item")
            .html(`
                <img src="${item.image}" alt="${item.name}" onerror="this.src='img/default.webp'">
                <div class="furniture-name">${item.name}</div>
                <div class="furniture-price">$${item.price}</div>
            `)
            .click(() => {
				$(".buyobjecttextname").text(item.name);
				$(".buyobjecttextprice").text('$'+item.price+'');
				$.post('https://'+yachtresourcename+'/addnewfurnituretohouse', JSON.stringify({
					furniturecategoryid: category,
					furnitureid: item.id,
				}));				
            });
        $("#furnitureItems").append(furnitureItem);
    });
}

function searchFurniture(query) {
    const lowerCaseQuery = query.toLowerCase();

    $(".category-button, .furniture-item").hide();

    $(".category-button").each(function () {
        const category = $(this).text().toLowerCase();
        if (category.includes(lowerCaseQuery)) {
            $(this).show();
        }
    });

    $(".furniture-item").each(function () {
        const itemName = $(this).find(".furniture-name").text().toLowerCase();
        if (itemName.includes(lowerCaseQuery)) {
            $(this).show();
        }
    });
}

$("#searchInput").on("input", function () {
    const query = $(this).val();
    searchFurniture(query);
});

function searchFurnitureown(query) {
    const lowerCaseQuery = query.toLowerCase();

    $(".furnitureown-item").hide();

    $(".furnitureown-item").each(function () {
        const itemName = $(this).find(".furnitureown-name").text().toLowerCase();
        if (itemName.includes(lowerCaseQuery)) {
            $(this).show();
        }
    });
}

$("#searchownInput").on("input", function () {
    const query = $(this).val();
    searchFurnitureown(query);
});

$("#backButton").click(showCategories);

const updateSelection = () => {
	calculateFinalPrice();
};

$(".color-picker div").on("click", function() {
    $(".color-picker div").removeClass("selected");
    $(this).addClass("selected");
    yachtColor = $(this).attr("data-color");
    updateSelection();
    $.post('https://'+yachtresourcename+'/buyyachtchangecolor', JSON.stringify({
        yachtcolorddata: yachtColor,
    }));
});

$(".light-type-picker div").on("click", function() {
    $(".light-type-picker div").removeClass("selected");
    $(this).addClass("selected");
    lightType = $(this).attr("data-light-type");
    updateSelection();
    $.post('https://'+yachtresourcename+'/buyyachtchangelight', JSON.stringify({
        ligthtcolorcategorydata: lightType,
        ligthtcolordata: lightColor,
    }));
});

$(".light-color-picker div").on("click", function() {
    $(".light-color-picker div").removeClass("selected");
    $(this).addClass("selected");
    lightColor = $(this).attr("data-light-color");
    updateSelection();
    $.post('https://'+yachtresourcename+'/buyyachtchangelight', JSON.stringify({
        ligthtcolorcategorydata: lightType,
        ligthtcolordata: lightColor,
    }));
});

$(".railing-picker div").on("click", function() {
    $(".railing-picker div").removeClass("selected");
    $(this).addClass("selected");
    railingColor = $(this).attr("data-railing");
    updateSelection();
    $.post('https://'+yachtresourcename+'/buyyachtchangerailing', JSON.stringify({
        railingdata: railingColor,
    }));
});

$(".equipment-picker div").on("click", function() {
    $(".equipment-picker div").removeClass("selected");
    $(this).addClass("selected");
    equipment = $(this).attr("data-equipment");
    updateSelection();
});

$("#flag-select").on("change", function() {
    flag = $(this).val();
    updateSelection();
    $.post('https://'+yachtresourcename+'/buyyachtchangeflag', JSON.stringify({
        flagdata: flag,
    }));
});

$("#upper-text").on("input", function() {
    upperText = $(this).val();
    updateSelection();
    $.post('https://'+yachtresourcename+'/buyyachtchangename', JSON.stringify({
        uppertextdata: upperText,
        bottomtextdata: bottomText,
    }));
});

$("#bottom-text").on("input", function() {
    bottomText = $(this).val();
    updateSelection();
    $.post('https://'+yachtresourcename+'/buyyachtchangename', JSON.stringify({
        uppertextdata: upperText,
        bottomtextdata: bottomText,
    }));
});

$("#purchase-yacht").on("click", function() {
    if (validateSelection()) {
        updateSelection();
		$.post('https://'+yachtresourcename+'/buyyacht', JSON.stringify({
			yachtcolorddata: yachtColor,
			ligthtcolorcategorydata: lightType,
			ligthtcolordata: lightColor,			
			railingdata: railingColor,
			flagdata: flag,
			uppertextdata: upperText,
			bottomtextdata: bottomText,
			equipmentdata: equipment,
		}));
    }
});

$("#close-menu").on("click", function() {
    resetSelection(); 
	$.post('https://'+yachtresourcename+'/closebuymenu', JSON.stringify({}));
});

$("#change-camera").on("click", function() {
    $.post('https://'+yachtresourcename+'/buycamerachange', JSON.stringify({}));
});

resetSelection();

$("#closeYachtTransferMenu").click(function () {
$("#yachtTransferMenu").hide();
$("#mainMenuManagment").show();
});

$("#closePlayersWithPermissionsMenu").click(function () {
$("#playersWithPermissionsMenu").hide();
$("#mainMenuManagment").show();
});

$("#closeAddPermissionsMenu").click(function () {
$("#addPermissionsMenu").hide();
$("#mainMenuManagment").show();
});

$("#closeMainMenu").click(function () {
$("#mainMenuManagment").hide();
	$.post('https://'+yachtresourcename+'/closemanagment', JSON.stringify({}));
});

$(".save-permissions-button").click(function () {
const playerId = $(this).closest(".playermanagment").data("player-id");
const permissions = {};

$(this).siblings(".permissions").find(".permission").each(function () {
  const permissionName = $(this).data("permission");
  const isChecked = $(this).is(":checked");
  permissions[permissionName] = isChecked;
});

let yachtControl = permissions.yacht_control || false;
let doorAccess = permissions.door_access || false;
let furnitureManagement = permissions.furniture_management || false;
let storageAccess = permissions.storage_access || false;
let wardrobeAccess = permissions.wardrobe_access || false;

});

$(".delete-player-button").click(function () {
const playerId = $(this).closest(".playermanagment").data("player-id");
$(this).closest(".playermanagment").remove();
});

$(".transfer-yacht-button").click(function () {
const playerName = $(this).siblings(".player-name").text();
});

$("#openOwnedFurniture").click(function () {
 $.post('https://'+yachtresourcename+'/chooseownfurniture', JSON.stringify({}));
});  

$("#openBuyFurniture").click(function () {
 $.post('https://'+yachtresourcename+'/choosebuyfurniture', JSON.stringify({}));
});    

$("#openAddPermissions").click(function () {
 $.post('https://'+yachtresourcename+'/chooseaddpermissions', JSON.stringify({}));
});    

$("#openYachtTransfer").click(function () {
 $.post('https://'+yachtresourcename+'/choosetransferyacht', JSON.stringify({}));
});    

$("#SellYacht").click(function () {
 $.post('https://'+yachtresourcename+'/sellyacht', JSON.stringify({}));
});    

$("#openPlayersWithPermissions").click(function () {
 $.post('https://'+yachtresourcename+'/choosepermissions', JSON.stringify({}));
});    