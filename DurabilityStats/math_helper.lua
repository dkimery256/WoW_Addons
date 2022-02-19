--[[ Math Helpers ]]
local addon_name, ns = ...

ns.math_helper = {}

-- Get the percent of current and max values
local function percent(curr, max)
    return math.floor(tonumber(string.format("%.2f", (curr / max * 100))))
end

-- Get the percentage of a value
local function percentage_of(perc, max)
    if type(perc) == "string" then
        perc = string.gsub(perc, "%%", "")
        perc = string.gsub(perc, " ", "")
        perc = tonumber(perc)
    end

    return (perc * 0.01) * max
end

ns.math_helper.percent = percent
ns.math_helper.percentage_of = percentage_of