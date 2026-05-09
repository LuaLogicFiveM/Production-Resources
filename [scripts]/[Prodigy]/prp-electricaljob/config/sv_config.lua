Config = Config or {}

ElectricalBoxes = {}

local fileString = LoadResourceFile(GetCurrentResourceName(), "config/boxes.json")
if fileString then
    local boxes = json.decode(fileString)
    for k, v in pairs(boxes) do
        if Config.WhitelistedProps[v.Name] then
            table.insert(ElectricalBoxes, {
                model = joaat(v.Name),
                coords = vector3(v.Position.X, v.Position.Y, v.Position.Z),
            })
        end
    end

    -- ElectricalBoxes = boxes
end

Config.Minigame = {
    progTime = 5000,
    showTime = 1200,
    timesToDo = 1,
}

Config.Webhook = "" -- Webhook for logging electrical job completions

-- local x = 0;
-- RegisterCommand("good_box", function(source)
--     x = x + 1
--     print("Good box: " .. x .. " / "..(#ElectricalBoxes))

--     SetEntityCoords(GetPlayerPed(source), ElectricalBoxes[x].Position.X, ElectricalBoxes[x].Position.Y, ElectricalBoxes[x].Position.Z + 1.25)
-- end)

-- RegisterCommand("bad_box", function(source)
--     table.remove(ElectricalBoxes, x);
--     print("Bad box: " .. x .. " / "..(#ElectricalBoxes))

--     SaveResourceFile(GetCurrentResourceName(), "config/boxes.json", json.encode(ElectricalBoxes, { indent = true }), -1)

--     SetEntityCoords(GetPlayerPed(source), ElectricalBoxes[x].Position.X, ElectricalBoxes[x].Position.Y, ElectricalBoxes[x].Position.Z + 1.25)
-- end)

-- RegisterCommand("close_box", function(src, args)
--     local coords = GetEntityCoords(GetPlayerPed(src))

--     Wait(0)

--     print("call", coords)

--     table.sort(ElectricalBoxes, function(a, b)
--         return #(coords - a.coords) < #(coords - b.coords)
--     end)

--     local v = ElectricalBoxes[1]

--     print(v.coords, #(v.coords - coords))
--     SetEntityCoords(GetPlayerPed(src), v.coords.x, v.coords.y, v.coords.z + 1.25)
-- end, false)