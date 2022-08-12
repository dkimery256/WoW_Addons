local addon_name, ns = ...


local icon_id = 0
local spell_name = ""
local icon_frame = CreateFrame("Frame")

local EventFrame = CreateFrame('Frame')
EventFrame:RegisterEvent('ADDON_LOADED')
EventFrame:SetScript('OnEvent', function(self, event, ...)
    if self[event] then
        self[event](self, ...)
    end
end)

function EventFrame:ADDON_LOADED(name)
    if name == 'Rampage' then
        spell_name, _, icon_id = GetSpellInfo('Rampage')
        icon_frame:Hide()
        icon_frame:SetFrameStrata("BACKGROUND")
        icon_frame:SetParent(UIParent)
        icon_frame:SetHeight(50)
        icon_frame:SetWidth(50)
        icon_frame:EnableMouse(true)
        icon_frame:SetPoint("CENTER", 0, 100)
        icon_frame.icon = icon_frame:CreateTexture(nil, "ARTWORK")
        icon_frame.icon:SetAllPoints(true)
        icon_frame.icon:SetTexture(icon_id)
        icon_frame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                icon_frame:Hide()
            end
        end)
        self:UnregisterEvent('ADDON_LOADED')
        self.ADDON_LOADED = nil
    end
end

function GetForm()
    local i,isActive,form
    for i = 1, GetNumShapeshiftForms() do
        _,_,isActive = GetShapeshiftFormInfo(i)
        if isActive then
            form = i
        end
    end
    return form
end

local function buffTime()
    local buff, expirationTime, buffs, i = "", 0, { }, 1;
    buff = UnitBuff("player", i);
    while buff do
        buffs[#buffs + 1] = buff;
        i = i + 1;
        buff, _, _, _, _, expirationTime  = UnitBuff("player", i);
        if buff == spell_name then
            return ns.helper.round(expirationTime - GetTime())
        end
    end
    return 0
end

local function isActive()
    local buffs, i = { }, 1;
    local buff = UnitBuff("player", i);
    while buff do
        buffs[#buffs + 1] = buff;
        i = i + 1;
        buff = UnitBuff("player", i);
        if buff == spell_name then
            return true
        end
    end
    return false;
end

local function ShowOrHideIcon()
    buffTime()
    if not UnitAffectingCombat("player") then
        icon_frame:Hide()
        return
    end
    local _, _, class_id = UnitClass("player")
    if class_id ~= 1 then
        icon_frame:Hide()
        return
    end
    if GetForm() ~= 3 then
        icon_frame:Hide()
    end
    if isActive() and IsUsableSpell(spell_name) then
        if buffTime() > 10 then
            icon_frame:Hide()
        else
            icon_frame:Show();
            return
        end
    end
    if not isActive() and IsUsableSpell(spell_name) then
        icon_frame:Show()
    else
        icon_frame:Hide()
    end
end

local rampage_frame = CreateFrame("Frame", "rampage_frame")
rampage_frame:RegisterEvent("UNIT_POWER_FREQUENT")

local function fire_rampage_event(self, event, ...)
    local unit, type = ...
    if event == 'UNIT_POWER_FREQUENT' and unit == 'player' and string.lower(type) == "rage" then
        ShowOrHideIcon()
    end
end

-- Register UNIT COMBAT Event
local player_dealt_damage_frame = CreateFrame("Frame", "playerDamage")
player_dealt_damage_frame:RegisterEvent("UNIT_COMBAT")

-- Function for UNIT COMBAT Event
local function player_dealt_damage_event(self, event, ...)
    local target = ...
    if event == 'UNIT_COMBAT' and (target == 'target' or target == 'player') then
        ShowOrHideIcon()
    end
end
-- Set the script for the UNIT COMBAT Event
player_dealt_damage_frame:SetScript("OnEvent", player_dealt_damage_event);

rampage_frame:SetScript("OnEvent", fire_rampage_event)

local combat_ended_frame = CreateFrame("Frame", "combat_ended")
combat_ended_frame:RegisterEvent("PLAYER_LEAVE_COMBAT")

local function combat_ended(self, event, ...)
    icon_frame:Hide()
end

combat_ended_frame:SetScript("OnEvent", combat_ended)



