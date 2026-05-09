local function setupTestRunCommand()
    if not Config.Commands?.testRun?.enabled then return end

    bridge.fw.registerCommand(
        Config.Commands.testRun.command,
        Config.Commands.testRun.description,
        nil,
        'group.admin',
        function(playerId)
            StartDrugDrops(playerId)
        end
    )
end

local function setupCommands()
    setupTestRunCommand()
end
SetTimeout(0, setupCommands)