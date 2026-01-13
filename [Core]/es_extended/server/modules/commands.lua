local upgrades = Config.SpawnVehMaxUpgrades and {
    plate = "ADMINCAR",
    modEngine = 3,
    modBrakes = 2,
    modTransmission = 2,
    modSuspension = 3,
    modArmor = true,
    windowTint = 1,
} or {}

ESX.RegisterCommand(
    "car",
    "admin",
    function(xPlayer, args, showError)
        if not xPlayer then
            return showError("[^1ERROR^7] The xPlayer value is nil")
        end

        local playerPed = GetPlayerPed(xPlayer.source)
        local playerCoords = GetEntityCoords(playerPed)
        local playerHeading = GetEntityHeading(playerPed)
        local playerVehicle = GetVehiclePedIsIn(playerPed, false)

        if not args.car or type(args.car) ~= "string" then
            args.car = "adder"
        end

        if playerVehicle then
            DeleteEntity(playerVehicle)
        end

        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Spawn Car /car Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Vehicle", value = args.car, inline = true },
            })
        end

        local xRoutingBucket = GetPlayerRoutingBucket(xPlayer.source)

        ESX.OneSync.SpawnVehicle(args.car, playerCoords, playerHeading, upgrades, function(networkId)
            if networkId then
                local vehicle = NetworkGetEntityFromNetworkId(networkId)

                if xRoutingBucket ~= 0 then
                    SetEntityRoutingBucket(vehicle, xRoutingBucket)
                end

                for _ = 1, 100 do
                    Wait(0)
                    SetPedIntoVehicle(playerPed, vehicle, -1)

                    if GetVehiclePedIsIn(playerPed, false) == vehicle then
                        break
                    end
                end

                if GetVehiclePedIsIn(playerPed, false) ~= vehicle then
                    showError("[^1ERROR^7] The player could not be seated in the vehicle")
                end
            end
        end)
    end,
    false,
    {
        help = TranslateCap("command_car"),
        validate = false,
        arguments = {
            { name = "car", validate = false, help = TranslateCap("command_car_car"), type = "string" },
        },
    }
)

ESX.RegisterCommand(
    "setjob",
    {"mod", "admin", "manager", "owner"},
    function(xPlayer, args, showError)
        if not ESX.DoesJobExist(args.job, args.grade) then
            return showError(TranslateCap("command_setjob_invalid"))
        end

        args.playerId.setJob(args.job, args.grade)
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Set Job /setjob Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Job", value = args.job, inline = true },
                { name = "Grade", value = args.grade, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_setjob"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
            { name = "job", help = TranslateCap("command_setjob_job"), type = "string" },
            { name = "grade", help = TranslateCap("command_setjob_grade"), type = "number" },
        },
    }
)

ESX.RegisterCommand(
    "massdv",
    {"mod", "admin", "manager", "owner"},
    function(xPlayer, args)
        local radius = args.radius or 5.0
        if radius < 100 then
            local ped = GetPlayerPed(xPlayer.source)
            local pedVehicle = GetVehiclePedIsIn(ped, false)

            if DoesEntityExist(pedVehicle) then
                DeleteEntity(pedVehicle)
            end

            local coords = GetEntityCoords(ped)
            local Vehicles = ESX.OneSync.GetVehiclesInArea(coords, tonumber(args.radius) or 5.0)
            for i = 1, #Vehicles do
                local Vehicle = NetworkGetEntityFromNetworkId(Vehicles[i])
                if DoesEntityExist(Vehicle) then
                    DeleteEntity(Vehicle)
                end
            end
            if Config.AdminLogging then
                ESX.DiscordLogFields("UserActions", "Delete Vehicle /dv Triggered!", "pink", {
                    { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                    { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                })
            end
        end
    end,
    false,
    {
        help = TranslateCap("command_cardel"),
        validate = false,
        arguments = {
            { name = "radius", validate = false, help = TranslateCap("command_cardel_radius"), type = "number" },
        },
    }
)

ESX.RegisterCommand(
    "setaccountmoney",
    "owner",
    function(xPlayer, args, showError)
        if not args.playerId.getAccount(args.account) then
            return showError(TranslateCap("command_giveaccountmoney_invalid"))
        end
        args.playerId.setAccountMoney(args.account, args.amount, "Government Grant")
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Set Account Money /setaccountmoney Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Account", value = args.account, inline = true },
                { name = "Amount", value = args.amount, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_setaccountmoney"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
            { name = "account", help = TranslateCap("command_giveaccountmoney_account"), type = "string" },
            { name = "amount", help = TranslateCap("command_setaccountmoney_amount"), type = "number" },
        },
    }
)

ESX.RegisterCommand(
    "giveaccountmoney",
    "owner",
    function(xPlayer, args, showError)
        if not args.playerId.getAccount(args.account) then
            return showError(TranslateCap("command_giveaccountmoney_invalid"))
        end
        args.playerId.addAccountMoney(args.account, args.amount, "Government Grant")
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Give Account Money /giveaccountmoney Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Account", value = args.account, inline = true },
                { name = "Amount", value = args.amount, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_giveaccountmoney"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
            { name = "account", help = TranslateCap("command_giveaccountmoney_account"), type = "string" },
            { name = "amount", help = TranslateCap("command_giveaccountmoney_amount"), type = "number" },
        },
    }
)

