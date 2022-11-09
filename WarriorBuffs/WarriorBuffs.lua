local addonName, ns = ...

WarriorBuffsAddon = {}
local wba = WarriorBuffsAddon

local bloodsurgeId = 0
local bloodsurgeName = ""
local bloodsurgeIconFrame = CreateFrame("Frame", "bloodsurgeIcon", UIParent)

local battleShoutIconId = 0
local battleShoutName = ""
local battleShoutIconFrame = CreateFrame("Frame", "battleShourIcon", UIParent)

local bloodrageIconId = 0
local bloodrageName = ""
local bloodrageIconFrame = CreateFrame("Frame", "bloodrageIcon", UIParent)

local berserkerRageIconId = 0
local berserkerRageName = ""
local berserkerRageIconFrame = CreateFrame("Frame", "berserkerRageIcon", UIParent)

local victoryRushIconId = 0
local victoryRushName = ""
local victoryRushIconFrame = CreateFrame("Frame", "victoryRushIcon", UIParent)

local saveOnLogOff = false

local addonLoadedFrame = CreateFrame('Frame')
addonLoadedFrame:RegisterEvent('ADDON_LOADED')
addonLoadedFrame:SetScript('OnEvent', function(self, event, ...) wba[event](wba, ...) end)

function wba:ADDON_LOADED(name)
    if name == addonName then
        wba:SetDefaults()
       
        bloodsurgeName, bloodsurgeId = GetTalentInfo(2,23)
        bloodsurgeName = "Slam" -- Talent Name differs from Skill it effects
        bloodsurgeIconFrame:Hide()
        bloodsurgeIconFrame:SetFrameStrata("BACKGROUND")
        bloodsurgeIconFrame:SetParent(UIParent)
        bloodsurgeIconFrame:SetHeight(50)
        bloodsurgeIconFrame:SetWidth(50)
        bloodsurgeIconFrame:EnableMouse(true)
        bloodsurgeIconFrame:SetPoint(CharacterDB.bloodsurgeIconPoint.point, UIParent, CharacterDB.bloodsurgeIconPoint.ofsx, CharacterDB.bloodsurgeIconPoint.ofsy)
        bloodsurgeIconFrame.icon = bloodsurgeIconFrame:CreateTexture(nil, "ARTWORK")
        bloodsurgeIconFrame.icon:SetAllPoints(true)
        bloodsurgeIconFrame.icon:SetTexture(bloodsurgeId)
        bloodsurgeIconFrame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                bloodsurgeIconFrame:Hide()
            end
        end)

        battleShoutName, _, battleShoutIconId = GetSpellInfo("Battle Shout")
        battleShoutIconFrame:Hide()
        battleShoutIconFrame:SetFrameStrata("BACKGROUND")
        battleShoutIconFrame:SetParent(UIParent)
        battleShoutIconFrame:SetHeight(50)
        battleShoutIconFrame:SetWidth(50)
        battleShoutIconFrame:EnableMouse(true)
        battleShoutIconFrame:SetPoint(CharacterDB.battleShoutIconPoint.point, UIParent, CharacterDB.battleShoutIconPoint.ofsx, CharacterDB.battleShoutIconPoint.ofsy)
        battleShoutIconFrame.icon = battleShoutIconFrame:CreateTexture(nil, "ARTWORK")
        battleShoutIconFrame.icon:SetAllPoints(true)
        battleShoutIconFrame.icon:SetTexture(battleShoutIconId)
        battleShoutIconFrame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                battleShoutIconFrame:Hide()
            end
        end)

        bloodrageName, _, bloodrageIconId = GetSpellInfo("Bloodrage")
        bloodrageIconFrame:Hide()
        bloodrageIconFrame:SetFrameStrata("BACKGROUND")
        bloodrageIconFrame:SetParent(UIParent)
        bloodrageIconFrame:SetHeight(50)
        bloodrageIconFrame:SetWidth(50)
        bloodrageIconFrame:EnableMouse(true)
        bloodrageIconFrame:SetPoint(CharacterDB.bloodrageIconPoint.point, UIParent, CharacterDB.bloodrageIconPoint.ofsx, CharacterDB.bloodrageIconPoint.ofsy)
        bloodrageIconFrame.icon = bloodrageIconFrame:CreateTexture(nil, "ARTWORK")
        bloodrageIconFrame.icon:SetAllPoints(true)
        bloodrageIconFrame.icon:SetTexture(bloodrageIconId)
        bloodrageIconFrame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                bloodrageIconFrame:Hide()
            end
        end)

        berserkerRageName, _, berserkerRageIconId = GetSpellInfo("Berserker Rage")
        berserkerRageIconFrame:Hide()
        berserkerRageIconFrame:SetFrameStrata("BACKGROUND")
        berserkerRageIconFrame:SetParent(UIParent)
        berserkerRageIconFrame:SetHeight(50)
        berserkerRageIconFrame:SetWidth(50)
        berserkerRageIconFrame:EnableMouse(true)
        berserkerRageIconFrame:SetPoint(CharacterDB.berserkerRageIconPoint.point, UIParent, CharacterDB.berserkerRageIconPoint.ofsx, CharacterDB.berserkerRageIconPoint.ofsy)
        berserkerRageIconFrame.icon = berserkerRageIconFrame:CreateTexture(nil, "ARTWORK")
        berserkerRageIconFrame.icon:SetAllPoints(true)
        berserkerRageIconFrame.icon:SetTexture(berserkerRageIconId)
        berserkerRageIconFrame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                berserkerRageIconFrame:Hide()
            end
        end)

        victoryRushName, _, victoryRushIconId = GetSpellInfo("Victory Rush")
        victoryRushIconFrame:Hide()
        victoryRushIconFrame:SetFrameStrata("BACKGROUND")
        victoryRushIconFrame:SetParent(UIParent)
        victoryRushIconFrame:SetHeight(50)
        victoryRushIconFrame:SetWidth(50)
        victoryRushIconFrame:EnableMouse(true)
        victoryRushIconFrame:SetPoint(CharacterDB.victoryRushIconPoint.point, UIParent, CharacterDB.victoryRushIconPoint.ofsx, CharacterDB.victoryRushIconPoint.ofsy)
        victoryRushIconFrame.icon = victoryRushIconFrame:CreateTexture(nil, "ARTWORK")
        victoryRushIconFrame.icon:SetAllPoints(true)
        victoryRushIconFrame.icon:SetTexture(victoryRushIconId)
        victoryRushIconFrame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                victoryRushIconFrame:Hide()
            end
        end)
    end
