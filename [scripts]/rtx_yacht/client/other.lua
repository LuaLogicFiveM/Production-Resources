function RegisterStorages(yachtiddata)
	if Config.InventorySystem == "qsinventory" then		
		for i, yachstoragehandler in pairs(Config.YachtStorageLocations) do	
			local stashID = "yacht-"..yachtiddata.."-storage-"..i..""
			local stashSlots = 50           -- Total number of slots
			local stashWeight = 1000        -- Maximum weight capacity

			exports['qs-inventory']:RegisterStash(stashID, stashSlots, stashWeight)
		end
	end
end

function OpenYachtStorage(yachtiddata, storageiddata)
	if Config.InventorySystem == "oxinventory" then
		if Config.OxInventory == true then
			exports.ox_inventory:openInventory('stash', {id='yacht-'..yachtiddata..'-storage-'..storageiddata..'', owner=false})
		end
	elseif Config.InventorySystem == "qsinventory" then		
		local stashID = "yacht-"..yachtiddata.."-storage-"..storageiddata..""
		local stashdata = {
			maxweight = 1000000,
			slots = 10,
		} 
		TriggerServerEvent('inventory:server:OpenInventory', 'stash', stashID, stashdata)
		TriggerEvent('inventory:client:SetCurrentStash', stashID)		
	elseif Config.InventorySystem == "qbcoreinventory" then		
		TriggerServerEvent("rtx_yacht:Global:OpenStorageQB", "yacht-"..yachtiddata.."-storage-"..storageiddata.."")
	elseif Config.InventorySystem == "codeminventory" then		
		local name = "yacht-"..yachtiddata.."-storage-"..storageiddata..""
		local maxweight = 10000
		local slot = 50
		exports['codem-inventory']:OpenStash(name, maxweight, slot)
	elseif Config.InventorySystem == "coreinventory" then		
		local name = "yacht-"..yachtiddata.."-storage-"..storageiddata..""
		TriggerServerEvent('core_inventory:server:openInventory', name, 'stash', nil, nil)
	elseif Config.InventorySystem == "psinventory" then		
		local name = "yacht-"..yachtiddata.."-storage-"..storageiddata..""
		local stashdata = {
			maxweight = 1000000,
			slots = 30,		
		}
		TriggerServerEvent('ps-inventory:server:OpenInventory', 'stash', name, stashdata)
		TriggerEvent('ps-inventory:client:SetCurrentStash', name)
	elseif Config.InventorySystem == "chezza" then		
		local name = "yacht-"..yachtiddata.."-storage-"..storageiddata..""
		TriggerEvent('inventory:openInventory', { type = 'stash', id = name, title = 'Stash_' .. name, weight = 1000000, delay = 100, save = true })
	end
end	

function OpenYachtWardrobe(yachtiddata, wardrobeiddata)
	if Config.WardrobeSystem == "default" then
	elseif Config.WardrobeSystem == "esx" then
		  ESX.TriggerServerCallback('esx_property:getPlayerDressing', function(dressing)
			local elements = {{unselectable = true, icon = "fas fa-tshirt", title = "Wardrobe"}, {unselectable = false, icon = "", title = "Outfit 1"}, {unselectable = false, icon = "", title = "Outfit 2"}}

			for i=1, #dressing, 1 do
				elements[#elements + 1] = {
					title = dressing[i],
					value = i
				}
			end
			
			ESX.OpenContext("right", elements, function(menu, element)
				TriggerEvent('skinchanger:getSkin', function(skin)
					ESX.TriggerServerCallback('esx_property:getPlayerOutfit', function(clothes)
						TriggerEvent('skinchanger:loadClothes', skin, clothes)
						TriggerEvent('esx_skin:setLastSkin', skin)

						TriggerEvent('skinchanger:getSkin', function(skin)
							TriggerServerEvent('esx_skin:save', skin)
						end)
					end, element.value)
				end)
			end)
		end)
	elseif Config.WardrobeSystem == "qbcore" then
		TriggerEvent('qb-clothing:client:openOutfitMenu')
	elseif Config.WardrobeSystem == "codem" then
		TriggerEvent('codem-apperance:OpenWardrobe')
	elseif Config.WardrobeSystem == "fivemappearance" then
		exports['fivem-appearance']:openWardrobe()
	elseif Config.WardrobeSystem == "illeniumappearance" then
		 TriggerEvent('illenium-appearance:client:openOutfitMenu')
	 elseif Config.WardrobeSystem == "rcore" then
		 TriggerEvent('rcore_clothes:openOutfits')
	 elseif Config.WardrobeSystem == "qsappearance" then
		 TriggerEvent('clothing:openOutfitMenu')
	end
end	

function InSomeMenu()
	local noinmenu = true
	if LocalPlayer.state.invOpen == true then
		noinmenu = false
	end
	return noinmenu
end	


TriggerEvent('chat:addSuggestion', "/"..Config.GiveYachtCommand, 'Yacht Player Give', {
    { name="Player ID", help="player id" },
    { name="Flag (1-46)", help="flag type" },
	{ name="Light Category (1-2)", help="light category" },
    { name="Light Color (1-8)", help="lig color" },
	{ name="Upper Text", help="yacht text" },
    { name="Bottom Text", help="yacht text" },
	{ name="Railing Type (1-2)", help="railing type" },
    { name="Yacht Color (1-16)", help="yacht color" },
	{ name="Equipment (1 - No, 2 - Yes)", help="equipment" }
})

TriggerEvent('chat:addSuggestion', "/"..Config.GiveYachtIdentifierCommand, 'Yacht Player Give', {
    { name="Player identifier", help="player identifier" },
    { name="Flag (1-46)", help="flag type" },
	{ name="Light Category (1-2)", help="light category" },
    { name="Light Color (1-8)", help="lig color" },
	{ name="Upper Text", help="yacht text" },
    { name="Bottom Text", help="yacht text" },
	{ name="Railing Type (1-2)", help="railing type" },
    { name="Yacht Color (1-16)", help="yacht color" },
	{ name="Equipment (1 - No, 2 - Yes)", help="equipment" }
})