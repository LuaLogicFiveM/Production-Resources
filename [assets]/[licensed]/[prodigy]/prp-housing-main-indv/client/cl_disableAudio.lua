SetStaticEmitterEnabled("ambient_tv_36", false)
SetStaticEmitterEnabled("ambient_tv_34", false)
SetAmbientZoneStatePersistent("az_music_malibu_12", false, true)
SetAmbientZoneStatePersistent("az_music_malibu_11", false, true)

SetStaticEmitterEnabled("sweetener_courthouse_collision", false)
SetStaticEmitterEnabled("spans_galatians_collision", false)
SetAmbientZoneStatePersistent("az_music_southcentral_01",  false, true)
SetAmbientZoneStatePersistent("az_music_southcentral_02",  false, true)

for i = 1, 100 do
    SetAmbientZoneStatePersistent(string.format("az_music_southcentral_%d", i), false, true)
end

for i = 1, 100 do
    SetAmbientZoneStatePersistent(string.format("ambient_tv_%d", i), false, true)
end