end

local loginFrame = CreateFrame("Frame")
loginFrame:RegisterEvent("PLAYER_LOGIN")
loginFrame:SetScript('OnEvent', function(self, event, ...) wba[event](wba, ...) end)

function wba:PLAYER_LOGIN()
    wba:SetDefaults()
end

local logoutFrame = CreateFrame("Frame")
logoutFrame:RegisterEvent("PLAYER_LOGOUT")
logoutFrame:SetScript('OnEvent', function(self, event, ...) wba[event](wba, ...) end)

function wba:PLAYER_LOGOUT()
    if (CharacterDB.saveOnLogOff) then wba:Save() end
end

function wba:SetDefaults(reset)
    if not (type(reset) == "boolean") then reset = false end
    if CharacterDB == nil or reset then
        CharacterDB = {
            bloodsurgeIconPoint = {
                point = "CENTER",
                ofsx = 0,
                ofsy = 100
            },
            battleShoutIconPoint = {
                point = "CENTER",
                ofsx = 0,
                ofsy = 100
            },
            bloodrageIconPoint = {
                point = "CENTER",
                ofsx = 0,
                ofsy = 100
            },
            berserkerRageIconPoint = {
                point = "CENTER",
                ofsx = 0,
                ofsy = 100
            },
            victoryRushIconPoint = {
                point = "CENTER",
                ofsx = 0,
                ofsy = 100
            },
            saveOnLogOff = saveOnLogOff
        }
    else
        saveOnLogOff = CharacterDB.saveOnLogOff
    end
    if reset then
        bloodsurgeIconFrame:SetPoint(CharacterDB.bloodsurgeIconPoint.point, UIParent, CharacterDB.bloodsurgeIconPoint.ofsx, CharacterDB.bloodsurgeIconPoint.ofsy)
        battleShoutIconFrame:SetPoint(CharacterDB.battleShoutIconPoint.point, UIParent, CharacterDB.battleShoutIconPoint.ofsx, CharacterDB.battleShoutIconPoint.ofsy)
        bloodrageIconFrame:SetPoint(CharacterDB.bloodrageIconPoint.point, UIParent, CharacterDB.bloodrageIconPoint.ofsx, CharacterDB.bloodrageIconPoint.ofsy)
        berserkerRageIconFrame:SetPoint(CharacterDB.berserkerRageIconPoint.point, UIParent, CharacterDB.berserkerRageIconPoint.ofsx, CharacterDB.berserkerRageIconPoint.ofsy)
        victoryRushIconFrame:SetPoint(CharacterDB.victoryRushIconPoint.point, UIParent, CharacterDB.victoryRushIconPoint.ofsx, CharacterDB.victoryRushIconPoint.ofsy)
    end
