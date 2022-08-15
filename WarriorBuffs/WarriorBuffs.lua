local addon_name, ns = ...

local rampage_icon_id = 0
local rampage_name = ""
local rampage_icon_frame = CreateFrame("Frame")

local battle_shout_icon_id = 0
local battle_shout_name = ""
local battle_shout_icon_frame = CreateFrame("Frame")

local bloodrage_icon_id = 0
local bloodrage_name = ""
local bloodrage_icon_frame = CreateFrame("Frame")

local berserker_rage_icon_id = 0
local berserker_rage_name = ""
local berserker_rage_icon_frame = CreateFrame("Frame")

local EventFrame = CreateFrame('Frame')
EventFrame:RegisterEvent('ADDON_LOADED')
EventFrame:SetScript('OnEvent', function(self, event, ...)
    if self[event] then
        self[event](self, ...)
    end
end)

function EventFrame:ADDON_LOADED(name)
    if name == addon_name then
        rampage_name, _, rampage_icon_id = GetSpellInfo('Rampage')
        rampage_icon_frame:Hide()
        rampage_icon_frame:SetFrameStrata("BACKGROUND")
        rampage_icon_frame:SetParent(UIParent)
        rampage_icon_frame:SetHeight(50)
        rampage_icon_frame:SetWidth(50)
        rampage_icon_frame:EnableMouse(true)
        rampage_icon_frame:SetPoint("CENTER", 0, 100)
        rampage_icon_frame.icon = rampage_icon_frame:CreateTexture(nil, "ARTWORK")
        rampage_icon_frame.icon:SetAllPoints(true)
        rampage_icon_frame.icon:SetTexture(rampage_icon_id)
        rampage_icon_frame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                rampage_icon_frame:Hide()
            end
        end)

        battle_shout_name, _, battle_shout_icon_id = GetSpellInfo("Battle Shout")
        battle_shout_icon_frame:Hide()
        battle_shout_icon_frame:SetFrameStrata("BACKGROUND")
        battle_shout_icon_frame:SetParent(UIParent)
        battle_shout_icon_frame:SetHeight(50)
        battle_shout_icon_frame:SetWidth(50)
        battle_shout_icon_frame:EnableMouse(true)
        battle_shout_icon_frame:SetPoint("CENTER", 0, 100)
        battle_shout_icon_frame.icon = battle_shout_icon_frame:CreateTexture(nil, "ARTWORK")
        battle_shout_icon_frame.icon:SetAllPoints(true)
        battle_shout_icon_frame.icon:SetTexture(battle_shout_icon_id)
        battle_shout_icon_frame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                battle_shout_icon_frame:Hide()
            end
        end)

        bloodrage_name, _, bloodrage_icon_id = GetSpellInfo("Bloodrage")
        bloodrage_icon_frame:Hide()
        bloodrage_icon_frame:SetFrameStrata("BACKGROUND")
        bloodrage_icon_frame:SetParent(UIParent)
        bloodrage_icon_frame:SetHeight(50)
        bloodrage_icon_frame:SetWidth(50)
        bloodrage_icon_frame:EnableMouse(true)
        bloodrage_icon_frame:SetPoint("CENTER", 0, 100)
        bloodrage_icon_frame.icon = bloodrage_icon_frame:CreateTexture(nil, "ARTWORK")
        bloodrage_icon_frame.icon:SetAllPoints(true)
        bloodrage_icon_frame.icon:SetTexture(bloodrage_icon_id)
        bloodrage_icon_frame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                bloodrage_icon_frame:Hide()
            end
        end)

        berserker_rage_name, _, berserker_rage_icon_id = GetSpellInfo("Berserker Rage")
        berserker_rage_icon_frame:Hide()
        berserker_rage_icon_frame:SetFrameStrata("BACKGROUND")
        berserker_rage_icon_frame:SetParent(UIParent)
        berserker_rage_icon_frame:SetHeight(50)
        berserker_rage_icon_frame:SetWidth(50)
        berserker_rage_icon_frame:EnableMouse(true)
        berserker_rage_icon_frame:SetPoint("CENTER", 0, 100)
        berserker_rage_icon_frame.icon = berserker_rage_icon_frame:CreateTexture(nil, "ARTWORK")
        berserker_rage_icon_frame.icon:SetAllPoints(true)
        berserker_rage_icon_frame.icon:SetTexture(berserker_rage_icon_id)
        berserker_rage_icon_frame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                berserker_rage_icon_frame:Hide()
            end
        end)
        
        self:UnregisterEvent('ADDON_LOADED')
        self.ADDON_LOADED = nil
    end
end

function GetStance()
    local i,isActive,stance
    for i = 1, GetNumShapeshiftForms() do
        _,_,isActive = GetShapeshiftFormInfo(i)
        if isActive then
            stance = i
        end
    end
    return stance
end

