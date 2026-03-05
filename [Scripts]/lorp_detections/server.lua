local ESX = exports.es_extended:getSharedObject()
local detection_config = {
    webhook = 'https://discord.com/api/webhooks/1342640236290904167/GWjOe9L71R986W14sEh208batTln0o9Cras7ALvZY-_L6lh2jAzUO0RmP88pr3jf7U9a',

    money = {
        checkTime = 60 * 5, -- Seconds
        whitelisted_groups = { ['owner'] = true, ['manager'] = true },
        max = {
            ['bank'] = 20000000,
            ['money'] = 20000000,
            ['black_money'] = 5000000
        }
    },

    inventory = {
        drop_limit = 500000,
        jobCheck = true, -- Open Inventory Detection
        allowed_jobs = { ['bcso'] = true, ['sasp'] = true, ['gov'] = true } -- Open Inventory Detection
    },

    entities = {
        whitelisted = { [`A_C_shepherd`] = true },
        max_peds = 8, -- max peds that can be spawned within the timer
        timer = 5, -- Time to reset the saved cache
        threshold = 3, -- Amount of times the threshold can be exceeded before a ban
        rate_limit = {
            [1] = { -- DO NOT CHANGE
                max = 15, -- max peds that can be spawned within the timer
                timer = 5, -- Time to reset the saved cache
                threshold = 3, -- Amount of times the threshold can be exceeded before a ban
            },
            [2] = { -- DO NOT CHANGE
                max = 5, -- max vehicles that can be spawned within the timer
                timer = 5, -- Time to reset the saved cache
                threshold = 3, -- Amount of times the threshold can be exceeded before a ban
            },
            [3] = { -- DO NOT CHANGE
                max = 15, -- max objects that can be spawned within the timer
                timer = 5, -- Time to reset the saved cache
                threshold = 3, -- Amount of times the threshold can be exceeded before a ban
            }
        },
        blacklisted = { [`cargoplane`] = 'none', [`cargoplane2`] = 'none', [`ruiner3`] = 'none', [`ruiner2`] = 'none', [`ruiner`] = 'none', [`oppressor`] = 'none', [`oppressor2`] = 'none', [`kosatka`] = 'none', [`prop_beach_fire`] = 'ban', [`csx_coastboulder_00`] = 'ban', [`des_tankercrash_01`] = 'ban', [`des_tankerexplosion_01`] = 'ban', [`des_tankerexplosion_02`] = 'ban', [`des_trailerparka_02`] = 'ban', [`des_trailerparkb_02`] = 'ban', [`des_trailerparkc_02`] = 'ban', [`des_trailerparkd_02`] = 'ban', [`des_traincrash_root2`] = 'ban', [`des_traincrash_root3`] = 'ban', [`des_traincrash_root4`] = 'ban', [`des_traincrash_root5`] = 'ban', [`des_finale_vault_end`] = 'ban', [`des_finale_vault_root001`] = 'ban', [`des_finale_vault_root002`] = 'ban', [`des_finale_vault_root003`] = 'ban', [`des_finale_vault_root004`] = 'ban', [`des_finale_vault_start`] = 'ban', [`des_vaultdoor001_root001`] = 'ban', [`des_vaultdoor001_root002`] = 'ban', [`des_vaultdoor001_root003`] = 'ban', [`des_vaultdoor001_root004`] = 'ban', [`des_vaultdoor001_root005`] = 'ban', [`des_vaultdoor001_root006`] = 'ban', [`des_vaultdoor001_skin001`] = 'ban', [`des_vaultdoor001_start`] = 'ban', [`des_traincrash_root6`] = 'ban', [`prop_ld_vault_door`] = 'ban', [`prop_vault_door_scene`] = 'ban', [`prop_vault_shutter`] = 'ban', [`p_fin_vaultdoor_s`] = 'ban', [`v_ilev_bk_vaultdoor`] = 'ban', [`prop_gold_vault_fence_l`] = 'ban', [`prop_gold_vault_fence_r`] = 'ban', [`prop_gold_vault_gate_01`] = 'ban', [`prop_bank_vaultdoor`] = 'ban', [`des_traincrash_root7`] = 'ban', [`prop_flag_russia`] = 'ban', [`prop_flag_russia_s`] = 'ban', [`prop_flag_s`] = 'ban', [`ch2_03c_props_rrlwindmill_lod`] = 'ban', [`prop_flag_sa`] = 'ban', [`prop_flag_sapd`] = 'ban', [`prop_flag_sapd_s`] = 'ban', [`prop_flag_sa_s`] = 'ban', [`prop_flag_scotland`] = 'ban', [`prop_flag_scotland_s`] = 'ban', [`prop_flag_sheriff`] = 'ban', [`prop_flag_sheriff_s`] = 'ban', [`prop_flag_uk`] = 'ban', [`prop_yacht_lounger`] = 'ban', [`prop_yacht_seat_01`] = 'ban', [`prop_yacht_seat_02`] = 'ban', [`prop_yacht_seat_03`] = 'ban', [`marina_xr_rocks_02`] = 'ban', [`marina_xr_rocks_03`] = 'ban', [`prop_test_rocks01`] = 'ban', [`prop_test_rocks02`] = 'ban', [`prop_test_rocks03`] = 'ban', [`prop_test_rocks04`] = 'ban', [`marina_xr_rocks_04`] = 'ban', [`marina_xr_rocks_05`] = 'ban', [`marina_xr_rocks_06`] = 'ban', [`prop_yacht_table_01`] = 'ban', [`csx_searocks_02`] = 'ban', [`csx_searocks_03`] = 'ban', [`csx_searocks_04`] = 'ban', [`csx_searocks_05`] = 'ban', [`csx_searocks_06`] = 'ban', [`p_yacht_chair_01_s`] = 'ban', [`p_yacht_sofa_01_s`] = 'ban', [`prop_yacht_table_02`] = 'ban', [`csx_coastboulder_01`] = 'ban', [`csx_coastboulder_02`] = 'ban', [`csx_coastboulder_03`] = 'ban', [`csx_coastboulder_04`] = 'ban', [`csx_coastboulder_05`] = 'ban', [`csx_coastboulder_06`] = 'ban', [`csx_coastboulder_07`] = 'ban', [`csx_coastrok1`] = 'ban', [`csx_coastrok2`] = 'ban', [`csx_coastrok3`] = 'ban', [`csx_coastrok4`] = 'ban', [`csx_coastsmalrock_01`] = 'ban', [`csx_coastsmalrock_02`] = 'ban', [`csx_coastsmalrock_03`] = 'ban', [`csx_coastsmalrock_04`] = 'ban', [`csx_coastsmalrock_05`] = 'ban', [`prop_yacht_table_03`] = 'ban', [`prop_flag_uk_s`] = 'ban', [`prop_flag_us`] = 'ban', [`prop_flag_usboat`] = 'ban', [`prop_flag_us_r`] = 'ban', [`prop_flag_us_s`] = 'ban', [`p_gasmask_s`] = 'ban', [`prop_flamingo`] = 'ban', [`stt_prop_stunt_soccer_ball`] = 'ban', [`prop_rock_4_big2`] = 'ban', [`p_crahsed_heli_s`] = 'ban', [`stt_prop_c4_stack`] = 'ban', [`stt_prop_corner_sign_01`] = 'ban', [`stt_prop_corner_sign_02`] = 'ban', [`stt_prop_corner_sign_03`] = 'ban', [`stt_prop_corner_sign_04`] = 'ban', [`stt_prop_corner_sign_05`] = 'ban', [`stt_prop_corner_sign_06`] = 'ban', [`stt_prop_corner_sign_07`] = 'ban', [`stt_prop_corner_sign_08`] = 'ban', [`stt_prop_corner_sign_09`] = 'ban', [`stt_prop_corner_sign_10`] = 'ban', [`stt_prop_corner_sign_11`] = 'ban', [`stt_prop_corner_sign_12`] = 'ban', [`stt_prop_corner_sign_13`] = 'ban', [`stt_prop_corner_sign_14`] = 'ban', [`stt_prop_flagpole_1a`] = 'ban', [`stt_prop_flagpole_1b`] = 'ban', [`stt_prop_flagpole_1c`] = 'ban', [`stt_prop_flagpole_1d`] = 'ban', [`stt_prop_flagpole_1e`] = 'ban', [`stt_prop_flagpole_1f`] = 'ban', [`stt_prop_flagpole_2a`] = 'ban', [`stt_prop_flagpole_2b`] = 'ban', [`stt_prop_flagpole_2c`] = 'ban', [`stt_prop_flagpole_2d`] = 'ban', [`stt_prop_flagpole_2e`] = 'ban', [`stt_prop_flagpole_2f`] = 'ban', [`stt_prop_hoop_constraction_01a`] = 'ban', [`stt_prop_hoop_small_01`] = 'ban', [`stt_prop_hoop_tyre_01a`] = 'ban', [`stt_prop_lives_bottle`] = 'ban', [`stt_prop_race_gantry_01`] = 'ban', [`stt_prop_race_start_line_01`] = 'ban', [`stt_prop_race_start_line_01b`] = 'ban', [`stt_prop_race_start_line_02`] = 'ban', [`stt_prop_race_start_line_02b`] = 'ban', [`stt_prop_race_start_line_03`] = 'ban', [`stt_prop_race_start_line_03b`] = 'ban', [`stt_prop_race_tannoy`] = 'ban', [`stt_prop_ramp_adj_flip_m`] = 'ban', [`stt_prop_ramp_adj_flip_mb`] = 'ban', [`stt_prop_ramp_adj_flip_s`] = 'ban', [`stt_prop_ramp_adj_flip_sb`] = 'ban', [`stt_prop_ramp_adj_hloop`] = 'ban', [`stt_prop_ramp_adj_loop`] = 'ban', [`stt_prop_ramp_jump_l`] = 'ban', [`stt_prop_ramp_jump_m`] = 'ban', [`stt_prop_ramp_jump_s`] = 'ban', [`stt_prop_ramp_jump_xl`] = 'ban', [`stt_prop_ramp_jump_xs`] = 'ban', [`stt_prop_ramp_jump_xxl`] = 'ban', [`stt_prop_ramp_multi_loop_rb`] = 'ban', [`stt_prop_ramp_spiral_l`] = 'ban', [`stt_prop_ramp_spiral_l_l`] = 'ban', [`stt_prop_ramp_spiral_l_m`] = 'ban', [`stt_prop_ramp_spiral_l_s`] = 'ban', [`stt_prop_ramp_spiral_l_xxl`] = 'ban', [`stt_prop_ramp_spiral_m`] = 'ban', [`stt_prop_ramp_spiral_s`] = 'ban', [`stt_prop_ramp_spiral_xxl`] = 'ban', [`stt_prop_sign_circuit_01`] = 'ban', [`stt_prop_sign_circuit_02`] = 'ban', [`stt_prop_sign_circuit_03`] = 'ban', [`stt_prop_sign_circuit_04`] = 'ban', [`stt_prop_sign_circuit_05`] = 'ban', [`stt_prop_sign_circuit_06`] = 'ban', [`stt_prop_sign_circuit_07`] = 'ban', [`stt_prop_sign_circuit_08`] = 'ban', [`stt_prop_sign_circuit_09`] = 'ban', [`stt_prop_sign_circuit_10`] = 'ban', [`stt_prop_sign_circuit_11`] = 'ban', [`stt_prop_sign_circuit_11b`] = 'ban', [`stt_prop_sign_circuit_12`] = 'ban', [`stt_prop_sign_circuit_13`] = 'ban', [`stt_prop_sign_circuit_13b`] = 'ban', [`stt_prop_sign_circuit_14`] = 'ban', [`stt_prop_sign_circuit_14b`] = 'ban', [`stt_prop_sign_circuit_15`] = 'ban', [`stt_prop_slow_down`] = 'ban', [`stt_prop_speakerstack_01a`] = 'ban', [`stt_prop_startline_gantry`] = 'ban', [`stt_prop_stunt_bblock_huge_01`] = 'ban', [`stt_prop_stunt_bblock_huge_02`] = 'ban', [`stt_prop_stunt_bblock_huge_03`] = 'ban', [`stt_prop_stunt_bblock_huge_04`] = 'ban', [`stt_prop_stunt_bblock_huge_05`] = 'ban', [`stt_prop_stunt_bblock_hump_01`] = 'ban', [`stt_prop_stunt_bblock_hump_02`] = 'ban', [`stt_prop_stunt_bblock_lrg1`] = 'ban', [`stt_prop_stunt_bblock_lrg2`] = 'ban', [`stt_prop_stunt_bblock_lrg3`] = 'ban', [`stt_prop_stunt_bblock_mdm1`] = 'ban', [`stt_prop_stunt_bblock_mdm2`] = 'ban', [`stt_prop_stunt_bblock_mdm3`] = 'ban', [`stt_prop_stunt_bblock_qp`] = 'ban', [`stt_prop_stunt_bblock_qp2`] = 'ban', [`stt_prop_stunt_bblock_qp3`] = 'ban', [`stt_prop_stunt_bblock_sml1`] = 'ban', [`stt_prop_stunt_bblock_sml2`] = 'ban', [`stt_prop_stunt_bblock_sml3`] = 'ban', [`stt_prop_stunt_bblock_xl1`] = 'ban', [`stt_prop_stunt_bblock_xl2`] = 'ban', [`stt_prop_stunt_bblock_xl3`] = 'ban', [`stt_prop_stunt_bowling_ball`] = 'ban', [`stt_prop_stunt_bowling_pin`] = 'ban', [`stt_prop_stunt_bowlpin_stand`] = 'ban', [`stt_prop_stunt_domino`] = 'ban', [`stt_prop_stunt_jump15`] = 'ban', [`stt_prop_stunt_jump30`] = 'ban', [`stt_prop_stunt_jump45`] = 'ban', [`stt_prop_stunt_jump_l`] = 'ban', [`stt_prop_stunt_jump_lb`] = 'ban', [`stt_prop_stunt_jump_loop`] = 'ban', [`stt_prop_stunt_jump_m`] = 'ban', [`stt_prop_stunt_jump_mb`] = 'ban', [`stt_prop_stunt_jump_s`] = 'ban', [`stt_prop_stunt_jump_sb`] = 'ban', [`stt_prop_stunt_landing_zone_01`] = 'ban', [`stt_prop_stunt_ramp`] = 'ban', [`stt_prop_stunt_soccer_goal`] = 'ban', [`stt_prop_stunt_soccer_lball`] = 'ban', [`stt_prop_stunt_soccer_sball`] = 'ban', [`stt_prop_stunt_target`] = 'ban', [`stt_prop_stunt_target_small`] = 'ban', [`stt_prop_stunt_track_bumps`] = 'ban', [`stt_prop_stunt_track_cutout`] = 'ban', [`stt_prop_stunt_track_dwlink`] = 'ban', [`stt_prop_stunt_track_dwlink_02`] = 'ban', [`stt_prop_stunt_track_dwsh15`] = 'ban', [`stt_prop_stunt_track_dwshort`] = 'ban', [`stt_prop_stunt_track_dwslope15`] = 'ban', [`stt_prop_stunt_track_dwslope30`] = 'ban', [`stt_prop_stunt_track_dwslope45`] = 'ban', [`stt_prop_stunt_track_dwturn`] = 'ban', [`stt_prop_stunt_track_dwuturn`] = 'ban', [`stt_prop_stunt_track_exshort`] = 'ban', [`stt_prop_stunt_track_fork`] = 'ban', [`stt_prop_stunt_track_funlng`] = 'ban', [`stt_prop_stunt_track_funnel`] = 'ban', [`stt_prop_stunt_track_hill`] = 'ban', [`stt_prop_stunt_track_hill2`] = 'ban', [`stt_prop_stunt_track_jump`] = 'ban', [`stt_prop_stunt_track_link`] = 'ban', [`stt_prop_stunt_track_otake`] = 'ban', [`stt_prop_stunt_track_sh15`] = 'ban', [`stt_prop_stunt_track_sh30`] = 'ban', [`stt_prop_stunt_track_sh45`] = 'ban', [`stt_prop_stunt_track_sh45_a`] = 'ban', [`stt_prop_stunt_track_short`] = 'ban', [`stt_prop_stunt_track_slope15`] = 'ban', [`stt_prop_stunt_track_slope30`] = 'ban', [`stt_prop_stunt_track_slope45`] = 'ban', [`stt_prop_stunt_track_start`] = 'ban', [`stt_prop_stunt_track_start_02`] = 'ban', [`stt_prop_stunt_track_straight`] = 'ban', [`stt_prop_stunt_track_straightice`] = 'ban', [`stt_prop_stunt_track_st_01`] = 'ban', [`stt_prop_stunt_track_st_02`] = 'ban', [`stt_prop_stunt_track_turn`] = 'ban', [`stt_prop_stunt_track_turnice`] = 'ban', [`stt_prop_stunt_track_uturn`] = 'ban', [`stt_prop_stunt_tube_crn`] = 'ban', [`stt_prop_stunt_tube_crn2`] = 'ban', [`stt_prop_stunt_tube_crn_15d`] = 'ban', [`stt_prop_stunt_tube_crn_30d`] = 'ban', [`stt_prop_stunt_tube_crn_5d`] = 'ban', [`stt_prop_stunt_tube_cross`] = 'ban', [`stt_prop_stunt_tube_end`] = 'ban', [`stt_prop_stunt_tube_ent`] = 'ban', [`stt_prop_stunt_tube_fn_01`] = 'ban', [`stt_prop_stunt_tube_fn_02`] = 'ban', [`stt_prop_stunt_tube_fn_03`] = 'ban', [`stt_prop_stunt_tube_fn_04`] = 'ban', [`stt_prop_stunt_tube_fn_05`] = 'ban', [`stt_prop_stunt_tube_fork`] = 'ban', [`stt_prop_stunt_tube_gap_01`] = 'ban', [`stt_prop_stunt_tube_gap_02`] = 'ban', [`stt_prop_stunt_tube_gap_03`] = 'ban', [`stt_prop_stunt_tube_hg`] = 'ban', [`stt_prop_stunt_tube_jmp`] = 'ban', [`stt_prop_stunt_tube_jmp2`] = 'ban', [`stt_prop_stunt_tube_l`] = 'ban', [`stt_prop_stunt_tube_m`] = 'ban', [`stt_prop_stunt_tube_qg`] = 'ban', [`stt_prop_stunt_tube_s`] = 'ban', [`stt_prop_stunt_tube_speed`] = 'ban', [`stt_prop_stunt_tube_speeda`] = 'ban', [`stt_prop_stunt_tube_speedb`] = 'ban', [`stt_prop_stunt_tube_xs`] = 'ban', [`stt_prop_stunt_tube_xxs`] = 'ban', [`stt_prop_stunt_wideramp`] = 'ban', [`stt_prop_track_bend2_bar_l`] = 'ban', [`stt_prop_track_bend2_bar_l_b`] = 'ban', [`stt_prop_track_bend2_l`] = 'ban', [`stt_prop_track_bend2_l_b`] = 'ban', [`stt_prop_track_bend_15d`] = 'ban', [`stt_prop_track_bend_15d_bar`] = 'ban', [`stt_prop_track_bend_180d`] = 'ban', [`stt_prop_track_bend_180d_bar`] = 'ban', [`stt_prop_track_bend_30d`] = 'ban', [`stt_prop_track_bend_30d_bar`] = 'ban', [`stt_prop_track_bend_5d`] = 'ban', [`stt_prop_track_bend_5d_bar`] = 'ban', [`stt_prop_track_bend_bar_l`] = 'ban', [`stt_prop_track_bend_bar_l_b`] = 'ban', [`stt_prop_track_bend_bar_m`] = 'ban', [`stt_prop_track_bend_l`] = 'ban', [`stt_prop_track_bend_l_b`] = 'ban', [`stt_prop_track_bend_m`] = 'ban', [`stt_prop_track_block_01`] = 'ban', [`stt_prop_track_block_02`] = 'ban', [`stt_prop_track_block_03`] = 'ban', [`stt_prop_track_chicane_l`] = 'ban', [`stt_prop_track_chicane_l_02`] = 'ban', [`stt_prop_track_chicane_r`] = 'ban', [`stt_prop_track_chicane_r_02`] = 'ban', [`stt_prop_track_cross`] = 'ban', [`stt_prop_track_cross_bar`] = 'ban', [`stt_prop_track_fork`] = 'ban', [`stt_prop_track_fork_bar`] = 'ban', [`stt_prop_track_funnel`] = 'ban', [`stt_prop_track_funnel_ads_01a`] = 'ban', [`stt_prop_track_funnel_ads_01b`] = 'ban', [`stt_prop_track_funnel_ads_01c`] = 'ban', [`stt_prop_track_jump_01a`] = 'ban', [`stt_prop_track_jump_01b`] = 'ban', [`stt_prop_track_jump_01c`] = 'ban', [`stt_prop_track_jump_02a`] = 'ban', [`stt_prop_track_jump_02b`] = 'ban', [`stt_prop_track_jump_02c`] = 'ban', [`stt_prop_track_link`] = 'ban', [`stt_prop_track_slowdown`] = 'ban', [`stt_prop_track_slowdown_t1`] = 'ban', [`stt_prop_track_slowdown_t2`] = 'ban', [`stt_prop_track_speedup`] = 'ban', [`stt_prop_track_speedup_t1`] = 'ban', [`stt_prop_track_speedup_t2`] = 'ban', [`stt_prop_track_start`] = 'ban', [`stt_prop_track_start_02`] = 'ban', [`stt_prop_track_stop_sign`] = 'ban', [`stt_prop_track_straight_bar_l`] = 'ban', [`stt_prop_track_straight_bar_m`] = 'ban', [`stt_prop_track_straight_bar_s`] = 'ban', [`stt_prop_track_straight_l`] = 'ban', [`stt_prop_track_straight_lm`] = 'ban', [`stt_prop_track_straight_lm_bar`] = 'ban', [`stt_prop_track_straight_m`] = 'ban', [`stt_prop_track_straight_s`] = 'ban', [`stt_prop_track_tube_01`] = 'ban', [`stt_prop_track_tube_02`] = 'ban', [`stt_prop_tyre_wall_01`] = 'ban', [`stt_prop_tyre_wall_010`] = 'ban', [`stt_prop_tyre_wall_011`] = 'ban', [`stt_prop_tyre_wall_012`] = 'ban', [`stt_prop_tyre_wall_013`] = 'ban', [`stt_prop_tyre_wall_014`] = 'ban', [`stt_prop_tyre_wall_015`] = 'ban', [`stt_prop_tyre_wall_02`] = 'ban', [`stt_prop_tyre_wall_03`] = 'ban', [`stt_prop_tyre_wall_04`] = 'ban'}
    }
}

