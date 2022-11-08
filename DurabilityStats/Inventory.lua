local addon_name, ns = ...

local Inventory = {}

-- Inventory Slots Id Constants
local InventorySlotConstants = {
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

-- Inventory Slots Names
local InventorySlotNames = {
	"HEADSLOT",
	"SHOULDERSLOT",
	"CHESTSLOT",
	"WAISTSLOT",
	"LEGSSLOT",
	"FEETSLOT",
	"WRISTSLOT",
	"HANDSSLOT",
	"MAINHANDSLOT",
	"SECONDARYHANDSLOT"
}

-- Inventory Label Name
local InventorySlotLabels = {
	"Head",
	"Shoulders",
	"Chest",
	"Waist",
	"Legs",
	"Feet",
	"Wrist",
	"Hands",
	"Main Hand",
	"Off Hand"
}

local Slot = {}
Slot.__index = Slot
function Slot:Create(id, name, label)
    local this = {
		id = id or 0,
		name = name or "",
		label = label or "",
		frame = CreateFrame("Frame", name)
	}
	setmetatable(this, Slot)
	return this
end

function Slot:GetDurabilityPercent()
	local current, maximum = GetInventoryItemDurability(self.id)
	if current ~= nil then
        return ns.math_helper.percent(current, maximum)
    else
        return 'N/A'
    end
end

function Slot:GetItemName()
	local itemName = GetItemInfo(GetInventoryItemLink("player", self.id))
	return itemName
end

Inventory = {
	Head      = Slot:Create(InventorySlotConstants[1], InventorySlotNames[1], InventorySlotLabels[1]),
	Shoulders = Slot:Create(InventorySlotConstants[2], InventorySlotNames[2], InventorySlotLabels[2]),
	Chest     = Slot:Create(InventorySlotConstants[3], InventorySlotNames[3], InventorySlotLabels[3]),
	Waist     = Slot:Create(InventorySlotConstants[4], InventorySlotNames[4], InventorySlotLabels[4]),
	Legs      = Slot:Create(InventorySlotConstants[5], InventorySlotNames[5], InventorySlotLabels[5]),
	Feet      = Slot:Create(InventorySlotConstants[6], InventorySlotNames[6], InventorySlotLabels[6]),
	Wrist     = Slot:Create(InventorySlotConstants[7], InventorySlotNames[7], InventorySlotLabels[7]),
	Hands     = Slot:Create(InventorySlotConstants[8], InventorySlotNames[8], InventorySlotLabels[8]),
	MainHand  = Slot:Create(InventorySlotConstants[9], InventorySlotNames[9], InventorySlotLabels[9]),
	OffHand   = Slot:Create(InventorySlotConstants[10], InventorySlotNames[10], InventorySlotLabels[10]),
	GetAllItemsDurabilityPercent = function ()
		local current, maximum = 0, 0
		local curTotal, maxTotal = 0, 0
		for k, v in pairs(Inventory) do
			if (getmetatable(v) == Slot) then
				current, maximum = GetInventoryItemDurability(v.id)
				if current ~= nil then
					curTotal = curTotal + current
					maxTotal = maxTotal + maximum
				end
			end
		end
		return ns.math_helper.percent(curTotal, maxTotal)
	end
}

ns.Inventory = Inventory