# Illegal Garage - ox_lib Compatibility Update

The script was updated with full compatibility for both old and new versions of ox_lib, fixing entity set conflicts and spawn issues.

```diff
+ fixed entity set conflict (no more double rendering of props)
+ added support for new ox_lib promise-based functions
+ backward compatible with old ox_lib versions (auto-detected)
+ fixed spawn point garbage collection in newer ox_lib
+ added debug toggle in config (Config.Debug = false by default)
+ added ox_target support (Config.UseOxTarget = true by default)
+ auto-detects ox_target - if available and enabled, uses it for interactions
+ added permissions system with framework support (QBCore, QBox, ESX)
+ optional ACE permissions support
```

**Throw a huge** :w_~1: 

Now how to use the updated version:
**INSTALLATION STEPS**
1. Make sure you have `ox_lib` resource installed and started
2. Ensure `ox_lib` starts BEFORE `prompt_sandy_illegal_garage` in your server.cfg
3. That's it! Script automatically detects your ox_lib version and works with both old and new versions

**Optional configs in `open_config.lua`:**
- `Config.Debug = true` - to see debug messages in console
- `Config.UseOxTarget = false` - to disable ox_target even if you have it installed
- `Config.Permissions.enabled = true` - to enable job-based restrictions
- `Config.Permissions.framework = 'auto'` - auto-detect or set to 'qb', 'qbox', 'esx'
- `Config.Permissions.useAce = true` - use ACE permissions instead of jobs

**To restrict a prop to specific jobs:**
Add `allowedJobs = {"mechanic", "police"}` to the prop in config.lua

Bug reports can be sent into the support channel.

Update is available :chefkiss:

