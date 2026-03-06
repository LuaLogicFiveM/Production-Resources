TEXTUI = {}

TEXTUI.Show = function(message)
    if not message then
        return
    end

    if not _G.TextUiDetected then
        _G.DetectTextUiSystem()
    end

    local textUiType = _G.TextUi or _G.DetectTextUiSystem()

    if not textUiType then
        return
    end

    if textUiType == "okok" then
        exports.okokTextUI:Open(message, "darkblue", "right")
    elseif textUiType == "ox_lib" then
        exports["ox_lib"]:showTextUI(message)
    elseif textUiType == "esx" then
        if ESX and ESX.ShowHelpNotification then
            ESX.ShowHelpNotification(message)
        end
    elseif textUiType == "lation_ui" then
        exports.lation_ui:showText({
            description = tostring(message),
            position = 'right-center'
        })
    elseif textUiType == "jg-textui" then
        exports['jg-textui']:DrawText(message)
    elseif textUiType == "cd_drawtextui" then
        TriggerEvent('cd_drawtextui:ShowUI', 'show', message)
    elseif textUiType == "qbcore" then
        exports["qb-core"]:DrawText(message, "right")
    end
end

TEXTUI.Hide = function()
    if not _G.TextUiDetected then
        _G.DetectTextUiSystem()
    end

    local textUiType = _G.TextUi or _G.DetectTextUiSystem()

    if not textUiType then
        return
    end

    if textUiType == "okok" then
        exports.okokTextUI:Close()
    elseif textUiType == "qbcore" then
        exports["qb-core"]:HideText()
    elseif textUiType == "ox_lib" then
        exports["ox_lib"]:hideTextUI()
    elseif textUiType == "lation_ui" then
        exports.lation_ui:hideText()
    elseif textUiType == "jg-textui" then
        exports['jg-textui']:HideText()
    elseif textUiType == "esx" then
        if ESX and ESX.HideHelpNotification then
            ESX.HideHelpNotification()
        end
    elseif textUiType == "cd_drawtextui" then
        TriggerEvent('cd_drawtextui:HideUI')
    end
end

TextUIShow = TEXTUI.Show
TextUIHide = TEXTUI.Hide
