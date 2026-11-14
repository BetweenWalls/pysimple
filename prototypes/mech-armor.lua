--- mech-armor.lua

if feature_flags["space_travel"] and settings.startup["pysimple-graphics"].value and mods["mech-armor"] then
    data.raw.armor["heavy-armor"].icon = data.raw.armor["modular-armor"].icon
    data.raw.technology["heavy-armor"].icon = data.raw.technology["modular-armor"].icon

    local modular_armor = table.deepcopy(data.raw.armor["power-armor"])
    modular_armor.name = data.raw.armor["modular-armor"].name
    modular_armor.resistances = data.raw.armor["modular-armor"].resistances
    modular_armor.subgroup = data.raw.armor["modular-armor"].subgroup
    modular_armor.order = data.raw.armor["modular-armor"].order
    modular_armor.equipment_grid = data.raw.armor["modular-armor"].equipment_grid
    modular_armor.inventory_size_bonus = data.raw.armor["modular-armor"].inventory_size_bonus
    modular_armor.factoriopedia_simulation = data.raw.armor["modular-armor"].factoriopedia_simulation
    modular_armor.weight = data.raw.armor["modular-armor"].weight
    data.raw.armor["modular-armor"] = modular_armor
    data.raw.technology["modular-armor"].icon = data.raw.technology["power-armor-mk2"].icon

    local power_armor = table.deepcopy(data.raw.armor["mech-armor"])
    power_armor.name = data.raw.armor["power-armor"].name
    power_armor.resistances = data.raw.armor["power-armor"].resistances
    power_armor.subgroup = data.raw.armor["power-armor"].subgroup
    power_armor.order = data.raw.armor["power-armor"].order
    power_armor.equipment_grid = data.raw.armor["power-armor"].equipment_grid
    power_armor.inventory_size_bonus = data.raw.armor["power-armor"].inventory_size_bonus
    power_armor.weight = data.raw.armor["power-armor"].weight
    data.raw.armor["power-armor"] = power_armor
    data.raw.technology["power-armor"].icon = "__mech-armor__/graphics/technology/mech-armor.png"

    local power_armor_mk2 = table.deepcopy(data.raw.armor["mech-armor"])
    power_armor_mk2.name = data.raw.armor["power-armor-mk2"].name
    power_armor_mk2.resistances = data.raw.armor["power-armor-mk2"].resistances
    power_armor_mk2.subgroup = data.raw.armor["power-armor-mk2"].subgroup
    power_armor_mk2.order = data.raw.armor["power-armor-mk2"].order
    power_armor_mk2.equipment_grid = data.raw.armor["power-armor-mk2"].equipment_grid
    power_armor_mk2.inventory_size_bonus = data.raw.armor["power-armor-mk2"].inventory_size_bonus
    power_armor_mk2.weight = data.raw.armor["power-armor-mk2"].weight
    data.raw.armor["power-armor-mk2"] = power_armor_mk2
    data.raw.armor["power-armor-mk2"].icons = {
        {icon = data.raw.armor["power-armor-mk2"].icon, icon_size = data.raw.armor["power-armor-mk2"].icon_size},
        {icon = "__pysimple__/graphics/mech-armor-mk2-icon.png", icon_size = 64}
    }
    data.raw.technology["power-armor-mk2"].icon = "__mech-armor__/graphics/technology/mech-armor.png"

    for i,animation in pairs(data.raw.character.character.animations) do
        if animation.armors then
            for j,armor in pairs(animation.armors) do
                if armor == "modular-armor" or armor == "power-armor-mk2" then
                    data.raw.character.character.animations[i].armors[j] = nil
                end
            end
            for j,armor in pairs(animation.armors) do
                if armor == "power-armor" then
                    data.raw.character.character.animations[i].armors[j] = "modular-armor"
                end
            end
            for j,armor in pairs(animation.armors) do
                if armor == "mech-armor" then
                    table.insert(data.raw.character.character.animations[i].armors, "power-armor")
                    table.insert(data.raw.character.character.animations[i].armors, "power-armor-mk2")
                end
            end
        end
    end

    data.raw.armor["mech-armor"].hidden = true
    data.raw.recipe["mech-armor"].hidden = true
    data.raw.technology["mech-armor"].hidden = true
end
