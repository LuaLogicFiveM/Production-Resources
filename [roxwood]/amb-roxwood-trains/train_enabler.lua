-- Ambitioneers Train Enabler – Track Setup Only
-- This ensures the train tracks are active, but disables random native train spawns

Citizen.CreateThread(function()
    -- Enable relevant tracks
    SwitchTrainTrack(0, true)     -- Main loop
    SwitchTrainTrack(3, true)     -- Metro
    SwitchTrainTrack(12, true)    -- Roxwood Freight Line
    SwitchTrainTrack(13, true)    -- Roxwood Passenger Line

    -- Prevent native train spawning by setting absurd frequencies
    SetTrainTrackSpawnFrequency(0, 999999)
    SetTrainTrackSpawnFrequency(3, 999999)
    SetTrainTrackSpawnFrequency(12, 999999)
    SetTrainTrackSpawnFrequency(13, 999999)

    -- Turn off engine-driven random spawns
    SetRandomTrains(false)
end)