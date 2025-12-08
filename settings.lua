--- settings.lua

data:extend ({
    {
        type = "bool-setting",
        name = "pysimple-recipe-menu",
        setting_type = "startup",
        default_value = true,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "pysimple-graphics",
        setting_type = "startup",
        default_value = true,
        order = "b"
    },
    {
        type = "string-setting",
        name = "pysimple-descriptions",
        setting_type = "startup",
        allowed_values = {"1", "2", "3"},
        default_value = "3",
        order = "c"
    },
    {
        type = "string-setting",
        name = "pysimple-tech-tree",
        setting_type = "startup",
        allowed_values = {"1", "2", "3"},
        default_value = "3",
        order = "d"
    },
    {
        type = "bool-setting",
        name = "pysimple-storage-tanks",
        setting_type = "startup",
        default_value = false,
        order = "e"
    },
    {
        type = "bool-setting",
        name = "pysimple-storage-chests",
        setting_type = "startup",
        default_value = false,
        order = "f"
    },
    {
        type = "bool-setting",
        name = "pysimple-faster-recipes",
        setting_type = "startup",
        default_value = false,
        order = "g"
    },
    {
        type = "bool-setting",
        name = "pysimple-brains",
        setting_type = "startup",
        default_value = false,
        order = "h"
    },
    {
        type = "bool-setting",
        name = "pysimple-misc",
        setting_type = "startup",
        default_value = false,
        order = "i"
    },
})

if data.raw["bool-setting"]["py-tank-adjust"] ~= nil then
    data.raw["bool-setting"]["py-tank-adjust"].default_value = true
end
if data.raw["bool-setting"]["future-beacons"] ~= nil then
    data.raw["bool-setting"]["future-beacons"].default_value = true
end
if data.raw["bool-setting"]["pypp-big-inventory-gui"] ~= nil then
    data.raw["bool-setting"]["pypp-big-inventory-gui"].default_value = true
end

if mods["PyBlock"] or mods["pystellarexpedition"] then
    data.raw["string-setting"]["pysimple-tech-tree"].hidden = true
else
    data.raw["string-setting"]["pysimple-tech-tree"].hidden = false
end

if mods["pyhardmode"] then
    data.raw["bool-setting"]["pysimple-storage-chests"].hidden = true
else
    data.raw["bool-setting"]["pysimple-storage-chests"].hidden = false
end
