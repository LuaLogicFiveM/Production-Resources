Config = {}

Config.Debug = false

--[[
    Supported frameworks:
        * auto: auto-detect framework
        * esx: es_extended - https://github.com/esx-framework/esx-legacy
        * qb: qb-core - https://github.com/qbcore-framework/qb-core
        * standalone: no framework, you will have to implement the functions yourself
]]
Config.Framework = "esx" -- recommended to use "auto"

--[[
	Supported company money systems:
		* auto: auto-detect company money system
		* esx_addonaccount
		* qb-banking
		* renewed-banking
		* custom: implement it yourself in vivum-billing/server/frameworks/company-money/custom.lua
]]
Config.CompanyMoneySystem = "custom" -- recommended to use "auto"

-- The locale the notifications are in and the fallback locale in case user has an unsupported locale specified in their phone.
Config.Locale = "en"

-- If individuals (players) can receive invoices from societies or (optionally) players.
Config.CanIndividualsReceive = true

-- If individuals (players) can send invoices to societies and players.
Config.CanIndividualsSend = false

-- How often to check for overdue invoices (default)
Config.OverdueCheckInterval = 1000 * 60 * 60 -- Defaults to one hour (the value is in milliseconds)

--[[
	The different behaviors of penalities:
		* none: do nothing, just mark the invoices as overdue in the app.

		* partial: each overdue check (Config.OverdueCheckInterval) will check for unpaid invoices and forcefully pay the with what bank money they have (i.e. if they have the full amount of the invoice it'll be fully paid and completed. If they do *not* have the full amount, it'll partially pay what they have and subtract the amount from the invoice—and wait for the next overdue check to see if they have any more money)

		* debt: forcefully pay the invoice even if they do not have the full amount and make them go into debt. Some frameworks and resources may not handle negative bank balance well, so be careful.
]]

Config.UnpaidInvoiceBehavior = "partial"

-- The max amount of overdue payment penalty fee (in percentage). Defaults to an maximum of 100% (double of the invoice amount)
Config.MaxPenaltyFee = 100
Config.BasePenaltyFee = 10 -- If starting amount of penalty fee for overdue invoices (i.e. if the invoice is 30 minutes late, it will be set to the BasePenaltyFee, if its 1 hour and 30 minutes late it'll be BasePenaltyFee + (PenaltyIncreasePerHour * 1))
Config.PenaltyIncreasePerHour = 0.5 -- Each hour will add an interest of <value>% to the amount of the invoice. Defaults to 0.5% each hour (a day overdue equals an 12% increase)

-- Distances if under MaxDistance will show in the dropdown when sending an invoice. If ShowOnlyNearbyPlayers is true, the players will not show up in the dropdown at all if the distance overexceeds MaxDistance.
Config.ShowPlayerDistance = true
Config.MaxDistance = 10
Config.ShowOnlyNearbyPlayers = true
Config.DistanceFormat = function(distance)
	return math.round(distance) .. "m"
end

-- If the app should be downloaded by default.
Config.DefaultApp = true

-- The requireed grade to send/pay company invoices. Default is "boss"
--  ** If you want to disable a certain grade from paying or cancelling invoices, specify a table with `false` as a second value as so: { "my_grade", false }
Config.Grades = {
	bcso = { "all" },
	gsp = { "all" },
	gov = { "all" },
}

Config.Avatars = {
	bcso = "https://static.wikia.nocookie.net/nopixel/images/2/2a/LSPD4.png",
	gsp = "https://static.wikia.nocookie.net/nopixel/images/2/2a/LSPD4.png",
}

-- You can specify societies which should be blacklisted from the billing funcitonality.
Config.Blacklisted = {
	--tailor = { send = false, receive = false },
}

-- You can add commission rates for each grade for every invoice they send, especially handy for car dealerships and similar professions.
Config.Commission = {
	gsp = {
		cadet = 0.3,
		trooper = 0.3,
		trooper_sr = 0.3,
		corporal = 0.3,
		sergeant = 0.3,
		sr_sergeant = 0.3,
		supervisor = 0.3,
		sr_supervisor = 0.3,
		lieutenant = 0.3,
		captain = 0.3,
		major = 0.3,
		boss = 0.3,
	},
	bcso = {
		recruit = 0.3,
		corporal = 0.3,
		sergeant = 0.3,
		srsergeant = 0.3,
		lieutenant = 0.3,
		captain = 0.3,
		major = 0.3,
		supervisor = 0.3,
		command = 0.3,
		astdep = 0.3,
		depcom = 0.3,
		boss = 0.3,
	},
	gov = {
		boss = 0.3,
		dmv = 0.3,
		atf = 0.3,
		dea = 0.3,
		prosecutor = 0.3,
		lawyer = 0.3,
	},
}

-- Disable the UI for sending invoices (i.e. only being able to send through exports)
Config.DisableSendInvoiceUI = false

-- Disable the option for multiple payments.
Config.DisableMultiplePayments = false

-- Disable the option for payment periods.
Config.DisablePaymentPeriods = false

-- If you want to override the app name, regardless of locales,
Config.OverrideAppName = "" -- "Billing"

-- Check and fix the database on every restart. This is recommended to be enabled.
Config.CheckDatabase = false

-- Disable standalone UI
Config.DisableStandaloneUI = false

-- The default keybind to open the billing UI if *standalone mode* (i.e not lb-phone)
Config.DefaultKeybind = "f7"

Config.Functions = {
	SentInvoice = function(source, invoice) end,
	CancelledInvoice = function(source, invoice) end,
	PaidInvoice = function(source, invoice) end,
}
