local addon_name, ns = ...

-- Inventory Slots
local inventorySlotConstants = {
	INVSLOT_HEAD,
	INVSLOT_SHOULDER,
	INVSLOT_CHEST,
	INVSLOT_WAIST,
	INVSLOT_LEGS,
	INVSLOT_FEET,
	INVSLOT_WRIST,
	INVSLOT_HAND,
	INVSLOT_MAINHAND,
	INVSLOT_OFFHAND
}

local inventorySlotNames = {
    'Head',
    'Shoulder',
    'Chest',
    'Waist',
    'Legs',
    'Feet',
    'Wrist',
    'Hands',
    'Main Hand',
    'Off Hand'
}

-- Colorize Chat base off of our msg and percent values
local function colorize_chat(msg, percent)
    if percent == 'N/A' then
        print('|cffffcc00'.. msg .. ': |r' .. percent)
        return
    end

    if percent >= 75 and percent <= 100 then
        print('|cffffcc00'.. msg .. ': |r|cff00cf07' .. percent .. '%|r')
    elseif percent >= 50 and percent < 75 then
        print('|cffffcc00'.. msg .. ': |r|cfff7f707' .. percent .. '%|r')
    elseif percent >=25 and percent < 50 then
        print('|cffffcc00'.. msg .. ': |r|cffffb300' .. percent .. '%|r')
    elseif percent >=0 and percent < 25 then
        print('|cffffcc00'.. msg .. ': |r|cffe60000' .. percent .. '%|r')
    end
end

-- Colorize Status bar based of our percent value
local function colorize_bar(bar, percent)
    percent = string.gsub(percent, "%%", "")
    percent = string.gsub(percent, " ", "")
    percent = tonumber(percent)
    if percent >= 75 and percent <= 100 then
        bar:SetColorTexture(0, 1, 0, 1)
    elseif percent >= 50 and percent < 75 then
        bar:SetColorTexture(1, 1, 0, 1)
    elseif percent >= 25 and percent < 50 then
        bar:SetColorTexture(1, 0.5, 0, 1)
    elseif percent >= 0 and percent < 25 then
        bar:SetColorTexture(1, 0, 0, 1)
    end
end

-- Get the total percentage of all your equipment
local function total_equipment(toChat)
    toChat = toChat or false
    local curTotal = 0
    local maxTotal = 0

    for key, value in pairs(inventorySlotConstants) do
        local current, maximum = GetInventoryItemDurability(value)
        if current ~= nil then
            curTotal = curTotal + current
            maxTotal = maxTotal + maximum
        end
    end
    if toChat then
        colorize_chat("All Slots", ns.math_helper.percent(curTotal, maxTotal))
        return
    end
    return ns.math_helper.percent(curTotal, maxTotal)
end

local function single_slot(index)
    local slot = inventorySlotConstants[index]
    local curr, max = GetInventoryItemDurability(slot)
    local percent
    if curr ~= nil then
        percent = ns.math_helper.percent(curr, max)
    else
        percent = 'N/A'
    end
    colorize_chat(inventorySlotNames[index] .. ' Slot', percent)
end

-- Lets start with slash commands for testing
local function durabilityStats(msg, editbox)
    msg = string.lower(msg)
    -- Total
    if msg == '-t' or msg == 'total' then
	    total_equipment(true)
    end

    -- Head
    if msg == '-hd' or msg == 'head' then
        single_slot(1)
    end

    -- Shoulders
    if msg == '-s' or msg == 'shoulders' then
        single_slot(2)
    end

    -- Chest
    if msg == '-c' or msg == 'chest' then
        single_slot(3)
    end

    -- Waist
    if msg == '-wat' or msg == 'waist' then
        single_slot(4)
    end

    -- Legs
    if msg == '-l' or msg == 'legs' then
        single_slot(5)
    end

    -- Feet
    if msg == '-f' or msg == 'feet' then
        single_slot(6)
    end

    -- Wrist
    if msg == '-wrt' or msg == 'wrist' then
        single_slot(7)
    end

    -- Hands
    if msg == '-hds' or msg == 'hands' then
        single_slot(8)
    end

    -- Main Hand
    if msg == '-m' or msg == 'main' then
        single_slot(9)
    end

    -- Off Hand
    if msg == '-o' or msg == 'off' then
        single_slot(10)
    end
end

SLASH_DS1 = '/ds'

SlashCmdList["DS"] = durabilityStats

-- Frame container for our status bar
local ds_container = CreateFrame("Frame", "ds_container", UIParent)
ds_container:SetFrameStrata("HIGH")
ds_container:SetWidth(85)
ds_container:SetHeight(12)
ds_container:SetPoint("CENTER",0, 0)
ds_container:Show()

-- Background for main ds container
local ds_container_background = ds_container:CreateTexture("ds_container_background","BACKGROUND")
ds_container_background:SetColorTexture(0, 0, 0, 0.6)
ds_container_background:SetAllPoints(ds_container)
ds_container.texture = ds_container_background

