local icon_id = 0
local spell_name = ""
local spell_id = 0;
local icon_frame = CreateFrame("Frame")
local spell_damage = 0

local EventFrame = CreateFrame('Frame')
EventFrame:RegisterEvent('ADDON_LOADED')
EventFrame:SetScript('OnEvent', function(self, event, ...)
    if self[event] then
        self[event](self, ...)
    end
end)

function Split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function GetSpellDamage(id)
    return GetSpellDamageRangeAverageFromDescr(GetSpellDescription(id))
end

function GetSpellDamageRangeAverageFromDescr(descr)
    local damageRangeStr = "";
    damageRangeStr = descr:match '%d%d%d%d%sto%s%d%d%d%d'
    if damageRangeStr == nil then damageRangeStr = descr:match '%d%d%d%sto%s%d%d%d%d' end
    if damageRangeStr == nil then damageRangeStr = descr:match '%d%d%d%sto%s%d%d%d' end
    if damageRangeStr == nil then damageRangeStr = descr:match '%d%d%sto%s%d%d%d' end
    if damageRangeStr == nil then damageRangeStr = descr:match '%d%d%sto%s%d%d' end
    if damageRangeStr == nil then damageRangeStr = descr:match '%d%d%sto%s%d%d' end
    if damageRangeStr == nil then damageRangeStr = descr:match '%d%sto%s%d%d' end
    if damageRangeStr == nil then damageRangeStr = descr:match '%d%sto%s%d' end
    local damageRange = Split(damageRangeStr, " to ")
    local totalDamage = tonumber(damageRange[1]) + tonumber(damageRange[2])
    totalDamage = totalDamage / 2
    return totalDamage + GetSpellBonusDamage(6)
end

local function WillKillTarget()
    local health = UnitHealth('target')
    if (health - GetSpellDamage(spell_id) <= 0) then return true end
    return false
end

function EventFrame:ADDON_LOADED(name)
    if name == 'ShadowWordDeath' then
        spell_name, _, icon_id, _, _, _, spell_id = GetSpellInfo('Shadow Word: Death')
        icon_frame:Hide()
        icon_frame:SetFrameStrata("BACKGROUND")
        icon_frame:SetParent(UIParent)
        icon_frame:SetHeight(50)
        icon_frame:SetWidth(50)
        icon_frame:EnableMouse(true)
        icon_frame:SetPoint("CENTER", 0, 200)
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

local function ShowOrHideIcon()
    if not UnitAffectingCombat("player") then
        icon_frame:Hide()
        return
    end
    local _, _, class_id = UnitClass("player")
    if class_id ~= 5 then
        icon_frame:Hide()
        return
    end
    if (IsUsableSpell(spell_id)) and (WillKillTarget()) then
        icon_frame:Show()
    else
        icon_frame:Hide()
    end
end

local swd_frame = CreateFrame("Frame", "swd_frame")
swd_frame:RegisterEvent("UNIT_POWER_FREQUENT")

local function fire_swd_event(self, event, ...)
    local unit, type = ...
    if event == 'UNIT_POWER_FREQUENT' and unit == 'player' and string.lower(type) == "mana" then
        ShowOrHideIcon()
    end
end

swd_frame:SetScript("OnEvent", fire_swd_event)

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



local combat_ended_frame = CreateFrame("Frame", "combat_ended")
combat_ended_frame:RegisterEvent("PLAYER_LEAVE_COMBAT")

local function combat_ended(self, event, ...)
    icon_frame:Hide()
end

combat_ended_frame:SetScript("OnEvent", combat_ended)

local success_cast_frame = CreateFrame("Frame", "success_cast")
success_cast_frame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")

local function success_cast(self, event, ...)
    local unit, _, spellID = ...
    if unit == 'player' and event == 'UNIT_SPELLCAST_SUCCEEDED' then
        if spellID == spell_id then icon_frame:Hide() end
    end
end

success_cast_frame:SetScript("OnEvent", success_cast)





