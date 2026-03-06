Config = {}

--- RECOMENDED TO LEAVE AS TRUE ---
Config.CheckForUpdates = true -- Check for updates on server start
Config.AutoImportSQL = true   -- Automatically import on server start

Config.SystemSettings = {
	-- en - English | es - spanish | de - German | fr = French | pt = portuguese | tr - Turkish | ru - Russian
	Language = "en",
	Debug = false,
	theme = "theme3",     -- gblue | theme2 | theme3 | theme4 | theme5 - defalt theme
	OpenMenuVia = "textui", -- target | textui | custom
	ClockItems = true,    -- if this true SV_CONFIG.Items will add/remove when ever player clock in or out
	ForceJobUpdate = false, -- If true, the player's job will be updated in the database whenever they clock in, clock out, or use the setjob command. Not recommended for production use; intended for testing only.
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
					vec4(437.0450, -986.5495, 30.6896, 349.8869),
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
					vec3(451.7888488769531, -972.6823120117188, 30.72463035583496),
					-- add more coords if you want
				},
			},
		},
		Blip = {
			Enable = true,
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
					vec4(437.0450, -986.5495, 30.6896, 349.8869),
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
					vec3(451.7888488769531, -972.6823120117188, 30.72463035583496),
					-- add more coords if you want
				},
			},
		},
		Blip = {
			Enable = true,
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
					vec4(294.0028, -597.4308, 43.2904, 58.5312),
				},
				EnablePed = true,
				model = "s_m_m_doctor_01",
				scenario = "WORLD_HUMAN_CLIPBOARD",
			},
			boss = {
				allowedGrades = { 3 },
				coords = {
					vec3(297.287, -588.770, 42.710),
				},
			},
		},
		Blip = {
			Enable = true,
			BlipSprite = 408, -- https://docs.fivem.net/docs/game-references/blips/
			BlipScale = 0.8,
			BlipColor = 6,
			BlipName = "Ambulance Duty Station",
		},
	},
}

Config.DutySelect = "V2" -- V1: Classic Menu (Default) | V2: Fingerprint Scanner (Modern & Realistic)
Config.fingerprintColorSchemes = "green" -- blue | green | red | purple | orange | cyan | teal | pink
-- Rewards
Config.EnableLeaderBoard = true
Config.EnableRewards = true

-- Rewards and LeaderBoard
Config.LeaderBoard = {
	-- Coordinates for where you want to display the leaderboard and rewards menu.
	["bcso"] = {
		Coords = {
			vec4(427.9968, -986.4164, 30.7118, 356.7822), -- add more coords if you want
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
			BlipName = "BCSO Rewards Station",
		},
	},
	["sasp"] = {
		Coords = {
			vec4(427.9968, -986.4164, 30.7118, 356.7822), -- add more coords if you want
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
			vec4(287.2109, -588.2889, 43.1209, 252.0593), -- add more coords if you want
		},
		Peds = {
			EnablePed = true,
			model = "ig_sacha",           -- https://docs.fivem.net/docs/game-references/ped-models/
			scenario = "WORLD_HUMAN_CLIPBOARD", -- https://gtaforums.com/topic/796181-list-of-scenarios-for-peds/
		},
		Blip = {
			Enable = true,
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
