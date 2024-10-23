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
        name = "pysimple-descriptions",
        setting_type = "startup",
        default_value = true,
        order = "b"
    },
    {
        type = "string-setting",
        name = "pysimple-tech-tree",
        setting_type = "startup",
        allowed_values = {"1", "2", "3"},
        default_value = "3",
        order = "c"
    },
    {
        type = "bool-setting",
        name = "pysimple-saline-water",
        setting_type = "startup",
        default_value = false,
        order = "d"
    },
    {
        type = "bool-setting",
        name = "pysimple-storage-tanks",
        setting_type = "startup",
        default_value = false,
        order = "e"
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