end

function wba:GetStance()
    local active, stance
    for i = 1, GetNumShapeshiftForms() do
        _,active = GetShapeshiftFormInfo(i)
        if active then
            stance = i
        end
    end
    return stance
end

function wba:BuffTime(buffName)
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

function wba:IsActive(buffName)
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

function wba:IsOnCoolDown(name)
    local start, duration = GetSpellCooldown(name);
    if (start > 0 and duration > 0) then return true end
    return false
end

function wba:ShowOrHideBloodsurgeIcon()
    if not UnitAffectingCombat("player") then
        bloodsurgeIconFrame:Hide()
        return
    end
    local _, _, classId = UnitClass("player")
    if classId ~= 1 then
        bloodsurgeIconFrame:Hide()
        return
    end
    if wba:GetStance() ~= 3 then
        bloodsurgeIconFrame:Hide()
        return
    end
    if wba:IsActive(bloodsurgeName.."!") and IsUsableSpell(bloodsurgeName) then
        bloodsurgeIconFrame:Show()
    else
        bloodsurgeIconFrame:Hide() 
    end
end

function wba:ShowOrHideBattleShoutIcon()
    if not UnitAffectingCombat("player") then
        battleShoutIconFrame:Hide()
        return
    end
    local _, _, classId = UnitClass("player")
    if classId ~= 1 then
        battleShoutIconFrame:Hide()
        return
    end
    if wba:IsActive(battleShoutName) and IsUsableSpell(battleShoutName) then
        if wba:BuffTime(battleShoutName) > 11 then
            battleShoutIconFrame:Hide()
        else
            battleShoutIconFrame:Show()
        end
        return
    end
    if not wba:IsActive(battleShoutName) and IsUsableSpell(battleShoutName) then
        battleShoutIconFrame:Show()
    else
        battleShoutIconFrame:Hide()
    end
end

function wba:ShowOrHideBloodrageIcon()
    if not UnitAffectingCombat("player") then
        bloodrageIconFrame:Hide()
        return
    end
    local _, _, classId = UnitClass("player")
    if classId ~= 1 then
        bloodrageIconFrame:Hide()
        return
    end
    if wba:IsActive(bloodrageName) then
        bloodrageIconFrame:Hide()
        return
    end
    if wba:IsOnCoolDown(bloodrageName) then
        bloodrageIconFrame:Hide()
        return
    end
    if IsUsableSpell(bloodrageName) then
        bloodrageIconFrame:Show()
    else
        bloodrageIconFrame:Hide()
    end
end

function wba:ShowOrHideBerserkerRageIcon()
    if not UnitAffectingCombat("player") then
        berserkerRageIconFrame:Hide()
        return
    end
    if wba:GetStance() ~= 3 then
        berserkerRageIconFrame:Hide()
        return
    end
    local _, _, classId = UnitClass("player")
    if classId ~= 1 then
        berserkerRageIconFrame:Hide()
        return
    end
    if wba:IsActive(berserkerRageName) then
        berserkerRageIconFrame:Hide()
        return
    end
    if wba:IsOnCoolDown(berserkerRageName) then
        berserkerRageIconFrame:Hide()
        return
    end
    if IsUsableSpell(berserkerRageName) then
        berserkerRageIconFrame:Show()
    else
        berserkerRageIconFrame:Hide()
    end
end

