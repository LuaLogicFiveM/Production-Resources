if not Config.Shells.EnviShells then return end

CreateThread(function()
    local EnviStarterShell = {
        ["envi_shell_01_empty"] = {
            label = "envi_shell_01_empty",
            hash = `envi_shell_01_empty`,
            doorOffset = { x = 0.558014, y = 0.334473, z = -0.137978, h = 182.922058, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/ZngkezOOkpjh.png",
                },
                {
                    url = "https://r2.fivemanage.com/images/3MZp6FETGgqi.png",
                },
            }
        },

        ["envi_shell_01_furnished"] = {
            label = "envi_shell_01_furnished",
            hash = `envi_shell_01_furnished`,
            doorOffset = { x = 0.645004, y = 0.374390, z = -0.138672, h = 178.034500, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://i.fmfile.com/acP9u7gLziIbHCwCT6NVX/FiveM_b3095_GTAProcess_CxtnIljUTO.webp",
                },
                {
                    url = "https://i.fmfile.com/acP9u7gLziIbHCwCT6NVX/FiveM_b3095_GTAProcess_Ef0WrMccis.webp",
                },
                {
                    url = "https://i.fmfile.com/acP9u7gLziIbHCwCT6NVX/FiveM_b3095_GTAProcess_OJBHlNOqYe.webp",
                },
                {
                    url = "https://i.fmfile.com/acP9u7gLziIbHCwCT6NVX/FiveM_b3095_GTAProcess_C8r8pOBJqT.webp",
                },
                {
                    url = "https://i.fmfile.com/acP9u7gLziIbHCwCT6NVX/FiveM_b3095_GTAProcess_bkvov0nljk.webp",
                },
            }
        },

        ["envi_shell_02_empty"] = {
            label = "envi_shell_02_empty",
            hash = `envi_shell_02_empty`,
            doorOffset = { x = 0.033615, y = -10.830933, z = 1.028763, h = 180.285309, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/gKI16BwCSxh4.png",
                },
            }
        },

        ["envi_shell_02_furnished"] = {
            label = "envi_shell_02_furnished",
            hash = `envi_shell_02_furnished`,
            doorOffset = { x = 0.062836, y = -11.282349, z = 1.035652, h = 189.682327, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/KypFkSVYrTle.png",
                },
            }
        },

        ["envi_shell_03_empty"] = {
            label = "envi_shell_03_empty",
            hash = `envi_shell_03_empty`,
            doorOffset = { x = 5.040665, y = -6.923462, z = 1.182632, h = 265.386353, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/bxPoWekvnct6.png",
                },
            }
        },

        ["envi_shell_03_furnished"] = {
            label = "envi_shell_03_furnished",
            hash = `envi_shell_03_furnished`,
            doorOffset = { x = 5.074585, y = 1.100098, z = 1.184517, h = 266.767059, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 120,
            },
            imgs = {
                {
                    url = "https://r2.fivemanage.com/images/jFyCZixN3CcZ.png",
                },
            }
        },
    }

    InsertInteriors(EnviStarterShell, "EnviStarter")
end)
