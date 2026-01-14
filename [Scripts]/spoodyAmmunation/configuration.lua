ESX = exports['es_extended']:getSharedObject()

Configuration = {
    ---@param title? string
    ---@param message string
    ---@param type? 'warning' | 'error' | 'success' | 'inform'
    Notify = function(title, message, type)
        lib.notify({
            title = title or 'Weapon Shops',
            description = message,
            type = type or 'inform',
            duration = 5000,
            position = 'top'
        })
    end,

    Settings = {
        Debug = false, --- Enable debug mode? if you are experiencing bugs or any issues, please enable this for easier solution.

        Blips = {
            Hash = 110, --- What hash should the script use for blips?
        },

        InventoryImagePath = 'nui://ox_inventory/web/images/', --- What path should the script use for inventory images? (Important for images)

        Automation = {
            Job = {
                Create = true, --- Automatically create gunstore jobs into the database? [ESX ONLY]
            },
        },

        --- Munitions are paid shipments that allow weapons to be constructed and crafted.
        --- Depending on each weapon, the amount of munitions required is different.
        Munitions = {
            Max = 1000, --- Maximum amount of munitions that can be stored in the shop.
            PricePerMunition = 1000, --- Price per munition
        },

        Interactions = {
            Timers = {
                WipeTable = 5000, --- 5 Seconds to wipe the table cleanup
                SetupCraft = 14000, --- 14 Seconds to setup the crafting
                WeaponCraft = 30000, --- 30 Seconds (per weapon)
            }
        },

        --- MAX: 3 Grades for 1 job
        --- Don't remove or add grades, just edit the existing ones.
        Grades = {
            [1] = {
                label = "Gun Smith", --- Grade label
                hash = "gun_smith", --- Grade hash
                base_salary = 50, --- Base salary
            },

            [2] = {
                label = "Manager", --- Grade label
                hash = "manager", --- Grade hash
                base_salary = 75, --- Base salary
            },

            [3] = {
                label = "Owner", --- Grade label
                hash = "owner", --- Grade hash
                base_salary = 100, --- Base salary
            }
        },

        --- Important for firing and hiring employees.
        Player = {
            UnemployedJob = 'unemployed', --- Unemployed job name
            UnemployedGrade = 0, --- Unemployed job grade
        },

        Admin = {
            Enabled = true, --- Enable admin menu?
            Command = 'gunstores', --- Command to open admin menu
            Permission = 'group.owner', --- Ace Permission
        },

        Commands = {
            Delete = 'gunstoredelete', --- Server Side Command Only (console)
            Refresh = 'gunstorerefresh', --- Server Side Commad Only (console)
        }
    },

    --- NOTICE: You cannot edit or create new categories, you can only insert the specified weapons into them.
    Weapons = {
        ['Rifles'] = {
            ['WEAPON_ARP300'] = {
                label = 'AR Pistol (300. Blackout) (556)',
                licensedPrice = 500000, --- Price to purchase a license to sell this weapon
                minimumPrice = 75000, --- Minimum Price to be set by the job manager
                requiredMunitions = 75, --- Required Munitions to craft this weapon
                minCraft = 1, --- Minimum amount of weapons that can be crafted at once
                maxCraft = 3, --- Maximum amount of weapons that can be crafted at once
            },

            ['WEAPON_AK47'] = {
                label = 'AK-47 (762)',
                licensedPrice = 500000, --- Price to purchase a license to sell this weapon
                minimumPrice = 75000, --- Minimum Price to be set by the job manager
                requiredMunitions = 75, --- Required Munitions to craft this weapon
                minCraft = 1, --- Minimum amount of weapons that can be crafted at once
                maxCraft = 3, --- Maximum amount of weapons that can be crafted at once
            },

            ['WEAPON_AR15'] = {
                label = 'AR-15 (556)',
                licensedPrice = 500000, --- Price to purchase a license to sell this weapon
                minimumPrice = 75000, --- Minimum Price to be set by the job manager
                requiredMunitions = 75, --- Required Munitions to craft this weapon
                minCraft = 1, --- Minimum amount of weapons that can be crafted at once
                maxCraft = 3, --- Maximum amount of weapons that can be crafted at once
            },

            ['WEAPON_SR16'] = {
                label = 'SR-16 (556)',
                licensedPrice = 500000, --- Price to purchase a license to sell this weapon
                minimumPrice = 75000, --- Minimum Price to be set by the job manager
                requiredMunitions = 75, --- Required Munitions to craft this weapon
                minCraft = 1, --- Minimum amount of weapons that can be crafted at once
                maxCraft = 3, --- Maximum amount of weapons that can be crafted at once
            },

            ['WEAPON_MK18'] = {
                label = 'MK-18 (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_300B'] = {
                label = '300 Blackout (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_AR15S'] = {
                label = 'AR-15 Special (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_AKCATCHER'] = {
                label = 'AK-47 CQC (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SWPBLACKARP'] = {
                label = 'ARP Black (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SWPBLUEARP'] = {
                label = 'ARP Blue (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GREENARP'] = {
                label = 'ARP Green (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_ORANGEARP'] = {
                label = 'ARP Orange (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_PINKARP'] = {
                label = 'ARP Pink (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_PURPLEARP'] = {
                label = 'ARP Purple (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SWPREDARP'] = {
                label = 'ARP Red (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_WHITEARP'] = {
                label = 'ARP White (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_YELLOWARP'] = {
                label = 'ARP Yellow (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_KTECPLR'] = {
                label = 'Kel Tec PLR (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_LILUZI'] = {
                label = 'Lil Uzi (9mm)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_MARP'] = {
                label = 'Mirco ARP (556)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_MDRACO'] = {
                label = 'Micro Draco (762)',
                licensedPrice = 500000,
                minimumPrice = 75000,
                requiredMunitions = 75,
                minCraft = 1,
                maxCraft = 3,
            },
        },

        ['Pistols'] = {
            ['WEAPON_L5'] = {
                label = 'Deagle (50 BMG)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_COLTM45'] = {
                label = 'Colt M-45 (.45)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GLOCK27WHITE'] = {
                label = 'Glock 17 (White) (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_BLUEGLOCKSWITCH'] = {
                label = 'Glock 26 w/ Switch (Blue) (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GLOCK19TANSWITCHDRUM'] = {
                label = 'Glock 19 w/ Switch (Tan) (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GLOCK17STICK'] = {
                label = 'Glock 17 w/ Stick (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_FN509'] = {
                label = 'FN-509 (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_FIVESEVEN'] = {
                label = 'Five Seven (5.7)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_P890'] = {
                label = 'P-890 (.45)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_MAKAROV'] = {
                label = 'Makarov (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GLOCK40SWITCH'] = {
                label = 'Glock 40 w/ Switch (10mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GLOCK19TAN'] = {
                label = 'Glock 19 (Tan) (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GLOCK26'] = {
                label = 'Glock 26 (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_YELLOWSWITCH'] = {
                label = 'Glock 18 Yellow Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_WHITESWITCH'] = {
                label = 'Glock 18 White Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SWPREDSWITCH'] = {
                label = 'Glock 18 Red Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_PURPLESWITCH'] = {
                label = 'Glock 18 Purple Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SWPPINKSWITCH'] = {
                label = 'Glock 18 Pink Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_ORANGESWITCH'] = {
                label = 'Glock 18 Orange Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GREENSWITCH'] = {
                label = 'Glock 18 Green Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GRAYSWITCH'] = {
                label = 'Glock 18 Gray Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_BLUESWITCH'] = {
                label = 'Glock 18 Blue Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_BLACKSWITCH'] = {
                label = 'Glock 18 Black Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_3DGLOCK'] = {
                label = 'Glock 3D Printed (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_BAGGLOCK'] = {
                label = 'Bagged Glock (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_G19BEAM'] = {
                label = 'Glock 19 w/ Beam (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_G22'] = {
                label = 'Glock 22 (22)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_G22B'] = {
                label = 'Glock 22 Binary (22)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_G43X'] = {
                label = 'Glock 43x (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GHOSTG30'] = {
                label = 'Glock 30 Ghost (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GP80C'] = {
                label = 'Glock P80 Switch (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_TANGLOCK'] = {
                label = 'Glock 17 Tan (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_UGLOCK'] = {
                label = 'Glock Unauthorized (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_T247'] = {
                label = 'Taurus 247 (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_PTX22'] = {
                label = 'Taurus TX22 Pink (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_FN57B'] = {
                label = 'FN-57 Binary (5.7)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_FN509HUNT'] = {
                label = 'FN-509 (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_357SNUB'] = {
                label = 'S&W .357 Snubnose (.357)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SW357'] = {
                label = 'S&W .357 (.357)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SWMP9'] = {
                label = 'S&W M&P9 (9mm)',
                licensedPrice = 250000,
                minimumPrice = 25000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },
        },

        ['SMGs'] = {
            ['WEAPON_YAKUZASMG'] = {
                label = 'Dragon SMG (9mm)',
                licensedPrice = 350000,
                minimumPrice = 50000,
                requiredMunitions = 50,
                minCraft = 1,
                maxCraft = 3,
            },
            ['WEAPON_KOIFISH'] = {
                label = 'Koi SMG (9mm)',
                licensedPrice = 350000,
                minimumPrice = 50000,
                requiredMunitions = 50,
                minCraft = 1,
                maxCraft = 3,
            },
            ['WEAPON_MP5C'] = {
                label = 'MP5-CQC (45)',
                licensedPrice = 350000,
                minimumPrice = 50000,
                requiredMunitions = 50,
                minCraft = 1,
                maxCraft = 3,
            },
            ['WEAPON_SCORPIONX9'] = {
                label = 'Scorpion X9 Evo (9mm)',
                licensedPrice = 350000,
                minimumPrice = 50000,
                requiredMunitions = 50,
                minCraft = 1,
                maxCraft = 3,
            },
        },

        ['Melees'] = {
            ['WEAPON_CANDYAXE'] = {
                label = 'Candy Axe',
                licensedPrice = 1000000,
                minimumPrice = 500000,
                requiredMunitions = 500,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_FIREAXE'] = {
                label = 'Fire Axe',
                licensedPrice = 1000000,
                minimumPrice = 500000,
                requiredMunitions = 500,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SHOVEL'] = {
                label = 'Rusty Shovel',
                licensedPrice = 1000000,
                minimumPrice = 500000,
                requiredMunitions = 500,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_OPPSLUGGER'] = {
                label = 'OPP Slugger Bat',
                licensedPrice = 1000000,
                minimumPrice = 500000,
                requiredMunitions = 500,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SCREWD'] = {
                label = 'Rusty Screwdriver',
                licensedPrice = 1000000,
                minimumPrice = 500000,
                requiredMunitions = 500,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_SLEDGEH'] = {
                label = 'Sledgehammer',
                licensedPrice = 1000000,
                minimumPrice = 500000,
                requiredMunitions = 500,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_WOODAXE'] = {
                label = 'Wood Axe',
                licensedPrice = 1000000,
                minimumPrice = 500000,
                requiredMunitions = 500,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_BLACKKNIFE'] = {
                label = 'Knife (Black)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_BLUEKNIFE'] = {
                label = 'Knife (Blue)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GRAYKNIFE'] = {
                label = 'Knife (Gray)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_GREENKNIFE'] = {
                label = 'Knife (Green)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_ORANGEKNIFE'] = {
                label = 'Knife (Orange)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_PINKKNIFE'] = {
                label = 'Knife (Pink)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_PURPLEKNIFE'] = {
                label = 'Knife (Purple)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_REDKNIFE'] = {
                label = 'Knife (Red)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_WHITEKNIFE'] = {
                label = 'Knife (White)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },

            ['WEAPON_YELLOWKNIFE'] = {
                label = 'Knife (Yellow)',
                licensedPrice = 1000000,
                minimumPrice = 300000,
                requiredMunitions = 300,
                minCraft = 1,
                maxCraft = 3,
            },
        },

        ['Shotguns'] = {
            ['WEAPON_STREETSWEEP'] = {
                label = 'Streetsweeper (12 Gauge)',
                licensedPrice = 200000,
                minimumPrice = 50000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },
            ['WEAPON_R580'] = {
                label = 'Remington 580 (12 Gauge)',
                licensedPrice = 200000,
                minimumPrice = 50000,
                requiredMunitions = 25,
                minCraft = 1,
                maxCraft = 3,
            },
        },
    },
}

Locales = {
    ['Titles'] = {
        ['TITLE_GENERAL'] = 'Ammunation',
        ['TITLE_SALE_COMPLETED'] = 'Sale Completed',
        ['TITLE_PRODUCT_MANAGER'] = 'Product Manager',
        ['TITLE_MUNITIONS_SHIPMENT'] = 'Munitions Shipment',
        ['TITLE_POINT_MANAGER'] = 'Point Manager',
        ['TITLE_EMPLOYEE'] = 'Employee',
        ['TITLE_GUNSHOP_CREATOR'] = 'Shop Creator',
        ['TITLE_ERROR'] = 'Error',
        ['TITLE_SUCCESS'] = 'Success',
        ['TITLE_MANAGER_EMPLOYEE'] = 'Employee Manager',
        ['TITLE_FINANCE_MANAGER'] = "Finance Manager",
    },

    ['Notification'] = {
        ['NOFICATION_SALE_COMPLETED'] = 'Your purchase at %s was completed successfully!',
        ['NOTIFICATION_PRODUCT_PRICE_UPDATED'] = "Product price has been updated successfully!",
        ['NOTIFICATION_PRODUCT_REMOVED'] = "Product has been removed successfully!",
        ['NOTIFICATION_PRODUCT_REMOVED_FAIL'] = "Failed to remove product!",
        ['NOTIFICATION_POINT_CREATED'] = "Point has been created successfully!",
        ['NOTIFICATION_POINT_DELETED'] = "Point has been deleted successfully!",
        ['NOTIFICATION_MUNITIONS_ORDERED'] = "Munitions shipment has been ordered successfully! it is available immediately.",
        ['NOTIFICATION_CRAFTED'] = "You have crafted %sx %s!",
        ['NOTIFICATION_INSUFFICIENT_MUNITIONS'] = "You don't have enough munitions to craft this weapon!",
        ['NOTIFICATION_STOCK_FAILED_FETCH'] = "Failed to fetch stock, please add products to your stock via product manager.",
        ['NOTIFICATION_CLOCKIN_REQUIRED'] = "You must clock in first!",
        ['NOTIFICATION_CLOCKED_IN'] = "You have clocked in!",
        ['NOTIFICATION_CLOCKED_OUT'] = "You have clocked out!",
        ['NOTIFICATION_GUNSHOP_CREATED'] = "Successfully created %s as a weapon shop!",
        ['NOTIFICATION_SAVED_POINT'] = "Successfully saved %s point!",
        ['NOTIFICATION_PLAYER_NOT_FOUND'] = "Player not found!",
        ['NOTIFICATION_BALANCE_INSUFFICIENT'] = "You do not have enough money to purchase these items!",
        ['NOTIFICATION_STOCK_INSUFFICIENT'] = "Not enough stock or failed to update store stock.",
        ['NOTIFICATION_TRANSACTION_ROLLED_BACK'] = "Failed to add items to your inventory. Transaction rolled back.",
        ['NOTIFICATION_PRICE_BELOW_MIN'] = "Price is below the minimum price limit.",
        ['NOTIFICATION_PRICE_SAME'] = "Price is the same as the current price.",
        ['NOTIFICATION_PRICE_UPDATE_FAIL'] = "Failed to update product price.",
        ['NOTIFICATION_POINT_CREATE_FAIL'] = "Failed to create point.",
        ['NOTIFICATION_POINT_DELETE_FAIL'] = "Failed to delete point.",
        ['NOTIFICATION_VAULT_INSUFFICIENT'] = "This shop does not have enough money in its vault to order this amount of munitions.",
        ['NOTIFICATION_STORAGE_INSUFFICIENT'] = "This shop does not have enough space to order this amount of munitions.",
        ['NOTIFICATION_AUTHORIZED'] = "You are not authorized to perform this action.",
        ['NOTIFICATION_WEAPON_INVALID_DATA'] = "Invalid weapon data provided.",
        ['NOTIFICATION_SHOP_FINANCE_FAILED'] = "Failed to fetch shop finance data.",
        ['NOTIFICATION_SHOP_VAULT_INSUFFICIENT'] = "This shop does not have enough money in its vault to order this amount of munitions.",
        ['NOTIFICATION_WEAPON_ALREADY_EXISTS'] = "This weapon is already in the database under %ss.",
        ['NOTIFICATION_WEAPON_ADDED_SUCCESS'] = "Weapon added successfully to %ss.",
        ['NOTIFICATION_PROMPT_ACCEPTED'] = "%s has accepted your hire request! (%s)",
        ['NOTIFICATION_PROMPT_REJECTED'] = "%s has rejected your hire request!",
        ['NOTIFICATION_PROMP_HIRED'] = "You were hired to %s (%s)",
        ['NOTIFICATION_JOB_POS_CHANGED'] = "Your position has been set to %s!",
        ['NOTIFICATION_JOB_SET_PLAYER'] = "Successfully set %s to %s!",
        ['NOTIFICATION_JOB_FIRED'] = "Successfully fired %s!",
        ['NOTIFICATION_PLAYER_NOT_EXISTS'] = "Player does not exist in-game.",
        ['NOTIFICATION_PLAYER_ALREADY_HIRED'] = "This player is already hired!",
        ['NOTIFICATION_INVALID_NUMBER'] = "Invalid number received.",
        ['NOTIFICATION_BALANCE_WITHDRAW_FAILED'] = "Failed to withdraw; you don't have enough money to do this action.",
        ['NOTIFICATION_BALANCE_DEPO_SUCCESS'] = "You have successfully deposited $%s into this business!",
        ['NOTIFICATION_WITHDRAW_FAILED_FETCH'] = "Failed to withdraw; could not fetch finances.",
        ['NOTIFICATION_WITHDRAW_SUCCESS'] = "You have successfully withdrew $%s from this business!",
        ['NOTIFICATION_FAILED_FETCH_MUNITION'] = "Failed to fetch munitions.",
        ['NOTIFICATION_INSUFFICIENT_MUNITIONS_SHOP'] = "There are not enough munitions in stock.",
        ['NOTIFICATION_UPDATE_MUNITIONS_SUCCESS'] = "Successfully updated munitions for shop: %s",
        ['NOTIFICATION_STORE_DELETED'] = "Store succesfully deleted!",
        ['NOTIFICATION_STORE_DELETED_FAIL'] = "Failed to delete store; contact a developer.",
        ['NOTIFICATION_STORE_LOCATION_UPDATE'] = "Store location succesfully updated!",
        ['NOTIFICATION_SHOPID_INVALID'] = "Shop ID can only contain letters and underscores. No numbers, spaces, or special characters allowed.",
        ['NOTIFICATION_SHOPID_EXISTS'] = "This weaponshop already exists.",
        ['NOTIFICATION_SHOP_DOESNT_EXIST'] = "No shops exist in the database.",
        ['NOTIFICATION_TOO_FAR'] = 'You cannot create a point further than 35 meters from your start location.',
    },

    ['Text UI'] = {
        ['TEXT_CLOCK_IN'] = "Clock In",
        ['TEXT_CLOCK_OUT'] = "Clock Out",
        ['TEXT_OPEN_SHOP'] = "Open Gun Shop"
    },

    ['Other'] = {
        ['NEW_SHOP_POINT'] = "New Shop Point",
        ['GENERAL_POINT'] = "Point",
        ['GENERAL_POINT_NAME'] = "New %s Point"
    }
}

RegisterNetEvent('spoodyAmmunation:notify', function(title, message, type)
    return Configuration.Notify(title, message, type)
end)