SV_CONFIG = {}
-- When "SV_CONFIG.TXAdmin = true" is enabled, the script will save all player duty data 15 seconds before a scheduled restart.
-- If set to false, the script will use periodic auto-saving based on the hours set in "SV_CONFIG.AutoSaveHours".
-- To enable periodic saving, make sure "SV_CONFIG.EnableAutoSave = true".
SV_CONFIG.TXAdmin = true
SV_CONFIG.EnableAutoSave = false
SV_CONFIG.AutoSaveHours = 4 -- 4 = 4hours save all duty time every 4 hours auto

SV_CONFIG.Webhooks = {
	["DUTY_LOGS"] = {
		["safd"] = {
			webhook = "https://discord.com/api/webhooks/1479569299583668315/csxRUIcMHbdGlh8skdzqTAN-HfzBnfzBVWjyBMcswhCH8poHbPNKIS1_xmNSOCF_IxhD",
		},
		["bcso"] = {
			webhook = "https://discord.com/api/webhooks/1479569299583668315/csxRUIcMHbdGlh8skdzqTAN-HfzBnfzBVWjyBMcswhCH8poHbPNKIS1_xmNSOCF_IxhD",
		},
		["sasp"] = {
			webhook = "https://discord.com/api/webhooks/1479569299583668315/csxRUIcMHbdGlh8skdzqTAN-HfzBnfzBVWjyBMcswhCH8poHbPNKIS1_xmNSOCF_IxhD",
		},
	},
	["DUTY_ITEMS_LOG"] = {
		["bcso"] = {
			webhook = "https://discord.com/api/webhooks/1479569299583668315/csxRUIcMHbdGlh8skdzqTAN-HfzBnfzBVWjyBMcswhCH8poHbPNKIS1_xmNSOCF_IxhD",
			Title = "BCSO Duty Logs",
		},
		["sasp"] = {
			webhook = "https://discord.com/api/webhooks/1479569299583668315/csxRUIcMHbdGlh8skdzqTAN-HfzBnfzBVWjyBMcswhCH8poHbPNKIS1_xmNSOCF_IxhD",
			Title = "SASP Duty Logs",
		},
		["safd"] = {
			webhook = "https://discord.com/api/webhooks/1479569299583668315/csxRUIcMHbdGlh8skdzqTAN-HfzBnfzBVWjyBMcswhCH8poHbPNKIS1_xmNSOCF_IxhD",
			Title = "SAFD Duty Logs",
		},
	},
}

