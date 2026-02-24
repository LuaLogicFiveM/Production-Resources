local tgiann_clothing    = GetResourceState("tgiann-clothing") ~= "missing"
local rcore_clothing     = GetResourceState("rcore_clothing") ~= "missing"

tgiCore.OpenClothingShop = function()
    --local invokingResource = GetInvokingResource()
    if tgiann_clothing then
        exports["tgiann-clothing"]:openMenu({
            allowedMenus = { [0] = false, [1] = true, [2] = false, [3] = false },
            isBerberMenu = false,
        })
    elseif rcore_clothing then
        TriggerEvent('rcore_clothing:openShop', "binco")
    elseif config.framework == "qb" then
        TriggerEvent("qb-clothing:client:openOutfitMenu")
    elseif confg.framework == "esx" then
        -- TODO: Implement ESX clothing shop
    end
end
