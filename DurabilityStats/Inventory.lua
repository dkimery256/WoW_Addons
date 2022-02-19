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

local Slot = { percent = 0, curr = 0, max = 0 }
function Slot:new(slot)
	setmetatable({}, Slot)
    self.curr, self.max = GetInventoryItemDurability(slot)
    if self.curr ~= nil then
        self.percent = ns.math_helper.percent(self.curr, self.max)
    else
        self.percent = 'N/A'
    end
    return self
end

local Inventory = {
	head = "",
	shoulders = "",
	chest = "",
	waist = "",
}