Config.Interactions = {
    fryer = {
        oil = {
            label = Translate("pour_oil_fryer"),
            icon = "fas fa-droplet",
            distance = 2.0,
            items = {"sunflower_oil"}
        },
        throw_oil = {
            label = Translate("throw_away_oil"),
            icon = "fas fa-droplet",
            distance = 2.0,
        },
        cooking = {
            label = Translate("place_item"),
            icon = "fas fa-fire-burner",
            distance = 2.0,
        },
        store = {
            label = Translate("store_fryer") or "Store",
            icon = "fas fa-box-archive",
            distance = 2.0,
        },
    },
    fryer_basket = {
        content = {
            label = Translate("pour_frozen_fries") or "Pour frozen fries",
            icon = "fas fa-snowflake",
            distance = 2.0,
            items = {"frozen_fries"}
        },
        pour_falafels = {
            label = Translate("pour_falafels") or "Pour falafels",
            icon = "fas fa-snowflake",
            distance = 2.0,
            items = {"frozen_falafels"}
        }
    },
    table_fries = {
        box = {
            label = Translate("table_fries_insert_fries") or "Insert Fries",
            icon = "fas fa-box",
            distance = 2.0,  
        },
        refill = {
            label = Translate("refill_fries_shovel") or "Pick Fries",
            icon = "fas fa-hand",
            distance = 2.0,
        },
        paper = {
            label = Translate("drop_fries_on_table") or "Drop Fries",
            icon = "fas fa-arrow-down",
            distance = 2.0,
        },
        paper_clear = {
            label = Translate("trash_fries_from_table") or "Trash Fries",
            icon = "fas fa-trash",
            distance = 2.0,
        },
        store = {
            label = Translate("put_down_shovel") or "Put down",
            icon = "fas fa-hand",
            distance = 2.0,
        }
    },
    table_burger = {
        start = {
            label = Translate("start_hamburger") or "Start hamburger creation",
            icon = "fa-solid fa-hamburger",
            distance = 3.0,
        },
        cancel = {
            label = Translate("cancel_hamburger") or "Cancel hamburger creation",
            icon = "fa-solid fa-trash",
            distance = 3.0,
        },
        finish = {
            label = Translate("finish_hamburger") or "Finish hamburger creation",
            icon = "fa-solid fa-check",
            distance = 3.0,
        },
        add_patty = {
            label = Translate("add_patty_on_hamburger") or "Add patty",
            icon = "fa-solid fa-minus",
            distance = 3.0,
        },
        add_base = {
            label = Translate("add_bread_on_hamburger") or "Add bread bottom",
            icon = "fa-solid fa-hamburger",
            distance = 3.0,
        }
    },
    griddle = {
        cooking = {
            label = Translate("place_item") or "Place",
            icon = "fas fa-fire-burner",
            distance = 2.0,
        }, 
    },
    bin = {
        trash = {
            label = Translate("bin_trash_item") or "Trash",
            icon = "fas fa-trash",
            distance = 2.0,
        }
    },
    littlecontainers = {
        salad = {
            label = Translate("add_lettuce_hamburger") or "Add lettuce",
            icon = "fas fa-leaf",
            allowed_items = {"lettuce"}
        },
        tomatoes = {
            label = Translate("add_tomatoes_hamburger") or "Add tomatoes",
            icon = "fa-regular fa-circle",
            allowed_items = {"tomato"}
        },
        cheddar = {
            label = Translate("add_cheddar_hamburger") or "Add cheddar",
            icon = "fas fa-cheese",
            allowed_items = {"cheddar"}
        },
        pickles = {
            label = Translate("add_pickles_hamburger") or "Add pickles",
            icon = "fas fa-wand-magic",
            allowed_items = {"pickle"}
        },
        onions = {
            label = Translate("add_onions_hamburger") or "Add onions",
            icon = "fas fa-tablets",
            allowed_items = {"onion"}
        },
        bacon = {
            label = Translate("add_bacon_hamburger") or "Add bacon",
            icon = "fas fa-bacon",
            allowed_items = {"bacon"}
        },

        ketchup = {
            label = Translate("add_ketchup_hamburger") or "Add ketchup",
            icon = "fas fa-splotch",
            allowed_items = {"ketchup"}
        },
        mayonnaise = {
            label = Translate("add_mayonnaise_hamburger") or "Add mayonnaise",
            icon = "fas fa-splotch",
            allowed_items = {"mayonnaise"}
        },
    },
    containers = {
        meat = {
            label = Translate("containers_take_patty") or "Take patty",
            icon = "fas fa-minus",
            allowed_items = {"patty"}
        }
    },

    shared = {
        pickup = {
            label = Translate("pickup_general") or "Pickup",
            icon = "fas fa-hand",
            distance = 2.0,
        },
        put_down = {
            label = Translate("put_down_general") or "Put down",
            icon = "fas fa-hand",
            distance = 2.0,
        },
        toggle_door = {
            label = Translate("toggle_door") or "Toggle door",
            icon = "fas fa-door-closed",
            distance = 2.0,
        },

        openInventory = {
            label = Translate("open_inventory") or "Open inventory",
            icon = "fas fa-box-open",
            distance = 2.0,
        }
    },

    expansions = {},
}