function wba:ShowOrHideVictoryRush()
    local _, _, classId = UnitClass("player")
    if classId ~= 1 then
        victoryRushIconFrame:Hide()
        return
    end
    if IsUsableSpell(victoryRushName) then
        victoryRushIconFrame:Show()
    else
        victoryRushIconFrame:Hide()
    end
end

local unitPowerFreqFrame = CreateFrame("Frame", "unitPowerFreqFrame")
unitPowerFreqFrame:RegisterEvent("UNIT_POWER_FREQUENT")
unitPowerFreqFrame:SetScript("OnEvent", function(self, event, ...) wba[event](wba, ...) end)

function wba:UNIT_POWER_FREQUENT(unit, type)
    if unit == 'player' and string.lower(type) == "rage" then
        wba:ShowOrHideBloodrageIcon()
        wba:ShowOrHideBerserkerRageIcon()
        wba:ShowOrHideBattleShoutIcon()
        wba:ShowOrHideBloodsurgeIcon()
        wba:ShowOrHideVictoryRush()
    end
end

local playerDealtDamageFrame = CreateFrame("Frame", "playerDamage")
playerDealtDamageFrame:RegisterEvent("UNIT_COMBAT")
playerDealtDamageFrame:SetScript("OnEvent", function(self, event, ...) wba[event](wba, ...) end)

function wba:UNIT_COMBAT()
    wba:ShowOrHideBloodsurgeIcon()
    wba:ShowOrHideBattleShoutIcon()
    wba:ShowOrHideBloodrageIcon()
    wba:ShowOrHideBerserkerRageIcon()
    wba:ShowOrHideVictoryRush()
end

local combatEndedFrame = CreateFrame("Frame", "combatEnded")
combatEndedFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
combatEndedFrame:SetScript("OnEvent", function(self, event, ...) wba[event](wba, ...) end )

function wba:PLAYER_LEAVE_COMBAT()
    bloodsurgeIconFrame:Hide()
    battleShoutIconFrame:Hide()
    bloodrageIconFrame:Hide()
    berserkerRageIconFrame:Hide()
end

function wba:Save()
    local point, _, _, ofsx, ofsy = bloodsurgeIconFrame:GetPoint()
    CharacterDB.bloodsurgeIconPoint.point = point
    CharacterDB.bloodsurgeIconPoint.ofsx = ofsx
    CharacterDB.bloodsurgeIconPoint.ofsy = ofsy

    point, _, _, ofsx, ofsy = battleShoutIconFrame:GetPoint()
    CharacterDB.battleShoutIconPoint.point = point
    CharacterDB.battleShoutIconPoint.ofsx = ofsx
    CharacterDB.battleShoutIconPoint.ofsy = ofsy

    point, _, _, ofsx, ofsy = bloodrageIconFrame:GetPoint()
    CharacterDB.bloodrageIconPoint.point = point
    CharacterDB.bloodrageIconPoint.ofsx = ofsx
    CharacterDB.bloodrageIconPoint.ofsy = ofsy

    point, _, _, ofsx, ofsy = berserkerRageIconFrame:GetPoint()
    CharacterDB.berserkerRageIconPoint.point = point
    CharacterDB.berserkerRageIconPoint.ofsx = ofsx
    CharacterDB.berserkerRageIconPoint.ofsy = ofsy

    point, _, _, ofsx, ofsy = victoryRushIconFrame:GetPoint()
    CharacterDB.victoryRushIconPoint.point = point
    CharacterDB.victoryRushIconPoint.ofsx = ofsx
    CharacterDB.victoryRushIconPoint.ofsy = ofsy

    CharacterDB.saveOnLogOff = saveOnLogOff
end

function wba:ShowAllIcons()
    bloodsurgeIconFrame:Show()
    battleShoutIconFrame:Show()
    bloodrageIconFrame:Show()
    berserkerRageIconFrame:Show()
    victoryRushIconFrame:Show()
end

function wba:HideAllIcons()
    bloodsurgeIconFrame:Hide()
    battleShoutIconFrame:Hide()
    bloodrageIconFrame:Hide()
    berserkerRageIconFrame:Hide()
    victoryRushIconFrame:Hide()
end

