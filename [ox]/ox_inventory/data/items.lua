return {
	['defibrillator'] = {
		label = 'Defibrillator',
		weight = 100,
		stack = true,
		description = "Used for reviving patients.",
	},

	['tweezers'] = {
		label = 'Tweezers',
		weight = 100,
		stack = true,
		description = "Precision tweezers for safely removing foreign objects, such as bullets, from wounds.",
	},

	['burncream'] = {
		label = 'Burn Cream',
		weight = 100,
		stack = true,
		description = "Specialized cream for treating and soothing minor burns and skin irritations.",
	},

	['suturekit'] = {
		label = 'Suture Kit',
		weight = 100,
		stack = true,
		description = "A kit containing surgical tools and materials for stitching and closing wounds.",
	},

	['icepack'] = {
		label = 'Ice Pack',
		weight = 200,
		stack = true,
		description = "An ice pack used to reduce swelling and provide relief from pain and inflammation.",
	},

	['emstablet'] = {
		label = 'Ems tablet',
		weight = 200,
		stack = true,
		client = {
			export = 'ars_ambulancejob.openDistressCalls'
		}
	},

	-- MARK: Prodigy

	-- Security
	["security_camera"] = {
		label = "Security Camera",
		weight = 0,
		stack = false
	},
	["motion_sensor"] = {
		label = "Motion Sensor",
		weight = 0,
		stack = false
	},
	["privacy_tool"] = {
		label = "Device Pry Tool",
		weight = 0,
		stack = false
	},

	-- Scenes
	-- Graffiti (optional)
	["spray_can"] = {
		label = "Spray Can",
		weight = 1,
		stack = false
	},
	["spray_remover"] = {
		label = "Spray Remover",
		weight = 1,
		stack = false,
	},

	-- Racing
	["racing_tablet"] = {
		label = "Racing Tablet",
		weight = 500,
		stack = false
	},
	["pink_slip"] = {
		label = "Pink Slip Claim",
		weight = 5,
		stack = false
	},

	-- Pressure Washing
	-- Generator (deployable)
	["pressurewash"] = {
		label = "Pressure Wash Generator",
		weight = 5000,
		stack = false
	},
	-- Refill consumables
	["petrolcan"] = {
		label = "Gas Can",
		weight = 1000,
		stack = false,
	},
	["watercanister"] = {
		label = "Water Canister",
		weight = 1000,
		stack = false,
	},

	-- Police Utils
	-- Spike strips
	["spikesbox"] = {
		label = "Spike Strip Box",
		weight = 2000,
		stack = false
	},
	["spikebox_pilot"] = {
		label = "Spike Strip Remote",
		weight = 200,
		stack = false
	},
	-- GPS trackers
	["placeable_gps"] = {
		label = "GPS Tracker",
		weight = 100,
		stack = false
	},
	["shootable_gps"] = {
		label = "GPS Tracker (Shootable)",
		weight = 50,
		stack = true,
	},

	-- Notebook
	["notebook"] = {
		label = "Notebook",
		weight = 200,
		buttons = {
			{
				label = "Duplicate",
				action = function(slot)
					TriggerServerEvent("prp-notebook:server:duplicateNotebook", slot)
				end
			}
		},
	},

	-- Mining
	-- Ore items (raw drops)
	["iron_ore"] = { label = "Iron Ore", weight = 500, stack = 50 },
	["copper_ore"] = { label = "Copper Ore", weight = 500, stack = 50 },
	["zinc_ore"] = { label = "Zinc Ore", weight = 500, stack = 50 },
	["aluminium_ore"] = { label = "Aluminium Ore", weight = 500, stack = 50 },
	["lithium_ore"] = { label = "Lithium Ore", weight = 500, stack = 50 },
	["nickel_ore"] = { label = "Nickel Ore", weight = 500, stack = 50 },
	["magnesium_ore"] = { label = "Magnesium Ore", weight = 500, stack = 50 },
	["gold_ore"] = { label = "Gold Ore", weight = 500, stack = 50 },
	["diamond_ore"] = { label = "Diamond Ore", weight = 500, stack = 50 },
	["limestone_ore"] = { label = "Limestone Ore", weight = 500, stack = 50 },
	["basic_looking_ore"] = { label = "Stone Ore", weight = 500, stack = 50 },
	["gem_ore"] = { label = "Gem Ore", weight = 500, stack = 50 },
	-- Refined minerals (after cleaning)
	["iron"] = { label = "Iron", weight = 500, stack = 50 },
	["copper"] = { label = "Copper", weight = 500, stack = 50 },
	["zinc"] = { label = "Zinc", weight = 500, stack = 50 },
	["aluminium"] = { label = "Aluminium", weight = 500, stack = 50 },
	["lithium"] = { label = "Lithium", weight = 500, stack = 50 },
	["nickel"] = { label = "Nickel", weight = 500, stack = 50 },
	["magnesium"] = { label = "Magnesium", weight = 500, stack = 50 },
	["gold"] = { label = "Gold", weight = 500, stack = 50 },
	["diamond"] = { label = "Diamond", weight = 500, stack = 50 },
	["limestone"] = { label = "Limestone", weight = 500, stack = 50 },
	["basic_looking"] = { label = "Stone", weight = 500, stack = 50 },
	["gem"] = { label = "Gem", weight = 500, stack = 50 },
	-- Gems (found in tunnels, rank 5+)
	["sapphire_gem"] = { label = "Sapphire", weight = 100, stack = 50 },
	["ruby_gem"] = { label = "Ruby", weight = 100, stack = 50 },
	["emerald_gem"] = { label = "Emerald", weight = 100, stack = 50 },
	["topaz_gem"] = { label = "Topaz", weight = 100, stack = 50 },

	-- Metal Detector
	["metaldetector"] = {
		label = "Metal Detector",
		weight = 1500
	},
	["treasure_key"] = {
		label = "Treasure Key",
		weight = 100,
	},

	-- Lumberjack
	-- Logs
	["oak_log"] = {
		label = "Low Softwood Log",
		weight = 10000,
		stack = false,
	},
	["cedar_log"] = {
		label = "Medium Softwood Log",
		weight = 10000,
		stack = false,
	},
	["pine_log"] = {
		label = "High Softwood Log",
		weight = 10000,
		stack = false,
	},
	["olive_log"] = {
		label = "Hardwood Log",
		weight = 10000,
		stack = false,
	},
	["forest_tree_log"] = {
		label = "Hard Hardwood Log",
		weight = 10000,
		stack = false,
	},

	-- Planks
	["oak_plank"] = {
		label = "Oak Plank",
		weight = 100,
		stack = 50,
	},
	["cedar_plank"] = {
		label = "Medium Softwood Plank",
		weight = 100,
		stack = 50,
	},
	["pine_plank"] = {
		label = "High Softwood Plank",
		weight = 100,
		stack = 50,
	},
	["olive_plank"] = {
		label = "Hardwood Plank",
		weight = 100,
		stack = 50,
	},
	["forest_tree_plank"] = {
		label = "Hard Hardwood Plank",
		weight = 100,
		stack = 50,
	},

	-- Fishing
	["basic_fishing_rod"] = {
		label = "Basic Fishing Rod",
		weight = 800
	},
	["sport_fishing_rod"] = {
		label = "Sport Fishing Rod",
		weight = 1000
	},
	["professional_fishing_rod"] = {
		label = "Professional Fishing Rod",
		weight = 1200
	},
	["prodigy_fishing_rod"] = {
		label = "Prodigy Fishing Rod",
		weight = 1400,
	},
	["aqua_fishing_rod"] = {
		label = "Aqua Fishing Rod",
		weight = 1500,
		closeUi = true
	},
	["sunset_fishing_rod"] = {
		label = "Sunset Fishing Rod",
		weight = 1500
	},
	["golden_fishing_rod"] = {
		label = "Golden Fishing Rod",
		weight = 1500
	},
	
	-- Bait
	["fishing_bait_worm"] = {
		label = "Worm Bait",
		weight = 10,
	},
	["fishing_bait_lugworm"] = {
		label = "Lugworm Bait",
		weight = 10,
	},
	["fishing_bait_radiated"] = {
		label = "Radiated Bait",
		weight = 10,
	},
	
	["small_bullhead"] = {
		label = "Bullhead",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_bullhead"] = {
		label = "Bullhead",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_bullhead"] = {
		label = "Bullhead",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_carp"] = {
		label = "Carp",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_carp"] = {
		label = "Carp",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_carp"] = {
		label = "Carp",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_catfish"] = {
		label = "Catfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_catfish"] = {
		label = "Catfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_catfish"] = {
		label = "Catfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_perch"] = {
		label = "Perch",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_perch"] = {
		label = "Perch",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_perch"] = {
		label = "Perch",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_rainbow_trout"] = {
		label = "Rainbow Trout",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_rainbow_trout"] = {
		label = "Rainbow Trout",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_rainbow_trout"] = {
		label = "Rainbow Trout",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_northern_pike"] = {
		label = "Northern Pike",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_northern_pike"] = {
		label = "Northern Pike",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_northern_pike"] = {
		label = "Northern Pike",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	
	-- Saltwater Fish
	["small_atlantic_croaker"] = {
		label = "Atlantic Croaker",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_atlantic_croaker"] = {
		label = "Atlantic Croaker",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_atlantic_croaker"] = {
		label = "Atlantic Croaker",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_atlantic_mackerel"] = {
		label = "Atlantic Mackerel",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_atlantic_mackerel"] = {
		label = "Atlantic Mackerel",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_atlantic_mackerel"] = {
		label = "Atlantic Mackerel",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_flounder"] = {
		label = "Flounder",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_flounder"] = {
		label = "Flounder",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_flounder"] = {
		label = "Flounder",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_red_mullet"] = {
		label = "Red Mullet",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_red_mullet"] = {
		label = "Red Mullet",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_red_mullet"] = {
		label = "Red Mullet",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_sardine"] = {
		label = "Sardine",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_sardine"] = {
		label = "Sardine",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_sardine"] = {
		label = "Sardine",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_red_snapper"] = {
		label = "Red Snapper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_red_snapper"] = {
		label = "Red Snapper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_red_snapper"] = {
		label = "Red Snapper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_salmon"] = {
		label = "Salmon",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_salmon"] = {
		label = "Salmon",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_salmon"] = {
		label = "Salmon",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_striped_bass"] = {
		label = "Striped Bass",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_striped_bass"] = {
		label = "Striped Bass",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_striped_bass"] = {
		label = "Striped Bass",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_tuna"] = {
		label = "Tuna",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_tuna"] = {
		label = "Tuna",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_tuna"] = {
		label = "Tuna",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_breamfish"] = {
		label = "Bream Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_breamfish"] = {
		label = "Bream Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_breamfish"] = {
		label = "Bream Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_hake"] = {
		label = "Hake",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_hake"] = {
		label = "Hake",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_hake"] = {
		label = "Hake",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_barracuda"] = {
		label = "Barracuda",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_barracuda"] = {
		label = "Barracuda",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_barracuda"] = {
		label = "Barracuda",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_coralgrouper"] = {
		label = "Coral Grouper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_coralgrouper"] = {
		label = "Coral Grouper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_coralgrouper"] = {
		label = "Coral Grouper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_drumfish"] = {
		label = "Drum Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_drumfish"] = {
		label = "Drum Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_drumfish"] = {
		label = "Drum Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	
	-- Jellyfish
	["small_jellyfish"] = {
		label = "Blue Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_jellyfish"] = {
		label = "Blue Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_jellyfish"] = {
		label = "Blue Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_jellyfish_orange"] = {
		label = "Orange Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_jellyfish_orange"] = {
		label = "Orange Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_jellyfish_orange"] = {
		label = "Orange Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_jellyfish_red"] = {
		label = "Red Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_jellyfish_red"] = {
		label = "Red Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_jellyfish_red"] = {
		label = "Red Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_jellyfish_green"] = {
		label = "Green Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_jellyfish_green"] = {
		label = "Green Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_jellyfish_green"] = {
		label = "Green Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_jellyfish_pink"] = {
		label = "Pink Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_jellyfish_pink"] = {
		label = "Pink Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_jellyfish_pink"] = {
		label = "Pink Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_jellyfish_purple"] = {
		label = "Purple Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_jellyfish_purple"] = {
		label = "Purple Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_jellyfish_purple"] = {
		label = "Purple Jellyfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_jellyfish_rainbow"] = {
		label = "Rainbow Jellyfish",
		weight = 300,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_jellyfish_rainbow"] = {
		label = "Rainbow Jellyfish",
		weight = 300,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_jellyfish_rainbow"] = {
		label = "Rainbow Jellyfish",
		weight = 300,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	
	-- Golden Fish
	["small_golden_fish"] = {
		label = "Golden Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_golden_fish"] = {
		label = "Golden Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_golden_fish"] = {
		label = "Golden Fish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	
	-- Radiated Fish
	["small_atlantic_croaker_rad"] = {
		label = "Radiated Atlantic Croaker",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_atlantic_croaker_rad"] = {
		label = "Radiated Atlantic Croaker",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_atlantic_croaker_rad"] = {
		label = "Radiated Atlantic Croaker",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_barracuda_rad"] = {
		label = "Radiated Barracuda",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_barracuda_rad"] = {
		label = "Radiated Barracuda",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_barracuda_rad"] = {
		label = "Radiated Barracuda",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_breamfish_rad"] = {
		label = "Radiated Breamfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_breamfish_rad"] = {
		label = "Radiated Breamfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_breamfish_rad"] = {
		label = "Radiated Breamfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_bullhead_rad"] = {
		label = "Radiated Bullhead",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_bullhead_rad"] = {
		label = "Radiated Bullhead",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_bullhead_rad"] = {
		label = "Radiated Bullhead",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_carp_rad"] = {
		label = "Radiated Carp",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_carp_rad"] = {
		label = "Radiated Carp",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_carp_rad"] = {
		label = "Radiated Carp",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_catfish_rad"] = {
		label = "Radiated Catfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_catfish_rad"] = {
		label = "Radiated Catfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_catfish_rad"] = {
		label = "Radiated Catfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_coralgrouper_rad"] = {
		label = "Radiated Coral Grouper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_coralgrouper_rad"] = {
		label = "Radiated Coral Grouper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_coralgrouper_rad"] = {
		label = "Radiated Coral Grouper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_drumfish_rad"] = {
		label = "Radiated Drumfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_drumfish_rad"] = {
		label = "Radiated Drumfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_drumfish_rad"] = {
		label = "Radiated Drumfish",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_flounder_rad"] = {
		label = "Radiated Flounder",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_flounder_rad"] = {
		label = "Radiated Flounder",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_flounder_rad"] = {
		label = "Radiated Flounder",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_hake_rad"] = {
		label = "Radiated Hake",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_hake_rad"] = {
		label = "Radiated Hake",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_hake_rad"] = {
		label = "Radiated Hake",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_northern_pike_rad"] = {
		label = "Radiated Northern Pike",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_northern_pike_rad"] = {
		label = "Radiated Northern Pike",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_northern_pike_rad"] = {
		label = "Radiated Northern Pike",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_perch_rad"] = {
		label = "Radiated Perch",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_perch_rad"] = {
		label = "Radiated Perch",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_perch_rad"] = {
		label = "Radiated Perch",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_rainbow_trout_rad"] = {
		label = "Radiated Rainbow Trout",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_rainbow_trout_rad"] = {
		label = "Radiated Rainbow Trout",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_rainbow_trout_rad"] = {
		label = "Radiated Rainbow Trout",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_red_mullet_rad"] = {
		label = "Radiated Red Mullet",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_red_mullet_rad"] = {
		label = "Radiated Red Mullet",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_red_mullet_rad"] = {
		label = "Radiated Red Mullet",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_red_snapper_rad"] = {
		label = "Radiated Red Snapper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_red_snapper_rad"] = {
		label = "Radiated Red Snapper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_red_snapper_rad"] = {
		label = "Radiated Red Snapper",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_salmon_rad"] = {
		label = "Radiated Salmon",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_salmon_rad"] = {
		label = "Radiated Salmon",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_salmon_rad"] = {
		label = "Radiated Salmon",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_sardine_rad"] = {
		label = "Radiated Sardine",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_sardine_rad"] = {
		label = "Radiated Sardine",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_sardine_rad"] = {
		label = "Radiated Sardine",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_striped_bass_rad"] = {
		label = "Radiated Striped Bass",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_striped_bass_rad"] = {
		label = "Radiated Striped Bass",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_striped_bass_rad"] = {
		label = "Radiated Striped Bass",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["small_tuna_rad"] = {
		label = "Radiated Tuna",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["medium_tuna_rad"] = {
		label = "Radiated Tuna",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	["large_tuna_rad"] = {
		label = "Radiated Tuna",
		weight = 225,
		buttons = {
			{
				label = "Cut Fish",
				action = function(slot)
					TriggerServerEvent("prp-fishing:server:cutFish", slot)
				end,
			}
		}
	},
	
	-- Fishing misc
	["fishing_boot"] = {
		label = "Fishing Boot",
		weight = 1000
	},
	
	["fish_meat"] = {
		label = "Fish Meat",
		weight = 100
	},
	
	-- Fishing Trophies
	["pr_trophy_fish_january"] = {
		label = "Fishing Trophy (January)",
		weight = 2000,
	},
	["pr_trophy_fish_february"] = {
		label = "Fishing Trophy (February)",
		weight = 2000,
	},
	["pr_trophy_fish_march"] = {
		label = "Fishing Trophy (March)",
		weight = 2000,
	},
	["pr_trophy_fish_april"] = {
		label = "Fishing Trophy (April)",
		weight = 2000,
	},
	["pr_trophy_fish_may"] = {
		label = "Fishing Trophy (May)",
		weight = 2000,
	},
	["pr_trophy_fish_june"] = {
		label = "Fishing Trophy (June)",
		weight = 2000,
	},
	["pr_trophy_fish_july"] = {
		label = "Fishing Trophy (July)",
		weight = 2000,
	},
	["pr_trophy_fish_august"] = {
		label = "Fishing Trophy (August)",
		weight = 2000,
	},
	["pr_trophy_fish_september"] = {
		label = "Fishing Trophy (September)",
		weight = 2000,
	},
	["pr_trophy_fish_october"] = {
		label = "Fishing Trophy (October)",
		weight = 2000,
	},
	["pr_trophy_fish_november"] = {
		label = "Fishing Trophy (November)",
		weight = 2000,
	},
	["pr_trophy_fish_december"] = {
		label = "Fishing Trophy (December)",
		weight = 2000,
	},

	-- Farming
	-- Pots
	["farm_pot_small"] = {
		label = "Small Pot",
		weight = 500
	},
	["farm_pot_medium"] = {
		label = "Medium Pot",
		weight = 750
	},
	["farm_pot_large"] = {
		label = "Large Pot",
		weight = 1000
	},

	-- Tools
	["farm_water_can"] = {
		label = "Watering Can",
		weight = 300
	},
	["farm_fertilizer"] = {
		label = "Fertilizer",
		weight = 200,
	},

	-- Seeds
	["seeds_lettuce"] = {
		label = "Lettuce Seeds",
		weight = 50
	},
	["seeds_tomato"] = {
		label = "Tomato Seeds",
		weight = 50
	},
	["seeds_strawberry"] = {
		label = "Strawberry Seeds",
		weight = 50
	},
	["seeds_grape"] = {
		label = "Grape Seeds",
		weight = 50
	},
	["seeds_cucumber"] = {
		label = "Cucumber Seeds",
		weight = 50
	},
	["seeds_eggplant"] = {
		label = "Eggplant Seeds",
		weight = 50
	},
	["seeds_onion"] = {
		label = "Onion Seeds",
		weight = 50
	},
	["seeds_potato"] = {
		label = "Potato Seeds",
		weight = 50
	},
	["seeds_watermelon"] = {
		label = "Watermelon Seeds",
		weight = 50
	},
	["seeds_banana"] = {
		label = "Banana Seeds",
		weight = 50
	},
	["seeds_apple"] = {
		label = "Apple Seeds",
		weight = 50
	},
	["seeds_wheat"] = {
		label = "Wheat Seeds",
		weight = 50
	},
	["seeds_soy"] = {
		label = "Soy Seeds",
		weight = 50
	},

	-- Crops
	["farm_lettuce"] = {
		label = "Organic Lettuce",
		weight = 200,
	},
	["farm_tomato"] = {
		label = "Organic Tomato",
		weight = 200,
	},
	["farm_strawberry"] = {
		label = "Organic Strawberry",
		weight = 200,
	},
	["farm_grape"] = {
		label = "Organic Grape",
		weight = 200,
	},
	["farm_cucumber"] = {
		label = "Organic Cucumber",
		weight = 200,
	},
	["farm_eggplant"] = {
		label = "Organic Eggplant",
		weight = 200,
	},
	["farm_onion"] = {
		label = "Organic Onion",
		weight = 200,
	},
	["farm_potato"] = {
		label = "Organic Potato",
		weight = 200,
	},
	["farm_watermelon"] = {
		label = "Organic Watermelon",
		weight = 200,
	},
	["farm_banana"] = {
		label = "Organic Banana",
		weight = 200,
	},
	["farm_apple"] = {
		label = "Organic Apple",
		weight = 200,
	},
	["farm_wheat"] = {
		label = "Organic Wheat",
		weight = 200,
	},
	["farm_soy"] = {
		label = "Organic Soy Bean",
		weight = 200,
	},

	-- Aerial Run
	["ar_pendrive_a"] = {
		label = "Encrypted Pendrive",
		weight = 50,
		stack = false,
	},
	["ar_pendrive_b"] = {
		label = "Decrypted Pendrive",
		weight = 50,
		stack = false,
	},
	["ar_start_item"] = {
		label = "Supply Drop Pass",
		weight = 50,
		stack = false,
	},

	-- ATM Robbery
	["atm_hack_device"] = {
		label = "Hacking Device",
		weight = 100,
		stack = false,
		metadata = {
			durability = 100,
		},
	},
	["atm_bomb"] = {
		label = "Small Explosive",
		weight = 200,
		stack = false,
	},
	["metal_rope"] = {
		label = "Metal Rope",
		weight = 500,
		stack = false,
	},

	-- Boosting
	["pdm_blowtorch"] = {
		label = "Blowtorch",
		weight = 300,
		stack = false,
	},
	["bolt_cutter"] = {
		label = "Bolt Cutter",
		weight = 500,
		stack = false,
	},
	["diving_angle_grinder"] = {
		label = "Angle Grinder",
		weight = 800,
		stack = false,
	},
	["empty_fake_id"] = {
		label = "Empty Fake ID",
		weight = 50,
		stack = false,
	},
	["fake_id"] = {
		label = "Fake ID",
		weight = 50,
		stack = false,
	},
	["boosting_bank_key"] = {
		label = "Bank Key",
		weight = 50,
		stack = false,
	},
	["boosting_jewelery_key"] = {
		label = "Jewelry Key",
		weight = 50,
		stack = false,
	},
	["boosting_pdm_key"] = {
		label = "PDM Key",
		weight = 50,
		stack = false,
	},
	["boosting_obd_d"] = {
		label = "Very Basic OBD Tools",
		weight = 100,
		stack = false,
	},
	["boosting_obd_c"] = {
		label = "Basic OBD Tools",
		weight = 100,
		stack = false,
	},
	["boosting_obd_b"] = {
		label = "Semi Advanced OBD Tools",
		weight = 100,
		stack = false,
	},
	["boosting_obd_a"] = {
		label = "Advanced OBD Tools",
		weight = 100,
		stack = false,
	},
	["boosting_obd_s"] = {
		label = "Premium OBD Tools",
		weight = 100,
		stack = false,
	},
	["boosting_obd_x"] = {
		label = "OBD Tools",
		weight = 100,
		stack = false,
	},
	["boosting_vinscratch_d"] = {
		label = "Vin Scratch Contract (D)",
		weight = 10,
		stack = true,
	},
	["boosting_vinscratch_c"] = {
		label = "Vin Scratch Contract (C)",
		weight = 10,
		stack = true,
	},
	["boosting_vinscratch_b"] = {
		label = "Vin Scratch Contract (B)",
		weight = 10,
		stack = true,
	},
	["boosting_vinscratch_a"] = {
		label = "Vin Scratch Contract (A)",
		weight = 10,
		stack = true,
	},
	["boosting_vinscratch_s"] = {
		label = "Vin Scratch Contract (S)",
		weight = 10,
		stack = true,
	},
	["boosting_contract_d"] = {
		label = "Boosting Contract (D)",
		weight = 10,
		stack = true,
	},
	["boosting_contract_c"] = {
		label = "Boosting Contract (C)",
		weight = 10,
		stack = true,
	},
	["boosting_contract_b"] = {
		label = "Boosting Contract (B)",
		weight = 10,
		stack = true,
	},
	["boosting_contract_a"] = {
		label = "Boosting Contract (A)",
		weight = 10,
		stack = true,
	},
	["boosting_contract_s"] = {
		label = "Boosting Contract (S)",
		weight = 10,
		stack = true,
	},
	["boosting_scrap"] = {
		label = "Scrap",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_bonnet"] = {
		label = "Bonnet",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_boot"] = {
		label = "Boot",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_door_dside_f"] = {
		label = "Door",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_door_dside_r"] = {
		label = "Door",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_door_pside_f"] = {
		label = "Door",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_door_pside_r"] = {
		label = "Door",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_wheel_lf"] = {
		label = "Wheel",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_wheel_lr"] = {
		label = "Wheel",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_wheel_rf"] = {
		label = "Wheel",
		weight = 100,
		stack = false,
	},
	["boosting_scrap_wheel_rr"] = {
		label = "Wheel",
		weight = 100,
		stack = false,
	},
	["boosting_hack_a"] = {
		label = "Green Pendrive",
		weight = 10,
		stack = true,
	},
	["boosting_hack_b"] = {
		label = "Blue Pendrive",
		weight = 10,
		stack = true,
	},
	["boosting_hack_c"] = {
		label = "Aqua Pendrive",
		weight = 10,
		stack = true,
	},
	["boosting_hack_d"] = {
		label = "White Pendrive",
		weight = 10,
		stack = true,
	},
	["boosting_hack_s"] = {
		label = "Purple Pendrive",
		weight = 10,
		stack = true,
	},
	["boosting_hack_x"] = {
		label = "Red Pendrive",
		weight = 10,
		stack = true,
	},
	["boosting_tablet"] = {
		label = "Boosting Tablet",
		weight = 100,
		stack = false,
	},

	-- Drug Drops
	["drug_drops_box"] = {
		label = "Suspicious Package",
		weight = 5000,
		stack = false,
		buttons = {
			{
				label = "Unbox",
				action = function(slot)
					TriggerServerEvent("prp-drug-drops:server:openDrugBox", slot)
				end,
			}
		}
	},

	-- Drugs
	["drugs_pot_small"] = {
		label = "Small Drug Pot",
		stack = false,
		weight = 1000
	},
	["drugs_pot_medium"] = {
		label = "Medium Drug Pot",
		stack = false,
		weight = 2000
	},
	["drugs_pot_large"] = {
		label = "Large Drug Pot",
		stack = false,
		weight = 3000
	},

	-- Drug Farming Seeds
	["seeds_weed_1a"] = {
		label = "Regular Grape Ape Seed",
		weight = 100
	},
	["seeds_weed_1b"] = {
		label = "Cherry Kush Seed",
		weight = 100
	},
	["seeds_weed_2a"] = {
		label = "Martian Candy Seed",
		weight = 100
	},
	["seeds_weed_2b"] = {
		label = "Exodus Seed",
		weight = 100
	},
	["seeds_weed_2c"] = {
		label = "Headband Seed",
		weight = 100
	},
	["seeds_cocaine"] = {
		label = "Cocaine Seeds",
		weight = 100
	},

	-- Drug Farming Crops
	["weed_1a"] = {
		label = "Crop of Regular Grape Ape",
		weight = 100
	},
	["weed_1b"] = {
		label = "Crop of Cherry Kush",
		weight = 100
	},
	["weed_2a"] = {
		label = "Crop of Martian Candy",
		weight = 100
	},
	["weed_2b"] = {
		label = "Crop of Exodus",
		weight = 100
	},
	["weed_2c"] = {
		label = "Crop of Headband",
		weight = 100
	},

	-- Weed
	["rolling_paper"] = {
		label = "Rolling Paper",
		weight = 0,
	},
	["joint_1a"] = {
		label = "(Joint) Regular Grape Ape",
		weight = 200
	},
	["joint_1b"] = {
		label = "(Joint) Cherry Kush",
		weight = 200
	},
	["joint_2a"] = {
		label = "(Joint) Martian Candy",
		weight = 200
	},
	["joint_2b"] = {
		label = "(Joint) Exodus",
		weight = 200
	},
	["joint_2c"] = {
		label = "(Joint) Headband",
		weight = 200
	},

	-- Cocaine
	["plastic"] = {
		label = "Plastic",
		weight = 0
	},
	["cocaine_container"] = {
		label = "Mixing Container",
		weight = 500,
		stack = false,
		close = true,
		buttons = {
			{
				label = "Shake",
				action = function(slot)
					TriggerServerEvent("prp-drugs:server:cocaine:shakeContainer", slot)
				end
			}
		}
	},
	["cocaine_solvent"] = {
		label = "Solvent",
		weight = 1000,
	},
	["cocaine_leaf"] = {
		label = "Coca Leaf",
		weight = 100
	},
	["cocaine_drying_rack"] = {
		label = "Drying Rack",
		weight = 15000,
		model = `pr_cokedry_01`,
		stack = false
	},
	["cocaine_paste"] = {
		label = "Coca Paste",
		weight = 100,
		model = `prp_cocaine_paste`
	},
	["cocaine_smelter"] = {
		label = "Smelting Furnace",
		weight = 25000,
		model = `cocaine_smelting_01a`,
		stack = false
	},
	["limestone_dust"] = {
		label = "Limestone Dust",
		weight = 100
	},
	["cocaine_powder"] = {
		label = "Coca Powder",
		weight = 100,
		model = `prp_cocaine_powder`
	},
	["cocaine_brick"] = {
		label = "Cocaine Brick",
		weight = 1000,
		model = `hei_prop_heist_weed_block_01`,
		stack = false
	},
	["cocaine"] = {
		label = "Cocaine",
		weight = 100,
		stack = false,
	},
	["wood_log"] = {
		label = "Wood Log",
		weight = 2300,
		stack = false
	},
	["wood_plank"] = {
		label = "Wood Plank",
		weight = 1600,
		stack = false
	},

	-- Meth
	["meth_kit"] = {
		label = "Lab Kit",
		weight = 20000,
		stack = false,
		model = `prp_meth_kit`,
	},
	["meth_cooker_low"] = {
		label = "Small Meth Cooker",
		weight = 20000,
		stack = false,
		model = `pr_methcooker_01`,
	},
	["meth_cooker_mid"] = {
		label = "Medium Meth Cooker",
		weight = 20000,
		stack = false,
		model = `pr_methcooker_01`,
	},
	["meth_cooker_high"] = {
		label = "Large Meth Cooker",
		weight = 20000,
		stack = false,
		model = `pr_methcooker_01`,
	},
	["meth_cooler_low"] = {
		label = "Small Meth Cooler",
		weight = 5000,
		stack = false
	},
	["meth_cooler_mid"] = {
		label = "Medium Meth Cooler",
		weight = 5000,
		stack = false
	},
	["meth_cooler_high"] = {
		label = "Large Meth Cooler",
		weight = 5000,
		stack = false
	},
	["meth_explosive"] = {
		label = "Explosive",
		weight = 2000,
		stack = false,
	},
	["meth"] = {
		label = "Meth",
		weight = 100,
		model = `prp_meth`,
	},
	["meth_slop"] = {
		label = "Wet Slop",
		weight = 0.05,
		model = `prp_meth_slop`
	},
	["meth_hose"] = {
		label = "Rubber Hose",
		weight = 1000,
		model = `prop_hose`,
	},
	["meth_pseudo"] = {
		label = "Pseudoephedrine Extract",
		weight = 5,
		model = `prp_meth_pseudo`
	},
	["meth_redpowder"] = {
		label = "Red Phosphorus Powder",
		weight = 5,
		model = `prp_meth_redpowder`
	},
	["meth_lithium"] = {
		label = "Lithium Strips",
		weight = 5,
		model = `prp_meth_lithium`
	},
	["meth_ammonia_barrel"] = {
		label = "Barrel of Ammonia",
		weight = 50000,
		model = `prop_barrel_01a`,
	},
	["meth_lab_card"] = {
		label = "Laboratory Card",
		weight = 1,
		degrade = 2880, -- 2 days in minutes
		stack = false,
		description = "You can notice a logo saying \"THORNS\" on the card"
	},

	-- Gun Smuggling
	["gun_smuggling_contract_smg"] = { label = "SMG Contract", weight = 10, stack = false },
	["gun_smuggling_contract_smg_large"] = { label = "Large SMG Contract", weight = 10, stack = false },
	["gun_smuggling_contract_rifle"] = { label = "Rifle Contract", weight = 10, stack = false },
	["gun_smuggling_contract_chaos"] = { label = "Rifle+ Contract", weight = 10, stack = false },

	-- Mission item
	["gun_smuggling_crate"] = { label = "Gun Crate", weight = 5000, stack = false },

	-- Gun parts (transported goods)
	["gun_parts"] = { label = "Gun Parts", weight = 200, stack = true },
	["military_gun_parts"] = { label = "Military Gun Parts", weight = 200, stack = true },

	-- SMG components & blueprints
	["smg_slide"] = { label = "SMG Slide", weight = 100, stack = true },
	["smg_lower"] = { label = "SMG Lower", weight = 100, stack = true },
	["smg_upper"] = { label = "SMG Upper", weight = 100, stack = true },
	["smg_barrel"] = { label = "SMG Barrel", weight = 100, stack = true },
	["smg_grip"] = { label = "SMG Grip", weight = 100, stack = true },
	["smg_trigger"] = { label = "SMG Trigger", weight = 100, stack = true },
	["ammo_smg"] = { label = "SMG Ammo", weight = 50, stack = true },
	["blueprint_smg_parts"] = { label = "Blueprint: SMG Parts", weight = 10, stack = true },
	["blueprint_smg_minismg"] = { label = "Blueprint: Mini SMG", weight = 10, stack = false },
	["blueprint_smg_microsmg"] = { label = "Blueprint: Micro SMG", weight = 10, stack = false },
	["blueprint_smg_uzi"] = { label = "Blueprint: Uzi", weight = 10, stack = false },
	["blueprint_smg_smgpistol"] = { label = "Blueprint: SMG Pistol", weight = 10, stack = false },
	["blueprint_smg_machinepistol"] = { label = "Blueprint: Machine Pistol", weight = 10, stack = false },
	["blueprint_for_smg_basic_parts"] = { label = "Blueprint: SMG Basic Parts", weight = 10, stack = true },
	["blueprint_for_smg_semi_advanced_parts"] = { label = "Blueprint: SMG Semi-Advanced Parts", weight = 10, stack = true },
	["blueprint_for_smg_advanced_parts"] = { label = "Blueprint: SMG Advanced Parts", weight = 10, stack = true },

	-- Medium SMG components & blueprints
	["smg_medium_slide"] = { label = "Medium SMG Slide", weight = 100, stack = true },
	["smg_medium_lower"] = { label = "Medium SMG Lower", weight = 100, stack = true },
	["smg_medium_upper"] = { label = "Medium SMG Upper", weight = 100, stack = true },
	["smg_medium_barrel"] = { label = "Medium SMG Barrel", weight = 100, stack = true },
	["smg_medium_grip"] = { label = "Medium SMG Grip", weight = 100, stack = true },
	["smg_medium_trigger"] = { label = "Medium SMG Trigger", weight = 100, stack = true },
	["blueprint_smg_medium_parts"] = { label = "Blueprint: Medium SMG Parts", weight = 10, stack = true },
	["blueprint_smg_assaultsmg"] = { label = "Blueprint: Assault SMG", weight = 10, stack = false },
	["blueprint_smg_gusenberg"] = { label = "Blueprint: Gusenberg", weight = 10, stack = false },
	["blueprint_smg_smg_mk2"] = { label = "Blueprint: SMG Mk II", weight = 10, stack = false },

	-- Rifle components & blueprints
	["rifle_slide"] = { label = "Rifle Slide", weight = 100, stack = true },
	["rifle_lower"] = { label = "Rifle Lower", weight = 100, stack = true },
	["rifle_upper"] = { label = "Rifle Upper", weight = 100, stack = true },
	["rifle_barrel"] = { label = "Rifle Barrel", weight = 100, stack = true },
	["rifle_grip"] = { label = "Rifle Grip", weight = 100, stack = true },
	["rifle_trigger"] = { label = "Rifle Trigger", weight = 100, stack = true },
	["ammo_rifle"] = { label = "Rifle Ammo", weight = 50, stack = true },
	["blueprint_rifle_parts"] = { label = "Blueprint: Rifle Parts", weight = 10, stack = true },
	["blueprint_rifle_compactrifle"] = { label = "Blueprint: Compact Rifle", weight = 10, stack = false },
	["blueprint_rifle_assaultrifle"] = { label = "Blueprint: Assault Rifle", weight = 10, stack = false },
	["blueprint_rifle_bullpuprifle"] = { label = "Blueprint: Bullpup Rifle", weight = 10, stack = false },
	["blueprint_rifle_tacticalrifle"] = { label = "Blueprint: Tactical Rifle", weight = 10, stack = false },
	["blueprint_for_rifle_basic_parts"] = { label = "Blueprint: Rifle Basic Parts", weight = 10, stack = true },
	["blueprint_for_rifle_semi_advanced_parts"] = { label = "Blueprint: Rifle Semi-Advanced Parts", weight = 10, stack = true },
	["blueprint_for_rifle_advanced_parts"] = { label = "Blueprint: Rifle Advanced Parts", weight = 10, stack = true },

	-- Horde
	['horde_revive'] = {
		label = 'Horde Health Token',
		weight = 100
	},
	['horde_crate_key'] = {
		label = 'Horde Crate Key',
		weight = 100
	},
	['horde_small'] = {
		label = "Horde Small Item",
		weight = 5
	},
	['horde_medium'] = {
		label = "Horde Medium Item",
		weight = 8
	},
	['horde_big'] = {
		label = "Horde Big Item",
		weight = 10
	},

	-- Outpost
	['outposts_exchange_card'] = {
		label = 'Exchange Access Card',
		weight = 10,
		stack = false,
		close = true,
	},
	['outposts_clue_taxi'] = {
		label = 'Taxi Receipt',
		weight = 10,
	},
	['outposts_clue_delivery'] = {
		label = 'Delivery Note',
		weight = 10,
	},
	['outposts_clue_washing'] = {
		label = 'Laundry Slip',
		weight = 10,
	},

	-- Petty Crimes
	-- Mail items
	['envelope'] = {
		label = 'Envelope',
		weight = 10,
	},
	['catalog_envelope'] = {
		label = 'Catalog Envelope',
		weight = 20,
	},
	['letter'] = {
		label = 'Letter',
		weight = 5,
	},

	-- Porch Pirate packages
	['pp_small_1'] = {
		label = 'Small Package',
		weight = 500,
		stack = false,
	},
	['pp_small_2'] = {
		label = 'Small Package',
		weight = 500,
		stack = false,
	},
	['pp_small_3'] = {
		label = 'Small Package',
		weight = 500,
		stack = false,
	},
	['pp_medium_1'] = {
		label = 'Medium Package',
		weight = 1000,
		stack = false,
	},
	['pp_large_1'] = {
		label = 'Large Package',
		weight = 2000,
		stack = false,
	},

	-- Point control
	['point_control_contract'] = {
		label = 'Point Control Contract',
		weight = 10,
		stack = false,
	},
	['point_control_crate'] = {
		label = 'Capture Crate',
		weight = 500,
		stack = false,
	},
	['point_control_plans'] = {
		label = 'Point Control Plans',
		weight = 10,
		stack = false,
	},
	['point_control_map'] = {
		label = 'Map with Drop Points',
		weight = 10,
		stack = false,
	},

	-- Sea Battle
	['seabattle_start'] = {
		label = 'Sea Battle Pass',
		weight = 10,
		stack = false,
	},
	['sb_boat_rope'] = {
		label = 'Rope',
		weight = 100,
		stack = false,
	},

	-- Sea hunt
	["sea_hunt_start"] = {
		label = "Blue Folder",
		weight = 100,
	},
	["diving_rebreather"] = {
		label = "Diving Rebreather",
		weight = 300,
	},

	-- Warehouse Robbery
	['warehouse_entry'] = {
		label = 'Warehouse Entry',
		weight = 10,
		stack = false,
	},
	['warehouse_fuse'] = {
		label = 'Warehouse Fuse',
		weight = 50,
	},
	['warehouse_bomb'] = {
		label = 'Warehouse Bomb',
		weight = 100,
		stack = false,
	},

	-- Ocean Run
	['ocean_run_entry'] = {
		label = 'Ocean Run Entry',
		weight = 10,
		stack = false,
	},
	['smuggling_nas'] = {
		label = 'NAS Device',
		weight = 2000,
		stack = false,
	},
	['smuggling_hdd'] = {
		label = 'Hard Drive',
		weight = 200,
	},

	-- Wasabi gang wars
	['wartablet'] = {
		label = 'War Tablet',
		weight = 200,
		stack = false,
		close = true,
	},

	-- Console Jobs

	['vortex_x_shell'] = {
		label = 'Vortex X Shell',
		weight = 1,
		stack = true
	},

	['prodigy_5_shell'] = {
		label = 'Prodigy 5 Shell',
		weight = 1,
		stack = true
	},
	
	['novadeck_shell'] = {
		label = 'NovaDeck Shell',
		weight = 1,
		stack = true
	},
	
	['phantom_shell'] = {
		label = 'Phantom Shell',
		weight = 1,
		stack = true
	},
	
	['lcd_screen'] = {
		label = 'LCD Screen',
		weight = 1,
		stack = true
	},
	
	['console_motherboard'] = {
		label = 'Console Motherboard',
		weight = 1,
		stack = true
	},
	
	['power_unit'] = {
		label = 'Power Unit',
		weight = 1,
		stack = true
	},
	
	['cooling_kit'] = {
		label = 'Cooling Kit',
		weight = 1,
		stack = true
	},
	
	['storage_module'] = {
		label = 'Storage Module',
		weight = 1,
		stack = true
	},
	
	['disc_drive'] = {
		label = 'Disc Drive',
		weight = 1,
		stack = true
	},
	
	['network_module'] = {
		label = 'Network Module',
		weight = 1,
		stack = true
	},
	
	['vortex_x_controller_parts'] = {
		label = 'Vortex X Controller Parts',
		weight = 1,
		stack = true
	},
	
	['prodigy_5_controller_parts'] = {
		label = 'Prodigy 5 Controller Parts',
		weight = 1,
		stack = true
	},
	
	['vortex_x_battery'] = {
		label = 'Vortex X Battery',
		weight = 1,
		stack = true
	},
	
	['prodigy_5_battery'] = {
		label = 'Prodigy 5 Battery',
		weight = 1,
		stack = true
	},
	
	['vortex_x'] = {
		label = 'Vortex X Console',
		weight = 1,
		stack = false
	},
	
	['prodigy_5'] = {
		label = 'Prodigy 5 Console',
		weight = 1,
		stack = false
	},
	
	['novadeck'] = {
		label = 'NovaDeck Console',
		weight = 1,
		stack = false
	},
	
	['phantom'] = {
		label = 'Phantom Console',
		weight = 1,
		stack = false
	},
	
	['vortex_x_controller'] = {
		label = 'Vortex X Controller',
		weight = 1,
		stack = false
	},
	
	['prodigy_5_controller'] = {
		label = 'Prodigy 5 Controller',
		weight = 1,
		stack = false
	},
	
	['vortex_x_jailbreak'] = {
		label = 'Vortex X Jailbreak Kit',
		weight = 1,
		stack = true
	},
	
	['phantom_jailbreak'] = {
		label = 'Phantom Jailbreak Kit',
		weight = 1,
		stack = true
	},
	
	['prodigy_5_jailbreak'] = {
		label = 'Prodigy 5 Jailbreak Kit',
		weight = 1,
		stack = true
	},
	
	['novadeck_jailbreak'] = {
		label = 'NovaDeck Jailbreak Kit',
		weight = 1,
		stack = true
	},
	
	['workz_usb'] = {
		label = 'TechworkZ USB',
		weight = 1,
		stack = true
	},
	
	['techworkz_station'] = {
		label = 'TechWorkz Table',
		weight = 1,
		stack = true
	},	

	['carfax_report'] = {
		label = 'CarFax Report',
		weight = 0,
		consume = 0,
		stack = false
	},

	["kq_carjack"] = {
		label = "Jack Stand (Drifting)",
		description = 'Used to install drift tires',
		weight = 1000,
		stack = true,
		close = true,
	},

	["kq_drifttire"] = {
		label = "Drift Tire",
		weight = 250,
		stack = true,
		close = true,
	},

	["kq_regulartire"] = {
		label = "Stock Tire",
		weight = 250,
		stack = true,
		close = true,
	},

	["ls_jackstand"] = {
		label = "Jack Stand (Spacers)",
		description = 'Used to install spacers',
		weight = 1000,
		stack = true,
		close = true,
	},

	["ls_spacer_black"] = {
		label = "Spacer (15mm)",
		weight = 500,
		stack = true,
		close = true,
	},

	["ls_spacer_gold"] = {
		label = "Spacer (30mm)",
		weight = 500,
		stack = true,
		close = true,
	},

	["ls_spacer_hardened"] = {
		label = "Spacer (20mm)",
		weight = 500,
		stack = true,
		close = true,
	},

	["ls_spacer_red"] = {
		label = "Spacer (10mm)",
		weight = 500,
		stack = true,
		close = true,
	},

	["ls_spacer_silver"] = {
		label = "Spacer (25mm)",
		weight = 500,
		stack = true,
		close = true,
	},

	["pd_licence_plate_flipper"] = {
		label = "Plate Flipper Install Kit",
		weight = 2500,
		stack = true,
		close = true,
	},

	["pd_screwdriver"] = {
		label = "Plate Flipper Screwdriver",
		weight = 500,
		stack = true,
		close = true,
	},

	['gps'] = {
		label = 'GPS',
		weight = 1000,
		stack = false,
		description = 'Track you and your crew on the map',
		client = {
			export = 'lorp_gps.useGPS'
		}
	},

	-- Drugs

	-- WEED
	-- WEED
	-- WEED

	['weed_seed'] = {
		label = 'Weed Seed',
		weight = 40,
		stack = true,
	},

	['gingeritis_weed'] = {
		label = 'Wet Gingeritis Weed',
		weight = 110,
		stack = true,
	},

	['energizing_dried_weed'] = {
		label = 'Energizing Dried Weed',
		weight = 30,
		stack = true,
	},

	['weed'] = {
		label = 'Wet Weed',
		weight = 100,
		stack = true,
	},

	['high_quality_weed'] = {
		label = 'Wet High Quality Weed',
		weight = 100,
		stack = true,
	},

	['dried_weed'] = {
		label = 'Dried Weed',
		weight = 20,
		stack = true,
	},

	['dried_high_quality_weed'] = {
		label = 'Dried High Quality Weed',
		weight = 20,
		stack = true,
	},

	['packaged_gingeritis_weed'] = {
		label = 'Packaged Wet Gingeritis Weed',
		weight = 110,
		stack = true,
	},

	['packaged_energizing_dried_weed'] = {
		label = 'Packaged Dried Energizing Weed',
		weight = 40,
		stack = true,
	},

	['packaged_weed'] = {
		label = 'Packaged Wet Weed',
		weight = 110,
		stack = true,
	},

	['packaged_high_quality_weed'] = {
		label = 'Packaged Wet High Quality Weed',
		weight = 110,
		stack = true,
	},

	['packaged_dried_weed'] = {
		label = 'Packaged Dried Weed',
		weight = 30,
		stack = true,
	},

	['packaged_dried_high_quality_weed'] = {
		label = 'Packaged Dried High Quality Weed',
		weight = 20,
		stack = true,
	},


	-- COKE
	-- COKE
	-- COKE

	['coke_seed'] = {
		label = 'Coke Seed',
		weight = 40,
		stack = true,
	},

	['coke_leaf'] = {
		label = 'Wet Coke Leaf',
		weight = 50,
		stack = true,
	},

	['high_quality_coke_leaf'] = {
		label = 'Wet High Quality Coke Leaf',
		weight = 50,
		stack = true,
	},

	['dried_coke_leaf'] = {
		label = 'Dried Coke Leaf',
		weight = 10,
		stack = true,
	},

	['dried_high_quality_coke_leaf'] = {
		label = 'Dried High Quality Coke Leaf',
		weight = 10,
		stack = true,
	},

	['coke'] = {
		label = 'Wet Coke Base',
		weight = 100,
		stack = true,
	},

	['high_quality_coke'] = {
		label = 'Wet High Quality Coke Base',
		weight = 100,
		stack = true,
	},

	['dried_coke'] = {
		label = 'Dried Coke Base',
		weight = 20,
		stack = true,
	},

	['dried_high_quality_coke'] = {
		label = 'Dried High Quality Coke Base',
		weight = 20,
		stack = true,
	},

	['cooked_coke'] = {
		label = 'Wet Coke',
		weight = 100,
		stack = true,
	},

	['cooked_high_quality_coke'] = {
		label = 'Wet High Quality Coke',
		weight = 100,
		stack = true,
	},

	['cooked_dried_coke'] = {
		label = 'Dried Coke',
		weight = 20,
		stack = true,
	},

	['cooked_dried_high_quality_coke'] = {
		label = 'Dried High Quality Coke',
		weight = 20,
		stack = true,
	},

	['packaged_coke'] = {
		label = 'Packaged Wet Coke Base',
		weight = 100,
		stack = true,
	},

	['packaged_high_quality_coke'] = {
		label = 'Packaged Wet High Quality Coke Base',
		weight = 100,
		stack = true,
	},

	['packaged_dried_coke'] = {
		label = 'Packaged Dried Coke Base',
		weight = 20,
		stack = true,
	},

	['packaged_dried_high_quality_coke'] = {
		label = 'Packaged Dried High Quality Coke Base',
		weight = 20,
		stack = true,
	},

	['packaged_cooked_coke'] = {
		label = 'Packaged Wet Coke',
		weight = 100,
		stack = true,
	},

	['packaged_cooked_high_quality_coke'] = {
		label = 'Packaged Wet High Quality Coke',
		weight = 100,
		stack = true,
	},

	['packaged_cooked_dried_coke'] = {
		label = 'Packaged Dried Coke',
		weight = 20,
		stack = true,
	},

	['packaged_cooked_dried_high_quality_coke'] = {
		label = 'Packaged Dried High Quality Coke',
		weight = 20,
		stack = true,
	},

	-- METH 
	-- METH 
	-- METH 

	['liquid_meth'] = {
		label = 'Liquid Meth',
		weight = 200,
		stack = true,
	},

	['default_meth'] = {
		label = 'Meth Bud',
		weight = 10,
		stack = true,
	},

	['packaged_default_meth'] = {
		label = 'Packaged Meth',
		weight = 60,
		stack = true,
	},

	-- BRICKS
	-- BRICKS
	-- BRICKS

	['weed_brick'] = {
		label = 'Weed Brick',
		weight = 400,
		stack = true,
	},

	['high_quality_weed_brick'] = {
		label = 'High Quality Weed Brick',
		weight = 400,
		stack = true,
	},

	['coke_brick'] = {
		label = 'Coke Base Brick',
		weight = 500,
		stack = true,
	},

	['high_quality_coke_brick'] = {
		label = 'High Quality Coke Base Brick',
		weight = 500,
		stack = true,
	},

	['cooked_coke_brick'] = {
		label = 'Coke Brick',
		weight = 500,
		stack = true,
	},

	['cooked_high_quality_coke_brick'] = {
		label = 'Coke High Quality Brick',
		weight = 500,
		stack = true,
	},

	-- GEAR
	-- GEAR
	-- GEAR

	['baggy'] = {
		label = 'Baggy',
		weight = 10,
		stack = true,
	},

	['plant_pot'] = {
		label = 'Plant Pot',
		weight = 100,
		stack = true,
	},

	['fertilizer'] = {
		label = 'Fertilizer',
		weight = 1000,
		stack = true,
	},

	['default_lamp'] = {
		label = 'Lamp',
		weight = 500,
		stack = true,
	},

	['default_fan'] = {
		label = 'Fan',
		weight = 500,
		stack = true,
	},

	['default_soil'] = {
		label = 'Soil',
		weight = 500,
		stack = true,
	},

	['drying_rack'] = {
		label = 'Drying Rack',
		weight = 500,
		stack = false,
	},

	['watering_can'] = {
		label = 'Watering Can',
		weight = 500,
		stack = true,
	},

	['default_brick_press'] = {
		label = 'Brick Press',
		weight = 3500,
		stack = false,
	},

	['packaging_station'] = {
		label = 'Packaging Station',
		weight = 5000,
		stack = false,
	},

	['drug_mixer'] = {
		label = 'Drug Mixer',
		weight = 2000,
		stack = false,
	},

	['plant_trimmers'] = {
		label = 'Plant Trimmers',
		weight = 200, 
		stack = true,
	},

	['drug_cauldron'] = {
		label = 'Cauldron',
		weight = 5000, 
		stack = false,
	},

	['drug_oven'] = {
		label = 'Lab Oven',
		weight = 5000, 
		stack = false,
	},

	['chemistry_station'] = {
		label = 'Chemistry Station',
		weight = 5000, 
		stack = false,
	},

	-- EXTRA / CHEMICALS
	-- EXTRA / CHEMICALS
	-- EXTRA / CHEMICALS

	['acetone'] = {
		label = 'Acetone',
		weight = 500,
		stack = true,
	},

	['ecola'] = {
		label = 'E-Cola',
		weight = 200,
		stack = true,
	},


	['pills'] = {
		label = 'Pseudo',
		weight = 100,
		stack = true,
	},

	['phosphorus'] = {
		label = 'Phosphorus',
		weight = 500,
		stack = true,
	},

	['gasoline'] = {
		label = 'Gasoline',
		weight = 2000,
		stack = true,
	},

	['hammer'] = {
		label = 'Hammer',
		weight = 1000,
		stack = true,
	},

	-- Codewave
	
	-- Exotic Rims

	['candy_blue_spray'] = {
		label = 'Candy Blue Spray',
		weight = 5,
		stack  = true
	},
	['candy_purple_spray'] = {
		label = 'Candy Purple Spray',
		weight = 5,
		stack  = true
	},
	['candy_red_spray'] = {
		label = 'Candy Red Spray',
		weight = 25,
		stack  = true
	},
	['candy_green_spray'] = {
		label = 'Candy Green Spray',
		weight = 5,
		stack  = true
	},
	['bare_metal_rim'] = {
		label = 'Bare Metal Rim',
		weight = 5,
		stack  = true
	},
	['candy_purple_rim'] = {
		label = 'Candy Purple Rim',
		weight = 5,
		stack  = true
	},
	['candy_purple_rim_balanced'] = {
		label = 'Candy Purple Rim Balanced',
		weight = 5,
		stack  = true
	},
	['candy_red_rim'] = {
		label = 'Candy Red Rim',
		weight = 5,
		stack  = true
	},
	['candy_red_rim_balancer'] = {
		label = 'Candy Red Rim Balancer',
		weight = 5,
		stack  = true
	},
	['candy_green_rim'] = {
		label = 'Candy Green Rim',
		weight = 5,
		stack  = true
	},
	['candy_green_rim_balanced'] = {
		label = 'Candy Green Rim Balanced',
		weight = 5,
		stack  = true
	},
	['candy_blue_rim'] = {
		label = 'Candy Blue Rim',
		weight = 5,
		stack  = true
	},
	['candy_blue_rim_balanced'] = {
		label = 'Candy Blue Rim Balanced',
		weight = 5,
		stack  = true
	},
	['rims_table'] = {
		label = 'Rims Table',
		weight = 5,
		stack  = true
	},
	['wheel_weights'] = {
		label = 'Wheel Weights',
		weight = 5,
		stack  = true
	},

	-- Lashes

	["empty_lash_box"] = {
		label = "Empty Lash Box",
		weight = 0.5,
		stack = true,
		close = true,
	},
	
	["strips"] = {
		label = "Strips",
		weight = 0.2,
		stack = true,
		close = true,
	},
	
	["eyelash_glue"] = {
		label = "Eyelash Glue",
		weight = 0.1,
		stack = true,
		close = true,
	},
	
	["lashes_phone"] = {
		label = "Lashes Phone",
		weight = 1.2,
		stack = false,
		close = true,
	},
	
	["lashes_table"] = {
		label = "Lashes Table",
		weight = 1,
		stack = true,
		close = true,
	},
	
	["ellipse_lashes"] = {
		label = "Ellipse Lashes",
		weight = 0.3,
		stack = true,
		close = true,
	},
	
	["faux_mink_lashes"] = {
		label = "Faux Mink Lashes",
		weight = 0.25,
		stack = true,
		close = true,
	},
	
	["mink_lashes"] = {
		label = "Mink Lashes",
		weight = 0.2,
		stack = true,
		close = true,
	},
	
	["silk_lashes"] = {
		label = "Silk Lashes",
		weight = 0.15,
		stack = true,
		close = true,
	},
	
	["synthetic_lashes"] = {
		label = "Synthetic Lashes",
		weight = 0.3,
		stack = true,
		close = true,
	},
	
	["volume_lashes"] = {
		label = "Volume Lashes",
		weight = 0.4,
		stack = true,
		close = true,
	},

	-- Nails

	['nailtable'] = {
		label = 'Nail Table',
		weight = 0,
		stack = true
	},
	
	['acrylic-liquid'] = {
		label = 'Acrylic Liquid',
		weight = 0,
		stack = true
	},
	
	['acrylic-powder'] = {
		label = 'Acrylic Powder',
		weight = 0,
		stack = true
	},
	
	['acrylic-nails'] = {
		label = 'Acrylic Nails',
		weight = 0,
		stack = true
	},
	
	['nailphone'] = {
		label = 'Nail Client Phone',
		weight = 0,
		stack = true
	},
	
	['cfn-nails'] = {
		label = 'Set Of Coffin Nails',
		weight = 0,
		stack = true
	},
	
	['sti-nails'] = {
		label = 'Set Of Stiletto Nails',
		weight = 0,
		stack = true
	},
	
	['alm-nails'] = {
		label = 'Set Of Almond Nails',
		weight = 0,
		stack = true
	},
	
	['lip-nails'] = {
		label = 'Set Of Lipstick Nails',
		weight = 0,
		stack = true
	},
	
	['bal-nails'] = {
		label = 'Set Of Ballerina Nails',
		weight = 0,
		stack = true
	},
	
	['squ-nails'] = {
		label = 'Set Of Square Nails',
		weight = 0,
		stack = true
	},
	
	['fla-nails'] = {
		label = 'Set Of Flare Nails',
		weight = 0,
		stack = true
	},

	-- Sneakers

	['leather_materials'] = {
		label = 'Leathers',
		weight = 5,
		stack = true
	},
	['shoe_foam'] = {
		label = 'Foam Material',
		weight = 5,
		stack = true
	},
	
	['clothe_materials'] = {
		label = 'Raw Cloth',
		weight = 25,
		stack = true
	},
	
	['work_station'] = {
		label = 'Shoe Work Station',
		weight = 5,
		stack = true
	},
	
	['shoe_phone'] = {
		label = 'Shoe client phone',
		weight = 5,
		stack = true
	},
	
	['sky_gliders_plus'] = {
		label = 'Sky Gliders Plus',
		weight = 5,
		stack = true
	},
	['breeze_bangs'] = {
		label = 'Breeze Bangs',
		weight = 5,
		stack = true
	},
	['tiger_mediums'] = {
		label = 'Tiger Mediums',
		weight = 5,
		stack = true
	},
	['galaxy_x'] = {
		label = 'Galaxy X',
		weight = 5,
		stack = true
	},
	['sky_walkers'] = {
		label = 'Sky Walkers',
		weight = 5,
		stack = true
	},
	['sky_pilots'] = {
		label = 'Sky Pilots',
		weight = 5,
		stack = true
	},
	['sky_flyers'] = {
		label = 'Sky Flyers',
		weight = 5,
		stack = true
	},
	['sky_gliders'] = {
		label = 'Sky Gliders',
		weight = 5,
		stack = true
	},
	['fastrunner_2000'] = {
		label = 'Fastrunner 2000',
		weight = 5,
		stack = true
	},
	['speedster_300'] = {
		label = 'Speedster 300',
		weight = 5,
		stack = true
	},
	['runner_prime'] = {
		label = 'Runner Prime',
		weight = 5,
		stack = true
	},
	['breeze_95s'] = {
		label = 'Breeze 95s',
		weight = 5,
		stack = true
	},
	['breeze_100s'] = {
		label = 'Breeze 100s',
		weight = 5,
		stack = true
	},
	['breeze_90s'] = {
		label = 'Breeze 90s',
		weight = 5,
		stack = true
	},
	['sky_walkers_red'] = {
		label = 'Sky Walkers Red',
		weight = 5,
		stack = true
	},
	['shadow_yellows'] = {
		label = 'Shadow Yellows',
		weight = 5,
		stack = true
	},

	-- Caps

	['cotton_assortment'] = { 
		label = 'Cotton Assortment', 
		weight = 1,
		stack = true
	},
	
	['sewing_kits_caps'] = { 
		label = 'Sewing Kits for Caps', 
		weight = 1,
		stack = true
	},
	
	['cap_client_phone'] = { 
		label = 'Cap Client Phone', 
		weight = 1,
		stack = true
	},
	
	['capcity_table'] = { 
		label = 'Cap City Table', 
		weight = 1,
		stack = true
	},
	
	['la_black_cap'] = { 
		label = 'LA Black Cap', 
		weight = 1,
		stack = true
	},
	
	['ls_black_cap'] = { 
		label = 'LS Black Cap', 
		weight = 1,
		stack = true
	},
	
	['corkers_black_cap'] = { 
		label = 'Corkers Black Cap', 
		weight = 1,
		stack = true
	},
	
	['swingers_black_cap'] = { 
		label = 'Swingers Black Cap', 
		weight = 1,
		stack = true
	},
	
	['packers_black_cap'] = { 
		label = 'Packers Black Cap', 
		weight = 1,
		stack = true
	},
	
	['bandits_black_cap'] = { 
		label = 'Bandits Black Cap', 
		weight = 1,
		stack = true
	},
	
	['red_cap'] = { 
		label = 'Red Cap', 
		weight = 1,
		stack = true
	},
	
	['black_cap'] = { 
		label = 'Black Cap', 
		weight = 1,
		stack = true
	},
	
	['blue_cap'] = { 
		label = 'Blue Cap', 
		weight = 1,
		stack = true
	},
	
	['orange_cap'] = { 
		label = 'Orange Cap', 
		weight = 1,
		stack = true
	},
	
	['quality_black_cap'] = { 
		label = 'Quality Black Cap', 
		weight = 1,
		stack = true
	},
	
	['quality_purple_hat'] = { 
		label = 'Quality Purple Hat', 
		weight = 1,
		stack = true
	},
	
	['quality_blue_cap'] = { 
		label = 'Quality Blue Cap', 
		weight = 1,
		stack = true
	},
	
	['quality_green_cap'] = { 
		label = 'Quality Green Cap', 
		weight = 1,
		stack = true
	},

	-- 

	['boombox'] = {
		label = 'Boombox',
		weight = 5000,
	},

	['cups'] = {
		label = 'Beer Pong',
		weight = 250,
		close = true,
		consume = 0,
		client = {},
		server = {
			export = 'rcore_beerpong.cups',
		},
	},

	-- pizza start

	["pizza_box"] = {
		label = "Pizza Box",
		weight = 1,
		stack = false,
	},

	["pizza_slice"] = {
		label = "Pizza Slice",
		weight = 1,
		stack = true,
	},

	["dough"] = {
		label = "Dough",
		weight = 1,
		stack = true,
	},

	["sausage"] = {
		label = "Sausage",
		weight = 1,
		stack = true,
	},

	["artichoke"] = {
		label = "Artichoke",
		weight = 1,
		stack = true,
	},

	["fries_pizza"] = {
		label = "Fries",
		weight = 1,
		stack = true,
	},

	["ham"] = {
		label = "Ham",
		weight = 1,
		stack = true,
	},

	["mushroom"] = {
		label = "Mushroom",
		weight = 1,
		stack = true,
	},

	["olive"] = {
		label = "Olive",
		weight = 1,
		stack = true,
	},

	["pepper"] = {
		label = "Pepper",
		weight = 1,
		stack = true,
	},

	["rawham"] = {
		label = "Raw Ham",
		weight = 1,
		stack = true,
	},

	["pepperoni"] = {
		label = "Pepperoni",
		weight = 1,
		stack = true,
	},

	["wurstel"] = {
		label = "Wurstel",
		weight = 1,
		stack = true,
	},

	["basil"] = {
		label = "Basil",
		weight = 1,
		stack = true,
	},

	["rucola"] = {
		label = "Rucola",
		weight = 1,
		stack = true,
	},

	-- pizza end

	-- dice start

	['diamond_dice'] = {
		label = 'Diamond Dice',
		weight = 50,
		stack = false,
		close = true,
		consume = 0.03, -- 20 uses (1/20 = 0.05)
		description = 'Rolls 2d6',
		server = {
			export = 'lorp_dice.useDice',
		},
	},

	['wooden_dice'] = {
		label = 'Wooden Dice',
		weight = 50,
		stack = true,
		close = true,
		consume = 0.02, -- 10 uses
		description = 'Rolls 1d6',
		server = {
			export = 'lorp_dice.useDice',
		},
	},

	['god_dice'] = {
		label = 'God Dice',
		weight = 50,
		stack = false,
		close = true,
		consume = 0.01, -- 100 uses
		description = 'Rolls 1d100',
		server = {
			export = 'lorp_dice.useDice',
		},
	},

	['death_dice'] = {
		label = 'Death Dice',
		weight = 50,
		stack = false,
		close = true,
		degrade = 1440, -- 24 hours
		decay = true,
		description = 'Rolls custom sidded sided die',
		server = {
			export = 'lorp_dice.openRollMenu',
		},
	},

	-- dice end

	-- evidence start

	['evidence_laptop'] = {
		label = 'Evidence Laptop',
		description = 'Laptop for accessing DNA and fingerprint database',
		weight = 1500,
		stack = true,
		close = true,
		client = {
			export = 'evidences.evidence_laptop'
		}
	},

	['evidence_box'] = {
		label = 'Evidence Box',
		description = 'Box to store evidences',
		weight = 250,
		stack = false,
		close = false,
		buttons = {{
			label = 'Label',
			action = function(slot)
				exports.evidences:evidence_box(slot)
			end
		}}
	},

	['forensic_kit'] = {
		label = 'Forensic Kit',
		description = 'You need this kit to secure evidences. The case can be used ten times.',
		weight = 2500,
		close = false,
		stack = false,
		decay = true
	},

	['hydrogen_peroxide'] = {
		label = 'Hydrogen peroxide',
		weight = 500,
		stack = true,
		client = {
			export = 'evidences.hydrogen_peroxide'
		}
	},

	['fingerprint_scanner'] = {
		label = 'Fingerprint Scanner',
		description = 'With this, you can scan the fingerprint of the person opposite you. If the fingerprint matches a database entry, their identity will be displayed to you.',
		weight = 500,
		stack = false,
		close = true,
		consume = 0,
		client = {
			export = 'evidences.fingerprint_scanner',
		},
	},

	['collected_blood'] = {
		label = 'Collected Blood',
		weight = 200,
		stack = false
	},

	['collected_saliva'] = {
		label = 'Collected Saliva',
		weight = 200,
		stack = false
	},

	['collected_magazine'] = {
		label = 'Collected Magazine',
		weight = 200,
		stack = false
	},

	['collected_fingerprint'] = {
		label = 'Collected Fingerprint',
		weight = 5,
		stack = false
	},

	['spy_microphone'] = {
		label = 'Spy Microphone',
		description = 'Microphone for observing nearby people',
		weight = 1500,
		stack = true,
		close = true,
		client = {
			export = 'evidences.spy_microphone'
		}
	},

	-- evidence end

	-- prison start

	["ankle_monitor"] = {
		label = "Ankle Monitor",
		weight = 500,
		stack = true,
		close = true,
	},

	["power_saw"] = {
		label = "Power Saw",
		weight = 5000,
		stack = true,
		close = true,
	},

	["prisunflower"] = {
		label = "Prisunflower",
		weight = 50,
		stack = true,
		close = false,
	},

	["prisunflower_seed"] = {
		label = "Prisunflower seed",
		weight = 10,
		stack = true,
		close = true,
	},

	["jail_chemicals"] = {
		label = "Chemicals",
		weight = 10,
		stack = true,
		close = false,
	},

	["slammer"] = {
		label = "Slammer",
		weight = 10,
		stack = true,
		close = false,
	},

	["jail_lab_tools"] = {
		label = "Laboratory Equipment",
		weight = 100,
		stack = true,
		close = false,
	},

	["jail_cigarette"] = {
		label = "Cigarette",
		weight = 10,
		stack = true,
		close = false,
	},

	["jail_lighter"] = {
		label = "Handmade lighter",
		weight = 50,
		stack = true,
		close = true,
	},

	["jail_explosive"] = {
		label = "Handmade explosive",
		weight = 500,
		stack = true,
		close = true,
	},

	["plastic_knife"] = {
		label = "Plastic knife",
		weight = 5,
		stack = true,
		close = false,
	},

	["plastic_spoon"] = {
		label = "Plastic spoon",
		weight = 5,
		stack = true,
		close = false,
	},

	["plastic_fork"] = {
		label = "Plastic fork",
		weight = 5,
		stack = true,
		close = false,
	},

	["sharpened_plastic_knife"] = {
		label = "Sharpened plastic knife",
		weight = 5,
		stack = true,
		close = true,
	},

	["sharpened_plastic_spoon"] = {
		label = "Sharpened plastic spoon",
		weight = 5,
		stack = true,
		close = true,
	},

	["sharpened_plastic_fork"] = {
		label = "Sharpened plastic fork",
		weight = 5,
		stack = true,
		close = true,
	},

	["freedom_chip"] = {
		label = "A32 Freedom Chip",
		weight = 10,
		stack = true,
		close = true,
	},

	["fence_cutters"] = {
		label = "Fence cutters",
		weight = 1000,
		stack = true,
		close = true,
	},

	["jail_shovel"] = {
		label = "Handmade shovel",
		weight = 3000,
		stack = true,
		close = true,
	},

	["jail_security_card"] = {
		label = "Prison security card",
		weight = 50,
		stack = true,
		close = false,
	},

	["battery"] = {
		label = "Battery",
		weight = 250,
		stack = true,
		close = false,
	},

	["metal_scrap"] = {
		label = "Metal scrap",
		weight = 10,
		stack = true,
		close = false,
	},

	["electronic_scrap"] = {
		label = "Electronic scrap",
		weight = 10,
		stack = true,
		close = false,
	},

	["plastic_scrap"] = {
		label = "Plastic scrap",
		weight = 10,
		stack = true,
		close = false,
	},

	["tape"] = {
		label = "Tape",
		weight = 10,
		stack = true,
		close = false,
	},

	["electric_cable"] = {
		label = "Electric cable",
		weight = 10,
		stack = true,
		close = false,
	},

	["metal_pipe"] = {
		label = "Metal pipe",
		weight = 10,
		stack = true,
		close = false,
	},

	["tin_foil"] = {
		label = "Tin foil",
		weight = 10,
		stack = true,
		close = false,
	},

	["gunpowder"] = {
		label = "Gunpowder",
		weight = 10,
		stack = true,
		close = false,
	},

	["prison_mdt"] = {
		label = "Prison MDT",
		weight = 100,
		stack = true,
		close = true,
	},

	["ifak"] = {
		label = "IFAK",
		weight = 50,
		stack = true,
		close = true,
	},

	-- prison end

	-- gruppe sechs job start

	["gruppesechstablet"] = {
		label = "Gruppe Sechs Tablet",
		description = 'Used to Hi-jack Gruppe Sechs Deliveries',
		weight = 100,
		stack = true,
		close = true,
	},

	-- gruppe sechs job end

	-- atm robbery start

	["drill"] = {
		label = "Drill",
		description = 'ATM Robbery',
		weight = 1,
		stack = true,
		close = true,
	},

	["hacking_device"] = {
		label = "Hacking Device",
		description = 'ATM Robbery',
		weight = 1,
		stack = true,
		close = true,
	},

	-- atm robbery end

	-- graffiti start

	["graffiti_spray"] = {
        label = "Graffiti Spray",
        weight = 1000,
        stack = false,
        close = true,
        consume = 0.25,
		decay = true,
		client = {
			event = 'rtx_graffiti:OpenGraffiti'
		}
    },

	["graffiti_remover"] = {
        label = "Graffiti Remover",
        weight = 1000,
        stack = false,
        close = true,
        consume = 0.25,
		decay = true,
		client = {
			event = 'rtx_graffiti:GraffitiClean'
		}
    },

	-- graffiti end

	-- fishing start

	['bitterling'] = {
        label = 'Bitterling',
        description = 'A small freshwater fish common in calm waters.',
        stack = true,
    },

    ['pale_chub'] = {
        label = 'Pale Chub',
        description = 'A modest-sized fish found in streams and rivers.',
        stack = true,
    },

    ['dace'] = {
        label = 'Dace',
        description = 'A river fish most active during evening and early morning.',
        stack = true,
    },

    ['carp'] = {
        label = 'Carp',
        description = 'A large pond-dwelling fish found year-round.',
        stack = true,
    },

    ['goldfish'] = {
        label = 'Goldfish',
        description = 'A classic small pond fish.',
        stack = true,
    },

    ['killifish'] = {
        label = 'Killifish',
        description = 'A small pond fish found during spring and summer.',
        stack = true,
    },

    ['crawfish'] = {
        label = 'Crawfish',
        description = 'A crustacean found in ponds during spring and summer.',
        stack = true,
    },

    ['tadpole'] = {
        label = 'Tadpole',
        description = 'A young amphibian found in ponds during spring.',
        stack = true,
    },

    ['frog'] = {
        label = 'Frog',
        description = 'An amphibian found in ponds during late spring and summer.',
        stack = true,
    },

    ['freshwater_goby'] = {
        label = 'Freshwater Goby',
        description = 'A small river fish most active during evening hours.',
        stack = true,
    },

    ['loach'] = {
        label = 'Loach',
        description = 'A river fish found during spring.',
        stack = true,
    },

    ['bluegill'] = {
        label = 'Bluegill',
        description = 'A small river fish active during daytime.',
        stack = true,
    },

    ['yellow_perch'] = {
        label = 'Yellow Perch',
        description = 'A river fish found during winter and early spring.',
        stack = true,
    },

    ['black_bass'] = {
        label = 'Black Bass',
        description = 'A large and common river fish found year-round.',
        stack = true,
    },

    ['tilapia'] = {
        label = 'Tilapia',
        description = 'A river fish found during summer months.',
        stack = true,
    },

    ['pond_smelt'] = {
        label = 'Pond Smelt',
        description = 'A small river fish found in winter months.',
        stack = true,
    },

    ['sweetfish'] = {
        label = 'Sweetfish',
        description = 'A river fish found during summer months.',
        stack = true,
    },

    ['anchovy'] = {
        label = 'Anchovy',
        description = 'A small, silvery marine fish often found in schools.',
        stack = true,
    },
    
    ['horse_mackerel'] = {
        label = 'Horse Mackerel',
        description = 'A common marine fish found in large schools.',
        stack = true,
    },

    ['sea_bass'] = {
        label = 'Sea Bass',
        description = 'A common large marine fish found year-round.',
        stack = true,
    },

    ['dab'] = {
        label = 'Dab',
        description = 'A flatfish found in marine environments.',
        stack = true,
    },
    
    ['olive_flounder'] = {
        label = 'Olive Flounder',
        description = 'A large flatfish found in marine environments.',
        stack = true,
    },

    ['squid'] = {
        label = 'Squid',
        description = 'A marine cephalopod with a distinctive elongated body.',
        stack = true,
    },

    ['koi'] = {
        label = 'Koi',
        description = 'A colorful and sought-after ornamental carp.',
        stack = true,
    },

    ['pop_eyed_goldfish'] = {
        label = 'Pop-eyed Goldfish',
        description = 'A unique goldfish variant with prominent eyes.',
        stack = true,
    },

    ['ranchu_goldfish'] = {
        label = 'Ranchu Goldfish',
        description = 'A round-bodied goldfish breed.',
        stack = true,
    },

    ['angelfish'] = {
        label = 'Angelfish',
        description = 'A tropical river fish with distinctive shape.',
        stack = true,
    },

    ['betta'] = {
        label = 'Betta',
        description = 'A colorful river fish known for its vibrant fins.',
        stack = true,
    },

    ['neon_tetra'] = {
        label = 'Neon Tetra',
        description = 'A small, brightly colored river fish.',
        stack = true,
    },

    ['rainbowfish'] = {
        label = 'Rainbowfish',
        description = 'A colorful river fish active during late spring and summer.',
        stack = true,
    },

    ['sea_butterfly'] = {
        label = 'Sea Butterfly',
        description = 'A delicate marine creature found in winter seas.',
        stack = true,
    },

    ['seahorse'] = {
        label = 'Seahorse',
        description = 'A unique marine fish with a distinctive shape.',
        stack = true,
    },

    ['clownfish'] = {
        label = 'Clownfish',
        description = 'A small, brightly colored tropical marine fish.',
        stack = true,
    },

    ['surgeonfish'] = {
        label = 'Surgeonfish',
        description = 'A colorful marine fish with distinctive markings.',
        stack = true,
    },

    ['butterfly_fish'] = {
        label = 'Butterfly Fish',
        description = 'A vibrant tropical marine fish with unique patterns.',
        stack = true,
    },

    ['zebra_turkeyfish'] = {
        label = 'Zebra Turkeyfish',
        description = 'A unique marine fish with striking striped patterns.',
        stack = true,
    },

    ['barred_knifejaw'] = {
        label = 'Barred Knifejaw',
        description = 'A distinctive marine fish with unique markings.',
        stack = true,
    },

    ['red_snapper'] = {
        label = 'Red Snapper',
        description = 'A prized marine fish with distinctive red coloration.',
        stack = true,
    },

    ['moray_eel'] = {
        label = 'Moray Eel',
        description = 'A serpentine marine creature found in rocky areas.',
        stack = true,
    },

    ['ribbon_eel'] = {
        label = 'Ribbon Eel',
        description = 'A colorful and unique marine eel species.',
        stack = true,
    },

    ['sturgeon'] = {
        label = 'Sturgeon',
        description = 'An ancient species known for its size and caviar.',
        stack = true,
    },

    ['giant_snakehead'] = {
        label = 'Giant Snakehead',
        description = 'A large and distinctive pond fish.',
        stack = true,
    },

    ['golden_trout'] = {
        label = 'Golden Trout',
        description = 'A rare and beautiful trout with golden coloring.',
        stack = true,
    },

    ['stringfish'] = {
        label = 'Stringfish',
        description = 'A large clifftop river fish found in winter.',
        stack = true,
    },
    
    ['king_salmon'] = {
        label = 'King Salmon',
        description = 'The largest and most prestigious salmon species.',
        stack = true,
    },

    ['napoleonfish'] = {
        label = 'Napoleonfish',
        description = 'A large, distinctive marine fish found during summer.',
        stack = true,
    },

    ['dorado'] = {
        label = 'Dorado',
        description = 'A powerful predatory river fish from South America.',
        stack = true,
    },

    ['gar'] = {
        label = 'Gar',
        description = 'A prehistoric-looking fish found in ponds during summer.',
        stack = true,
    },

    ['arapaima'] = {
        label = 'Arapaima',
        description = 'A massive river fish from the Amazon basin.',
        stack = true,
    },

    ['tuna'] = {
        label = 'Tuna',
        description = 'A large, powerful marine fish prized by anglers.',
        stack = true,
    },

    ['blue_marlin'] = {
        label = 'Blue Marlin',
        description = 'A massive and powerful oceanic predator.',
        stack = true,
    },

    ['giant_trevally'] = {
        label = 'Giant Trevally',
        description = 'A large and aggressive marine game fish.',
        stack = true,
    },

    ['mahi_mahi'] = {
        label = 'Mahi-Mahi',
        description = 'A colorful and fast-swimming tropical marine fish.',
        stack = true,
    },

    ['ray'] = {
        label = 'Ray',
        description = 'A flat marine creature gliding through the waters.',
        stack = true,
    },

    ['saw_shark'] = {
        label = 'Saw Shark',

        description = 'A unique shark species with a distinctive saw-like snout.',
        stack = true,
    },

    ['hammerhead_shark'] = {
        label = 'Hammerhead Shark',
        description = 'A shark with a uniquely shaped head resembling a hammer.',
        stack = true,
    },

    ['whale_shark'] = {
        label = 'Whale Shark',
        description = 'The largest fish species in the world, despite being a gentle giant.',
        stack = true,
    },

    ['ocean_sunfish'] = {
        label = 'Ocean Sunfish',
        description = 'A massive and unique marine creature with a distinctive fin.',
        stack = true,
    },

    ['oarfish'] = {
        label = 'Oarfish',
        description = 'A long, mysterious deep-sea creature rarely seen.',
        stack = true,
    },

    ['great_white_shark'] = {
        label = 'Great White Shark',
        description = 'The ocean\'s apex predator. A legendary catch.',
        stack = true,
    },

    ['coelacanth'] = {
        label = 'Coelacanth',
        description = 'A prehistoric fish thought to be extinct, only catchable during rain.',
        stack = true,
    },
    
    ['barreleye'] = {
        label = 'Barreleye',
        description = 'A unique deep-sea fish with a transparent head.',
        stack = true,
    },

    -- Fishing Equipment

    ['fishing_rod'] = {
        label = 'Fishing Rod',
        weight = 1000,
        stack = false,
        description = 'A tool for catching fish',
        server = {
            export = 'peak_fishing.useFishingRod',
        },
        buttons = {
            {
                label = 'Open Bait Storage',
                action = function(slot)
                    TriggerServerEvent('peak_fishing:server:openBaitStorage', slot)
                end
            },
            {
                label = 'Open Tackle Storage',
                action = function(slot)
                    TriggerServerEvent('peak_fishing:server:openTackleStorage', slot)
                end
            },
        },
    },

    ['fishing_net'] = {
        label = 'Fishing Net',
        weight = 2000,
        description = 'A sturdy fishing net used to catch multiple fish at once. Ideal for deep water or large catches.',
        stack = false,
        server = {
            export = 'peak_fishing.useFishingNet',
        }
    },  

    -- Tackle Items

    ['bobber'] = {
        label = 'Basic Bobber',
        weight = 50,
        description = 'Improves bite detection and helps stabilize your fishing line.',
        stack = true,
    },
    
    ['spinner'] = {
        label = 'Spinner Lure',
        weight = 75,
        description = 'Attracts predatory fish with its flashing movements.',
        stack = true,
    },
    
    ['sinker_set'] = {
        label = 'Professional Sinker Set',
        weight = 120,
        description = 'High-quality weights for precise depth control and better stability in currents.',
        stack = true,
    },
    
    ['premium_tackle'] = {
        label = 'Premium Tackle Kit',
        weight = 200,
        description = 'High-quality line and hooks for better control and reduced chance of losing fish.',
        stack = true,
    },

    -- Bait items

    ['earthworm'] = {
        label = 'Earthworm',
        weight = 10,
        stack = true,
        description = 'A classic natural bait, perfect for beginners.',
    },

    ['bread'] = {
        label = 'Bread Ball',
        weight = 10,
        stack = true,
        description = 'Simple but effective bait for surface fishing.',
    },

    ['corn'] = {
        label = 'Sweet Corn',
        weight = 10,
        stack = true,
        description = 'Popular bait for freshwater fishing.',
    },

    ['maggots'] = {
        label = 'Maggots',
        weight = 10,
        stack = true,
        description = 'Small but highly effective natural bait.',
    },

    ['minnow'] = {
        label = 'Live Minnow',
        weight = 30,
        stack = true,
        description = 'Fresh live bait, very attractive to predatory fish.',
    },

    ['nightcrawler'] = {
        label = 'Nightcrawler',
        weight = 20,
        stack = true,
        description = 'Large worms, excellent for night fishing.',
    },

    ['bloodworm'] = {
        label = 'Bloodworm',
        weight = 15,
        stack = true,
        description = 'Premium marine bait, highly effective in saltwater.',
    },

    ['magnet'] = {
        label = 'Fishing Magnet',
        weight = 200,
        description = 'A specialized magnet for treasure hunting. Unlikely to catch fish, but great for finding metal treasures.',
        stack = true,
    },

    -- Treasure Items

    ['old_boot'] = {
        label = 'Old Boot',
        weight = 500,
        description = 'A worn-out leather boot. Not valuable, but a fishing classic.',
        stack = true,
    },
    
    ['rusty_anchor'] = {
        label = 'Rusty Anchor',
        weight = 5000,
        description = 'A small, corroded ship anchor. Might be of interest to collectors.',
        stack = true,
    },
    
    ['broken_bottle'] = {
        label = 'Antique Bottle',
        weight = 300,
        description = 'An old glass bottle with faded markings. Could be centuries old.',
        stack = true,
    },
    
    ['gold_coin'] = {
        label = 'Gold Doubloon',
        weight = 20,
        description = 'A well-preserved gold coin from a bygone era. Quite valuable!',
        stack = true,
    },
    
    ['silver_necklace'] = {
        label = 'Silver Necklace',
        weight = 50,
        description = 'A tarnished silver necklace with an intricate pendant.',
        stack = true,
    },
    
    ['treasure_chest'] = {
        label = 'Small Treasure Chest',
        weight = 2000,
        description = 'A miniature wooden chest containing a few valuables. What a find!',
        stack = true,
    },
    
    ['ancient_statue'] = {
        label = 'Ancient Statue',
        weight = 1000,
        description = 'A small stone figurine of unknown origin. Archaeologists might be interested.',
        stack = true,
    },
    
    ['pearl'] = {
        label = 'Giant Pearl',
        weight = 50,
        description = 'An unusually large and lustrous pearl. Extremely rare.',
        stack = true,
    },

    ['diving_watch'] = {
        label = 'Vintage Diving Watch',
        weight = 150,
        description = 'A high-quality waterproof watch, somehow still in working condition.',
        stack = true,
    },

    ['shipwreck_plank'] = {
        label = 'Shipwreck Fragment',
        weight = 2000,
        description = 'A piece of wood with ornate carvings, likely from an old shipwreck.',
        stack = true,
    },

	-- fishing end

	-- switch start

	['switch'] = { -- Switches
		label = 'Switch',
		weight = 100,
		stack = false,
		client = {
			export = 'lorp_packed.activate'
		}
	},

	-- switch end

	-- oufit bag start

	['outfitbag'] = {
		label = 'Outfit Bag',
		weight = 500,
		client = {
			export = 'lorp_outfit_bags.placeBag'
		}
	},

	-- outfit bag end

	-- vehicle handler start

	["cleaningkit"] = {
		label = "Cleaning Kit",
		weight = 250,
		stack = true,
		close = true,
		description = "A microfiber cloth with some soap will let your car sparkle again!",
		client = {
			image = "cleaningkit.png",
		},
		server = {
			export = 'lorp_vehicle_handler.cleaningkit'
		}
	},

	["tirekit"] = {
		label = "Tire Kit",
		weight = 250,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your tire",
		client = {
			image = "tirekit.png",
		},
		server = {
			export = 'lorp_vehicle_handler.tirekit'
		}
	},

	["repairkit"] = {
		label = "Repair kit",
		weight = 2500,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle temporarily",
		client = {
			image = "repairkit.png",
		},
		server = {
			export = 'lorp_vehicle_handler.repairkit',
		}
	},

	["advancedrepairkit"] = {
		label = "Advanced Repair kit",
		weight = 5000,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle completely",
		client = {
			image = "advancedrepairkit.png",
		},
		server = {
			export = 'lorp_vehicle_handler.advancedrepairkit',
		}
	},

	-- vehicle handler end

	["police_stormram"] = {
		label = "Breaching Ram",
		weight = 1000,
		stack = false,
	},

	['bodycam'] = {
		label = "Body Cam",
		weight = 15,
		client = {
			event = 'spy-bodycam:bodycamstatus'
		}
	},

	['dashcam'] = {
		label = "Dash Cam",
		weight = 15,
		client = {
			event = 'spy-bodycam:toggleCarCam'
		}
	},

	["water"] = {
		label = "Water",
		weight = 1,
		stack = true,
	},

	-- kitchen start

	["fries"] = {
		label = "Fries",
		weight = 1,
		stack = true,
	},

	["sunflower_oil"] = {
		label = "Sunflower Oil",
		weight = 1,
		stack = true,
	},

	["patty"] = {
		label = "Patty",
		weight = 1,
		stack = true,
	},

	["lettuce"] = {
		label = "Lettuce",
		weight = 1,
		stack = true,
	},

	["tomato"] = {
		label = "Tomato",
		weight = 1,
		stack = true,
	},

	["cheddar"] = {
		label = "Cheddar",
		weight = 1,
		stack = true,
	},

	["pickle"] = {
		label = "Pickle",
		weight = 1,
		stack = true,
	},

	["onion"] = {
		label = "Onion",
		weight = 1,
		stack = true,
	},

	["bacon"] = {
		label = "Bacon",
		weight = 1,
		stack = true,
	},

	["hamburger"] = {
		label = "Burger",
		weight = 1,
		stack = true,
	},

	["frozen_fries"] = {
		label = "Frozen Fries",
		weight = 1,
		stack = true,
	},

	-- kitchen end

	-- windmill start

	["usb_stick"] = {
		label = "USB Stick",
		description = 'Used to hack windmills for energy',
		weight = 100,
		stack = false,
	},

	["hack_laptop"] = {
		label = "Hacking Laptop",
		description = 'Used to hack windmills for energy',
		weight = 1000,
		stack = false,
	},

	-- windmill end

	-- gang items start

	["ziptie"] = {
		label = "Ziptie",
		weight = 100,
	},

	["headbag"] = {
		label = "Head Bag",
		weight = 100,
	},

	["weed_bag"] = {
		label = "Weed Bag",
		weight = 100
	},

	["weed_plant"] = {
		label = "Weed Plant",
		weight = 1
	},

	["weed_dry"] = {
		label = "Dried Weed",
		weight = 1
	},

	-- gang items end

	-- bank heist start

	["bomb_big"] = {
		label = "Bomb",
		description = "Bank Heist",
		weight = 10000,
		stack = false,
	},

	-- bank heist end

	-- jewelry heist start

	["jewels"] = {
		label = "Jewels",
		description = "Jewelry Heist",
		weight = 1,
		stack = true,
	},

	["ruby"] = {
		label = "Red Ruby",
		description = "Jewelry Heist",
		weight = 1000,
	},

	["panther"] = {
		label = "Panther Statue",
		description = "Jewelry Heist",
		weight = 1000,
	},

	["ruby_necklace"] = {
		label = "Ruby Necklace",
		description = "Jewelry Heist",
		weight = 1000,
	},

	["emerald"] = {
		label = "Emerald",
		description = "Jewelry Heist",
		weight = 1000,
	},

	["golden_banana"] = {
		label = "Golden Banana",
		description = "Jewelry Heist",
		weight = 1000,
	},

	["cable_cutter"] = {
		label = "Cable cutter",
		description = "Jewelry Heist",
		weight = 100,
		stack = true,
	},

	["glass_cutter"] = {
		label = "Glass cutter",
		description = "Jewelry Heist",
		weight = 100,
		stack = true,
	},

	["screwdriver_jewelry"] = {
		label = "Screwdriver (Jewelry)",
		description = "Jewelry Heist",
		weight = 100,
		stack = true,
		client = {
			image = 'screwdriver.png'
		}
	},

	["screwdriver_bank"] = {
		label = "Screwdriver (Bank)",
		description = "Bank Heist",
		weight = 100,
		stack = true,
		client = {
			image = 'screwdriver.png'
		}
	},

	-- jewelry heist end

	-- leo items start

	["radar_scrambler"] = {
        label = "Radar scrambler",
        weight = 50,
        stack = true
    },

	["spikestrip"] = {
		label = "Spike Strip",
		weight = 500,
		stack = true,
		client = {
			event = 'lorp_spikestrips:placeSpikestrip'
		}
	},

	['tracking_bracelet'] = {
		label = 'Tracking Bracelet',
		weight = 2,
		stack = true,
		close = true,
	},

	['alcohol_tester'] = {
		label = 'Alcohol Tester',
		weight = 0,
		stack = true,
		close = true,
	},

	['bobby_pin'] = { -- break cuffs
		label = 'Bobby Pin',
		description = 'Used to break someone out of cuffs',
	},

	-- leo items end

	-- binoculars start

	["binoculars"] = {
		label = "Binoculars",
		weight = 1000,
		stack = false,
		client = {
			export = "lorp_binoculars.ToggleBinoculars",
		}
	},

	-- binoculars end

	-- fires start

	["light_portable_pump"] = {
		label = "Portable Pump",
		weight = 100,
		stack = true,
	},

	["standpipe"] = {
		label = "Stand Pipe",
		weight = 100,
		stack = true,
	},

	["ppv_fan"] = {
		label = "PPV Fan",
		weight = 1000,
		stack = false,
		client = {
			event = 'z_ppvfan:return:use'
		}
	},

	-- fires end

	-- moonshine start

	["sdam_apple"] = {
		label = "Apple",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_apricot"] = {
		label = "Apricot",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_bagofcorn"] = {
		label = "Bag Of Corn",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdam_bagofsugar"] = {
		label = "Bag Of Sugar",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdam_bagofyeast"] = {
		label = "Bag Of Yeast",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdam_banana"] = {
		label = "Banana",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_blackberry"] = {
		label = "Blackberry",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_blueberry"] = {
		label = "Blueberry",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_cherries"] = {
		label = "Cherries",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_coil"] = {
		label = "Copper Coil",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_ebarrel"] = {
		label = "Empty Barrel",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdam_ejug"] = {
		label = "Empty Jug",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdam_firewood"] = {
		label = "Firewood",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_kiwi"] = {
		label = "Kiwi",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_mango"] = {
		label = "Mango",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_orange"] = {
		label = "Orange",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_peach"] = {
		label = "Peach",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_pear"] = {
		label = "Pear",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_pineapple"] = {
		label = "Pineapple",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_plum"] = {
		label = "Plum",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_raspberry"] = {
		label = "Raspberry",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_apple"] = {
		label = "Apple Pie Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_apricot"] = {
		label = "Apricot Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_banana"] = {
		label = "Banana Split Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_blackberry"] = {
		label = "Blackberry Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_blueberry"] = {
		label = "Blueberry Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_cherries"] = {
		label = "Cherry Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_kiwi"] = {
		label = "Kiwi Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_mango"] = {
		label = "Mango Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_orange"] = {
		label = "Orange Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_peach"] = {
		label = "Peach Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_pear"] = {
		label = "Pear Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_pineapple"] = {
		label = "Pineapple Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_plum"] = {
		label = "Plum Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_raspberry"] = {
		label = "Raspberry Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_shine_strawberry"] = {
		label = "Strawberry Moonshine",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_stillpart1"] = {
		label = "Main Still Part",
		weight = 15,
		stack = true,
		close = true,
	},

	["sdam_stillpart2"] = {
		label = "Still Part 2",
		weight = 15,
		stack = true,
		close = true,
	},

	["sdam_stillpart3"] = {
		label = "Still Part 3",
		weight = 15,
		stack = true,
		close = true,
	},

	-- moonsine end

	-- food truck start

	["sdam_strawberry"] = {
		label = "Strawberry",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdam_watergallon"] = {
		label = "Gallon Of Water",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_bacon"] = {
		label = "Raw Bacon",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_baconburger"] = {
		label = "Bacon Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_bacon_cooked"] = {
		label = "Cooked Bacon",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_bleeder"] = {
		label = "Bleeder Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_bun"] = {
		label = "Burger Bun",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_bun_cooked"] = {
		label = "Toasted Bun",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_burger"] = {
		label = "Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_burrito_carneasada"] = {
		label = "Carne Asada Burrito",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_burrito_elpastor"] = {
		label = "El Pastor Burrito",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_carneasada"] = {
		label = "Raw Carne Asada",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_carneasada_cooked"] = {
		label = "Cooked Carne Asada",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_cheese"] = {
		label = "Cheese Slice",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_cheesesauce"] = {
		label = "Cheese Sauce",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_dog"] = {
		label = "Raw Dog",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_dog_cooked"] = {
		label = "Cooked Dog",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_donut"] = {
		label = "Donut",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_donut_cooked"] = {
		label = "Donut",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_doubleburger"] = {
		label = "Double Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_elpastor"] = {
		label = "Raw El Pastor",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_elpastor_cooked"] = {
		label = "Cooked El Pastor",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_fries"] = {
		label = "Fries",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_fries_cooked"] = {
		label = "Cooked Fries",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_heartstopper"] = {
		label = "Heartstopper Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_hoagie"] = {
		label = "Hoagie",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_hoagie_cooked"] = {
		label = "Toasted Hoagie",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_hotdog"] = {
		label = "Hotdog",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_hotdogbun"] = {
		label = "Hotdog Bun",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_hotdogbun_cooked"] = {
		label = "Toasted Hotdog Bun",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_kingsizeburger"] = {
		label = "King Size Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_lettuce"] = {
		label = "Lettuce",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_meatfree"] = {
		label = "Meat Free Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_megacheese"] = {
		label = "Megacheese Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_milkshake"] = {
		label = "Milkshake",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_minipretzel"] = {
		label = "Mini Pretzels",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_minipretzels"] = {
		label = "Mini Pretzels",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_minipretzel_cooked"] = {
		label = "Cooked Mini Pretzels",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_moneyshot"] = {
		label = "Moneyshot Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_nuts"] = {
		label = "Nuts",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_nuts_cooked"] = {
		label = "Roasted Nuts",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_patty"] = {
		label = "Raw Patty",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_patty_cooked"] = {
		label = "Cooked Patty",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_pizza"] = {
		label = "Frozen Pizza",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_pizzaslice"] = {
		label = "Pizza Slice",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_pizza_cooked"] = {
		label = "Cooked Pizza",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_pretzel"] = {
		label = "Pretzel",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_pretzel_cooked"] = {
		label = "Cooked Pretzel",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_quesadilla"] = {
		label = "Quesadilla",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_rawdonut"] = {
		label = "Donut Dough",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_rawfries"] = {
		label = "Raw Fries",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_rawpretzel"] = {
		label = "Raw Pretzel Dough",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_roastednuts"] = {
		label = "Roasted Nuts",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_sausage"] = {
		label = "Sausage",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_sausagedog"] = {
		label = "Sausage Dog",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_sausage_cooked"] = {
		label = "Cooked Sausage",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_shreddedcheese"] = {
		label = "Shredded Cheese",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_smoothie"] = {
		label = "Smoothie",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_taco_carneasada"] = {
		label = "Carne Asada Taco",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_taco_elpastor"] = {
		label = "El Pastor Taco",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_tomato"] = {
		label = "Tomato",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_torilla"] = {
		label = "Tortilla",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_torpedo"] = {
		label = "Torpedo Burger",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_torta_carneasada"] = {
		label = "Carne Asada Torta",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_torta_elpastor"] = {
		label = "El Pastor Torta",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_tostada"] = {
		label = "Tostada",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_vpatty"] = {
		label = "Veggie Patty",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdft_vpatty_cooked"] = {
		label = "Cooked Veggie Patty",
		weight = 1,
		stack = true,
		close = true,
	},

	["sprunk"] = {
		label = "Sprunk",
		weight = 1,
		stack = true,
		close = true,
	},

	-- food trucks end

	-- old licenses start

    ["driver_license"] = {
		label = "Drivers License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can drive a vehicle",
	},

	["weapons_license"] = {
		label = "License to Carry",
		weight = 0,
		stack = false,
		close = true,
		description = "License to Carry and permit the gun holder to use the weapon in self-defense.",
	},

	["medical_license"] = {
		label = "Medical Card",
		weight = 0,
		stack = false,
		close = true,
		description = "License to buy a limited amount of marijuana.",
	},

	["boating_license"] = {
		label = "Boating License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can operate a boat",
	},

	["hunting_license"] = {
		label = "Hunting License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you are allowed to hunt",
	},

	["fishing_license"] = {
		label = "Fishing License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you are allowed to fish",
	},

	["commercial_license"] = {
		label = "Commercial Drivers License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can operate a commercial vehicle",
	},

	-- old licenses end

	-- whippets start

	['ammonium_nitrate'] = {
		label = 'Ammonium Nitrate',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['n2o_strawberry'] = {
		label = 'N₂O Tank (Strawberry)',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	['n2o_strawberry_empty'] = {
		label = 'N₂O Tank (Empty, Strawberry)',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["n2o_watermelon"] = {
		label = "N₂O Tank (Watermelon)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["n2o_watermelon_empty"] = {
		label = "N₂O Tank (Empty, Watermelon)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["n2o_grape"] = {
		label = "N₂O Tank (Grape)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["n2o_grape_empty"] = {
		label = "N₂O Tank (Empty, Grape)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["n2o_mango"] = {
		label = "N₂O Tank (Mango)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["n2o_mango_empty"] = {
		label = "N₂O Tank (Empty, Mango)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["n2o_raspberry"] = {
		label = "N₂O Tank (Raspberry)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["n2o_raspberry_empty"] = {
		label = "N₂O Tank (Empty, Raspberry)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},

	["nitrous_compressor"] = {
		label = "Nitrous Compressor",
		weight = 1,
		stack = true,
		close = true,
		description = "A device used to compress ammonium nitrate into nitrous oxide."
	},

	-- whippets end

	-- fraud start

	["printer"] = {
		label = "Printer",
		weight = 1000,
		stack = true,
		close = true,
	},

	["msr"] = {
		label = "MSR",
		weight = 1000,
		stack = true,
		close = true,
	},

	["blank"] = {
		label = "Blank Cards",
		weight = 1,
		stack = true,
		close = true,
	},

	["sim"] = {
		label = "Swapped Sim Card",
		weight = 1,
		stack = true,
		close = true,
	},

	["ccard"] = {
		label = "Cloned Card",
		weight = 1,
		stack = true,
		close = true,
	},

	["checkpaper"] = {
		label = "Checkpaper",
		weight = 1,
		stack = true,
		close = true,
	},

	["laptop"] = {
		label = "Laptop",
		weight = 1000,
		stack = true,
		close = true,
	},

	["simcard"] = {
		label = "Empty Sim Card",
		weight = 1,
		stack = true,
		close = true,
	},

	["fcheck"] = {
		label = "Forged Check",
		weight = 1,
		stack = true,
		close = true,
	},

	["burnerphone"] = {
		label = "Burner Phone",
		weight = 1000,
		stack = true,
		close = true,
	},

	-- fraud end

	-- leo start

	['tintmeter'] = {
		label = 'Tint Meter',
		weight = 500,
		stack = false,
		description = 'Tint meter for checking opacity of windows',
		client = {
			export = 'lorp_packed.TintMeter'
		}
	},

	--[[["grinder"] = {
		label = "Grinder",
		weight = 1,
		stack = true,
		close = true,
		consume = 0,
		server = {
			export = 'r_handcuffs.grinder'
		}
	},

	["handcuffs"] = {
		label = "Handcuffs",
		weight = 1,
		stack = true,
		close = true,
		allowArmed = true,
		consume = 0,
		server = {
			export = 'r_handcuffs.handcuffs'
		}
	},

	["handcuff_keys"] = {
		label = "Handcuff Key",
		weight = 1,
		stack = true,
		close = true,
		allowArmed = true,
		consume = 0,
		server = {
			export = 'r_handcuffs.handcuff_keys'
		}
	},

	["rope"] = {
		label = "Rope",
		weight = 1,
		stack = true,
		close = true,
		consume = 0,
		server = {
			export = 'r_handcuffs.rope'
		}
	},

	["knife"] = {
		label = "Knife",
		weight = 1,
		stack = true,
		close = true,
		consume = 0,
		server = {
			export = 'r_handcuffs.knife'
		}
	},]]

	-- leo end

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		allowArmed = true,
		consume = 0,
		client = {
			event = 'mm_radio:client:use'
		}
	},
	
	['jammer'] = {
		label = 'Radio Jammer',
		weight = 10000,
		allowArmed = true,
		client = {
			event = 'mm_radio:client:usejammer'
		}
	},
	
	['radiocell'] = {
		label = 'AAA Cells',
		weight = 1000,
		stack = true,
		allowArmed = true,
		client = {
			event = 'mm_radio:client:recharge'
		}
	},

	['backpack'] = {
		label = 'Backpack',
		weight = 500,
		stack = false,
		consume = 0,
		client = {
			export = 'lorp_packed.openBackpack'
		}
	},

	["taser_cartridge"] = {
		label = "Taser Cartridge",
		weight = 100,
		stack = true,
		allowArmed = true,
		consume = 1,
	},

	['wire_cutter'] = {
		label = 'Wire Cutter',
		weight = 100,
		stack = true,
		consume = 0,
		close = true,
	},

	['cigarrete'] = {
		label = 'Cigarrete',
		weight = 100,
		stack = true,
		consume = 0,
		close = true,
	},

	-- licenses start

	["id_card"] = {
		label = "ID Card",
		weight = 0,
		stack = false,
		close = false,
		description = "A card containing all your information to identify yourself",
	},

	["id_badge"] = {
		label = "Badge",
		weight = 0,
		stack = false,
		close = false,
		description = "A card containing all your information to identify yourself as a law enforcement officer",
	},

    ["license_driver"] = {
		label = "Drivers License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can drive a vehicle",
	},

	["license_weapon"] = {
		label = "License to Carry",
		weight = 0,
		stack = false,
		close = true,
		description = "License to Carry and permit the gun holder to use the weapon in self-defense.",
	},

	["license_medical"] = {
		label = "Medical Card",
		weight = 0,
		stack = false,
		close = true,
		description = "License to buy a limited amount of marijuana.",
	},

	["license_boating"] = {
		label = "Boating License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can operate a boat",
	},

	["license_hunting"] = {
		label = "Hunting License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you are allowed to hunt",
	},

	["license_fishing"] = {
		label = "Fishing License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you are allowed to fish",
	},

	["license_commercial"] = {
		label = "Commercial Drivers License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can operate a commercial vehicle",
	},

	["ems_badge"] = {
		label = "EMS Badge",
		weight = 0,
		stack = false,
		close = true,
		description = "License to prove yourself as a Medical Professional.",
	},

	["gsp_badge"] = {
		label = "State Patrol Badge",
		weight = 0,
		stack = false,
		close = true,
		description = "License to prove yourself as Law Enforcement.",
	},

	-- licenses end

	-- mining start

	['ls_pickaxe'] = {
		label = 'Pickaxe',
		weight = 100
	},

	['ls_copper_pickaxe'] = {
		label = 'Brass Pickaxe',
		weight = 100
	},

	['ls_iron_pickaxe'] = {
		label = 'Iron Pickaxe',
		weight = 100
	},

	['ls_silver_pickaxe'] = {
		label = 'Silver Pickaxe',
		weight = 100
	},

	['ls_gold_pickaxe'] = {
		label = 'Gold Pickaxe',
		weight = 100
	},

	['ls_copper_ore'] = {
		label = 'Brass Ore',
		weight = 100
	},

	['ls_coal_ore'] = {
		label = 'Coal Ore',
		weight = 100
	},

	['ls_iron_ore'] = {
		label = 'Iron Ore',
		weight = 100
	},

	['ls_silver_ore'] = {
		label = 'Silver Ore',
		weight = 100
	},

	['ls_gold_ore'] = {
		label = 'Gold Ore',
		weight = 100
	},

	['ls_copper_ingot'] = {
		label = 'Brass Ingot',
		weight = 500
	},

	['ls_iron_ingot'] = {
		label = 'Iron Ingot',
		weight = 500
	},

	['ls_silver_ingot'] = {
		label = 'Silver Ingot',
		weight = 500
	},

	['ls_gold_ingot'] = {
		label = 'Gold Ingot',
		weight = 500
	},

	-- mining end

	["kq_tow_rope"] = { -- kuz quality tow
		label = "Tow Rope",
		weight = 1000,
		stack = false,
	},

	["kq_winch"] = { -- kuz quality tow
		label = "Winch",
		weight = 1000,
		stack = false,
	},

	-- alcohol start

	['bacardi'] = {
		label = 'Bacardi',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkBacardi',
			value = 10
		}
	},

	['barefoot'] = {
		label = 'Barefoot Bubbly',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkBarefoot',
			value = 10
		}
	},

	['casadelsol'] = {
		label = 'Casa Del Sol',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCasaDelSol',
			value = 10
		}
	},

	['casamigos_a'] = {
		label = 'Casamigos (Anejo)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCasamigosA',
			value = 10
		}
	},

	['casamigos_b'] = {
		label = 'Casamigos (Blanco)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCasamigosB',
			value = 10
		}
	},

	['casamigos_c'] = {
		label = 'Casamigos (Reposado)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCasamigosC',
			value = 10
		}
	},

	['casamigos_d'] = {
		label = 'Casamigos (Joven Mezcal)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCasamigosD',
			value = 10
		}
	},

	['ciroc_passion'] = {
		label = 'Ciroc (Passion)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCirocPassion',
			value = 10
		}
	},

	['ciroc_pomeranate'] = {
		label = 'Ciroc (Pomeranate)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCirocPomernate',
			value = 10
		}
	},

	['ciroc_summer'] = {
		label = 'Ciroc (Summer)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCirocSummer',
			value = 10
		}
	},

	['crown'] = {
		label = 'Crown',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkCrown',
			value = 10
		}
	},

	['donjulio'] = {
		label = 'Don Julio',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkDonJulio',
			value = 10
		}
	},

	['dusse'] = {
		label = 'Dusse',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkDusse',
			value = 10
		}
	},

	['everclear'] = {
		label = 'Everclear',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkEverclear',
			value = 10
		}
	},

	['hennessy_black'] = {
		label = 'Hennessy (Black)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkHennessyBlack',
			value = 10
		}
	},

	['hennessy_gold'] = {
		label = 'Hennessy (Gold)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkHennessyGold',
			value = 10
		}
	},

	['hennessy_nba'] = {
		label = 'Hennessy (NBA)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkHennessyNBA',
			value = 10
		}
	},

	['hennessy_vsop'] = {
		label = 'Hennessy (VSOP)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkHennessyVSOP',
			value = 10
		}
	},

	['jack_daniel_og'] = {
		label = 'Jack Daniel (Original)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkJackOG',
			value = 10
		}
	},

	['jack_daniel_berry'] = {
		label = 'Jack Daniel (Berry)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkJackBerry',
			value = 10
		}
	},

	['jack_daniel_cola'] = {
		label = 'Jack Daniel (Cola)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkJackCola',
			value = 10
		}
	},

	['jack_daniel_downhome'] = {
		label = 'Jack Daniel (Downhome)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkJackDownhome',
			value = 10
		}
	},

	['jack_daniel_lemonade'] = {
		label = 'Jack Daniel (Lemonade)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkJackLemonade',
			value = 10
		}
	},

	['jack_daniel_peach'] = {
		label = 'Jack Daniel (Peach)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkJackPeach',
			value = 10
		}
	},

	['remy_martin'] = {
		label = 'Remy Martin',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkRemy',
			value = 10
		}
	},

	['skyy_orange'] = {
		label = 'Skyy (Orange)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkSkyyOrange',
			value = 10
		}
	},

	['skyy_citrus'] = {
		label = 'Skyy (Citrus)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkSkyyCitrus',
			value = 10
		}
	},

	['skyy_strawberry'] = {
		label = 'Skyy (Strawberry)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkSkyyStrawberry',
			value = 10
		}
	},

	['skyy_peach'] = {
		label = 'Skyy (Peach)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkSkyyPeach',
			value = 10
		}
	},

	['skyy_pineapple'] = {
		label = 'Skyy (Pineapple)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkSkyyPineapple',
			value = 10
		}
	},

	['skyy_vanilla'] = {
		label = 'Skyy (Vanilla)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkSkyyVanilla',
			value = 10
		}
	},

	['smirnoff_lemonade'] = {
		label = 'Smirnoff (Pink Lemonade)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkSmirnoffLemonade',
			value = 10
		}
	},

	['smirnoff_rasberry'] = {
		label = 'Smirnoff (Rasberry)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkSmirnoffRasberry',
			value = 10
		}
	},

	['stella_berry'] = {
		label = 'Stella (Berry)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkStellaBerry',
			value = 10
		}
	},

	['stella_black'] = {
		label = 'Stella (Black)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkStellaBlack',
			value = 10
		}
	},

	['stella_rose'] = {
		label = 'Stella (Rose)',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkStellaRose',
			value = 10
		}
	},

	['tanqueray'] = {
		label = 'Tanqueray',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkTanqueray',
			value = 10
		}
	},

	['taylor_port'] = {
		label = 'Taylor Port',
		weight = 500,
		client = {
			export = 'cs_drunk.DrinkTaylorPort',
			value = 10
		}
	},

	-- alcohol end

	['casino_chips'] = { -- rcore_casino
		label = 'Casino Chips',
		weight = 0,
		stack = true
	},

	['bandage'] = { -- default
		label = 'Bandage',
		weight = 100,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = false },
			usetime = 2500,
		}
	},

	['black_money'] = { -- default
		label = 'Dirty Money',
	},

	['parachute'] = { -- default
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 500,
	},

	['lockpick_door'] = {
		label = 'Door Lockpick',
		description = 'Used to unlock interior doors',
		weight = 500,
		client = {
			image = "doorlock.png",
		},
	},

	['lockpick_house'] = {
		label = 'House Lockpick',
		description = 'Used to break into houses',
		weight = 500,
		client = {
			image = "doorlock.png",
		},
	},

	['money'] = { -- default
		label = 'Money',
	},

	['armour'] = { -- default
		label = 'Bulletproof Vest',
		weight = 500,
		stack = true,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 5000
		}
	},

	["phone"] = {
		label = "Phone",
		weight = 190,
		stack = false,
		consume = 0
	},

	["tablet"] = { -- lb-tablet
		label = "Tablet",
		weight = 1000,
		stack = false,
		consume = 0,
		client = {
			event = "tablet:toggleOpen"
		}
	},

	-- dispensary start

	["quality_fertilizer"] = {
		label = "Quality Fertilizer",
		weight = 1,
		stack = true,
		close = true,
	},

	["raw_paper"] = {
		label = "Raw Paper",
		weight = 1,
		stack = true,
		close = true,
	},

	["spray"] = {
		label = "Spray",
		weight = 1,
		stack = true,
		close = true,
	},

	['gelatti'] = {
		label = 'Gelatti',
		weight = 100
	},

	['gary_payton'] = {
		label = 'Gary Payton',
		weight = 100
	},

	['cereal_milk'] = {
		label = 'Cereal Milk',
		weight = 100
	},

	['cheetah_piss'] = {
		label = 'Cheetah Piss',
		weight = 100
	},

	['snow_man'] = {
		label = 'Snow Man',
		weight = 100
	},

	['georgia_pie'] = {
		label = 'Georgia Pie',
		weight = 100
	},

	['jefe'] = {
		label = 'Jefe',
		weight = 100
	},

	['cake_mix'] = {
		label = 'Cake Mix',
		weight = 100
	},

	['white_runtz'] = {
		label = 'White Runtz',
		weight = 100
	},

	['whitecherry_gelato'] = {
		label = 'White Cherry Gelato',
		weight = 100
	},

	['blueberry_cruffin'] = {
		label = 'Blueberry Cruffin',
		weight = 100
	},

	['fine_china'] = {
		label = 'Fine China',
		weight = 100
	},

	['pink_sandy'] = {
		label = 'Pink Sandy',
		weight = 100
	},

	['zushi'] = {
		label = 'Zushi',
		weight = 100
	},

	['apple_gelato'] = {
		label = 'Apple Gelato',
		weight = 100
	},

	['biscotti'] = {
		label = 'Biscotti',
		weight = 100
	},

	['collins_ave'] = {
		label = 'Collins Ave',
		weight = 100
	},

	['marathon'] = {
		label = 'Marathon',
		weight = 100
	},

	['oreoz'] = {
		label = 'Oreoz',
		weight = 100
	},

	['pirckly_pear'] = {
		label = 'Pirckly Pear',
		weight = 100
	},

	['runtz_og'] = {
		label = 'Runtz OG',
		weight = 100
	},

	['blue_tomyz'] = {
		label = 'Blue Tomyz',
		weight = 100
	},

	['ether'] = {
		label = 'Ether',
		weight = 100
	},

	['froties'] = {
		label = 'Froties',
		weight = 100
	},

	['gmo_cookies'] = {
		label = 'GMO Cookies',
		weight = 100
	},

	['ice_cream_cake_pack'] = {
		label = 'Ice Cream Cake Pack',
		weight = 100
	},

	['khalifa_kush'] = {
		label = 'Khalifa Kush',
		weight = 100
	},

	['la_confidential'] = {
		label = 'L.A. Confidential',
		weight = 100
	},

	['marshmallow_og'] = {
		label = 'Marshmallow OG',
		weight = 100
	},

	['moon_rock'] = {
		label = 'Moon Rocks',
		weight = 100
	},

	['sour_diesel'] = {
		label = 'Sour Diesel',
		weight = 100
	},

	['tahoe_og'] = {
		label = 'Tahoe OG',
		weight = 100
	},

	['backwoods_honey'] = {
		label = 'Honey Backwoods',
		weight = 15
	},

	['backwoods_grape'] = {
		label = 'Grape Backwoods',
		weight = 15
	},

	['grabba_leaf'] = {
		label = 'Grabba Leaf',
		weight = 15
	},

	['backwoods_russian_cream'] = {
		label = 'Russian Cream Backwoods',
		weight = 15
	},

	['paxton_pearl_cigars'] = {
		label = 'Paxton Pearl Cigars',
		weight = 15
	},

	['banana_backwoods'] = {
		label = 'Banana Backwoods',
		weight = 15
	},

	['raw_lean'] = {
		label = 'Raw Lean',
		weight = 12
	},

	['raw_cone_king'] = {
		label = 'Raw Cone King Size',
		weight = 15
	},

	['seed_weed'] = {
		label = 'Weed Seeds',
		weight = 10
	},

	['weed_fertilizer'] = {
		label = 'Weed Fertilizer',
		weight = 10
	},

	['weed_pot'] = {
		label = 'Weed Pot',
		weight = 10
	},

	['weed_spray'] = {
		label = 'Weed Spray',
		weight = 10
	},

	['cafe_bong'] = {
		label = 'Cafe Bong',
		weight = 100
	},

	['lighter'] = {
		label = 'Lighter',
		weight = 1
	},

	['cheap_lighter'] = {
		label = 'Cheap Lighter',
		weight = 1
	},

	['vape'] = {
		label = 'Vape',
		weight = 1
	},

	['gelatti_joint'] = {
		label = 'Gelatti Joint',
		weight = 1
	},

	['gary_payton_joint'] = {
		label = 'Gary Payton Joint',
		weight = 1
	},

	['cereal_milk_joint'] = {
		label = 'Cereal Milk Joint',
		weight = 1
	},

	['cheetah_piss_joint'] = {
		label = 'Cheetah Piss Joint',
		weight = 1
	},

	['snow_man_joint'] = {
		label = 'Snow Man Joint',
		weight = 1
	},

	['georgia_pie_joint'] = {
		label = 'Georgia Pie Joint',
		weight = 1
	},

	['jefe_joint'] = {
		label = 'Jefe Joint',
		weight = 1
	},

	['cake_mix_joint'] = {
		label = 'Cake Mix Joint',
		weight = 1
	},

	['white_runtz_joint'] = {
		label = 'White Runtz Joint',
		weight = 1
	},

	['blueberry_cruffin_joint'] = {
		label = 'Blueberry Cruffin Joint',
		weight = 1
	},

	['whitecherry_gelato_joint'] = {
		label = 'Whitecherry Gelato Joint',
		weight = 1
	},

	['fine_china_joint'] = {
		label = 'Fine China Joint',
		weight = 1
	},

	['pink_sandy_joint'] = {
		label = 'Pink Sandy Joint',
		weight = 1
	},

	['zushi_joint'] = {
		label = 'Zushi Joint',
		weight = 1
	},

	['apple_gelato_joint'] = {
		label = 'Apple Gelato Joint',
		weight = 1
	},

	['biscotti_joint'] = {
		label = 'Biscotti Joint',
		weight = 1
	},

	['collins_ave_joint'] = {
		label = 'Collins AVE Joint',
		weight = 1
	},

	['marathon_joint'] = {
		label = 'Marathon Joint',
		weight = 1
	},

	['oreoz_joint'] = {
		label = 'Oreoz Joint',
		weight = 1
	},

	['pirckly_pear_joint'] = {
		label = 'Pirckly Pear Joint',
		weight = 1
	},

	['runtz_og_joint'] = {
		label = 'Runtz OG Joint',
		weight = 1
	},

	['blue_tomyz_joint'] = {
		label = 'Blue Tomyz Joint',
		weight = 1
	},

	['ether_joint'] = {
		label = 'Ether Joint',
		weight = 1
	},

	['froties_joint'] = {
		label = 'Froties Joint',
		weight = 1
	},

	['gmo_cookies_joint'] = {
		label = 'GMO Cookies Joint',
		weight = 1
	},

	['ice_cream_cake_pack_joint'] = {
		label = 'Ice Cream Cake Pack Joint',
		weight = 1
	},

	['khalifa_kush_joint'] = {
		label = 'Khalifa Kush Joint',
		weight = 1
	},

	['la_confidential_joint'] = {
		label = 'LA Confidential Joint',
		weight = 1
	},

	['marshmallow_og_joint'] = {
		label = 'Marshmallow OG Joint',
		weight = 1
	},

	['moon_rock_joint'] = {
		label = 'Moon Rock Joint',
		weight = 1
	},

	['sour_diesel_joint'] = {
		label = 'Sour Diesel Joint',
		weight = 1
	},

	['tahoe_og_joint'] = {
		label = 'Tahoe OG Joint',
		weight = 1
	},

	-- Blunts

	['gelatti_blunt'] = {
		label = 'Gelatti Blunt',
		weight = 1
	},

	['gary_payton_blunt'] = {
		label = 'Gary Payton Blunt',
		weight = 1
	},

	['cereal_milk_blunt'] = {
		label = 'Cereal Milk Blunt',
		weight = 1
	},

	['cheetah_piss_blunt'] = {
		label = 'Cheetah Piss Blunt',
		weight = 1
	},

	['snow_man_blunt'] = {
		label = 'Snow Man Blunt',
		weight = 1
	},

	['georgia_pie_blunt'] = {
		label = 'Georgia Pie Blunt',
		weight = 1
	},

	['jefe_blunt'] = {
		label = 'Jefe Blunt',
		weight = 1
	},

	['cake_mix_blunt'] = {
		label = 'Cake Mix Blunt',
		weight = 1
	},

	['white_runtz_blunt'] = {
		label = 'White Runtz Blunt',
		weight = 1
	},

	['blueberry_cruffin_blunt'] = {
		label = 'Blueberry Cruffin Blunt',
		weight = 1
	},

	['whitecherry_gelato_blunt'] = {
		label = 'Whitecherry Gelato Blunt',
		weight = 1
	},

	['fine_china_blunt'] = {
		label = 'Fine China Blunt',
		weight = 1
	},

	['pink_sandy_blunt'] = {
		label = 'Pink Sandy Blunt',
		weight = 1
	},

	['zushi_blunt'] = {
		label = 'Zushi Blunt',
		weight = 1
	},

	['apple_gelato_blunt'] = {
		label = 'Apple Gelato Blunt',
		weight = 1
	},

	['biscotti_blunt'] = {
		label = 'Biscotti Blunt',
		weight = 1
	},

	['collins_ave_blunt'] = {
		label = 'Collins AVE Blunt',
		weight = 1
	},

	['marathon_blunt'] = {
		label = 'Marathon Blunt',
		weight = 1
	},

	['oreoz_blunt'] = {
		label = 'Oreoz Blunt',
		weight = 1
	},

	['pirckly_pear_blunt'] = {
		label = 'Pirckly Pear Blunt',
		weight = 1
	},

	['runtz_og_blunt'] = {
		label = 'Runtz OG Blunt',
		weight = 1
	},

	['blue_tomyz_blunt'] = {
		label = 'Blue Tomyz Blunt',
		weight = 1
	},

	['ether_blunt'] = {
		label = 'Ether Blunt',
		weight = 1
	},

	['froties_blunt'] = {
		label = 'Froties Blunt',
		weight = 1
	},

	['gmo_cookies_blunt'] = {
		label = 'GMO Cookies Blunt',
		weight = 1
	},

	['ice_cream_cake_pack_blunt'] = {
		label = 'Ice Cream Cake Pack Blunt',
		weight = 1
	},

	['khalifa_kush_blunt'] = {
		label = 'Khalifa Kush Blunt',
		weight = 1
	},

	['la_confidential_blunt'] = {
		label = 'LA Confidential Blunt',
		weight = 1
	},

	['marshmallow_og_blunt'] = {
		label = 'Marshmallow OG Blunt',
		weight = 1
	},

	['moon_rock_blunt'] = {
		label = 'Moon Rock Blunt',
		weight = 1
	},

	['sour_diesel_blunt'] = {
		label = 'Sour Diesel Blunt',
		weight = 1
	},

	['tahoe_og_blunt'] = {
		label = 'Tahoe OG Blunt',
		weight = 1
	},

	['blueberry_jam_cookie'] = {
		label = 'Blueberry Jam Cookie',
		weight = 1
	},

	['butter_cookie'] = {
		label = 'Butter Cookie',
		weight = 1
	},

	['cookie_craze'] = {
		label = 'Cookie Craze',
		weight = 1
	},

	['get_figgy'] = {
		label = 'Get Figgy',
		weight = 1
	},

	['key_lime_cookie'] = {
		label = 'Key Lime Cookie',
		weight = 1
	},

	['marshmallow_crisp'] = {
		label = 'Marshmallow Crisp',
		weight = 1
	},

	['no_99'] = {
		label = 'NO 99',
		weight = 1
	},

	['paris_fog'] = {
		label = 'Paris Fog',
		weight = 1
	},

	['pogo'] = {
		label = 'Pogo',
		weight = 1
	},

	['pumpkin_cookie'] = {
		label = 'Pumpkin Cookie',
		weight = 1
	},

	['shamrock_cookie'] = {
		label = 'Shamrock Cookie',
		weight = 1
	},

	['strawberry_jam_cookie'] = {
		label = 'Strawberry Jam Cookie',
		weight = 1
	},

	-- ems start

	["saline"] = {
		label = "Saline",
		weight = 1,
		stack = true,
		close = true,
	},

	["xray"] = {
		label = "X-Ray Scanner",
		weight = 1,
		stack = true,
		close = true,
	},

	["lucas3"] = {
		label = "Lucas 3",
		weight = 1,
		stack = true,
		close = true,
	},

	["armbrace"] = {
		label = "Armbrace",
		weight = 1,
		stack = true,
		close = true,
	},

	["medicinebox"] = {
		label = "Medicine Box",
		weight = 1,
		stack = true,
		close = true,
	},

	["stretcher"] = {
		label = "Stretcher",
		weight = 1,
		stack = true,
		close = true,
	},

	["wheelchair"] = {
		label = "Wheel Chair",
		weight = 1,
		stack = true,
		close = true,
	},

	["syringe"] = {
		label = "Syringe",
		weight = 1,
		stack = true,
		close = true,
	},

	["firstaid"] = {
		label = "Firstaid",
		weight = 1,
		stack = true,
		close = true,
	},

	["morphine10"] = {
		label = "Morphine 10mg",
		weight = 1,
		stack = true,
		close = true,
	},

	["morphine30"] = {
		label = "Morphine 30mg",
		weight = 1,
		stack = true,
		close = true,
	},

	["neckbrace"] = {
		label = "Neckbrace",
		weight = 1,
		stack = true,
		close = true,
	},

	["bodybandage"] = {
		label = "Body Bandage",
		weight = 1,
		stack = true,
		close = true,
	},

	["paracetamol"] = {
		label = "Paracetamol",
		weight = 1,
		stack = true,
		close = true,
	},

	["legbrace"] = {
		label = "Legbrace",
		weight = 1,
		stack = true,
		close = true,
	},

	["medicalbag"] = {
		label = "Medical Bag",
		weight = 1,
		stack = true,
		close = true,
	},

	-- ems end

	-- tuning start

	["sdcb_alternator"] = {
		label = "Alternator",
		weight = 15,
		stack = true,
		close = true,
	},

	["sdcb_axel"] = {
		label = "Axel",
		weight = 25,
		stack = true,
		close = true,
	},

	["sdcb_brakepad"] = {
		label = "Brake Pad",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_brakepad2"] = {
		label = "Race Brake Pad",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_brakerotor"] = {
		label = "Brake Pad",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_brakerotor2"] = {
		label = "Race Brake Rotor",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_camshaft"] = {
		label = "Camshaft",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_camshaft2"] = {
		label = "Race Camshaft",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_clutch"] = {
		label = "Clutch",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_clutch2"] = {
		label = "Race Clutch",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_cylinderhead"] = {
		label = "Cylinder Head",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_cylinderhead2"] = {
		label = "Race Cylinder Head",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_door"] = {
		label = "Door",
		weight = 50,
		stack = true,
		close = true,
	},

	["sdcb_doorrepairkit"] = {
		label = "Door Reapir Kit",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_exhaust"] = {
		label = "Exhuast",
		weight = 15,
		stack = true,
		close = true,
	},

	["sdcb_exhaust2"] = {
		label = "Race Exhuast",
		weight = 15,
		stack = true,
		close = true,
	},

	["sdcb_gearset"] = {
		label = "Gear Set",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_gearset2"] = {
		label = "Race Gear Set",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_header"] = {
		label = "Header",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_header2"] = {
		label = "Race Header",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_intake"] = {
		label = "Intake",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_intake2"] = {
		label = "Race Intake",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_oil"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_oil2"] = {
		label = "Race Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_piston"] = {
		label = "Piston",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_piston2"] = {
		label = "Race Piston",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_radiator"] = {
		label = "Radiator",
		weight = 15,
		stack = true,
		close = true,
	},

	["sdcb_radiator2"] = {
		label = "Race Radiator",
		weight = 15,
		stack = true,
		close = true,
	},

	["sdcb_rocker"] = {
		label = "Rocker",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_rocker2"] = {
		label = "Race Rocker",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_rod"] = {
		label = "Engine Rod",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_rod2"] = {
		label = "Race Engine Rod",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_shock"] = {
		label = "Shock",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_shock2"] = {
		label = "Race Shock",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_sparkplug"] = {
		label = "Spark Plug",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_sparkplug2"] = {
		label = "Race Spark Plug",
		weight = 1,
		stack = true,
		close = true,
	},

	["sdcb_spring"] = {
		label = "Spring",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_spring2"] = {
		label = "Race Spring",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_starter"] = {
		label = "Starter",
		weight = 15,
		stack = true,
		close = true,
	},

	["sdcb_tire"] = {
		label = "Tire",
		weight = 5,
		stack = true,
		close = true,
	},

	["sdcb_torqueconverter"] = {
		label = "Torque Converter",
		weight = 10,
		stack = true,
		close = true,
	},

	["sdcb_torqueconverter2"] = {
		label = "Race Torque Converter",
		weight = 10,
		stack = true,
		close = true,
	},

	["sdcb_turbo"] = {
		label = "Turbo",
		weight = 10,
		stack = true,
		close = true,
	},

	["sdcb_wheel"] = {
		label = "Wheel",
		weight = 10,
		stack = true,
		close = true,
	},

	["sdcb_window"] = {
		label = "Window",
		weight = 5,
		stack = true,
		close = true,
	},

	-- tuning end

	-- food/drink start

	["jarrito_grapefruit"] = {
		label = "Jarrito (Grapefruit)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `ps_jarrito_grapefruit`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 10000,
		}
	},

	["jarrito_lime"] = {
		label = "Jarrito (Lime)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `ps_jarrito_lime`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 10000,
		}
	},

	["jarritos_mango"] = {
		label = "Jarrito (Mango)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `ps_jarritos_mango`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 10000,
		}
	},

	["jarrito_strawberry"] = {
		label = "Jarrito (Strawberry)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `ps_jarrito_strawberry`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 10000,
		}
	},

	["jarrito_mandarin"] = {
		label = "Jarrito (Mandarin)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `ps_jarrito_mandarin`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 10000,
		}
	},

	["starbuckscan_coffeeshot"] = {
		label = "Starbucks Coffee (Shot)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_starbuckscan_coffeeshot`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["starbuckscan_hazelnut"] = {
		label = "Starbucks Coffee (Hazel Nut)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_starbuckscan_hazelnut`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["starbuckscan_whitechocolate"] = {
		label = "Starbucks Coffee (White Chocolate)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_starbuckscan_whitechocolate`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["starbuckscan_vanilla"] = {
		label = "Starbucks Coffee (Vanilla)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_starbuckscan_vanilla`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["starbuckscan_mocha"] = {
		label = "Starbucks Coffee (Mocha)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_starbuckscan_mocha`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["prime_blueras"] = {
		label = "Prime (Blue Ras)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_prime_blueraspberrry`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["prime_grape"] = {
		label = "Prime (Grape)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_prime_grape`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["prime_tropicalpunch"] = {
		label = "Prime (Tropical Punch)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_prime_tropicalpunch`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["prime_orange"] = {
		label = "Prime (Orange)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_prime_orange`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["prime_lemonlime"] = {
		label = "Prime (Lemon Lime)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_prime_lemonlime`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["prime_icepop"] = {
		label = "Prime (Ice Pop)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_prime_icepop`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["rootbeer"] = {
		label = "A&W Root Beer",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_awrootbeer`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["cherrycoke"] = {
		label = "Cherry Coke",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_cherrycoke`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	--[[["coke"] = {
		label = "Coke",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_coke`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},]]

	["sprite"] = {
		label = "Sprite",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_sprite`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["redbull_sugarfree"] = {
		label = "Redbull (Sugar Free)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_redbullsugarfree`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["redbull"] = {
		label = "Redbull",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_redbull`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["mountaindew"] = {
		label = "Mountain Dew",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_mountaindew`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["fanta_pineapple"] = {
		label = "Pinapple Fanta",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_fantapineapple`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["fanta_orange"] = {
		label = "Orange Fanta",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_fantaorange`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["fanta_grape"] = {
		label = "Grape Fanta",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_fantagrape`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["drpepper"] = {
		label = "Dr. Pepper",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_dppepper`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["dietdew"] = {
		label = "Mountain Dew (Diet)",
		weight = 100,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `brum_can_dietdew`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 10000,
		}
	},

	["coffee"] = {
		label = "Coffee",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 200000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = {
				model = 'v_res_mcofcup',
				bone = 18905,
				pos = vec3(0.14, 0.0, 0.07),
				rot = vec3(-119.7, -54.56, 7.22)
			},
			usetime = 6500,
		}
	},

	["chips_cheese"] = {
		label = "Chips Big Cheese",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_chips1',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 6500,
		}
	},

	["chips_paprika"] = {
		label = "Chips Paprika",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_chips2',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 6500,
		}
	},

	["chips_ribs"] = {
		label = "Chips Sticky Ribs",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_chips3',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 6500,
		}
	},

	["chips_salt"] = {
		label = "Chips: Salt & Sauce",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_chips4',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 6500,
		}
	},

	["chips_supersalt"] = {
		label = "Chips: Super Salt",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_chips5',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 6500,
		}
	},

	["chips_habanero"] = {
		label = "Chips: Habanero",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_chips6',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 6500,
		}
	},

	["chocolate_meteorite"] = {
		label = "Chocolate: Meteorite",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp" },
			prop = { 
				model = `mxc_vend_prop_item_chocolate1`, 
				bone = 18905,
				pos = vec3(0.12, 0.04, 0.01), 
				rot = vec3(51.55, -47.5, -4.65)
			},
			usetime = 2500,
		}
	},

	["chocolate_captain"] = {
		label = "Chocolate: Captain's Log",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp" },
			prop = { 
				model = `mxc_vend_prop_item_chocolate2`, 
				bone = 18905,
				pos = vec3(0.12, 0.04, 0.01), 
				rot = vec3(51.55, -47.5, -4.65)
			},
			usetime = 2500,
		}
	},

	["condom"] = {
		label = "Condom: Soth Lags",
		weight = 1,
		stack = true,
	},

	["candy_zebra"] = {
		label = "Candy: Zebrabar",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "mp_player_inteat@burger", clip = "mp_player_int_eat_burger_fp" },
			prop = { 
				model = `mxc_vend_prop_item_candybar1`, 
				bone = 18905,
				pos = vec3(0.12, 0.04, 0.01), 
				rot = vec3(51.55, -47.5, -4.65)
			},
			usetime = 2500,
		}
	},

	["candy_psqs"] = {
		label = "Candy: P's & Q's",
		weight = 1,
		stack = true,
		client = {
			status = { hunger = 200000 },
			anim = { dict = "mp_player_inteat@pnq", clip = "loop" },
			prop = { 
				model = `mxc_vend_prop_item_candybar2`, 
				bone = 18905,
				pos = vec3(0.14, -0.02, 0.06), 
				rot = vec3(65.76, -57.6, 2.8)
			},
			usetime = 2500,
		}
	},

	["medicine_laxmax"] = {
		label = "Medicine: Lax to the Max",
		weight = 1,
		stack = true,
		client = {
			anim =  { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_medical1',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.07),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 1500,
		}
	},

	["medicine_alcopatch"] = {
		label = "Medicine: AlcoPatch",
		weight = 1,
		stack = true,
		client = {
			anim =  { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_medical2',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.07),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 1500,
		}
	},

	["medicine_mollis"] = {
		label = "Medicine: Mollis",
		weight = 1,
		stack = true,
		client = {
			anim =  { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_medical3',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.07),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 1500,
		}
	},

	["medicine_betta"] = {
		label = "Medicine: Betta",
		weight = 1,
		stack = true,
		client = {
			anim =  { dict = "amb@world_human_drinking@coffee@male@idle_a", clip = "idle_a" },
			prop = {
				model = 'mxc_vend_prop_item_medical4',
				bone = 57005,
				pos = vec3(0.16, 0.01, -0.07),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 1500,
		}
	},

	["gum_peppermint"] = {
		label = "Gum: Peppermint",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = "mp_player_inteat@pnq", clip = "loop" },
			prop = { 
				model = `mxc_vend_prop_item_gum1`, 
				bone = 18905,
				pos = vec3(0.14, -0.02, 0.06), 
				rot = vec3(65.76, -57.6, 2.8)
			},
			usetime = 2500,
		}
	},

	["gum_cinnamon"] = {
		label = "Gum: Cinnamon",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = "mp_player_inteat@pnq", clip = "loop" },
			prop = { 
				model = `mxc_vend_prop_item_gum2`, 
				bone = 18905,
				pos = vec3(0.14, -0.02, 0.06), 
				rot = vec3(65.76, -57.6, 2.8)
			},
			usetime = 2500,
		}
	},

	["gum_spearmint"] = {
		label = "Gum: Spearmint",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = "mp_player_inteat@pnq", clip = "loop" },
			prop = { 
				model = `mxc_vend_prop_item_gum3`, 
				bone = 18905,
				pos = vec3(0.14, -0.02, 0.06), 
				rot = vec3(65.76, -57.6, 2.8)
			},
			usetime = 2500,
		}
	},

	["bottle_cola"] = {
		label = "Cola",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `mxc_vend_prop_item_bottle1`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0),
			},
			usetime = 2500,
		}
	},

	["bottle_junk"] = {
		label = "Junk",
		weight = 1,
		stack = true,
		--[[client = {
			status = { thirst = 300000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `mxc_vend_prop_item_bottle2`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 2500,
		}]]
	},

	["bottle_orang"] = {
		label = "Orang Tang",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `mxc_vend_prop_item_bottle3`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 2500,
		}
	},

	["bottle_tonic"] = {
		label = "Tonic",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `mxc_vend_prop_item_bottle4`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 2500,
		}
	},

	["bottle_water"] = {
		label = "Water",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `mxc_vend_prop_item_bottle5`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 2500,
		}
	},

	["bottle_sprunk"] = {
		label = "Sprunk",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = "mp_player_intdrink", clip = "loop_bottle" },
			prop = { 
				model = `mxc_vend_prop_item_bottle6`, 
				bone = 18905,
				pos = vec3(0.12, -0.03, 0.03),
				rot = vec3(-98.4, 0.0, -15.0)
			},
			usetime = 2500,
		}
	},

	["can_cola"] = {
		label = "Cola Can",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `mxc_vend_prop_item_cansoda1`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 2500,
		}
	},

	["can_orang"] = {
		label = "Orang Tang Can",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `mxc_vend_prop_item_cansoda2`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 2500,
		}
	},

	["can_junk"] = {
		label = "Junk Can",
		weight = 1,
		stack = true,
		--[[client = {
			status = { thirst = 300000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `mxc_vend_prop_item_cansoda3`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 2500,
		}]]
	},

	["can_sprunk"] = {
		label = "Sprunk Can",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `mxc_vend_prop_item_cansoda4`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 2500,
		}
	},

	["can_logger"] = {
		label = "Logger Can",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `mxc_vend_prop_item_canbeer1`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 2500,
		}
	},

	["can_blarneys"] = {
		label = "Blarneys Can",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `mxc_vend_prop_item_canbeer2`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 2500,
		}
	},

	["can_hoplivion"] = {
		label = "Hoplivion Can",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `mxc_vend_prop_item_canbeer3`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 2500,
		}
	},

	["can_cerbeza"] = {
		label = "Cerbeza Can",
		weight = 1,
		stack = true,
		client = {
			status = { thirst = 300000 },
			anim = { dict = 'amb@world_human_drinking@coffee@male@idle_a', clip = 'idle_a' },
			prop = { 
				model = `mxc_vend_prop_item_canbeer4`, 
				bone = 57005,
				pos = vec3(0.14, 0.01, -0.04),
				rot = vec3(-64.96, 36.0, -3.0)
			},
			usetime = 2500,
		}
	},

	["svapo_vaporglow1a"] = {
		label = "Vaporglow 2",
		weight = 1,
		stack = true
	},

	["svapo_vaporglow1b"] = {
		label = "Vaporglow 1",
		weight = 1,
		stack = true
	},

	["svapo_vaporglow1c"] = {
		label = "Vaporglow 1",
		weight = 1,
		stack = true
	},

	["svapo_vaporglow1d"] = {
		label = "Vaporglow 1",
		weight = 1,
		stack = true
	},

	["svapo_vaporglow1e"] = {
		label = "Vaporglow 1",
		weight = 1,
		stack = true
	},

	["svapo_vaporglow1f"] = {
		label = "Vaporglow 1",
		weight = 1,
		stack = true
	},

	["svapo_evape1a"] = {
		label = "E-Vape 1",
		weight = 1,
		stack = true
	},

	["svapo_evape1b"] = {
		label = "E-Vape 1",
		weight = 1,
		stack = true
	},

	["svapo_evape1c"] = {
		label = "E-Vape 1",
		weight = 1,
		stack = true
	},

	["svapo_evape1d"] = {
		label = "E-Vape 1",
		weight = 1,
		stack = true
	},

	["svapo_evape1e"] = {
		label = "E-Vape 1",
		weight = 1,
		stack = true
	},

	["svapo_evape1f"] = {
		label = "E-Vape 1",
		weight = 1,
		stack = true
	},

	["svapo_evape2a"] = {
		label = "E-Vape 2",
		weight = 1,
		stack = true
	},

	["svapo_evape2b"] = {
		label = "E-Vape 2",
		weight = 1,
		stack = true
	},

	["svapo_evape2c"] = {
		label = "E-Vape 2",
		weight = 1,
		stack = true
	},

	["svapo_evape2d"] = {
		label = "E-Vape 2",
		weight = 1,
		stack = true
	},

	["svapo_evape2e"] = {
		label = "E-Vape 2",
		weight = 1,
		stack = true
	},

	["svapo_evape2f"] = {
		label = "E-Vape 2",
		weight = 1,
		stack = true
	},

	["svapo_smoke1a"] = {
		label = "Smoke 1",
		weight = 1,
		stack = true
	},

	["svapo_smoke1b"] = {
		label = "Smoke 1",
		weight = 1,
		stack = true
	},

	["svapo_smoke1c"] = {
		label = "Smoke 1",
		weight = 1,
		stack = true
	},

	["svapo_smoke1d"] = {
		label = "Smoke 1",
		weight = 1,
		stack = true
	},

	["svapo_smoke1e"] = {
		label = "Smoke 1",
		weight = 1,
		stack = true
	},

	["svapo_smoke1f"] = {
		label = "Smoke 1",
		weight = 1,
		stack = true
	},

	["svapo_evape_box"] = {
		label = "E-Vape Box",
		weight = 1,
		stack = true
	},

	["svapo_evape2_box"] = {
		label = "E-Vape 2 Box",
		weight = 1,
		stack = true
	},

	["svapo_smoke_box"] = {
		label = "Smoke Box",
		weight = 1,
		stack = true
	},

	["svapo_sumo_box"] = {
		label = "Sumo Box",
		weight = 1,
		stack = true
	},

	["svapo_vaporglow_box"] = {
		label = "Vaporglow Box",
		weight = 1,
		stack = true
	},

	["cigs_redwood"] = {
		label = "Cigarettes: Redwood",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
			prop = { 
				model = 'prop_cs_ciggy_01b',
				bone = 57005,
				pos = vec3(0.18, 0.02, 0.02), 
				rot = vec3(0, 103.42, 0)
			},
			usetime = 10000,
		}
	},

	["cigs_redwood2"] = {
		label = "Cigarettes: Redwood2",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
			prop = { 
				model = 'prop_cs_ciggy_01b',
				bone = 57005,
				pos = vec3(0.18, 0.02, 0.02), 
				rot = vec3(0, 103.42, 0)
			},
			usetime = 10000,
		}
	},

	["cigs_debonaireb"] = {
		label = "Cigarettes: Debonaire Blue",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
			prop = { 
				model = 'prop_cs_ciggy_01b',
				bone = 57005,
				pos = vec3(0.18, 0.02, 0.02), 
				rot = vec3(0, 103.42, 0)
			},
			usetime = 10000,
		}
	},

	["cigs_debonaireg"] = {
		label = "Cigarettes: Debonaire Green",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
			prop = { 
				model = 'prop_cs_ciggy_01b',
				bone = 57005,
				pos = vec3(0.18, 0.02, 0.02), 
				rot = vec3(0, 103.42, 0)
			},
			usetime = 10000,
		}
	},

	["cigs_cardiaque"] = {
		label = "Cigarettes: Cardiaque",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
			prop = { 
				model = 'prop_cs_ciggy_01b',
				bone = 57005,
				pos = vec3(0.18, 0.02, 0.02), 
				rot = vec3(0, 103.42, 0)
			},
			usetime = 10000,
		}
	},

	["cigs_69brand"] = {
		label = "Cigarettes: 69Brand",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
			prop = { 
				model = 'prop_cs_ciggy_01b',
				bone = 57005,
				pos = vec3(0.18, 0.02, 0.02), 
				rot = vec3(0, 103.42, 0)
			},
			usetime = 10000,
		}
	},

	["cigs_cok"] = {
		label = "Cigarettes: CoK",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
			prop = { 
				model = 'prop_cs_ciggy_01b',
				bone = 57005,
				pos = vec3(0.18, 0.02, 0.02), 
				rot = vec3(0, 103.42, 0)
			},
			usetime = 10000,
		}
	},

	["cigs_estancia"] = {
		label = "Cigars: Estancia",
		weight = 1,
		stack = true,
		client = {
			anim = { dict = 'amb@world_human_aa_smoke@male@idle_a', clip = 'idle_c' },
			prop = { 
				model = 'prop_cs_ciggy_01b',
				bone = 57005,
				pos = vec3(0.18, 0.02, 0.02), 
				rot = vec3(0, 103.42, 0)
			},
			usetime = 10000,
		}
	},

	["herbaldelightgummies"] = {
		label = "Herbal Delight Gummies",
		weight = 1,
		stack = true,
		close = true,
	},

	["chroniccrunchcookies"] = {
		label = "Chronic Crunch Cookies",
		weight = 1,
		stack = true,
		close = true,
	},

	["kushkrisps"] = {
		label = "Kush Krisps",
		weight = 1,
		stack = true,
		close = true,
	},

	["hightimebrownies"] = {
		label = "HighTime Brownies",
		weight = 1,
		stack = true,
		close = true,
	},

	["blazebites"] = {
		label = "Blaze Bites",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_vodka"] = {
		label = "Vodka",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_whisky"] = {
		label = "Whisky",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_whiterum"] = {
		label = "White Rum",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_bluecuracao"] = {
		label = "Blue Curacao",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_champagne"] = {
		label = "Champagne",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_coffeebean"] = {
		label = "Coffee Bean",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_icecube"] = {
		label = "Ice Cube",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_khusbloom"] = {
		label = "Dry Khus Bloom",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_lemonade"] = {
		label = "Lemonade",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_limejuice"] = {
		label = "Lime juice",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_mintleaves"] = {
		label = "Mint Leaves",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_redwine"] = {
		label = "Redwine",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_shaker"] = {
		label = "Shaker",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_sodawater"] = {
		label = "Coffee Bean",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_tequila"] = {
		label = "Tequila",
		weight = 1,
		stack = true,
		close = true,
	},

	["cafe_whitewine"] = {
		label = "White Wine",
		weight = 1,
		stack = true,
		close = true,
	},

	["weed_leaf"] = {
		label = "Weed Leaf",
		weight = 1,
		stack = true,
		close = true,
	},

	["basketball"] = {
		label = "Basketball",
		weight = 0,
		stack = true,
		close = true,
	},

	["basketball_hoop"] = {
		label = "Basketball Hoop",
		weight = 0,
		stack = true,
		close = true,
	},

	["pooch_bag"] = {
		label = "Pooch Bag",
		weight = 1,
		stack = true,
		close = true,
	},

	["banana"] = {
		label = "Banana",
		weight = 1,
		stack = true,
		close = true,
	},

	["bed1"] = {
		label = "Lounger 1",
		weight = 1,
		stack = true,
		close = true,
	},

	["bed2"] = {
		label = "Lounger 2",
		weight = 1,
		stack = true,
		close = true,
	},

	["bed3"] = {
		label = "Lounger 3",
		weight = 1,
		stack = true,
		close = true,
	},

	["bed4"] = {
		label = "Lounger 4",
		weight = 1,
		stack = true,
		close = true,
	},

	["circle"] = {
		label = "Circle",
		weight = 1,
		stack = true,
		close = true,
	},

	["inflatable"] = {
		label = "Inflatable",
		weight = 1,
		stack = true,
		close = true,
	},

	["parasailing"] = {
		label = "Parachute",
		weight = 1,
		stack = true,
		close = true,
	},

	["ski"] = {
		label = "Ski",
		weight = 1,
		stack = true,
		close = true,
	},

	["2005_blueberry"] = {
		label = "2005 Blueberry Tangiers",
		weight = 1,
		stack = true,
		close = true,
	},

	["4play"] = {
		label = "4Play Fantasia",
		weight = 1,
		stack = true,
		close = true,
	},

	["50_below"] = {
		label = "50 Below Nirvana Dokha",
		weight = 1,
		stack = true,
		close = true,
	},

	["adalya_love"] = {
		label = "Adalya Love 66",
		weight = 1,
		stack = true,
		close = true,
	},

	["al_fakher"] = {
		label = "Al Fakher Two Apples",
		weight = 1,
		stack = true,
		close = true,
	},

	["coals"] = {
		label = "Shisha Coals",
		weight = 1,
		stack = true,
		close = true,
	},

	["double_apple"] = {
		label = "Nakhla Double Apple",
		weight = 1,
		stack = true,
		close = true,
	},

	["el_patron"] = {
		label = "Chaos El Patron",
		weight = 1,
		stack = true,
		close = true,
	},

	["foil"] = {
		label = "Foil Paper",
		weight = 1,
		stack = true,
		close = true,
	},

	["foil_poked"] = {
		label = "Foil Poked",
		weight = 1,
		stack = true,
		close = true,
	},

	["foil_poker"] = {
		label = "Foil Poker",
		weight = 1,
		stack = true,
		close = true,
	},

	["gummi_bear"] = {
		label = "Fumari White Gummi Bear",
		weight = 1,
		stack = true,
		close = true,
	},

	["hose"] = {
		label = "Shisha Hose",
		weight = 1,
		stack = true,
		close = true,
	},

	["hot_coals"] = {
		label = "Hot Coals",
		weight = 1,
		stack = true,
		close = true,
	},

	["mofo_fantasia"] = {
		label = "Adios Mofo Fantasia",
		weight = 1,
		stack = true,
		close = true,
	},

	["blue_mist"] = {
		label = "Starbuzz Blue Mist",
		weight = 1,
		stack = true,
		close = true,
	},

	["social_smoke"] = {
		label = "Social Smoke Absolute Zero",
		weight = 1,
		stack = true,
		close = true,
	},

	["spades_fantasia"] = {
		label = "Ace of Spades Fantasia",
		weight = 1,
		stack = true,
		close = true,
	},

	["zomo_cream"] = {
		label = "Acai Cream Zomo",
		weight = 1,
		stack = true,
		close = true,
	},

	["zomo_lemon"] = {
		label = "Zomo Lemon Mint",
		weight = 1,
		stack = true,
		close = true,
	},

	["cane_mint"] = {
		label = "Tangiers Cane Mint",
		weight = 1,
		stack = true,
		close = true,
	},

	["peppermint_shake"] = {
		label = "Trifecta Blonde Peppermint Shake",
		weight = 1,
		stack = true,
		close = true,
	},

	-- Hot Tubs

	["hottub3"] = {
		label = "Hottub 3",
		weight = 1,
		stack = true,
		close = true,
	},

	["hottub3stairs"] = {
		label = "Hottub 3 Stairs",
		weight = 1,
		stack = true,
		close = true,
	},

	["hottub1"] = {
		label = "Hottub 1",
		weight = 1,
		stack = true,
		close = true,
	},

	["hottub1stairs"] = {
		label = "Hottub 1 Stairs",
		weight = 1,
		stack = true,
		close = true,
	},

	["hottub2"] = {
		label = "Hottub 2",
		weight = 1,
		stack = true,
		close = true,
	},

	["hottub2stairs"] = {
		label = "Hottub 2 Stairs",
		weight = 1,
		stack = true,
		close = true,
	},
}