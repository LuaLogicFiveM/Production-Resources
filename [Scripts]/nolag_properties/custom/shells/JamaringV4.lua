if not Config.Shells.JamaringV4 then return end

CreateThread(function()
    local JamaringV4 = {
        ['jamaring_v4_1_dark'] = {
            label = 'jamaring_v4_1_dark',
            hash = `jamaring_v4_1_dark`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/1d.png',
                },
            }
        },

        ['jamaring_v4_1_light'] = {
            label = 'jamaring_v4_1_light',
            hash = `jamaring_v4_1_light`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/1b.png',
                },
            }
        },

        ['jamaring_v4_2_dark'] = {
            label = 'jamaring_v4_2_dark',
            hash = `jamaring_v4_2_dark`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/2d.png',
                },
            }
        },

        ['jamaring_v4_2_light'] = {
            label = 'jamaring_v4_2_light',
            hash = `jamaring_v4_2_light`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/2a.png',
                },
            }
        },

        ['jamaring_v4_3_dark'] = {
            label = 'jamaring_v4_3_dark',
            hash = `jamaring_v4_3_dark`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/3c.png',
                },

            }
        },

        ['jamaring_v4_3_light'] = {
            label = 'jamaring_v4_3_light',
            hash = `jamaring_v4_3_light`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/3b.png',
                },
            }
        },

        ['jamaring_v4_4_dark'] = {
            label = 'jamaring_v4_4_dark',
            hash = `jamaring_v4_4_dark`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/4d.png',
                },
            }
        },

        ['jamaring_v4_4_light'] = {
            label = 'jamaring_v4_4_light',
            hash = `jamaring_v4_4_light`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 0.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/4a.png',
                },

            }
        },

        ['jamaring_v4_5_dark'] = {
            label = 'jamaring_v4_5_dark',
            hash = `jamaring_v4_5_dark`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/5d.png',
                },

            }
        },

        ['jamaring_v4_5_light'] = {
            label = 'jamaring_v4_5_light',
            hash = `jamaring_v4_5_light`,
            doorOffset = { x = 0.0, y = 0.0, z = 0.0, h = 180.0, width = 2.0 },
            stash = {
                maxweight = 8000000,
                slots = 120,
            },
            imgs = {
                {
                    url = 'https://r2.fivemanage.com/NmXl928isHcRzikCZxrdo/5b.png',
                },
            }
        },
    }

    InsertInteriors(JamaringV4, "Jamaring V4")
end)
