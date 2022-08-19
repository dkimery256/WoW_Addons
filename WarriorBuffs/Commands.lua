local addonName, ns = ...

local function WarriorBuffsCommands(msg, editbox)
    msg = string.lower(msg)
    -- Unlock
    if msg == 'unlock' then
	    ns.WarriorBuffs.Unlock()
    end

    -- Lock
    if msg == 'lock' then
	    ns.WarriorBuffs.Lock()
    end

    if msg == 'save' then
        ns.WarriorBuffs.Save()
    end

    if msg == 'reset' then
        ns.WarriorBuffs.Reset()
    end

    if string.match(msg, 'solo') then
        if string.match(msg, 'true') then
            ns.WarriorBuffs.SetSaveOnLogOffTrue()    
        elseif string.match(msg, 'false') then
            ns.WarriorBuffs.SetSaveOnLogOffFalse()    
        else
            ns.WarriorBuffs.GetSaveOnLogOff()
        end
    end
end

SLASH_WB1 = '/wb'

SlashCmdList["WB"] = WarriorBuffsCommands