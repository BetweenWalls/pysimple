--- settings.lua

data:extend ({
    {
        type = "bool-setting",
        name = "pysimple-enemies",
        setting_type = "startup",
        default_value = false,
        order = "a"
    },
    {
        type = "bool-setting",
        name = "pysimple-storage-tanks",
        setting_type = "startup",
        default_value = false,
        hidden = true,
        order = "b"
    }
})

if data.raw["bool-setting"]["py-tank-adjust"] ~= nil then
    data.raw["bool-setting"]["py-tank-adjust"].default_value = true
end
if data.raw["bool-setting"]["future-beacons"] ~= nil then
    data.raw["bool-setting"]["future-beacons"].default_value = true
end