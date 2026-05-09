---@alias RacingAllowlistTypes "track_creator" | "create_race" | "create_ranked_race" | "racing_admin"

---@param source number
---@param allowlist RacingAllowlistTypes
---@return boolean
function HasAllowlist(source, allowlist)
    if not SvConfig.UseBridgeAllowlist then
        return true
    end

    local stateId = bridge.fw.getIdentifier(source)
    if not stateId then
        return false
    end

    return exports["prp-bridge"]:HasAllowlist(stateId, allowlist)
end

---@param plate string
---@return boolean status if it succeeded or not
---@return string? error locale if boolean is false
function DoesVehicleHaveLoan(plate)
    -- put custom logic here to check for any loans on a vehicle
    return false
end

---@param plate string
---@return boolean status if it succeeded or not
---@return string? error locale if boolean is false
function CanVehicleBePinkSlipped(plate)
    -- put custom logic here to check for any conditions on a vehicle
    return true
end

---@param plate string
---@return boolean status if it succeeded or not
---@return string? error locale if boolean is false
function CanPinkSlipBeRedeemed(plate)
    -- put custom logic here to check for any conditions on a vehicle
    return true
end

---@param plate string
---@return OwnedVehicle | nil
function GetPinkSlipVehicle(plate)
    local vehicle = bridge.fw.getOwnedVehicleByPlate(plate)
    if not vehicle then
        return
    end

    -- put custom logic here to check for any conditions on a vehicle (impounded, etc)
    return vehicle
end

---@param stateId string | number
---@param currency string currency type or crypto value
---@param amount number
---@return boolean
function VerifyHasCurrency(stateId, currency, amount)
    lib.print.debug("VerifyHasCurrency ", stateId, currency, amount)
    local src = bridge.fw.getSrcFromIdentifier(
        stateId --[[@as string]]
    )
    if not src then
        return false
    end

    if currency == "CASH" or currency == "BANK" then
        return bridge.fw.getMoney(src, currency:lower()) >= amount
    else
        if not SvConfig.AllowedCrypto[currency] then
            return false
        end

        -- integrate your crypto here
        return true
    end
end

---@param stateId string | number
---@param currency string currency type or crypto type
---@param amount number
---@param title string bank transaction title (if you wish to integrate)
---@param description string bank transaction desc (if you wish to integrate)
---@param reason string reason for the currency being removed
---@return boolean
function RemovePlayerCurrency(stateId, currency, amount, title, description, reason)
    lib.print.debug("RemovePlayerCurrency ", stateId, currency, amount, title, description, reason)
    local isCrypto = SvConfig.AllowedCrypto[currency]
    if not isCrypto and (currency ~= "BANK" and currency ~= "CASH") then
        return false
    end

    if amount < 0 then
        return false
    end

    local src = bridge.fw.getSrcFromIdentifier(
        stateId --[[@as string]]
    )
    if not src then
        return false
    end

    local hasCurrency = VerifyHasCurrency(stateId, currency, amount)
    if not hasCurrency then
        return false
    end

    if currency == "CASH" or currency == "BANK" then
        lib.print.debug("Remove money", src, currency:lower(), amount, reason)
        return bridge.fw.removeMoney(src, currency:lower(), amount, reason)
    else
        if not SvConfig.AllowedCrypto[currency] then
            return false
        end

        -- integrate your crypto here
        return true
    end
end

---@param stateId string | number
---@param currency string currency type or crypto type
---@param amount number
---@param title string bank transaction title (if you wish to integrate)
---@param description string bank transaction desc (if you wish to integrate)
---@param reason string reason for the currency being removed
---@return boolean
function AddPlayerCurrency(stateId, currency, amount, title, description, reason)
    lib.print.debug("AddPlayerCurrency ", stateId, currency, amount, title, description, reason)
    local isCrypto = SvConfig.AllowedCrypto[currency]
    if not isCrypto and (currency ~= "BANK" and currency ~= "CASH") then
        return false
    end

    if amount < 0 then
        return false
    end

    local src = bridge.fw.getSrcFromIdentifier(
        stateId --[[@as string]]
    )
    if not src then
        return false
    end

    if currency == "CASH" or currency == "BANK" then
        return bridge.fw.addMoney(src, currency:lower(), amount, reason)
    else
        if not SvConfig.AllowedCrypto[currency] then
            return false
        end

        -- integrate your crypto here
        return true
    end
end

---@return table<number, RacingCurrency>
function GetAllCurrencies()
    local currencies = {
        {
            name = "CASH",
            label = locale("CASH"),
            floor = true,
            isCrypto = false
        },
        {
            name = "BANK",
            label = locale("BANK"),
            floor = true,
            isCrypto = false
        },
    }

    ---@type RacingCurrency[]
    local cryptos = {} -- add you own cryptos call here
    for _, crypto in pairs(cryptos or {}) do
        if SvConfig.AllowedCrypto[crypto.name] then
            currencies[#currencies + 1] = {
                name = crypto.name or "unknown",
                label = crypto.label or "Unknown",
                floor = crypto.floor or false,
                isCrypto = crypto.isCrypto or false
            }
        end
    end

    return currencies
end

---@param source number
---@return boolean
function IsAdmin(source)
    return bridge.fw.isAdmin(source) or (SvConfig.UseAdminAllowlist and HasAllowlist(source, "racing_admin"))
end

---@param source number
function OpenRacingTablet(source)
    if Config.RequireItemToOpen and not bridge.inv.hasItem(source, Config.RacingItem, 1) then
        return
    end

    local hasRankedAllowlist = SvConfig.UseRankedAllowlist and HasAllowlist(source, "create_ranked_race") or true
    TriggerClientEvent("prp-racing:client:openTablet", source, IsAdmin(source), GetAllCurrencies(), hasRankedAllowlist)
end

---@param item table
function GiveSeasonReward(item)
    if item.type == "item" and item.name then
        bridge.inv.giveItem(source, item.name, item.count or 1, item.metaData or nil)
    end
end

exports("OpenUI", OpenRacingTablet)
