--[[
    =======================
    Invoice/Billing Settings
    =======================
]]
--Supported Scripts:  loaf_billing, okokBilling, codem, qs-billing, esx

Config.Invoice_Script = "custom"


function Config.SendInvoice(price, target, source, society_name)
    if not society_name then return end -- Dont Send invoices if the society_name was invalid
    if Config.Invoice_Script == "okokBilling" then
        local from = {
            label = society_name,
            identifier = society_name,
        }
        TriggerEvent('bill:createBill', target, price, society_name, from, source)
    elseif Config.Invoice_Script == "loaf_billing" then
        exports['loaf_billing']:CreateBill(source, function() end, target, 30, 0, price, society_name,
            "Stance Billing", society_name)
    elseif Config.Invoice_Script == "codem" then
        exports['codem-billing']:createBilling(source, target, price, society_name, society_name)
    elseif Config.Invoice_Script == "esx" then
        TriggerEvent('esx_billing:sendBill', target, society_name, society_name, price)
    elseif Config.Invoice_Script == "cs_billing" then
        exports['cs_billing']:createBill({
            playerID = target,           --Player's ID to whom you want to send an invoice
            society = society_name,      --Invoice Society Name
            society_name = society_name, --Invoice Society Label
            amount = price,              --Invoice Amount,
            senderID = source
        })
    elseif Config.Invoice_Script == "qs-billing" then
        exports['qs-billing']:ServerCreateInvoice(source, society_name, "Stance Billing", price, true, false,
            false, nil, society_name)
    elseif Config.Invoice_Script == 'RxBilling' then
        -- sendTo: PlayerId or Job Name
        -- isJobInvoice: should be true if invoice is sent by job from the player (fromPlayerId)
        exports['RxBilling']:SendInvoice(source, target, price, 'Stance Billing', true)
    elseif Config.Invoice_Script == "custom" then
        -- put your export here !!!
        local playerName = GetPlayerName(source)
        local invoiceData = {
            sender = society_name,
            sender_label = society_name,
            recipient = playerName.. '_' ..source,
            recipient_label = playerName,
            amount = price,
            payments_num = 1,
            payments_period = 7, -- (in days)
            summary = "Vehicle Stance Bill"
        }

        exports["vivum-billing"]:SendInvoice(target, invoiceData, function(res)
            print(res.status) -- OK or FAILED
        end)
    end
end
