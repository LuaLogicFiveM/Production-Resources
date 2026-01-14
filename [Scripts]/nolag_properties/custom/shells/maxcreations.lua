if not Config.Shells.MaxCreations then return end

CreateThread(function()
    local MaxCreations = {
        ["Max Creations"] = {
            label = "Max Creations Small",
            hash = `maxcreations_small`,
            doorOffset = { x = 2.5, y = 3, z = -1.5, h = 1.2633972168, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/rgla5mwk0zi1.jpg",
                },
            }
        },

        ["Max Creations 2"] = {
            label = "Max Creations 2",
            hash = `maxcreations_mediumend`,
            doorOffset = { x = 3.25, y = -2.951171875, z = -0.7, h = 3.2633972168, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/riwdkpfz02yz.jpg",
                },
            }
        },

        ["Max Creations 3"] = {
            label = "Max Creations 3",
            hash = `max_villa2`,
            doorOffset = { x = 4.25101, y = -11.901171875, z = -3.5, h = 2.2633972168, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/0bor93funrao.jpg",
                },
            }
        },

        ["Max Creations 4"] = {
            label = "Max Creations 4",
            hash = `small_house1`,
            doorOffset = { x = 2.5, y = 7, z = -1.9, h = 1.2633972168, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/n4cu6yz6b8sm.jpg",
                },
            }
        },

        ["Max Creations 5"] = {
            label = "Max Creations 5",
            hash = `lc_appartment`,
            doorOffset = { x = 0.5, y = -5.8, z = -3.1, h = 1.2633972168, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/zb72z0fof2ya.jpg",
                },
            }
        },

        ["Max Creations 6"] = {
            label = "Max Creations 6",
            hash = `furnished_shell`,
            doorOffset = { x = -2.2510, y = 6.501171875, z = 2.3, h = -2.2633972168, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/zreppdy4lfmf.jpg",
                },
            }
        },

        ["Max Creations 7"] = {
            label = "Max Creations 7",
            hash = `max_luxury_apartv2uf`,
            doorOffset = { x = -10.704, y = 1.84, z = 0.77, h = -2.2633972168, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/zzl3m5oa8fx3.jpg",
                },
            }
        },

        ["Max Creations 8"] = {
            label = "Max Creations 8",
            hash = `shell_mansion1`,
            doorOffset = { x = -1.62, y = 16.379, z = -4.058, h = 176.11, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/8xzni4tx08x9.jpg",
                },
            }
        },

        ["Max Creations 9"] = {
            label = "Max Creations 9",
            hash = `shell_apart1`,
            doorOffset = { x = 3.499, y = -7.409, z = 5.23, h = 82.54, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/1ff7dwc2fxkd.jpg",
                },
            }
        },

        ["Max Creations 10"] = {
            label = "Max Creations 10",
            hash = `shell_apart2`,
            doorOffset = { x = -2.641, y = 1.298, z = -0.762, h = 273.08, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/47xvly8rq4cd.jpg",
                },
            }
        },

        ["Max Creations 11"] = {
            label = "Max Creations 11",
            hash = `shell_apart3`,
            doorOffset = { x = 7.346, y = -1.307, z = 1.105, h = -2.2633972168, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/02rlx3ig51a3.jpg",
                },
            }
        },

        ["Max Creations 12"] = {
            label = "Max Creations 12",
            hash = `shell_modernapart`,
            doorOffset = { x = -6.453, y = 0.918, z = -1.831, h = 277.76, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/hzq4ihxnlpiw.jpg",
                },
            }
        },

        ["Max Creations 13"] = {
            label = "Max Creations 13",
            hash = `unfurnished_shell`,
            doorOffset = { x = -2.2510, y = 6.501171875, z = 2.3, h = -2.26, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/k3opjk5jfl6w.jpg",
                },
            }
        },

        ["Max Creations 14"] = {
            label = "Max Creations 14",
            hash = `lc_appartmentuf`,
            doorOffset = { x = 0.5, y = -5.8, z = -3.5, h = 1.2, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/ax5caojteb6w.jpg",
                },
            }
        },

        ["Max Creations 15"] = {
            label = "Max Creations 15",
            hash = `newunfurnished_shell`,
            doorOffset = { x = -16.9395, y = -6.023, z = 1.60818, h = 1.6, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/xjhy2pxxp537.jpg",
                },
            }
        },

        ["Max Creations 16"] = {
            label = "Max Creations 16",
            hash = `max_row_houseuf`,
            doorOffset = { x = -2.656, y = -6.83, z = 0.4, h = 1.26, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/yhx097ejbd21.jpg",
                },
            }
        },

        ["Max Creations 17"] = {
            label = "Max Creations 17",
            hash = `loft_shell1uf`,
            doorOffset = { x = -1.26084, y = 9.1032, z = 0.89618, h = 1.26, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/6r8k4xw912p2.jpg",
                },
            }
        },

        ["Max Creations 18"] = {
            label = "Max Creations 18",
            hash = `customloft_shell2uf`,
            doorOffset = { x = 2.06385, y = -6.15805, z = 0.702925, h = 1.26, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/pub/o52c656nnsg8.jpg",
                },
            }
        },

        ["Max Creations 19"] = {
            label = "Max Creations 19",
            hash = `max_row_houseuf`,
            doorOffset = { x = -2.499390, y = -7.218018, z = 0.556862, h = 6.384526, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/dACzXNE1bFuq.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/VRePAQ9XPPJJ.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/RSsaLfK2dkVw.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/2FIgMg7pCjo5.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/psK7yWgSJWNv.jpg",
                },
            }
        },

        ["Max Creations 20"] = {
            label = "Max Creations 20",
            hash = `shell_apart1`,
            doorOffset = { x = 3.420105, y = -7.515869, z = 5.299816, h = 92.331207, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/L3PMOeJUUc5Q.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/mY0iljwlygXu.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/iiBegADRAwWC.jpg",
                },
            }
        },

        ["Max Creations 21"] = {
            label = "Max Creations 21",
            hash = `shell_apart2`,
            doorOffset = { x = -2.770691, y = 1.247314, z = -0.475285, h = 277.447754, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/o3m0QEWh28wv.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/QL7k3UBdahZt.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/Bur7utTH99Os.jpg",
                },
            }
        },

        ["Max Creations 22"] = {
            label = "Max Creations 22",
            hash = `shell_apart3`,
            doorOffset = { x = 7.430542, y = -1.196533, z = 1.312153, h = 0.999760, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/lJU3hP01oxxM.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/jul8fiA6MXV5.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/EHmJhhmagyDR.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/taca8UoaCT5w.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/Gmpg9R51QMi5.jpg",
                },
            }
        },

        ["Max Creations 23"] = {
            label = "Max Creations 23",
            hash = `max_luxury_apartv2`,
            doorOffset = { x = -10.602173, y = 1.983154, z = 0.517056, h = 18.585056, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/MtH5TT47wLnR.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/E4T5wdKNjhZ2.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/tNDHqMuYYQhB.jpg",
                },
                {
                    url = "https://r2.fivemanage.com/images/TNXaUCQgctDL.jpg",
                },
            }
        },
    }

    InsertInteriors(MaxCreations, "MaxCreations")
end)
