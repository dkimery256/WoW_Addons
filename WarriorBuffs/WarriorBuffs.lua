local addonName, ns = ...

WarriorBuffsAddon = {}
local wba = WarriorBuffsAddon

local rampageIconId = 0
local rampageName = ""
local rampageIconFrame = CreateFrame("Frame", "rapmageIcon", UIParent)

local battleShoutIconId = 0
local battleShoutName = ""
local battleShoutIconFrame = CreateFrame("Frame", "battleShourIcon", UIParent)

local bloodrageIconId = 0
local bloodrageName = ""
local bloodrageIconFrame = CreateFrame("Frame", "bloodrageIcon", UIParent)

local berserkerRageIconId = 0
local berserkerRageName = ""
local berserkerRageIconFrame = CreateFrame("Frame", "berserkerRageIcon", UIParent)

local saveOnLogOff = false

local addonLoadedFrame = CreateFrame('Frame')
addonLoadedFrame:RegisterEvent('ADDON_LOADED')
addonLoadedFrame:SetScript('OnEvent', function(self, event, ...) wba[event](wba, ...) end)

function wba:ADDON_LOADED(name)
    if name == addonName then
        rampageName, _, rampageIconId = GetSpellInfo('Rampage')
        rampageIconFrame:Hide()
        rampageIconFrame:SetFrameStrata("BACKGROUND")
        rampageIconFrame:SetParent(UIParent)
        rampageIconFrame:SetHeight(50)
        rampageIconFrame:SetWidth(50)
        rampageIconFrame:EnableMouse(true)
        rampageIconFrame:SetPoint(CharacterDB.rampageIconPoint.point, UIParent, CharacterDB.rampageIconPoint.ofsx, CharacterDB.rampageIconPoint.ofsy)
        rampageIconFrame.icon = rampageIconFrame:CreateTexture(nil, "ARTWORK")
        rampageIconFrame.icon:SetAllPoints(true)
        rampageIconFrame.icon:SetTexture(rampageIconId)
        rampageIconFrame:SetScript("OnMouseDown", function (self, button)
            if button=='RightButton' then
                rampageIconFrame:Hide()
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
            rampageIconPoint = {
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
            saveOnLogOff = saveOnLogOff
        }
    else
        saveOnLogOff = CharacterDB.saveOnLogOff
    end
    if reset then
        rampageIconFrame:SetPoint(CharacterDB.rampageIconPoint.point, UIParent, CharacterDB.rampageIconPoint.ofsx, CharacterDB.rampageIconPoint.ofsy)
        battleShoutIconFrame:SetPoint(CharacterDB.battleShoutIconPoint.point, UIParent, CharacterDB.battleShoutIconPoint.ofsx, CharacterDB.battleShoutIconPoint.ofsy)
        bloodrageIconFrame:SetPoint(CharacterDB.bloodrageIconPoint.point, UIParent, CharacterDB.bloodrageIconPoint.ofsx, CharacterDB.bloodrageIconPoint.ofsy)
        berserkerRageIconFrame:SetPoint(CharacterDB.berserkerRageIconPoint.point, UIParent, CharacterDB.berserkerRageIconPoint.ofsx, CharacterDB.berserkerRageIconPoint.ofsy)
    end
end

function wba:GetStance()
    local IsActive, stance
    for i = 1, GetNumShapeshiftForms() do
        _,_,IsActive = GetShapeshiftFormInfo(i)
        if IsActive then
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

function wba:ShowOrHideRampageIcon()
    if not UnitAffectingCombat("player") then
        rampageIconFrame:Hide()
        return
    end
    local _, _, classId = UnitClass("player")
    if classId ~= 1 then
        rampageIconFrame:Hide()
        return
    end
    if wba:GetStance() ~= 3 then
        rampageIconFrame:Hide()
    end
    if wba:IsActive(rampageName) and IsUsableSpell(rampageName) then
        if wba:BuffTime(rampageName) > 11 then
            rampageIconFrame:Hide()
        else
            rampageIconFrame:Show()
        end
        return
    end
    if not wba:IsActive(rampageName) and IsUsableSpell(rampageName) then
        rampageIconFrame:Show()
    else
        rampageIconFrame:Hide()
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

local unitPowerFreqFrame = CreateFrame("Frame", "unitPowerFreqFrame")
unitPowerFreqFrame:RegisterEvent("UNIT_POWER_FREQUENT")
unitPowerFreqFrame:SetScript("OnEvent", function(self, event, ...) wba[event](wba, ...) end)

function wba:UNIT_POWER_FREQUENT(unit, type)
    if unit == 'player' and string.lower(type) == "rage" then
        wba:ShowOrHideBloodrageIcon()
        wba:ShowOrHideBerserkerRageIcon()
        wba:ShowOrHideBattleShoutIcon()
        wba:ShowOrHideRampageIcon()
    end
end

local playerDealtDamageFrame = CreateFrame("Frame", "playerDamage")
playerDealtDamageFrame:RegisterEvent("UNIT_COMBAT")
playerDealtDamageFrame:SetScript("OnEvent", function(self, event, ...) wba[event](wba, ...) end)

function wba:UNIT_COMBAT()
    wba:ShowOrHideRampageIcon()
    wba:ShowOrHideBattleShoutIcon()
    wba:ShowOrHideBloodrageIcon()
    wba:ShowOrHideBerserkerRageIcon()
end

local combatEndedFrame = CreateFrame("Frame", "combatEnded")
combatEndedFrame:RegisterEvent("PLAYER_LEAVE_COMBAT")
combatEndedFrame:SetScript("OnEvent", function(self, event, ...) wba[event](wba, ...) end )

function wba:PLAYER_LEAVE_COMBAT()
    rampageIconFrame:Hide()
    battleShoutIconFrame:Hide()
    bloodrageIconFrame:Hide()
    berserkerRageIconFrame:Hide()
end

function wba:Save()
    local point, _, _, ofsx, ofsy = rampageIconFrame:GetPoint()
    CharacterDB.rampageIconPoint.point = point
    CharacterDB.rampageIconPoint.ofsx = ofsx
    CharacterDB.rampageIconPoint.ofsy = ofsy

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

    CharacterDB.saveOnLogOff = saveOnLogOff
end

function wba:ShowAllIcons()
    rampageIconFrame:Show()
    battleShoutIconFrame:Show()
    bloodrageIconFrame:Show()
    berserkerRageIconFrame:Show()
end

function wba:HideAllIcons()
    rampageIconFrame:Hide()
    battleShoutIconFrame:Hide()
    bloodrageIconFrame:Hide()
    berserkerRageIconFrame:Hide()
end

function wba:Unlock()
    wba:ShowAllIcons()
    rampageIconFrame:SetMovable(true)
    rampageIconFrame:EnableMouse(true)
    rampageIconFrame:SetScript("OnMouseDown", function(self, button)
        if button == "LeftButton" and not self.isMoving then
            self:StartMoving();
            self.isMoving = true;
        end
    end)
    rampageIconFrame:SetScript("OnMouseUp", function(self, button)
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
end

function wba:Lock()
    wba:HideAllIcons()
    rampageIconFrame:SetMovable(false)
    rampageIconFrame:EnableMouse(false)
    rampageIconFrame:SetScript("OnMouseDown", nil)
    rampageIconFrame:SetScript("OnMouseUp", nil)
    battleShoutIconFrame:SetMovable(false)
    battleShoutIconFrame:EnableMouse(false)
    battleShoutIconFrame:SetScript("OnMouseDown", nil)
    battleShoutIconFrame:SetScript("OnMouseUp", nil)
    bloodrageIconFrame:SetMovable(false)
    bloodrageIconFrame:EnableMouse(false)
    bloodrageIconFrame:SetScript("OnMouseDown", nil)
    bloodrageIconFrame:SetScript("OnMouseUp", nil)
    berserkerRageIconFrame:SetMovable(false)
    berserkerRageIconFrame:EnableMouse(false)
    berserkerRageIconFrame:SetScript("OnMouseDown", nil)
    berserkerRageIconFrame:SetScript("OnMouseUp", nil)
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