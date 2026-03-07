-- society logic
local societyBanks = {
    ["Renewed-Banking"] = {
        getBalance = function(job)
            return exports["Renewed-Banking"]:getAccountMoney(job) or 0
        end,
        withdraw = function(job, amount)
            return exports["Renewed-Banking"]:removeAccountMoney(job, amount)
        end,
        deposit = function(job, amount)
            return exports["Renewed-Banking"]:addAccountMoney(job, amount)
        end,
        createTransaction = function(data)
            -- Transaction logs if you want implement them here
            DebugLog("[Renewed-Banking] Creating transaction: " .. json.encode(data))
            return true
        end
    },
    ["qb-banking"] = {
        getBalance = function(job)
            return exports["qb-banking"]:GetAccountBalance(job)
        end,
        withdraw = function(job, amount)
            return exports["qb-banking"]:RemoveMoney(job, amount)
        end,
        deposit = function(job, amount)
            return exports["qb-banking"]:AddMoney(job, amount)
        end,
        createTransaction = function(data)
            DebugLog("[qb-banking] Creating transaction: " .. json.encode(data))
            return true
        end
    },
    ["es_extended"] = {
        getBalance = function(job)
            local balance = 0
            local societyAccount = "society_" .. job
            TriggerEvent("esx_addonaccount:getSharedAccount", societyAccount, function(account)
                if account then
                    balance = account.money
                end
            end)
            return balance
        end,
        withdraw = function(job, amount)
            local success = false
            local societyAccount = "society_" .. job
            TriggerEvent("esx_addonaccount:getSharedAccount", societyAccount, function(account)
                if account and account.money >= amount then
                    account.removeMoney(amount)
                    success = true
                end
            end)
            return success
        end,
        deposit = function(job, amount)
            local societyAccount = "society_" .. job
            TriggerEvent("esx_addonaccount:getSharedAccount", societyAccount, function(account)
                if account then
                    account.addMoney(amount)
                end
            end)
        end,
        createTransaction = function(data)
            DebugLog("[es_extended] Creating transaction: " .. json.encode(data))
            return true
        end
    },
    ["okokBanking"] = {
        getBalance = function(job)
            return exports["okokBanking"]:GetAccount(job)
        end,
        withdraw = function(job, amount)
            return exports["okokBanking"]:RemoveMoney(job, amount)
        end,
        deposit = function(job, amount)
            return exports["okokBanking"]:AddMoney(job, amount)
        end,
        createTransaction = function(data)
            DebugLog("[okokBanking] Creating transaction: " .. json.encode(data))
            return true
        end
    },
    ["tgg-banking"] = {
        getBalance = function(job)
            return exports["tgg-banking"]:GetSocietyAccountMoney(job)
        end,
        withdraw = function(job, amount)
            return exports["tgg-banking"]:RemoveSocietyMoney(job, amount)
        end,
        deposit = function(job, amount)
            return exports["tgg-banking"]:AddSocietyMoney(job, amount)
        end,
        createTransaction = function(data)
            DebugLog("[tgg-banking] Creating transaction: " .. json.encode(data))
            return true
        end
    },
    ["crm-banking"] = {
        getBalance = function(job)
            return exports["crm-banking"]:getSocietyMoney(job)
        end,
        withdraw = function(job, amount)
            return exports["crm-banking"]:removeSocietyMoney(job, amount)
        end,
        deposit = function(job, amount)
            return exports["crm-banking"]:addSocietyMoney(job, amount)
        end,
        createTransaction = function(data)
            DebugLog("[crm-banking] Creating transaction: " .. json.encode(data))
            return true
        end
    },
    ["fd_banking"] = {
        getBalance = function(job)
            return exports.fd_banking:GetAccount(job)
        end,
        withdraw = function(job, amount)
            return exports.fd_banking:RemoveMoney(job, amount)
        end,
        deposit = function(job, amount)
            return exports.fd_banking:AddMoney(job, amount)
        end,
        createTransaction = function(data)
            DebugLog("[fd_banking] Creating transaction: " .. json.encode(data))
            return true
        end
    },
    ["p_banking"] = {
        getBalance = function(job)
            return exports["p_banking"]:getAccountMoney(job) or 0
        end,
        withdraw = function(job, amount)
            return exports["p_banking"]:removeAccountMoney(job, amount)
        end,
        deposit = function(job, amount)
            return exports["p_banking"]:addAccountMoney(job, amount)
        end,
        createTransaction = function(data)
            -- Transaction logs if you want implement them here
            DebugLog("[p_banking] Creating transaction: " .. json.encode(data))
            return true
        end
    }
    -- add your banking system here
}

function GetActiveBank()
    for name, _ in pairs(societyBanks) do
        if GetResourceState(name) == "started" then
            return societyBanks[name], name
        end
    end
end

-- paycheck related function
--- Adds money to a player's paycheck based on job and payment type.
--- This function queues the amount to be claimed later from a paycheck system.
---
--- @param identifier string              -- The player identifier (license/steam).
--- @param job string                      -- The job name (e.g., 'police', 'mechanic').
--- @param amount number                   -- The amount to be added.
--- @param payType 'default' | 'society'   -- The paycheck type.
--- @param isBonus boolean                 -- Whether this is a bonus paycheck.
--- @param approvalRequired boolean        -- Whether approval is required.
function AddPaycheckByIdentifier(identifier, job, amount, payType, isBonus, approvalRequired)
    if not identifier or not job or not amount or amount <= 0 or job == Config.UnemployedJob then
        return
    end
    if isResourceStarted(Config.RecommendedResources.advPaycheck) then
        local existingRow = MySQL.single.await([[
         SELECT id FROM g_paychecks
         WHERE identifier = ? AND job = ?
           AND DATE(created_at) = CURDATE()
           AND collected = 0
           AND is_bonus = ?
         LIMIT 1
     ]], {identifier, job, isBonus and 1 or 0})

        if existingRow and existingRow.id then
            MySQL.update.await([[
             UPDATE g_paychecks
             SET amount = amount + ?, type = ?, approval_required = ?, is_bonus = ?
             WHERE id = ?
         ]], {amount, payType or "default", approvalRequired and 1 or 0, isBonus and 1 or 0, existingRow.id})
        else
            MySQL.insert.await([[
             INSERT INTO g_paychecks
             (identifier, job, amount, type, created_at, approval_required, collected, is_bonus)
             VALUES (?, ?, ?, ?, NOW(), ?, 0, ?)
         ]], {identifier, job, amount, payType or "default", approvalRequired and 1 or 0, isBonus and 1 or 0})
        end
    else
        -- Add your own bonus system here
    end
end

function MultiJobFireEmployee(identifier, job)
    --TriggerEvent('randol_multijob:server:FireEmployeeByIdentifier', identifier, job)
    if GetResourceState("g-multijob") == "started" then
        exports['g-multijob']:RemoveJob(identifier, job, true)
    end
end