local LOG_WEBHOOK = detection_config.webhook

-- Inventory Detections

local ALLOWED_JOBS = detection_config.inventory.allowed_jobs
local JOB_CHECK = detection_config.inventory.jobCheck
local DROP_LIMIT = detection_config.inventory.drop_limit

local function IsAllowed(source)
    if JOB_CHECK then
        local xPlayer = ESX.GetPlayerFromId(source)
        local xPlayerJob = xPlayer.getJob().name
        return xPlayer and ALLOWED_JOBS[xPlayerJob] or false
    end
end

local function GetDiscordIdentifier(source)
	local src = source
	if src == 0 then return false end
	local discord = GetPlayerIdentifierByType(src, 'discord')
	return discord:sub(9)
end

local ReaperV4 = exports.ReaperV4
local ox_inventory = exports.ox_inventory

local hookId_open = ox_inventory:registerHook('openInventory', function(payload)
    if type(payload.inventoryId) == 'number' and not IsAllowed(payload.source) then
        return false, ReaperV4:InvokeSPlayer(payload.source, 'addDetection', 'ban', 'Attempted to open player inventory [CD-1]')
    end

    exports.lorp_packed:SendLog('Player Inventory Opened', '**[Source Name]:** '..GetPlayerName(payload.source)..' ('..payload.source..')\n **[Source Discord]:** <@'..GetDiscordIdentifier(payload.source) or 'Console'..'>  \n **[Target Name]:** '..GetPlayerName(payload.inventoryId)..' ('..payload.inventoryId..')\n **[Target Discord]:** <@'..GetDiscordIdentifier(payload.inventoryId)..'>\n **[Data]:** '..json.encode(payload), 'https://discord.com/api/webhooks/1245194741545566298/GKFB1CcZOEQVYy5qTmonRLay4punZNhZ4CjgHQvB3QYXwJeW-5k9q_aTL8_xeDk9sPD4')
end, {
    typeFilter = {['player'] = true}
})

