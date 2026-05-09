-- init locales
lib.locale()

Config = {}

Config.Debug = false

-- returns track creator cam back to its original position if you put prop on another entity
Config.TrackCamEntityPrevention = true

-- how far ahead from your position the track creator prop can go
Config.TrackCreatorCamDist = 25.0

Config.RacingItem = "racing_tablet"

-- requires `Config.RacingItem` item to open the UI
Config.RequireItemToOpen = true

-- how long the race leaderboard shows when you finish a race
Config.LeaderboardTimeout = 15 * 1000 -- [[ milliseconds ]]

-- show which players are in the racing track creator
Config.ShowCreatorUsage = true

Config.CheckpointModels = {
    `prop_offroad_tyres02`,
    `prop_beachflag_01`,
    `prop_golfflag`,
    `stt_prop_flagpole_1b`,
    `stt_prop_flagpole_2e`,
}

Config.PropModels = {
    -- Tires
    `prop_offroad_tyres02`,
    `prop_offroad_tyres01_tu`,
	`prop_tyre_wall_01`,
	`prop_tyre_wall_01b`,
	`prop_tyre_wall_01c`,
	`prop_tyre_wall_02`,
	`prop_tyre_wall_02b`,
	`prop_tyre_wall_02c`,
	`prop_tyre_wall_03`,
	`prop_tyre_wall_03b`,
	`prop_tyre_wall_03c`,
	`prop_tyre_wall_04`,
	`prop_tyre_wall_05`,

    -- SMALL
    `m23_2_prop_m32_roadcone_01a`,
    `m23_2_prop_m32_roadcone_03a`,
    `m23_2_prop_m32_roadcone_05a`,
    `m23_2_prop_m32_roadcone_06a`,
    `m23_2_prop_m32_roadcone_07a`,
    `m23_2_prop_m32_barrier_wat_01a`,
    `m23_2_prop_m32_roadpole_01a`,
    `m23_2_prop_m32_plasticbarrier_01a`,
    `m23_2_prop_m32_plasticbarrier_02a`,
    `m23_2_prop_m32_plasticbarrier_03a`,
    `m23_2_prop_m32_plasticbarrier_04a`,

    -- LIGHTS
    `prod_mssd_lamp_tripod_01a`,
    `prod_mssd_lamp_tripod_01b`,
    `prod_mssd_lamp_tripod_01c`,
    `prod_mssd_lamp_tripod_01d`,
    `prod_mssd_lamp_tripod_01e`,
    `prod_mssd_lamp_tripod_01f`,

    -- LARGE?
    `m23_2_prop_m32_truktrailer_01a`,
    `m23_2_prop_m32_truktrailer_02a`,
	`tr_prop_tr_truktrailer_01a`,
    `m23_2_prop_m32_tyre_wall_u_l`,
    `m23_2_prop_m32_tyre_wall_u_r`,
	`tr_prop_tr_wall_sign_01`,
	`tr_prop_tr_wall_sign_01_b`,
	`tr_prop_tr_wall_sign_0l1`,
	`tr_prop_tr_wall_sign_0l1_b`,
	`tr_prop_tr_wall_sign_0r1`,
	`tr_prop_tr_wall_sign_0r1_b`,
	`tr_prop_tr_mule_ms_01a`,
}
