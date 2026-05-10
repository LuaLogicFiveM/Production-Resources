lua54 'yes'

fx_version 'cerulean'
game 'gta5'

this_is_a_map 'yes'

file "sp_manifest.ymt"
data_file 'SCENARIO_POINTS_OVERRIDE_PSO_FILE' 'sp_manifest.#mt'

files {
	'events.meta',
	'relationships.dat'
}

data_file 'FIVEM_LOVES_YOU_4B38E96CC036038F' 'events.meta'

--data_file 'SCENARIO_POINTS_OVERRIDE_FILE' 'stream/government_facility.#mt'
--data_file 'SCENARIO_POINTS_OVERRIDE_FILE' 'extra/east_ls_hills.ymt'
data_file 'DLC_ITYP_REQUEST' 'stream/k4mb1_topgolf_props.ytyp'

escrow_ignore {
  'client.lua',
  'stream/extra/*.ydr'
}


dependency '/assetpacks'