local function BuffTime(buffName)
    local buff, expirationTime, buffs, i = "", 0, { }, 1;
    buff = UnitBuff("player", i);
    while buff do
        buffs[#buffs + 1] = buff;
        i = i + 1;
        buff, _, _, _, _, expirationTime  = UnitBuff("player", i);
        if buff == buffName then
            return ns.helper.round(expirationTime - GetTime())
        end
    end
    return 0
end

local function IsActive(buffName)
    local buffs, i = { }, 1;
    local buff = UnitBuff("player", i);
    while buff do
        buffs[#buffs + 1] = buff;
        i = i + 1;
        buff = UnitBuff("player", i);
        if buff == buffName then
            return true
        end
    end
    return false;
end

local function IsOnCoolDown(name)
    local start, duration = GetSpellCooldown(name);
    if (start > 0 and duration > 0) then return true end
    return false
end

local function ShowOrHideRampageIcon()
    if not UnitAffectingCombat("player") then
        rampage_icon_frame:Hide()
        return
    end
    local _, _, class_id = UnitClass("player")
    if class_id ~= 1 then
        rampage_icon_frame:Hide()
        return
    end
    if GetStance() ~= 3 then
        rampage_icon_frame:Hide()
    end
    if isActive(rampage_name) and IsUsableSpell(rampage_name) then
        if buffTime(rampage_name) > 11 then
            rampage_icon_frame:Hide()
        else
            rampage_icon_frame:Show()
        end
        return
    end
    if not isActive(rampage_name) and IsUsableSpell(rampage_name) then
        rampage_icon_frame:Show()
    else
        rampage_icon_frame:Hide()
    end
end

local function ShowOrHideBattleShoutIcon()
    if not UnitAffectingCombat("player") then
        battle_shout_icon_frame:Hide()
        return
    end
    local _, _, class_id = UnitClass("player")
    if class_id ~= 1 then
        battle_shout_icon_frame:Hide()
        return
    end
    if isActive(battle_shout_name) and IsUsableSpell(battle_shout_name) then
        if buffTime(battle_shout_name) > 11 then
            battle_shout_icon_frame:Hide()
        else
            battle_shout_icon_frame:Show()
        end
        return
    end
    if not isActive(battle_shout_name) and IsUsableSpell(battle_shout_name) then
        battle_shout_icon_frame:Show()
    else
        battle_shout_icon_frame:Hide()
    end
end

local function ShowOrHideBloodrageIcon()
    if not UnitAffectingCombat("player") then
        bloodrage_icon_frame:Hide()
        return
    end
    local _, _, class_id = UnitClass("player")
    if class_id ~= 1 then
        bloodrage_icon_frame:Hide()
        return
    end
    if isActive(bloodrage_name) then
        bloodrage_icon_frame:Hide()
        return
    end
    if isOnCoolDown(bloodrage_name) then
        bloodrage_icon_frame:Hide()
        return
    end
    if IsUsableSpell(bloodrage_name) then
        bloodrage_icon_frame:Show()
    else
        bloodrage_icon_frame:Hide()
    end
end

local function ShowOrHideBerserkerRageIcon()
    if not UnitAffectingCombat("player") then
        berserker_rage_icon_frame:Hide()
        return
    end
    if GetStance() ~= 3 then
        berserker_rage_icon_frame:Hide()
    end
    local _, _, class_id = UnitClass("player")
    if class_id ~= 1 then
        berserker_rage_icon_frame:Hide()
        return
    end
    if isActive(berserker_rage_name) then
        berserker_rage_icon_frame:Hide()
        return
    end
    if isOnCoolDown(berserker_rage_name) then
        berserker_rage_icon_frame:Hide()
        return
    end
    if IsUsableSpell(berserker_rage_name) then
        berserker_rage_icon_frame:Show()
    else
        berserker_rage_icon_frame:Hide()
    end
end

local unit_power_freq_frame = CreateFrame("Frame", "unit_power_freq_frame")
unit_power_freq_frame:RegisterEvent("UNIT_POWER_FREQUENT")

local function unit_power_freq_event(self, event, ...)
    local unit, type = ...
    if event == 'UNIT_POWER_FREQUENT' and unit == 'player' and string.lower(type) == "rage" then
        ShowOrHideBloodrageIcon()
        ShowOrHideBerserkerRageIcon()
        ShowOrHideBattleShoutIcon()
        ShowOrHideRampageIcon()
    end
end

-- Register UNIT COMBAT Event
local player_dealt_damage_frame = CreateFrame("Frame", "playerDamage")
player_dealt_damage_frame:RegisterEvent("UNIT_COMBAT")

-- Function for UNIT COMBAT Event
local function player_dealt_damage_event(self, event, ...)
    local target = ...
    if event == 'UNIT_COMBAT' and (target == 'target' or target == 'player') then
        ShowOrHideRampageIcon()
        ShowOrHideBattleShoutIcon()
        ShowOrHideBloodrageIcon()
        ShowOrHideBerserkerRageIcon()
    end
end
-- Set the script for the UNIT COMBAT Event
player_dealt_damage_frame:SetScript("OnEvent", player_dealt_damage_event);

unit_power_freq_frame:SetScript("OnEvent", unit_power_freq_event)

local combat_ended_frame = CreateFrame("Frame", "combat_ended")
combat_ended_frame:RegisterEvent("PLAYER_LEAVE_COMBAT")

local function combat_ended(self, event, ...)
    rampage_icon_frame:Hide()
    battle_shout_icon_frame:Hide()
    bloodrage_icon_frame:Hide()
    berserker_rage_icon_frame:Hide()
end

combat_ended_frame:SetScript("OnEvent", combat_ended)