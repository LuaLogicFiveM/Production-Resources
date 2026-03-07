Config = {}

--- RECOMENDED TO LEAVE AS TRUE ---
Config.CheckForUpdates = true -- Check for updates on server start
Config.AutoImportSQL = true   -- Automatically import on server start

Config.SystemSettings = {
	-- en - English | es - spanish | de - German | fr = French | pt = portuguese | tr - Turkish | ru - Russian
	Language = "en",
	Debug = false,
	theme = "theme5",     -- gblue | theme2 | theme3 | theme4 | theme5 - defalt theme
	OpenMenuVia = "textui", -- target | textui | custom
	ClockItems = false,    -- if this true SV_CONFIG.Items will add/remove when ever player clock in or out
	ForceJobUpdate = true, -- If true, the player's job will be updated in the database whenever they clock in, clock out, or use the setjob command. Not recommended for production use; intended for testing only.
}

Config.clockDuration = 5 -- clock in or out progress time 5 = 5 seconds

-- TextUI settings
Config.Key = 38          -- 38 = [E] https://docs.fivem.net/docs/game-references/controls/#controls
Config.KeyName = "[E] "
Config.TextUI = "ox_lib" -- supported Notifications TextUi's -  "ox_lib" | "okok" | "esx" | "qbcore"
Config.ImageFormat = ".png"
-- g-notifications package - https://groot-development.tebex.io/package/6838310
Config.Notify = "esx" -- supported Notification's' - "g-notifications" | "ox_lib" | "esx" | "qbcore" | "okok"  | 17mov | standalone

Config.Icons = {
	userTargetIcon = "fa-solid fa-d",
	bossTargetIcon = "fa-solid fa-chart-line",
	LeaderBoardAndRewardsIcon = "fa-solid fa-coins",
}

-- Clocking
Config.Scenario = "WORLD_HUMAN_CLIPBOARD"
Config.CanDeletePlayerRecord = true       -- if this true this boss can delete player record
Config.CanResetPlayerTotalDutyTime = true -- if this true this boss can reset player duty time
Config.colorThresholds = "74, 222, 128"   -- GitHub-style green in RGB
Config.DutySystem = {
	["bcso"] = {
		theme = "gblue",
		RestrictedGrades = {}, -- These are the grades that are not allowed to use the duty system
		Station = {
			-- user
			duty = {
				coords = {
					vec4(2828.1711, 4712.6313, 48.6273, 12.1099),
				},
				EnablePed = true,
				model = "s_m_y_cop_01",     -- https://docs.fivem.net/docs/game-references/ped-models/
				scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
			},
			-- boss
			boss = {
				allowedGrades = { 10, 11 },
				coords = {
					vec3(2786.8657, 4739.6084, 48.6274),
				},
			},
		},
		Blip = {
			Enable = false,
			BlipSprite = 408, -- https://docs.fivem.net/docs/game-references/blips/
			BlipScale = 0.8,
			BlipColor = 26,
			BlipName = "Police Duty Station",
		},
	},
	["sasp"] = {
		theme = "gblue",
		RestrictedGrades = {}, -- These are the grades that are not allowed to use the duty system
		Station = {
			-- user
			duty = {
				coords = {
					vec4(836.5297, -1295.3843, 26.8965, 357.7525),
					-- add more coords if you want
				},
				EnablePed = true,
				model = "s_m_y_cop_01",     -- https://docs.fivem.net/docs/game-references/ped-models/
				scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
			},
			-- boss
			boss = {
				allowedGrades = { 10, 11 },
				coords = {
					vec3(835.0731, -1286.5104, 31.7655),
					-- add more coords if you want
				},
			},
		},
		Blip = {
			Enable = false,
			BlipSprite = 408, -- https://docs.fivem.net/docs/game-references/blips/
			BlipScale = 0.8,
			BlipColor = 26,
			BlipName = "Police Duty Station",
		},
	},
	["safd"] = {
		theme = "gblue",
		RestrictedGrades = {},
		Station = {
			duty = {
				coords = {
					vec4(1681.4703, 3580.5217, 35.7300, 206.7306),
				},
				EnablePed = true,
				model = "s_m_m_doctor_01",
				scenario = "WORLD_HUMAN_CLIPBOARD",
			},
			boss = {
				allowedGrades = { 5, 6 },
				coords = {
					vec3(1662.0447, 3588.7351, 35.7301),
				},
			},
		},
		Blip = {
			Enable = false,
			BlipSprite = 408, -- https://docs.fivem.net/docs/game-references/blips/
			BlipScale = 0.8,
			BlipColor = 6,
			BlipName = "Ambulance Duty Station",
		},
	},
}

Config.DutySelect = "V1" -- V1: Classic Menu (Default) | V2: Fingerprint Scanner (Modern & Realistic)
Config.fingerprintColorSchemes = "green" -- blue | green | red | purple | orange | cyan | teal | pink
-- Rewards
Config.EnableLeaderBoard = true
Config.EnableRewards = true

-- Rewards and LeaderBoard
Config.LeaderBoard = {
	-- Coordinates for where you want to display the leaderboard and rewards menu.
	["bcso"] = {
		Coords = {
			vec4(2829.8735, 4712.8882, 48.6274, 15.5170), -- add more coords if you want
		},
		Peds = {
			EnablePed = true,
			model = "s_m_m_fiboffice_01", -- https://docs.fivem.net/docs/game-references/ped-models/
			scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
		},
		Blip = {
			Enable = false,
			BlipSprite = 515, -- https://docs.fivem.net/docs/game-references/blips/
			BlipScale = 0.5,
			BlipColor = 26,
			BlipName = "BCSO Rewards Station",
		},
	},
	["sasp"] = {
		Coords = {
			vec4(837.7642, -1281.7025, 31.7655, 83.0195), -- add more coords if you want
		},
		Peds = {
			EnablePed = true,
			model = "s_m_m_fiboffice_01", -- https://docs.fivem.net/docs/game-references/ped-models/
			scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
		},
		Blip = {
			Enable = true,
			BlipSprite = 515, -- https://docs.fivem.net/docs/game-references/blips/
			BlipScale = 0.5,
			BlipColor = 26,
			BlipName = "SASP Rewards Station",
		},
	},
	["safd"] = {
		Coords = {
			vec4(1667.8326, 3579.2070, 35.7283, 228.1019), -- add more coords if you want
		},
		Peds = {
			EnablePed = true,
			model = "ig_sacha",           -- https://docs.fivem.net/docs/game-references/ped-models/
			scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
		},
		Blip = {
			Enable = false,
			BlipSprite = 515, -- https://docs.fivem.net/docs/game-references/blips/
			BlipScale = 0.5,
			BlipColor = 26,
			BlipName = "SAFD Rewards Staiton",
		},
	},
}

-- Configure this if you want: when a player leaves the zone while clocked in, they will be automatically clocked out
Config.AutoClockOutOnLeaveZone = false
Config.DutyZones = {
	['bcso'] = {
		-- Take coordinates from the center of the building
		coords = vec3(439.9292, -983.7081, 30.6896),
		range = 70.0,
	},
	['sasp'] = {
		-- Take coordinates from the center of the building
		coords = vec3(439.9292, -983.7081, 30.6896),
		range = 70.0,
	},
	['safd'] = {
		-- Take coordinates from the center of the building
		coords = vec3(439.9292, -983.7081, 30.6896),
		range = 70.0,
	},
}
