
if not enableNamePerks then return end
playersWithPerks = {}
CreateThread(function()
    local perksFile = LoadResourceFile(GetCurrentResourceName(),"configs/playersWithPerks.json")
    if perksFile then
        local result = json.decode(perksFile)
        if result then
            playersWithPerks = result
            print("^2Chat perks loaded successfully!^0")
        end
    end
end)
RegisterNetEvent("did_chat:unlockPerks")
AddEventHandler("did_chat:unlockPerks", function()
    local src = source
    local Player = Framework.getPlayer(src)
    if not Player then return end
    local identifier = GetPlayerIdentifierByType(src, 'license')
    local hasPerks = hasPlayerUnlockedPerks(src)
    if not hasPerks then
        if Framework.hasMoney(src,namePerksPrice) then
            Framework.removeMoney(src,namePerksPrice)
            playersWithPerks[identifier] = defaultNamePerk
            local jsonData = json.encode(playersWithPerks, { indent = true })
            SaveResourceFile(GetCurrentResourceName(), "configs/playersWithPerks.json", jsonData, -1)
            TriggerClientEvent("did_chat:unlockPerks",src,defaultNamePerk)
        else
            --You can show a not enough money message to the player 
        end
    else
        --You can show a message to the player that they already have the perks unlocked
    end
end)
function hasPlayerUnlockedPerks(src)
    local Player = Framework.getPlayer(src)
    if not Player then return end
    local identifier = GetPlayerIdentifierByType(src, 'license')
    if playersWithPerks[identifier] then
        return true
    end
    --you can add your own logic here to check if the player has the perks unlocked 
    --for example if player is vip , if player has donator status etc
    --if Plauyer.getGroup() == "vip" then
    --    return true
    --end
    --You can also check if the player has a specific item in their inventory ...
    --We let you coock we just implement a basic system

    return false

end

RegisterNetEvent("did_chat:choosePerk")
AddEventHandler("did_chat:choosePerk", function(data)
    local src = source
    local Player = Framework.getPlayer(src)
    local identifier = GetPlayerIdentifierByType(src, 'license')
    if playersWithPerks[identifier] then
        playersWithPerks[identifier] = data.perk
        local jsonData = json.encode(playersWithPerks, { indent = true })
        SaveResourceFile(GetCurrentResourceName(), "configs/playersWithPerks.json", jsonData, -1)
    end
end)
    