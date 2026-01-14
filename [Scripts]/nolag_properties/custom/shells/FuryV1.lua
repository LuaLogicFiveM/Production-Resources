if not Config.Shells.FuryV1 then return end

CreateThread(function()
    local FuryV1 = {
        ["Loft Apartment"] = {
            label = "Loft Apartment",
            hash = `loft_shell`,
            doorOffset = { x = 2.10, y = -8.57, z = 0.8, h = 359.88, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/7882adac600f386c3bf2d13ceb889682f635a4f0.png",
                    label = "Loft Apartment",
                },
            },
        },

        ["Skyview Loft Unfurnished"] = {
            label = "Skyview Loft Unfurnished",
            hash = `skyview_shell_u`,
            doorOffset = { x = 7.51, y = 3.38, z = 0.61, h = 177.18, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/ec77392ceab7c66a78e7985559071ca9044794bf.png",
                    label = "Skyview Apartment",
                },
            },
        },

        ["Skyview Loft Furnished"] = {
            label = "Skyview Loft Furnished",
            hash = `skyview_shell_f`,
            doorOffset = { x = 7.51, y = 3.38, z = 0.61, h = 177.18, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/ec77392ceab7c66a78e7985559071ca9044794bf.png",
                    label = "Skyview Apartment",
                },
            },
        },

        ["Cozy Shell Unfurnished"] = {
            label = "Cozy Shell Unfurnished",
            hash = `cozy_shell_u`,
            doorOffset = { x = 2.23, y = -8.37, z = 0.72, h = 2.02, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/71953a3c3787cf0104256c1340c9272744a1f8ae.png",
                    label = "Cozy Apartment",
                },
            },
        },

        ["Cozy Shell Furnished"] = {
            label = "Cozy Shell Furnished",
            hash = `cozy_shell_f`,
            doorOffset = { x = 2.23, y = -8.37, z = 0.72, h = 2.02, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/71953a3c3787cf0104256c1340c9272744a1f8ae.png",
                    label = "Cozy Apartment",
                },
            },
        },

        ["Japanese Loft Unfurnished"] = {
            label = "Japanese Loft Unfurnished",
            hash = `jap_shell_u`,
            doorOffset = { x = 5.15, y = 0.86, z = 0.82, h = 93.2, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/9bdf99bfd0beee86868639a74d5eaf02188e117f.png",
                    label = "Japanese Apartment",
                },
            },
        },

        ["Japanese Loft Furnished"] = {
            label = "Japanese Loft Furnished",
            hash = `jap_shell_f`,
            doorOffset = { x = 5.155713, y = 0.86, z = 0.82, h = 93.2, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/9bdf99bfd0beee86868639a74d5eaf02188e117f.png",
                    label = "Japanese Apartment",
                },
            },
        },

        ["Starter Apartment Unfurnished"] = {
            label = "Starter Apartment Unfurnished",
            hash = `starter_shell_u`,
            doorOffset = { x = 3.72, y = -4.16, z = 1.01, h = 357.59, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/ded3c4b6b3663ef335597b351e7700256c98ff80.png",
                    label = "Starter Apartment",
                },
            },
        },

        ["Starter Apartment Furnished"] = {
            label = "Starter Apartment Furnished",
            hash = `starter_shell_f`,
            doorOffset = { x = 3.72, y = -4.16, z = 1.01, h = 357.59, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/ded3c4b6b3663ef335597b351e7700256c98ff80.png",
                    label = "Starter Apartment",
                },
            },
        },

        ["MidTier Apartment Unfurnished"] = {
            label = "MidTier Apartment Unfurnished",
            hash = `midshell1_u`,
            doorOffset = { x = 4.09, y = -3.6, z = 1.05, h = 270.40, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/e92a2e448842b521c01f42472ff46440c9545002.png",
                    label = "Midtier Apartment",
                },
            },
        },

        ["MidTier Apartment Furnished"] = {
            label = "MidTier Apartment Furnished",
            hash = `midshell1_f`,
            doorOffset = { x = 4.09, y = -3.6, z = 1.05, h = 270.40, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/e92a2e448842b521c01f42472ff46440c9545002.png",
                    label = "Midtier Apartment",
                },
            },
        },

        ["Midland Apartment Unfurnished"] = {
            label = "Midland Apartment Unfurnished",
            hash = `midshell2_u`,
            doorOffset = { x = 6.98, y = -7.96, z = 1.01, h = 3.11, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/3d8be62126fb789ec2b9c4109debbed6cdfba31f.png",
                    label = "Midland Apartment",
                },
            },
        },

        ["Midland Apartment Furnished"] = {
            label = "Midland Apartment Furnished",
            hash = `midshell2_f`,
            doorOffset = { x = 6.98, y = -7.96, z = 1.01, h = 3.11, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/3d8be62126fb789ec2b9c4109debbed6cdfba31f.png",
                    label = "Midland Apartment",
                },
            },
        },

        ["High-End Mansion 1"] = {
            label = "High-End Mansion 1",
            hash = `fury_shell04`,
            doorOffset = { x = -17.11, y = -6.05, z = 2.81, h = 271.89, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/58e21b0125ceb144d42183cf20f373ac51f540b4.png",
                    label = "High End Mansion",
                },
            },
        },

        ["High-End Mansion 2"] = {
            label = "High-End Mansion 2",
            hash = `fury_shell06`,
            doorOffset = { x = -17.11, y = -5.97, z = 2.41, h = 269.74, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/59c9b38749a033478c4d18252d9e55d3f61c7b02.png",
                    label = "High End Mansion",
                },
            },
        },

        ["High-End Mansion 3"] = {
            label = "High-End Mansion 3",
            hash = `fury_shell09`,
            doorOffset = { x = -7.68, y = -1.11, z = 1.21, h = 178.80, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/d47c3661dba110aa16508d1d6c26a77d291b79df.png",
                    label = "High End Mansion",
                },
            },
        },

        ["High-End Mansion 4"] = {
            label = "High-End Mansion 4",
            hash = `fury_shell08`,
            doorOffset = { x = -14.29, y = -1.96, z = 7.21, h = 270.80, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/bc00e952d5d6834c678c82f0d02ff9d0140717ad.png",
                    label = "High End Mansion",
                },
            },
        },

        ["High-End Apartment 1"] = {
            label = "High-End Apartment 1",
            hash = `fury_shell07`,
            doorOffset = { x = -3.46, y = 18.03, z = 1.02, h = 181.74, width = 2.0 },
            stash = {
                maxweight = 200000,
                slots = 50,
            },
            imgs = {
                {
                    url = "https://dunb17ur4ymx4.cloudfront.net/wysiwyg/1221848/a7d1e0961697039047d09b3c8c9a57638f0555cb.png",
                    label = "High End Apartment",
                },
            },
        },
    }

    InsertInteriors(FuryV1, "Fury V1 Shells")
end)