-- Frame for our status text
local ds_status_text = CreateFrame("Frame", "ds_status_text", ds_container)
ds_status_text:SetFrameStrata("HIGH")
ds_status_text:SetWidth(75)
ds_status_text:SetHeight(10)
ds_status_text:SetAlpha(1)
ds_status_text:SetPoint("CENTER", 0, 0)
ds_status_text.text = ds_status_text:CreateFontString(nil, "ARTWORK")
ds_status_text.text:SetPoint("CENTER", 0, 0)
ds_status_text.text:SetFont("Fonts\\ARIALN.ttf", 12, "OUTLINE")
ds_status_text:Hide()
ds_status_text.text:SetText(total_equipment())

-- Frame for our durability status bar
local ds_status_bar = CreateFrame("Frame", "ds_status_bar", ds_container)
ds_container:SetFrameStrata("HIGH")
ds_status_bar:SetWidth(ns.math_helper.percentage_of(total_equipment(), 85))
ds_status_bar:SetHeight(12)
ds_status_bar:SetPoint("LEFT",0, 0)
ds_status_bar:Show()

-- Background for the status bar frame
local ds_status_bar_background = ds_status_bar:CreateTexture("ds_status_bar_background", "BACKGROUND")
ds_status_bar_background:SetAllPoints(ds_status_bar)
ds_status_bar_background.texture = ds_container_background
colorize_bar(ds_status_bar_background, total_equipment())

-- Show Text on mouse over
-- Also, we need to be able to move the bar
ds_container:SetMovable(true)
ds_container:EnableMouse(true)
ds_container:SetScript('OnEnter',
    function()
        ds_status_text.text:SetText("Durability: " .. total_equipment() .. "%")
        ds_status_text:Show()
    end
)
ds_container:SetScript('OnLeave', function() ds_status_text:Hide() end)
ds_container:SetScript("OnMouseDown", function(self, button)
    if button == "LeftButton" and not self.isMoving then
        self:StartMoving();
        self.isMoving = true;
    end
end)
ds_container:SetScript("OnMouseUp", function(self, button)
    if button == "LeftButton" and self.isMoving then
        self:StopMovingOrSizing();
        self.isMoving = false;
    end
end)

-- Register UNIT COMBAT Event
local player_damage_frame = CreateFrame("Frame", "playerDamage")
player_damage_frame:RegisterEvent("UNIT_COMBAT")

-- Function for UNIT COMBAT Event
local function player_took_damage_event(self, event, ...)
    local target = ...
    if event == 'UNIT_COMBAT' and target == 'player' then
        ds_status_text.text:SetText(total_equipment())
        colorize_bar(ds_status_bar_background, total_equipment())
        ds_status_bar:SetWidth(ns.math_helper.percentage_of(total_equipment(), 85))
    end
end

-- Set the script for the UNIT COMBAT Event
player_damage_frame:SetScript("OnEvent", player_took_damage_event);

--[[ Register MERCHANT CLOSED Event
local player_left_merchant_frame = CreateFrame("Frame", "playerLeftMerchant")
player_left_merchant_frame:RegisterEvent("MERCHANT_CLOSED")

-- Function for MERCHANT CLOSED Event
local function player_left_merchant_event(self, event, ...)
    if event == 'MERCHANT_CLOSED' then
        ds_status_text.text:SetText(total_equipment())
        colorize_bar(ds_status_bar_background, total_equipment())
        ds_status_bar:SetWidth(ns.math_helper.percentage_of(total_equipment(), 85))
    end
end

-- Set the script for the MERCHANT CLOSED Event
player_left_merchant_frame:SetScript("OnEvent", player_left_merchant_event);
]]

-- Register UPDATE_INVENTORY_DURABILITY Event
local update_inventory_durability_frame = CreateFrame("Frame", "update_inventory_durability")
update_inventory_durability_frame:RegisterEvent("UPDATE_INVENTORY_DURABILITY")

-- Function for UPDATE_INVENTORY_DURABILITY Event
local function update_inventory_durability_event(self, event, ...)
    local target = ...
    if event == 'UPDATE_INVENTORY_DURABILITY' then
        ds_status_text.text:SetText(total_equipment())
        colorize_bar(ds_status_bar_background, total_equipment())
        ds_status_bar:SetWidth(ns.math_helper.percentage_of(total_equipment(), 85))
    end
end

-- Set the script for the BAG UPDATE Event
update_inventory_durability_frame:SetScript("OnEvent", update_inventory_durability_event);

-- Register BAG UPDATE Event
local player_bag_update_frame = CreateFrame("Frame", "playerBagUpdate")
player_bag_update_frame:RegisterEvent("BAG_UPDATE")

-- Function for BAG UPDATE Event
local function player_bag_update_event(self, event, ...)
    if event == 'BAG_UPDATE' then
        ds_status_text.text:SetText(total_equipment())
        colorize_bar(ds_status_bar_background, total_equipment())
        ds_status_bar:SetWidth(ns.math_helper.percentage_of(total_equipment(), 85))
    end
end

-- Set the script for the BAG UPDATE Event
player_bag_update_frame:SetScript("OnEvent", player_bag_update_event);