ESX.RegisterCommand(
    "removeaccountmoney",
    "owner",
    function(xPlayer, args, showError)
        if not args.playerId.getAccount(args.account) then
            return showError(TranslateCap("command_removeaccountmoney_invalid"))
        end
        args.playerId.removeAccountMoney(args.account, args.amount, "Government Tax")
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Remove Account Money /removeaccountmoney Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Account", value = args.account, inline = true },
                { name = "Amount", value = args.amount, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_removeaccountmoney"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
            { name = "account", help = TranslateCap("command_removeaccountmoney_account"), type = "string" },
            { name = "amount", help = TranslateCap("command_removeaccountmoney_amount"), type = "number" },
        },
    }
)

ESX.RegisterCommand({ "clear", "cls" }, {"user", "tmod", "mod", "admin", "manager", "owner"}, function(xPlayer)
    xPlayer.triggerEvent("chat:clear")
end, false, { help = TranslateCap("command_clear") })

ESX.RegisterCommand({ "clearall", "clsall" }, {"admin", "manager", "owner"}, function(xPlayer)
    TriggerClientEvent("chat:clear", -1)
    if Config.AdminLogging then
        ESX.DiscordLogFields("UserActions", "Clear Chat /clearall Triggered!", "pink", {
            { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
            { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
        })
    end
end, true, { help = TranslateCap("command_clearall") })

ESX.RegisterCommand("refreshjobs", "owner", function()
    ESX.RefreshJobs()
end, true, { help = TranslateCap("command_clearall") })

ESX.RegisterCommand(
    "setgroup",
    {"owner", "manager"},
    function(xPlayer, args)
        if not args.playerId then
            args.playerId = xPlayer.source
        end
        if args.group == "owner" and xPlayer.getGroup() ~= 'owner' then
            ESX.DiscordLogFields("UserActions", "Player tried to set owner group", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Group", value = args.group, inline = true },
            })
        end
        args.playerId.setGroup(args.group)
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "/setgroup Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Group", value = args.group, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_setgroup"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
            { name = "group", help = TranslateCap("command_setgroup_group"), type = "string" },
        },
    }
)

ESX.RegisterCommand(
    "save",
    "owner",
    function(_, args)
        Core.SavePlayer(args.playerId)
        print(("[^2Info^0] Saved Player - ^5%s^0"):format(args.playerId.source))
    end,
    true,
    {
        help = TranslateCap("command_save"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
        },
    }
)

ESX.RegisterCommand("saveall", "owner", function()
    Core.SavePlayers()
end, true, { help = TranslateCap("command_saveall") })

ESX.RegisterCommand("group", {"user", "tmod", "mod", "admin", "manager", "owner"}, function(xPlayer, _, _)
    xPlayer.showNotification(("%s, your group is %s"):format(xPlayer.getName(), xPlayer.getGroup()), true, false, 140)
end, true)

ESX.RegisterCommand("job", {"user", "tmod", "mod", "admin", "manager", "owner"}, function(xPlayer, _, _)
    xPlayer.showNotification(("%s, you are currently employed to %s as a %s"):format(xPlayer.getName(), xPlayer.getJob().label, xPlayer.getJob().grade_label), true, false, 140)
end, false)

ESX.RegisterCommand("info", {"user", "tmod", "mod", "admin", "manager", "owner"}, function(xPlayer)
    xPlayer.showNotification(("ID: %s | Name: %s | Group: %s | Job: %s"):format(xPlayer.source, xPlayer.getName(), xPlayer.getGroup(), xPlayer.getJob().label), true, false, 140)
end, false)

ESX.RegisterCommand("bank", {"user", "tmod", "mod", "admin", "manager", "owner"}, function(xPlayer, _, _)
    xPlayer.showNotification(("%s, your bank balance is: %s"):format(xPlayer.getName(), xPlayer.getAccount('bank').money), true, false, 140)
end, false)

ESX.RegisterCommand("playtime", { "user", "admin" }, function(xPlayer)
    local playtime = xPlayer.getPlayTime()
    local days = math.floor(playtime / 86400)
    local hours = math.floor((playtime % 86400) / 3600)
    local minutes = math.floor((playtime % 3600) / 60)
    print(("Playtime: ^5%s^0 Days | ^5%s^0 Hours | ^5%s^0 Minutes"):format(days, hours, minutes))
end, false)