local hookId_swap = ox_inventory:registerHook('swapItems', function(payload)
    if payload.toInventory ~= payload.fromInventory then
        if payload.count > DROP_LIMIT then
            if payload.toSlot and (payload.toSlot.count or payload.toSlot) > DROP_LIMIT then
                exports.lorp_packed:SendLog('Player Inventory Flag 1', '**[Source Name]:** '..GetPlayerName(payload.source)..' ('..payload.source..')  \n **[Source Discord]:** <@'..GetDiscordIdentifier(payload.source) or 'Console'..'>  \n **[Target Name]:** '..GetPlayerName(payload.inventoryId)..' ('..payload.inventoryId..')\n **[Target Discord]:** <@'..GetDiscordIdentifier(payload.inventoryId)..'>\n **[Item]:** '..payload.fromSlot.name..'\n **[Item Count]:** '..payload.fromSlot.count..'\n **[Data]:** '..json.encode(payload), 'https://discord.com/api/webhooks/1426030730034811040/28zCuiFSEx4kj_rX2eIiFYFbi6yj9azR8RAFLZTk3URo9bfdDtOhaa8O5uw9kizTmyXH')
                return false
            end
            exports.lorp_packed:SendLog('Player Inventory Flag 2', '**[Source Name]:** '..GetPlayerName(payload.source)..' ('..payload.source..')  \n **[Source Discord]:** <@'..GetDiscordIdentifier(payload.source) or 'Console'..'>  \n **[Target Name]:** '..GetPlayerName(payload.inventoryId)..' ('..payload.inventoryId..')\n **[Target Discord]:** <@'..GetDiscordIdentifier(payload.inventoryId)..'>\n **[Item]:** '..payload.fromSlot.name..'\n **[Item Count]:** '..payload.fromSlot.count..'\n **[Data]:** '..json.encode(payload), 'https://discord.com/api/webhooks/1426030730034811040/28zCuiFSEx4kj_rX2eIiFYFbi6yj9azR8RAFLZTk3URo9bfdDtOhaa8O5uw9kizTmyXH')
            return false
        end
    end
end, {
    print = false,
    itemFilter = {
        money = true,
        black_money = true,
    },
    typeFilter = {['ground'] = true, ['player'] = true, ['glovebox'] = true, ['trunk'] = true}
})

