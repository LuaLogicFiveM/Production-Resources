if not Config.Shells.FuryV2 then return end

CreateThread(function()
    local FuryV2 = {
        ["Fury Shell 1 Furnished"] = {
            label = "Fury Shell 1 Furnished",
            hash = `fury_shell01_f`,
            doorOffset = { x = 8.809814, y = 8.144440, z = 0.990875, h = 87.791367, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/a/d/6/7/ad6706ce0cfcbf12b8fa7fa92ac1881c44819bb3.jpeg",
                    label = "Shell 1",
                },
            },
        },

        ["Fury Shell 2 Furnished"] = {
            label = "Fury Shell 2 Furnished",
            hash = `fury_shell02_f`,
            doorOffset = { x = 8.916016, y = 8.209061, z = 0.989899, h = 90.667175, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/6/7/5/9/6759f3d8faac749a7cda1a5e7dc5a76d43fd14d7.jpeg",
                    label = "Shell 2",
                },
            },
        },

        ["Fury Shell 3 Furnished"] = {
            label = "Fury Shell 3 Furnished",
            hash = `fury_shell03_f`,
            doorOffset = { x = 8.804443, y = 8.178101, z = 0.990295, h = 87.540482, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/b/7/4/0/b740f7b76d9399415971477ad4639c5de33599bd.jpeg",
                    label = "Shell 3",
                },
            },
        },

        ["Fury Shell 4 Furnished"] = {
            label = "Fury Shell 4 Furnished",
            hash = `fury_shell04_f`,
            doorOffset = { x = 5.102051, y = -1.212967, z = 1.000336, h = 182.082703, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/1/e/1/7/1e1701a1e6c975f390106855af033d4723e06f52.jpeg",
                    label = "Shell 4",
                },
            },
        },

        ["Fury Shell 5 Furnished"] = {
            label = "Fury Shell 5 Furnished",
            hash = `fury_shell05_f`,
            doorOffset = { x = -1.351562, y = -4.718552, z = 0.999847, h = 359.413879, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/6/b/f/8/6bf8532ce4e4b9a1cbec13a63fd9365cbea21d72.jpeg",
                    label = "Shell 5",
                },
            },
        },

        ["Fury Shell 1 Unfurnished"] = {
            label = "Fury Shell 1 Unfurnished",
            hash = `fury_shell01_u`,
            doorOffset = { x = 8.809814, y = 8.144440, z = 0.990875, h = 87.791367, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/a/d/6/7/ad6706ce0cfcbf12b8fa7fa92ac1881c44819bb3.jpeg",
                    label = "Shell 1",
                },
            },
        },

        ["Fury Shell 2 Unfurnished"] = {
            label = "Fury Shell 2 Unfurnished",
            hash = `fury_shell02_u`,
            doorOffset = { x = 8.916016, y = 8.209061, z = 0.989899, h = 90.667175, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/6/7/5/9/6759f3d8faac749a7cda1a5e7dc5a76d43fd14d7.jpeg",
                    label = "Shell 2",
                },
            },
        },

        ["Fury Shell 3 Unfurnished"] = {
            label = "Fury Shell 3 Unfurnished",
            hash = `fury_shell03_u`,
            doorOffset = { x = 8.804443, y = 8.178101, z = 0.990295, h = 87.540482, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/b/7/4/0/b740f7b76d9399415971477ad4639c5de33599bd.jpeg",
                    label = "Shell 3",
                },
            },
        },

        ["Fury Shell 4 Unfurnished"] = {
            label = "Fury Shell 4 Unfurnished",
            hash = `fury_shell04_u`,
            doorOffset = { x = 5.102051, y = -1.212967, z = 1.000336, h = 182.082703, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/1/e/1/7/1e1701a1e6c975f390106855af033d4723e06f52.jpeg",
                    label = "Shell 4",
                },
            },
        },

        ["Fury Shell 5 Unfurnished"] = {
            label = "Fury Shell 5 Unfurnished",
            hash = `fury_shell05_u`,
            doorOffset = { x = -1.351562, y = -4.718552, z = 0.999847, h = 359.413879, width = 2.0 },
            stash = {
                maxweight = 500000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://forum-cfx-re.akamaized.net/original/5X/6/b/f/8/6bf8532ce4e4b9a1cbec13a63fd9365cbea21d72.jpeg",
                    label = "Shell 5",
                },
            },
        },
    }

    InsertInteriors(FuryV2, "Fury V2 Shells")
end)
