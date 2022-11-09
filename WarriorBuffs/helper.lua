--[[ Helpers ]]
local addon_name, ns = ...

-- Container for helper functions
ns.helper = {}

-- Round Function
-- x = value to round
-- n = decimal places
local function round(x, n)
	n = 10^(n or 0)
	x = x * n
	if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
	return x / n
end

ns.helper.round = round