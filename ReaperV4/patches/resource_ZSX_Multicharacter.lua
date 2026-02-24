local IsDuplicityVersion <const> = IsDuplicityVersion

if not IsDuplicityVersion() then
    local HookDetectionCheck <const> = ReaperAC.API.HookDetectionCheck
    local ZSX_Multicharacter <const> = exports.ZSX_Multicharacter

    HookDetectionCheck('antiGodMode', function()
        if ZSX_Multicharacter:isInMulticharacter() then
            return false
        end
    end)
end