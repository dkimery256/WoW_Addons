local tiger_fury_icon_id = 132242
local tiger_fury_spell_name = "Tiger's Fury"

local function isActive()
    local buffs, i = { }, 1;
    local buff = UnitBuff("player", i);
    while buff do
        buffs[#buffs + 1] = buff;
        i = i + 1;
        buff = UnitBuff("player", i);
        if buff == tiger_fury_spell_name then
            return true
        end
    end
    return false;
end

local function getForm()
    local active, form = false, 0
    for i = 1, GetNumShapeshiftForms() do
        _,active = GetShapeshiftFormInfo(i)
        if active then
            form = i
        end
    end
    return form
end

local icon_frame = CreateFrame("Frame")
icon_frame:Hide()
icon_frame:SetFrameStrata("BACKGROUND")
icon_frame:SetParent(UIParent)
icon_frame:SetHeight(50)
icon_frame:SetWidth(50)
icon_frame:EnableMouse(true)
icon_frame:SetPoint("CENTER", 0, 100)
icon_frame.icon = icon_frame:CreateTexture(nil, "ARTWORK")
icon_frame.icon:SetAllPoints(true)
icon_frame.icon:SetTexture(tiger_fury_icon_id)
icon_frame:SetScript("OnMouseDown", function (self, button)
    if button=='RightButton' then
        icon_frame:Hide()
    end
end)

local tiger_fury_frame = CreateFrame("Frame", "tiger_fury_frame")
tiger_fury_frame:RegisterEvent("UNIT_POWER_FREQUENT")

local function fire_tiger_fury_event(self, event, ...)
    local unit, type = ...
    if event == 'UNIT_POWER_FREQUENT' and unit == 'player' then
        if isActive() then
            icon_frame:Hide()
            return
        end
        if getForm() ~= 3 then
            icon_frame:Hide()
            return
        end
        if not UnitAffectingCombat("player") then
            icon_frame:Hide()
            return
        end
        local _, _, class_id = UnitClass("player")
        if class_id ~= 11 then
            icon_frame:Hide()
            return
        end
        if IsUsableSpell(tiger_fury_spell_name) then
            icon_frame:Show()
        else
            icon_frame:Hide()
        end
    end
end

tiger_fury_frame:SetScript("OnEvent", fire_tiger_fury_event)

local combat_ended_frame = CreateFrame("Frame", "combat_ended")
combat_ended_frame:RegisterEvent("PLAYER_LEAVE_COMBAT")

local function combat_ended(self, event, ...)
    icon_frame:Hide()
end

combat_ended_frame:SetScript("OnEvent", combat_ended)