ESX.RegisterCommand("coords", {"user", "tmod", "mod", "admin", "manager", "owner"}, function(xPlayer)
    local ped = GetPlayerPed(xPlayer.source)
    local coords = GetEntityCoords(ped, false)
    local heading = GetEntityHeading(ped)
    print(("Coords - Vector3: ^5%s^0"):format(vector3(coords.x, coords.y, coords.z)))
    print(("Coords - Vector4: ^5%s^0"):format(vector4(coords.x, coords.y, coords.z, heading)))
end, false)

ESX.RegisterCommand("tpm", {"tmod", "mod", "admin", "manager", "owner"}, function(xPlayer)
    xPlayer.triggerEvent("esx:tpm")
    if Config.AdminLogging then
        ESX.DiscordLogFields("UserActions", "Admin Teleport /tpm Triggered!", "pink", {
            { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
            { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
        })
    end
end, false)

ESX.RegisterCommand(
    "goto",
    {"tmod", "mod", "admin", "manager", "owner"},
    function(xPlayer, args)
        local targetCoords = args.playerId.getCoords()
        local srcDim = GetPlayerRoutingBucket(xPlayer.source)
        local targetDim = GetPlayerRoutingBucket(args.playerId.source)

        if srcDim ~= targetDim then
            SetPlayerRoutingBucket(xPlayer.source, targetDim)
        end
        xPlayer.setCoords(targetCoords)
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Admin Teleport /goto Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Target Coords", value = targetCoords, inline = true },
            })
        end
    end,
    false,
    {
        help = TranslateCap("command_goto"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
        },
    }
)

ESX.RegisterCommand(
    "bring",
    {"tmod", "mod", "admin", "manager", "owner"},
    function(xPlayer, args)
        local targetCoords = args.playerId.getCoords()
        local playerCoords = xPlayer.getCoords()
        local targetDim = GetPlayerRoutingBucket(args.playerId.source)
        local srcDim = GetPlayerRoutingBucket(xPlayer.source)

        if targetDim ~= srcDim then
            SetPlayerRoutingBucket(args.playerId.source, srcDim)
        end
        args.playerId.setCoords(playerCoords)
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Admin Teleport /bring Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Target Coords", value = targetCoords, inline = true },
            })
        end
    end,
    false,
    {
        help = TranslateCap("command_bring"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
        },
    }
)

ESX.RegisterCommand(
    "kill",
    "owner",
    function(xPlayer, args)
        args.playerId.triggerEvent("esx:killPlayer")
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Kill Command /kill Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_kill"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
        },
    }
)

ESX.RegisterCommand(
    "freeze",
    {"tmod", "mod", "admin", "manager", "owner"},
    function(xPlayer, args)
        args.playerId.triggerEvent("esx:freezePlayer", "freeze")
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Admin Freeze /freeze Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_freeze"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
        },
    }
)

ESX.RegisterCommand(
    "unfreeze",
    {"tmod", "mod", "admin", "manager", "owner"},
    function(xPlayer, args)
        args.playerId.triggerEvent("esx:freezePlayer", "unfreeze")
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Admin UnFreeze /unfreeze Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_unfreeze"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
        },
    }
)

ESX.RegisterCommand("noclip", "owner", function(xPlayer)
    xPlayer.triggerEvent("esx:noclip")
    if Config.AdminLogging then
        ESX.DiscordLogFields("UserActions", "Admin NoClip /noclip Triggered!", "pink", {
            { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
            { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
        })
    end
end, false)

ESX.RegisterCommand("players", "owner", function()
    local xPlayers = ESX.GetExtendedPlayers() -- Returns all xPlayers
    print(("^5%s^2 online player(s)^0"):format(#xPlayers))
    for i = 1, #xPlayers do
        local xPlayer = xPlayers[i]
        print(("^1[^2ID: ^5%s^0 | ^2Name : ^5%s^0 | ^2Group : ^5%s^0 | ^2Identifier : ^5%s^1]^0\n"):format(xPlayer.source, xPlayer.getName(), xPlayer.getGroup(), xPlayer.identifier))
    end
end, true)

ESX.RegisterCommand(
    {"setdim", "setbucket"},
    "owner",
    function(xPlayer, args)
        SetPlayerRoutingBucket(args.playerId.source, args.dimension)
        if Config.AdminLogging then
            ESX.DiscordLogFields("UserActions", "Admin Set Dim /setdim Triggered!", "pink", {
                { name = "Player", value = xPlayer and xPlayer.name or "Server Console", inline = true },
                { name = "ID", value = xPlayer and xPlayer.source or "Unknown ID", inline = true },
                { name = "Target", value = args.playerId.name, inline = true },
                { name = "Dimension", value = args.dimension, inline = true },
            })
        end
    end,
    true,
    {
        help = TranslateCap("command_setdim"),
        validate = true,
        arguments = {
            { name = "playerId", help = TranslateCap("commandgeneric_playerid"), type = "player" },
            { name = "dimension", help = TranslateCap("commandgeneric_dimension"), type = "number" },
        },
    }
)
