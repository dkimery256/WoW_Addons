-- Get Health String
local function GetHealth()
    local health = UnitHealth('target')
    if (health > 0) then
        return health .. ' / ' .. UnitHealthMax('target')
    else
        return ""
    end
end

-- Health Text override
TargetFrameTextureFrame:CreateFontString("TargetFrameHealthBarText", "BORDER", "TextStatusBarText")
TargetFrameHealthBarText:SetPoint("CENTER", TargetFrameTextureFrame, "CENTER", -50, 3)
TargetFrameHealthBarText:Hide()

-- Register the PLAYER_TARGET_CHANGED Event
local target_changed_frame = CreateFrame("Frame", "target_changed_frame")
target_changed_frame:RegisterEvent("PLAYER_TARGET_CHANGED")

-- Function for the PLAYER_TARGET_CHANGED Event
local function target_changed_event(self, event, ...)
    if event == 'PLAYER_TARGET_CHANGED' then
        TargetFrameHealthBarText:SetText(GetHealth())
        TargetFrameHealthBar:SetScript("OnEnter",function (self, event, ...)
            TargetFrameHealthBarText:Show()
        end)
        TargetFrameHealthBar:SetScript("OnLeave", function (self, event, ...)
            TargetFrameHealthBarText:Hide()
        end)
    end
end

-- Set Script for the PLAYER_TARGET_CHANGED Event
target_changed_frame:SetScript("OnEvent", target_changed_event)

-- Register UNIT COMBAT Event
local player_dealt_damage_frame = CreateFrame("Frame", "playerDamage")
player_dealt_damage_frame:RegisterEvent("UNIT_COMBAT")

-- Function for UNIT COMBAT Event
local function player_dealt_damage_event(self, event, ...)
    local target = ...
    if event == 'UNIT_COMBAT' and target == 'target' then
        TargetFrameHealthBarText:SetText(GetHealth())
    end
end

-- Set the script for the UNIT COMBAT Event
player_dealt_damage_frame:SetScript("OnEvent", player_dealt_damage_event);