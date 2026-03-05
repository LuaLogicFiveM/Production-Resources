return {
	-- Language setting for the script
	lang = 'en', -- Available options: 'en' (English) - add more language files as needed
	
	-- Notification system to use
	notify = 'ox', -- Options: 'ox', 'qb', 'esx', 'native', editable in bridge/client/utils.lua

	--[[ 
		SERVER-SIDE SAVING SYSTEM
		Enable this feature if you're not using oxmysql database system.
		This will save all data to a database.json file on your server.
	]]
	server_saving = false,

	-- Auto Save interval in milliseconds (default: 5 minutes)
	savingInterval = 5 * (60 * 1000),

	--[[ 
		ACCESS RESTRICTIONS
		Configure who can use the K9 system using different permission methods.
		Only ONE method should be enabled at a time!
	]]
	restrictions = {
		--[[ 
			ACE PERMISSIONS SYSTEM
			To use this, add these lines to your server.cfg (replace the identifier with actual player identifiers):
			
			add_ace k9 k9 allow
			add_principal identifier.license:YOUR_LICENSE_HERE k9
			
			Example:
			add_principal identifier.license:830e0a2add6393cf28f45474dbf6ac4577f0652a k9
		]]
		use_ace_perms = false, -- Set to true to enable ACE permissions

		--[[ 
			DISCORD ROLE INTEGRATION
			REQUIRES: badger_discord_api resource
			NOTE: If enabled, this takes priority over ACE permissions and job restrictions
		]]
		badger_discord = {
			enable = false, -- Set to true to enable Discord role checking
			roles = {
				-- Add Discord role IDs that should have access to K9 system
				['907104457018449941'] = true, -- Example role ID
				-- ['ANOTHER_ROLE_ID'] = true,
			}
		},

		--[[ 
			JOB-BASED RESTRICTIONS
			REQUIRES: QBCore, QBX, ESX, or ND Framework
			This is automatically disabled if ACE permissions or Discord roles are enabled
		]]
		jobs = {
			-- Format: ['job_name'] = {grade1, grade2, grade3, ...}
			['bcso'] = {10, 11, 12, 13, 14, 15}, -- All police grades (0-9)
			['sasp'] = {7, 8, 9, 10, 11, 12, 13}, -- All police grades (0-9)
			['gov'] = {0, 1, 2, 3, 4, 5}, -- Example
		}
	},

	-- Damage modifier for K9 attacks (affects ALL attacking animals in the server)
	-- WARNING: Players with 100 HP or less will be instantly killed - this is a GTA game limitation
	damage_modifier = 1.0, -- Range: 0.01 - 1.0 (recommended: 0.7 for more balanced gameplay)
	
	-- Whether headshots should instantly kill
	insta_headshot = true, -- Set to false for consistent damage regardless of hit location

	-- Maximum number of dogs each player can register
	max_dogs = 2,

	--[[ 
		TACKLE SYSTEM
		When K9 attacks, it can tackle the target to the ground
	]]
	tackle = {
		enable = true, -- Enable/disable tackle feature
		chance = 30, -- Percentage chance to tackle (only used if level system is disabled)
		type = 2 -- 1 = animation tackle, 2 = ragdoll tackle (more realistic)
	},

	--[[ 
		SPEED ENHANCEMENT (BETA)
		WARNING: This feature may cause desync issues or conflict with anti-cheat systems
		Use at your own risk!
	]]
	speeding = {
		enable = false, -- Set to true to enable speed boost
		value = 1.5 -- Speed multiplier (range: 1.0 - 2.0)
	},

	--[[ 
		AUTO-DELETE CONDITIONS
		Automatically remove dogs when certain conditions are met
	]]
	delete_dog = {
		dog_dead = true, -- Delete dog when it dies (disable health/armor saving if using this!!!)
		owner_dead = false -- Delete dog when owner dies
	},

	--[[ 
		VEHICLE ENTRY SYSTEM
	]]
	vehicle_entering = {
		-- Enhanced vehicle entry with realistic animations (BETA feature)
		-- May appear differently to other players due to sync limitations
		new = true,
	
		-- Special vehicles that require different entry animations
		vans = {
			[`rumpo`] = true, [`rumpo2`] = true,
			[`speedo`] = true, [`speedo2`] = true,
			[`speedo3`] = true, [`policet`] = true
			-- Add more vehicle hashes as needed
		}
	},

	--[[ 
		SPAWN AREA RESTRICTIONS
		Limit where players can spawn/despawn their K9 units
	]]
	spawn_areas = {
		enable = false, -- Set to true to enable area restrictions
		require_house = false, -- Require players to build a dog house in the area first
		areas = {
			{ radius = 30.0, coords = vector3(432.3, -981.64, 30.71) }, -- Example: Police station
			-- Add more areas as needed:
			-- { radius = 50.0, coords = vector3(x, y, z) },
		}
	},

	--[[ 
		TRACKING SYSTEM
		Configure how dogs track scents and follow trails
	]]
	tracking = {
		radius = 75.0, -- Detection radius in game units
		speed = 1.0, -- Dog movement speed while tracking (1.0-5.0, only used without level system)
		cooldown = 3 -- Cooldown between tracking attempts in minutes (0 = no cooldown)
	},
	
	--[[ 
		SEARCH SYSTEM
		Configure what items dogs can detect and search behavior
	]]
	search = {
		-- Automatically detect all weapon items (items starting with 'weapon_')
		-- REQUIRES: Framework with inventory system
		all_weapons = true,
		
		-- Specific items that can be detected by dogs
		-- REQUIRES: Framework with inventory system
		items = {
			-- Format: item_name = 'category'
			thermite = 'explosives',
			weed_brick = 'drugs',
			cocaine_brick = 'drugs',
			weapon_pistol = 'weapons',
			-- Add more items here
		},

		--[[ 
			SEARCH RESULT CATEGORIES
			These messages are shown when dogs detect different item types
			For standalone users: Random category is selected if search is successful
			For framework users: Category is determined by the item found
		]]
		item_types = {
			explosives = 'Smells like explosives...',
			drugs = 'Smells like drugs...',
			weapons = 'Smells like weapon...', -- Used when all_weapons = true
			-- Add custom categories here
		},

		search_time = 3, -- Duration of search animation in seconds

		-- Dog behavior when contraband is found
		onSuccess = 'bark', -- Options: 'bark', 'sit', 'laydown', or false for no action

		-- PLAYER SEARCH SETTINGS
		player = {
			chance = 30, -- Success percentage (only used without framework/inventory)
		},

		-- VEHICLE SEARCH SETTINGS
		vehicle = {
			open_doors = false, -- Automatically open all doors during search
			chance = 30, -- Success percentage (only used without framework/inventory)
		},

		-- NPC SEARCH SETTINGS
		npc = {
			chance = 30, -- Success percentage for finding contraband

			onSuccess = { -- Behavior when contraband is found
				flee = {
					enabled = true, -- Allow NPCs to flee when caught
					chance = 30, -- Percentage chance NPC will attempt to flee
					attack = true, -- Should dog pursue and attack fleeing NPC
				}
			},
			onFail = { -- Behavior when no contraband is found
				walk_away = true, -- Make NPC walk away naturally
			}
		}
	},

	--[[ 
		K9 STATUS SYSTEM
		Health, armor, hunger, and thirst management
	]]
	status = {
		ui = {
			disable_in_vehicle = true -- Hide status UI when player is in a vehicle
		},
		
		-- Starting stats for newly registered dogs
		-- NOTE: Dogs with 100 HP or less will always die in one shot (GTA limitation)
		maxHealth = 200,
		maxArmor = 100,
	
		-- Disable saving health/armor to database (allows respawning without revival)
		disable_hp_and_armor_saving = false,
	
		-- HEALING SYSTEM
		heal = {
			revive_timer = 3, -- Time in seconds to revive a dead dog
			timer = 3, -- Time in seconds to apply healing
			amount = {from = 10, to = 25}, -- Random HP restoration range
		},
		
		-- ARMOR SYSTEM
		armor = {
			timer = 3, -- Time in seconds to apply armor
			amount = {from = 10, to = 25}, -- Random armor restoration range
		},
	
		-- HUNGER & THIRST SYSTEM
		feed = {
			-- Thirst and hunger decrease every 10 seconds by these amounts
			thirst = { from = 0.1, to = 0.3 }, -- Range: 0.0 - 1.0
			hunger = { from = 0.1, to = 0.3 }, -- Range: 0.0 - 1.0
	
			warning = 20, -- Warn player when hunger/thirst drops below this percentage
			get_damaged = true, -- Gradually damage dog when hungry/thirsty
		
			-- Bathroom behavior (realistic dog actions)
			peeing = true, -- Dog will pee after being fed multiple times
			pooping = true -- Dog will poop after being fed multiple times
		}
	},

	--[[ 
		LEASH SYSTEM
		Visual rope connection between player and dog
	]]
	leash = {
		-- Rope type (1-4 = thick ropes, 5+ = thin ropes)
		-- WARNING: Type 0 will crash the game!
		type = 5,
		max_length = 5.0 -- Maximum leash length in game units
	},

	--[[ 
		ITEM REQUIREMENTS
		REQUIRES: Framework with inventory system
		Set specific items required for each action
		Use 'false' to disable item requirement, or 'item_name' to require that item
	]]
	items = {
		ball = false, -- Item needed to play fetch (e.g., 'dog_ball')
		frisbee = false, -- Item needed for frisbee (e.g., 'dog_frisbee')
		camera = false, -- Item needed for camera (e.g., 'dog_camera')
		armor = false, -- Item needed for armor (e.g., 'armor_vest')
		feed = false, -- Item needed for feeding (e.g., 'water_bottle')
		gps = false, -- Item needed for GPS (e.g., 'dog_gps')
		leash = false, -- Item needed for leash (e.g., 'dog_leash')
		heal = false, -- Item needed for healing (e.g., 'bandage')
		medkit = false -- Item needed for revival (e.g., 'medkit')
	},

	--[[ 
		PROP MODELS
		3D models used for various K9 system objects
	]]
	props = {
		food = `v_res_mbowl`, -- Dog food bowl
		ball = `w_am_baseball`, -- Tennis ball for fetch
		frisbee = `p_ld_frisbee_01`, -- Frisbee disc
		house = `prop_doghouse_01`, -- Dog house

		-- Special props from Marx's K9 prop pack
		-- REQUIRES: 'mm_k9' resource to be installed and named exactly 'mm_k9'
		marx = { 
			camera = `mm_k9_bodycam_botmount` -- Body camera for dogs
		}
	},

	--[[ 
		CONTROL SETTINGS
		Configure keybinds for various K9 actions
		Full list of available controls: https://docs.fivem.net/docs/game-references/controls/
	]]
	controls = {
		aim = {
			attack = 38, -- E key - Command dog to attack target
			go = 47 -- G key - Send dog to location
		},
		cam = { -- K9 camera controls (when using mounted camera)
			up = 172, -- Arrow Up - Tilt camera up
			down = 173, -- Arrow Down - Tilt camera down
			left = 174, -- Arrow Left - Tilt camera left
			right = 175, -- Arrow Right - Tilt camera right
			cancel = 177, -- ESC/Backspace/Right Click - Exit camera view
			zoomUp = 241, -- Scroll Up - Zoom in
			zoomDown = 242 -- Scroll Down - Zoom out
		}
	},

	--[[ 
		FIVEM KEYBINDING SYSTEM
		Integrate with FiveM's native keybinding system
	]]
	binding_system = {
		enable = true, -- Enable integration with FiveM keybinds menu
		commands = {
			--[[ 
				KEYBIND CONFIGURATION
				command = command name from the list below
				key = primary key for triggering (see FiveM input mapper docs)
				label = description shown in FiveM keybinds menu
				
				Available keys: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
			]]
			[1] = { command = 'k9', key = 'K', label = 'Open K9 Menu' },
			-- [2] = { command = 'k9follow', key = 'L', label = 'K9 Follow Command' },
			-- Add more keybinds as needed
		},
	},

	--[[ 
		COMMAND NAMES
		Customize chat command names for all K9 functions
		WARNING: Only change the command names, not the parameter names!
	]]
	commands = {
		drag_mode = 'k9drag', -- Enables dragging mode

		-- MENU NAVIGATION COMMANDS
		menu_top = 'k9top', -- Navigate menu up
		menu_down = 'k9down', -- Navigate menu down
		menu_left = 'k9left', -- Navigate menu left
		menu_right = 'k9right', -- Navigate menu right

		-- CORE SYSTEM COMMANDS
		register_dog = 'k9register', -- Register a new K9
		reselect = 'k9reselect', -- Switch between registered K9s
		main_menu = 'k9', -- Open main K9 menu
		save_dog = 'k9save', -- Save K9 data to database
		spawn = 'k9spawn', -- Spawn selected K9
		delete = 'k9delete', -- Permanently delete K9

		-- ACTION COMMANDS
		follow = 'k9follow', -- Make K9 follow player
		lead = 'k9lead', -- Lead K9 on leash
		vehicle = 'k9vehicle', -- K9 vehicle entry/exit
		search_player = 'k9searchped', -- Search nearby player
		search_car = 'k9searchcar', -- Search nearby vehicle
		search_npc = 'k9searchnpc', -- Search nearby NPC
		leash = 'k9leash', -- Toggle leash
		heal = 'k9heal', -- Heal K9
		armor = 'k9armor', -- Apply armor to K9
		track = 'k9trackall', -- General tracking command
		track_player = 'k9trackplayer', -- Track specific player
		track_by_vehicle = 'k9trackveh', -- Track by vehicle

		-- UTILITY COMMANDS
		house = 'k9house', -- Manage K9 house
		go_into_house = 'k9enterhouse', -- Send K9 to house
		ball = 'k9ball', -- Ball play mode
		frisbee = 'k9frisbee', -- Frisbee play mode
		fetch = 'k9fetch', -- Fetch command
		gps = 'k9gps', -- GPS tracking
		feed = 'k9feed', -- Feed K9
		carry = 'k9carry', -- Carry K9

		-- CAMERA COMMANDS
		toggle_camera = 'k9camera', -- Toggle camera view
		mount_camera = 'k9mount', -- Mount/unmount camera

		-- ANIMATION COMMANDS
		sit = 'k9sit', -- Make K9 sit
		laydown = 'k9lay', -- Make K9 lay down
		bark = 'k9bark', -- Make K9 bark
		indicate = 'k9indicate', -- K9 indication behavior
		sniff = 'k9sniff', -- Make K9 sniff around
		beg = 'k9beg', -- Make K9 beg
		paw = 'k9paw', -- K9 paw gesture
		petting = 'k9petting' -- Pet the K9
	}
}