SV_CONFIG.GoogleSheetsLogs = {
	Enable = true, -- If this is true, the script will save duty data to Google Sheets.
	Api = "https://sheetdb.io/api/v1/",
	Sheets = {
		["bcso"] = "4qyw1ixy2y8do", -- sheet id - replace this link with your sheetdb.io link (https://sheetdb.io/)
		["sasp"] = "risqug9ug6sjy", -- sheet id - replace this link with your sheetdb.io link (https://sheetdb.io/)
	},
}

SV_CONFIG.SlashCommands = {
	AllowSlashCommands = true, -- If this is true, players can clock in and out of duty using commands, e.g., /onduty or /offduty.
	CoolDown = 15, -- The cooldown time in seconds for using the clock-in and clock-out commands.
	["onduty"] = {
		cmd = "onduty",
		help = "Clock in and get ready to serve the community!",
	},
	["offduty"] = {
		cmd = "offduty",
		help = "Clock out and take a well-deserved break.",
	},
}

SV_CONFIG.AdminSlashCommands = {
	AllowSlashCommands = true,

	["resetduty"] = {
		cmd = "resetduty",
		help = "Reset total duty time for all players in the specified job.",
		params = { {
			name = "job",
			help = "The job name to reset (e.g., bcso, sasp, safd)",
		} },
	},

	["deleteduty"] = {
		cmd = "deleteduty",
		help = "Delete all saved duty data for the specified job.",
		params = {
			{
				name = "job",
				help = "The job name to delete (e.g., bcso, sasp, safd)",
			},
		},
	},
}

-- if you want to add items when clocking
-- for item remove if you set count = 0 then all than given item will be removed
SV_CONFIG.Items = {
	--[[["bcso"] = {
		Add = {
			{
				item = "bandage",
				count = 1,
			},
			{
				item = "radio",
				count = 1,
			},
		},
		Remove = {
			{
				item = "radio",
				count = 0,
			}
		},
	},
	["sasp"] = {
		Add = {
			{
				item = "bandage",
				count = 1,
			},
			{
				item = "radio",
				count = 1,
			},
		},
		Remove = {
			{
				item = "radio",
				count = 0,
			}
		},
	},
	["safd"] = {
		Add = {
			{
				item = "bandage",
				count = 2,
			},
			{
				item = "radio",
				count = 1,
			},
		},
		Remove = {
			{
				item = "radio",
				count = 1,
			},
			{
				item = "bandage",
				count = 2,
			},
		},
	},]]
}
-- Every item index should be unique for each job, as the system uses this ID to check whether it has been collected or not. Even if the item is deleted, do not reuse the same ID
SV_CONFIG.Rewards = {
	--[[["bcso"] = { -- job name
		[4] = {
			required_hours = 4,
			type = "item",
			label = "Medikit",
			desc = "Essential first-aid kit for emergencies.",
			item = "medikit",
			amount = 2,
			image = "medikit",
			disable = false,
			progressbarColor = "lime",
		},
		[5] = {
			required_hours = 0,
			type = "money",
			label = "Cash",
			desc = "Financial bonus for your service.",
			item = "bank", -- cash, bank, and black_money are supported. If you're not using ESX, black_money will be treated as crypto by default, but you can configure this behavior in the bridge.
			amount = 100,
			image = "money",
			disable = false,
			args = {},
		},
		[6] = {
			required_hours = 2,
			type = "xp",
			label = "XP",
			desc = "Boost your skills with extra XP.",
			item = "money",
			amount = 100,
			image = "xp",
			disable = false,
			args = {
				name = "shooting",
			},
		},
		[7] = {
			required_hours = 4,
			type = "money",
			label = "Cash",
			desc = "Earn extra cash for your dedication.",
			item = "cash", -- cash, bank, and black_money are supported. If you're not using ESX, black_money will be treated as crypto by default, but you can configure this behavior in the bridge.
			amount = 1000,
			image = "money",
			disable = false,
			args = {},
		},
		[8] = {
			required_hours = 6,
			type = "item",
			label = "Adv Repair Kit",
			desc = "Advanced kit for vehicle repairs.",
			item = "g_advanced_repairkit",
			amount = 1,
			image = "g_advanced_repairkit",
			disable = false,
			args = {},
		},
		[9] = {
			required_hours = 6,
			type = "item",
			label = "Binoculars",
			desc = "Get a clearer view from a distance.",
			item = "binoculars",
			amount = 1,
			image = "binoculars",
			disable = false,
			args = {},
		},
		[10] = {
			required_hours = 6,
			type = "item",
			label = "Iron",
			desc = "Useful raw material for crafting.",
			item = "iron",
			amount = 1,
			image = "iron",
			disable = false,
			args = {},
		},
	},
	["sasp"] = { -- job name
		[4] = {
			required_hours = 4,
			type = "item",
			label = "Medikit",
			desc = "Essential first-aid kit for emergencies.",
			item = "medikit",
			amount = 2,
			image = "medikit",
			disable = false,
			progressbarColor = "lime",
		},
		[5] = {
			required_hours = 0,
			type = "money",
			label = "Cash",
			desc = "Financial bonus for your service.",
			item = "bank", -- cash, bank, and black_money are supported. If you're not using ESX, black_money will be treated as crypto by default, but you can configure this behavior in the bridge.
			amount = 100,
			image = "money",
			disable = false,
			args = {},
		},
		[6] = {
			required_hours = 2,
			type = "xp",
			label = "XP",
			desc = "Boost your skills with extra XP.",
			item = "money",
			amount = 100,
			image = "xp",
			disable = false,
			args = {
				name = "shooting",
			},
		},
		[7] = {
			required_hours = 4,
			type = "money",
			label = "Cash",
			desc = "Earn extra cash for your dedication.",
			item = "cash", -- cash, bank, and black_money are supported. If you're not using ESX, black_money will be treated as crypto by default, but you can configure this behavior in the bridge.
			amount = 1000,
			image = "money",
			disable = false,
			args = {},
		},
		[8] = {
			required_hours = 6,
			type = "item",
			label = "Adv Repair Kit",
			desc = "Advanced kit for vehicle repairs.",
			item = "g_advanced_repairkit",
			amount = 1,
			image = "g_advanced_repairkit",
			disable = false,
			args = {},
		},
		[9] = {
			required_hours = 6,
			type = "item",
			label = "Binoculars",
			desc = "Get a clearer view from a distance.",
			item = "binoculars",
			amount = 1,
			image = "binoculars",
			disable = false,
			args = {},
		},
		[10] = {
			required_hours = 6,
			type = "item",
			label = "Iron",
			desc = "Useful raw material for crafting.",
			item = "iron",
			amount = 1,
			image = "iron",
			disable = false,
			args = {},
		},
	},
	["safd"] = {
		[11] = {
			required_hours = 4,
			type = "item",
			label = "Medikit",
			desc = "Essential first-aid kit for emergencies.",
			item = "medikit",
			amount = 2,
			image = "medikit",
			disable = false,
			progressbarColor = "lime",
		},
		[12] = {
			required_hours = 0,
			type = "money",
			label = "Cash",
			desc = "Financial bonus for your service.",
			item = "bank", -- cash, bank, and black_money are supported. If you're not using ESX, black_money will be treated as crypto by default, but you can configure this behavior in the bridge.
			amount = 100,
			image = "money",
			disable = false,
			args = {},
		},
	},]]
}