--[[local hookId_disable = ox_inventory:registerHook('openInventory', function(payload)
    return false, lib.notify(payload.source, {title = 'ERROR', description = 'Trunks & Gloveboxes are disabled', type = 'error', position = 'top'})
end, {
    print = false,
    inventoryFilter = {
        '^glove[%w]+',
        '^trunk[%w]+',
    }
})]]

-- Spawning Money Detections

local MAX_MONEY = detection_config.money.max
local CHECK_TIME = detection_config.money.checkTime
local WHITELISTED_GROUPS = detection_config.money.whitelisted_groups

local function check_players()
    local xPlayers = ESX.GetExtendedPlayers()

    for _, xPlayer in ipairs(xPlayers) do
        local group = xPlayer.getGroup()
        if not WHITELISTED_GROUPS[group] then
            local acc = xPlayer.getAccounts()
            local target = xPlayer.source
            local playerName = GetPlayerName(target)

            for _, v in pairs(acc) do
                if MAX_MONEY[v.name] then
                    if v.money >= MAX_MONEY[v.name] then
                        Wait(1000)
                        ReaperV4:InvokeSPlayer(target, 'addDetection', 'ban', 'Attempted to Spawn Money - [CD-2]')
                        exports.lorp_packed:SendLog('Money Limit Exceeded', ('```Account: %s | Amount: %s | Player: %s (ID: %s)```'):format(v.label, v.money, playerName, target), LOG_WEBHOOK)
                    end
                end
            end
        end
    end
