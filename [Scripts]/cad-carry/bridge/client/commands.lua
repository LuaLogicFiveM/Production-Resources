if Config.EnableCommands then

--- Carry Nearby Person
--- Default Keybind: NONE
RegisterKeyMapping('carry', 'Carry Nearby Person', 'KEYBOARD', '')
RegisterCommand('carry', function()
    exports['cad-carry']:CarryPerson()
end, false)

--- Remove Person InTrunk
--- Default Keybind: NONE
RegisterKeyMapping('removetrunk', 'Remove Trunk Person', 'KEYBOARD', '')
RegisterCommand('removetrunk', function()
    exports['cad-carry']:RemoveTrunk()
end, false)

--- Remove Person InSeat
--- Default Keybind: NONE
RegisterKeyMapping('removeseat', 'Remove Seat Person', 'KEYBOARD', '')
RegisterCommand('removeseat', function()
    exports['cad-carry']:RemoveSeat()
end, false)

end

--- Default Keybind: X
--- Cancel Carry (can be done by both carrying person and carried person)
RegisterKeyMapping('cancelcarry', 'Cancel Carry', 'KEYBOARD', 'X')
RegisterCommand('cancelcarry', function()
    exports['cad-carry']:CancelCarry()
end, false)

if Config.RequireAcceptance then

--- Accept Carry Request
--- Default Keybind: Y
RegisterKeyMapping('acceptcarry', 'Accept Carry Request', 'KEYBOARD', 'Y')
RegisterCommand('acceptcarry', function()
    exports['cad-carry']:AcceptCarryRequest()
end, false)

--- Deny Carry Request
--- Default Keybind: N
RegisterKeyMapping('denycarry', 'Deny Carry Request', 'KEYBOARD', 'N')
RegisterCommand('denycarry', function()
    exports['cad-carry']:DenyCarryRequest()
end, false)

end

--- Chat Suggestions
CreateThread(function()
    Wait(2000)
    if Config.EnableCommands then
        TriggerEvent('chat:addSuggestion', '/carry', 'Carry nearby person')
        TriggerEvent('chat:addSuggestion', '/removetrunk', 'Remove person from vehicle trunk')
        TriggerEvent('chat:addSuggestion', '/removeseat', 'Remove person from nearest vehicle seat')
    end
    if Config.RequireAcceptance then
        TriggerEvent('chat:addSuggestion', '/acceptcarry', 'Accept carry request')
        TriggerEvent('chat:addSuggestion', '/denycarry', 'Deny carry request')
    end
end)