local addon_name, ns = ...

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
end

SLASH_WB1 = '/wb'

SlashCmdList["WB"] = WarriorBuffsCommands