end

CreateThread(function()
    while true do
        check_players()
        Wait(CHECK_TIME * 1000)
    end
end)

-- Entity Detections

--[[local BLACKLISTED = detection_config.entities.blacklisted

AddEventHandler("entityCreating", function(entity)
    if not DoesEntityExist(entity) then return end

    local entityModel = GetEntityModel(entity)
    local action = BLACKLISTED[entityModel]
    if not action then return end

    local target = NetworkGetFirstEntityOwner(entity)
    if action == 'ban' then
        ReaperV4:InvokeSPlayer(target, 'addDetection', 'ban', 'Attempted to spawn blacklisted entity - [CD-3]')
    end

    CancelEvent()
end)]]

--[[AddEventHandler('txAdmin:events:scheduledRestart', function(eventData)
    if eventData.secondsRemaining == 120 then
        local allPlayers = GetPlayers()
        for _, playerSource in ipairs(allPlayers) do
            DropPlayer(playerSource, '⚠️ THE SERVER IS RESTARTING ⚠️  \n 🔴 PLEASE RECONNECT IN 5 MINUTES 🔴')
        end
    end
end)]]

-- Entity Rate Limit Detections

--[[local rateLimits = {
    [1] = {},
    [2] = {},
    [3] = {}
}

local function pruneOld(timestamps, timer)
    print(#timestamps)
    local now = os.time()
    local cutoff = now - timer
    local i = 1
    while i <= #timestamps do
        print(timestamps[i])
        if timestamps[i] < cutoff then
            timestamps[i] = nil
        else
            i = i + 1
        end
    end
end

local function entityCheck(playerId, data, type)
    local entityLimits = detection_config.entities.rate_limit[type]
    pruneOld(data.timestamps, entityLimits.timer)

    if #data.timestamps >= entityLimits.max then
        data.denied = (data.denied + 1)
        local playerName = GetPlayerName(playerId)
        print(("[Entity Rates] - Denied entity creation from %s (recent=%d, denied=%d)"):format(playerName, #data.timestamps, data.denied))

        if entityLimits.threshold and data.denied >= entityLimits.threshold then
            --ReaperV4:InvokeSPlayer(playerId, 'addDetection', 'ban', ('Attempted to exceed a rate limit: Entity %i - [CD-4]'):format(type))
            print(("[Entity Rates] - Player was detected for exceeting a rate limit too many times (%s | %i | %i | %s)"):format(playerName, playerId, entityLimits.threshold, type))
        end

        return true
    end

    print('[RATE LIMIT DEBUG] - Added to Cache', type, playerId)
    data.denied = 0
    data.timestamps[#data.timestamps+1] = os.time()
    rateLimits[type][playerId] = data
    return false
end

local function retrieveData(playerId, type)
    local data = rateLimits[type][playerId]

    if not data then
        data = {timestamps = {}, denied = 0}
        rateLimits[type][playerId] = data
    end

    return data
end

local WHITELISTED_ENTITIES = detection_config.entities.whitelisted

local pedPopulations = {
    [0] = true,
    [2] = true,
    [5] = true,
    [4] = true,
}]]

--[[AddEventHandler("entityCreating", function(entity)
    if not DoesEntityExist(entity) then return end

    local entityOwner = NetworkGetFirstEntityOwner(entity)
    if not entityOwner or entityOwner <= 0 then return end

    local entityPopulationType = GetEntityPopulationType(entity)
    if pedPopulations[entityPopulationType] then return end
    print('Entity Pop Type - ', entityPopulationType)

    local entityModel = GetEntityModel(entity)
    if WHITELISTED_ENTITIES[entityModel] then return end

    -- type 1: peds
    -- type 2: vehicles
    -- type 3: objects
    local entityType = GetEntityType(entity)
    local data = retrieveData(entityOwner, entityType)
    if entityCheck(entityOwner, data, entityType) then
        CancelEvent()
    end
end)]]

--[[local pedRate = {}
local MAX_PEDS = detection_config.entities.max_peds       -- maximum peds allowed per window
local WINDOW_SEC = detection_config.entities.timer    -- sliding window length in seconds
local KICK_THRESHOLD = detection_config.entities.threshold -- optional: number of denials before kick


local function pruneOld(timestamps)
    local now = os.time()
    local cutoff = now - WINDOW_SEC
    local i = 1
    while i <= #timestamps do
        if timestamps[i] < cutoff then
            table.remove(timestamps, i)
        else
            i = i + 1
        end
    end
end

AddEventHandler("entityCreating", function(entity)
    if not DoesEntityExist(entity) then return end

    local entityType = GetEntityType(entity)
    if entityType ~= 1 then return end

    local pedPopulationType = GetEntityPopulationType(entity)
    if pedPopulationType == 5 or pedPopulationType == 4 then return end

    local owner = NetworkGetFirstEntityOwner(entity)
    if not owner or owner <= 0 then return end

    local playerId = owner
    local entry = pedRate[playerId]

    if not entry then
        entry = { timestamps = {}, denied = 0 }
        pedRate[playerId] = entry
    end

    pruneOld(entry.timestamps)

    if #entry.timestamps >= MAX_PEDS then
        CancelEvent()
        entry.denied = entry.denied + 1

        print(("pedRate: Denied ped creation from %d (recent=%d, denied=%d)"):format(playerId, #entry.timestamps, entry.denied))

        if KICK_THRESHOLD and entry.denied >= KICK_THRESHOLD then
            --print('Would ban player here '..playerId)
            ReaperV4:InvokeSPlayer(playerId, 'addDetection', 'ban', 'Attempted to exceed a rate limit - [CD-4]')
        end

        return
    end

    table.insert(entry.timestamps, os.time())
    entry.denied = 0
    print(("pedRate: Allowed ped for %d (recent=%d)"):format(playerId, #entry.timestamps))
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    pedRate[src] = nil
end)]]