function wba:Unlock()
    wba:ShowAllIcons()
    bloodsurgeIconFrame:SetMovable(true)
    bloodsurgeIconFrame:EnableMouse(true)
    bloodsurgeIconFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)
    bloodsurgeIconFrame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)
    battleShoutIconFrame:SetMovable(true)
    battleShoutIconFrame:EnableMouse(true)
    battleShoutIconFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)
    battleShoutIconFrame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)
    bloodrageIconFrame:SetMovable(true)
    bloodrageIconFrame:EnableMouse(true)
    bloodrageIconFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)
    bloodrageIconFrame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)
    berserkerRageIconFrame:SetMovable(true)
    berserkerRageIconFrame:EnableMouse(true)
    berserkerRageIconFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)
    berserkerRageIconFrame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)
    victoryRushIconFrame:SetMovable(true)
    victoryRushIconFrame:EnableMouse(true)
    victoryRushIconFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)
    victoryRushIconFrame:SetScript("OnMouseUp", function(self, button)
        if button == "LeftButton" and self.isMoving then
            self:StopMovingOrSizing();
            self.isMoving = false;
        end
    end)
end

function wba:Lock()
    wba:HideAllIcons()
    bloodsurgeIconFrame:SetMovable(false)
    bloodsurgeIconFrame:EnableMouse(false)
    bloodsurgeIconFrame:SetScript("OnMouseUp", nil)
    bloodsurgeIconFrame:SetScript("OnMouseDown", nil)
    bloodsurgeIconFrame:SetScript("OnMouseDown", function (self, button)
        if button=='RightButton' then
            victoryRushIconFrame:Hide()
        end
    end)
    
    battleShoutIconFrame:SetMovable(false)
    battleShoutIconFrame:EnableMouse(false)
    battleShoutIconFrame:SetScript("OnMouseUp", nil)
    battleShoutIconFrame:SetScript("OnMouseDown", nil)
    battleShoutIconFrame:SetScript("OnMouseDown", function (self, button)
        if button=='RightButton' then
            victoryRushIconFrame:Hide()
        end
    end)

    bloodrageIconFrame:SetMovable(false)
    bloodrageIconFrame:EnableMouse(false)
    bloodrageIconFrame:SetScript("OnMouseUp", nil)
    bloodrageIconFrame:SetScript("OnMouseDown", nil)
    bloodrageIconFrame:SetScript("OnMouseDown", function (self, button)
        if button=='RightButton' then
            victoryRushIconFrame:Hide()
        end
    end)

    berserkerRageIconFrame:SetMovable(false)
    berserkerRageIconFrame:EnableMouse(false)
    berserkerRageIconFrame:SetScript("OnMouseUp", nil)
    berserkerRageIconFrame:SetScript("OnMouseDown", nil)
    berserkerRageIconFrame:SetScript("OnMouseDown", function (self, button)
        if button=='RightButton' then
            victoryRushIconFrame:Hide()
        end
    end)

    victoryRushIconFrame:SetMovable(false)
    victoryRushIconFrame:EnableMouse(false)
    victoryRushIconFrame:SetScript("OnMouseUp", nil)
    victoryRushIconFrame:SetScript("OnMouseDown", nil)
    victoryRushIconFrame:SetScript("OnMouseDown", function (self, button)
        if button=='RightButton' then
            victoryRushIconFrame:Hide()
        end
    end)
    
end

function wba:Reset()
    wba:SetDefaults(true)
end

function wba:SetSaveOnLogOffFalse(solo)
    saveOnLogOff = false
end

function wba:SetSaveOnLogOffTrue(solo)
    saveOnLogOff = true
end

function wba:GetSaveOnLogOff()
    print("Save on log off: " .. tostring(saveOnLogOff))
end

ns.WarriorBuffs = {}
ns.WarriorBuffs.Unlock = wba.Unlock
ns.WarriorBuffs.Lock = wba.Lock
ns.WarriorBuffs.Save = wba.Save
ns.WarriorBuffs.Reset = wba.Reset
ns.WarriorBuffs.SetSaveOnLogOffTrue = wba.SetSaveOnLogOffTrue
ns.WarriorBuffs.SetSaveOnLogOffFalse = wba.SetSaveOnLogOffFalse
ns.WarriorBuffs.GetSaveOnLogOff = wba.GetSaveOnLogOff