function StartPayCheck()
    CreateThread(function()
        while true do
            Wait(Config.PaycheckInterval)
            for player, xPlayer in pairs(ESX.Players) do
                local jobLabel = xPlayer.job.label
                local job = xPlayer.job.grade_name
                local onDuty = xPlayer.job.onDuty
                local salary = (job == "unemployed" or onDuty) and xPlayer.job.grade_salary or ESX.Math.Round(xPlayer.job.grade_salary * Config.OffDutyPaycheckMultiplier)

                if xPlayer.paycheckEnabled then
                    if salary > 0 then
                        if job == "unemployed" then -- unemployed
                            xPlayer.addAccountMoney("bank", salary, "Welfare Check")
                            TriggerClientEvent("esx:showAdvancedNotification", player, TranslateCap("bank"), TranslateCap("received_paycheck"), TranslateCap("received_help", salary), "CHAR_BANK_MAZE", 9)
                            if Config.LogPaycheck then
                                ESX.DiscordLogFields("Paycheck", "Paycheck - Unemployment Benefits", "green", {
                                    { name = "Player", value = xPlayer.name, inline = true },
                                    { name = "ID", value = xPlayer.source, inline = true },
                                    { name = "Amount", value = salary, inline = true },
                                })
                            end
                        elseif Config.EnableSocietyPayouts then -- possibly a society
                            local societyMoney = exports['g-bossmenu']:GetSocietyMoney(xPlayer.job.name)
                            if societyMoney then -- verified society
                                if societyMoney >= salary then -- does the society money to pay its employees?
                                    xPlayer.addAccountMoney("bank", salary, "Paycheck")
                                    exports['g-bossmenu']:WithdrawMoney(xPlayer.job.name, salary)
                                    exports['g-bossmenu']:CreateTransactionLog({
                                        society_name = xPlayer.job.name,
                                        type = 'withdraw',
                                        amount = salary,
                                        identifier = xPlayer.identifier,
                                        performed_by = 'Salary Paid',
                                        notes = ('%s\'s salary for the amount of %i was paid'):format(xPlayer.getName(), salary),
                                    })
                                    if Config.LogPaycheck then
                                        ESX.DiscordLogFields("Paycheck", "Paycheck - " .. jobLabel, "green", {
                                            { name = "Player", value = xPlayer.name, inline = true },
                                            { name = "ID", value = xPlayer.source, inline = true },
                                            { name = "Amount", value = salary, inline = true },
                                        })
                                    end

                                    TriggerClientEvent("esx:showAdvancedNotification", player, TranslateCap("bank"), TranslateCap("received_paycheck"), TranslateCap("received_salary", salary), "CHAR_BANK_MAZE", 9)
                                else
                                    TriggerClientEvent("esx:showAdvancedNotification", player, TranslateCap("bank"), "", TranslateCap("company_nomoney"), "CHAR_BANK_MAZE", 1)
                                end
                            else -- not a society
                                xPlayer.addAccountMoney("bank", salary, "Paycheck")
                                if Config.LogPaycheck then
                                    ESX.DiscordLogFields("Paycheck", "Paycheck - " .. jobLabel, "green", {
                                        { name = "Player", value = xPlayer.name, inline = true },
                                        { name = "ID", value = xPlayer.source, inline = true },
                                        { name = "Amount", value = salary, inline = true },
                                    })
                                end
                                TriggerClientEvent("esx:showAdvancedNotification", player, TranslateCap("bank"), TranslateCap("received_paycheck"), TranslateCap("received_salary", salary), "CHAR_BANK_MAZE", 9)
                            end
                        else -- generic job
                            xPlayer.addAccountMoney("bank", salary, "Paycheck")
                            if Config.LogPaycheck then
                                ESX.DiscordLogFields("Paycheck", "Paycheck - Generic", "green", {
                                    { name = "Player", value = xPlayer.name, inline = true },
                                    { name = "ID", value = xPlayer.source, inline = true },
                                    { name = "Amount", value = salary, inline = true },
                                })
                            end
                            TriggerClientEvent("esx:showAdvancedNotification", player, TranslateCap("bank"), TranslateCap("received_paycheck"), TranslateCap("received_salary", salary), "CHAR_BANK_MAZE", 9)
                        end
                    end
                end
            end
        end
    end)
end
