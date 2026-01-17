/*--------------------------------------
  % Made with ❤️ for: Rytrak Store
  % Author: Rytrak https://rytrak.fr
  % Script documentation: https://docs.rytrak.fr/scripts/advanced-handcuffs-system
  % Full support on discord: https://discord.gg/k22buEjnpZ
--------------------------------------*/

exports('IsPlayerCuffed', function(sid)
    return Player(sid).state[Config.StatebagsName.handcuffs] or false
end)

exports('IsPlayerRope', function(sid)
    return Player(sid).state[Config.StatebagsName.rope] or false
end)