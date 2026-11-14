--- data-updates.lua

if settings.startup["pysimple-turds"].value then -- "rebalance turd values"
    local recipe_changes = {
        ["zogna-bacteria-darkness"] = {{res="zogna-bacteria", mult=1.1}},
        ["log3-cheap"] = {{ing="ash", mult=1.5}},
        ["log6-cheap"] = {{ing="ash", mult=1.5}},
        ["fish-hydrolysate-cooling"] = {{res="fish-hydrolysate", mult=2}},
        ["breed-fish-egg-1-doused"] = {{res="fish-oil", mult=4}},
        ["breed-fish-egg-2-doused"] = {{res="fish-oil", mult=4}, {res="fish-hydrolysate", mult=4}},
        ["breed-fish-egg-3-doused"] = {{res="fish-oil", mult=4}, {res="fish-hydrolysate", mult=4}, {res="fishmeal", mult=4}},
        ["breed-fish-egg-4-doused"] = {{res="fish-oil", mult=4}, {res="fish-hydrolysate", mult=4}, {res="fishmeal", mult=4}, {res="fish-emulsion", mult=4}},
        ["seaweed-1-dry"] = {{res="seaweed", mult=1.2}},
        ["seaweed-2-dry"] = {{res="seaweed", mult=1.2}},
        ["seaweed-3-dry"] = {{res="seaweed", mult=1.2}},
        ["seaweed-4-dry"] = {{res="seaweed", mult=1.2}},
        ["seaweed-5-dry"] = {{res="seaweed", mult=1.2}},
        ["py-science-pack-1-turd"] = {{res="py-science-pack-1", mult=2.4}},
        ["py-science-pack-2-turd"] = {{res="py-science-pack-2", mult=1.5}},
    }
    for name,infos in pairs(recipe_changes) do
        local recipe = data.raw.recipe[name]
        if recipe then
            for _,info in pairs(infos) do
                if info.ing then
                    for i,ingredient in pairs(recipe.ingredients) do
                        if ingredient.name == info.ing then
                            recipe.ingredients[i].amount = math.floor(recipe.ingredients[i].amount * info.mult)
                        end
                    end
                elseif info.res then
                    for i,result in pairs(recipe.results) do
                        if result.name == info.res then
                            recipe.results[i].amount = math.floor(recipe.results[i].amount * info.mult)
                        end
                    end
                end
            end
        end
    end
    -- TODO: Add notes to descriptions similar to how speed multipliers are shown
    if data.raw.module["self-generation-module-mk01"] then
        data.raw.module["self-generation-module-mk01"].effect.productivity = 1.5
        data.raw.module["self-generation-module-mk02"].effect.productivity = 1.5
        data.raw.module["self-generation-module-mk03"].effect.productivity = 1.5
        data.raw.module["self-generation-module-mk04"].effect.productivity = 1.5
    end
    if data.raw.module["py-sawblade-module-mk01"] then
        data.raw.module["py-sawblade-module-mk01"].effect.productivity = 0.02
        data.raw.module["py-sawblade-module-mk02"].effect.productivity = 0.03
        data.raw.module["py-sawblade-module-mk03"].effect.productivity = 0.04
        data.raw.module["py-sawblade-module-mk04"].effect.productivity = 0.05
    end

    local recipe_speed_multipliers = {
        ["fiber-dry-storage"] = 5,
        ["ash-sap"] = 8,
        {names={"ulric-1-manure", "ulric-2-manure", "ulric-3-manure", "ulric-4-manure"}, mult=1.2},
        ["xyhiphoe-single"] = 3,
        {names={"quantum-dots-folding-1", "quantum-dots-folding-2", "quantum-dots-folding-3", "quantum-dots-folding-4"}, mult=10},
    }
    --- Multiplies the speed of a recipe and adds the multiplier to its description
    function multiply_recipe_speed(name, mult)
        local recipe = data.raw.recipe[name]
        if recipe then
            if recipe.energy_required then
                recipe.energy_required = recipe.energy_required / mult
                py.add_to_description(recipe, nil, {"description.pysimple-speed-mult", "×"..mult})
            end
        end
    end
    -- Increases speeds for recipes according to the above table
    for name,info in pairs(recipe_speed_multipliers) do
        if type(info) == "number" then
            multiply_recipe_speed(name, info)
        else
            for _,name in pairs(info.names) do
                multiply_recipe_speed(name, info.mult)
            end
        end
    end
end

if settings.startup["pysimple-misc"].value then -- "other balance changes"
    local recipe_changes = {
        ["saline-water"] = {{ing="stone", mult=2}, {ing="water", mult=2}, {res="water-saline", mult=2}},
        ["gravel-saline-water"] = {{ing="water", mult=2}, {res="water-saline", mult=2}},
        ["workers-food"] = {{res="workers-food", mult=3}},
        ["iron-slime"] = {{res="iron-slime", mult=5}},
        ["chitin-void"] = {{res="carbolic-oil", mult=2}, {res="naphthalene-oil", mult=2}},
        ["chitin-to-geothermal-water"] = {{res="geothermal-water", mult=4}}, 
        ["biomass-molten-salt-01"] = {{ing="biocrud", mult=2}},
        ["biomass-molten-salt-02"] = {{ing="biocrud", mult=2}},
        ["biomass-molten-salt-03"] = {{ing="biocrud", mult=2}},
        ["biomass-molten-salt-04"] = {{ing="biocrud", mult=2}},
        ["minor-extract-gas-from-coalbed-3"] = {{ing="oxygen", mult=0.2}},
        ["extract-gas-from-coalbed-3"] = {{ing="oxygen", mult=0.2}},
        ["extract-gas-from-coalbed-4"] = {{ing="oxygen", mult=0.2}},
        ["coalbed-gas-to-co2"] = {{ing="hot-air", mult=0.2}},
        ["coalbed-gas-to-hydrogen"] = {{ing="hot-air", mult=0.2}},
        ["coalbed-gas-to-syngas"] = {{ing="hot-air", mult=0.2}},
        ["coalbed-gas-to-acidgas"] = {{ing="hot-air", mult=0.2}},
        ["coalbed-gas-to-refsyngas"] = {{ing="hot-air", mult=1/3}},
        ["full-render-phagnots"] = {{res="gas-bladder", mult=2}},
        ["full-render-phagnots-lard"] = {{res="gas-bladder", mult=2}},
        ["full-render-phagnots-laser"] = {{res="gas-bladder", mult=2}},
        ["full-render-phagnots-music"] = {{res="gas-bladder", mult=2}},
        ["ex-gut-phag"] = {{res="gas-bladder", mult=2}},
    }
    for name,infos in pairs(recipe_changes) do
        local recipe = data.raw.recipe[name]
        if recipe then
            for _,info in pairs(infos) do
                if info.ing then
                    for i,ingredient in pairs(recipe.ingredients) do
                        if ingredient.name == info.ing then
                            recipe.ingredients[i].amount = math.floor(recipe.ingredients[i].amount * info.mult)
                        end
                    end
                elseif info.res then
                    for i,result in pairs(recipe.results) do
                        if result.name == info.res then
                            recipe.results[i].amount = math.floor(recipe.results[i].amount * info.mult)
                        end
                    end
                end
            end
        end
    end
    if data.raw.recipe["saline-water"] then
        data.raw.recipe["saline-water"].energy_required = 40
        data.raw.recipe["gravel-saline-water"].energy_required = 40
    end
    if data.raw.accumulator["accumulator"] then
        data.raw.accumulator["accumulator"].energy_source.input_flow_limit = "3MW"
        data.raw.accumulator["accumulator"].energy_source.output_flow_limit = "3MW"
    end
    if data.raw.item["workers-food"] then
        data.raw.item["workers-food"].stack_size = 40
        data.raw.item["workers-food-02"].stack_size = 20
        data.raw.item["workers-food-03"].stack_size = 20
    end
    if data.raw["assembling-machine"]["py-biomass-powerplant-mk01"] then
        data.raw["assembling-machine"]["py-biomass-powerplant-mk01"].energy_usage = 8 .. "MW"
        data.raw["assembling-machine"]["py-biomass-powerplant-mk02"].energy_usage = 20 .. "MW"
        data.raw["assembling-machine"]["py-biomass-powerplant-mk03"].energy_usage = 30 .. "MW"
        data.raw["assembling-machine"]["py-biomass-powerplant-mk04"].energy_usage = 40 .. "MW"
    end

    if data.raw["electric-pole"]["substation"] and data.raw["electric-pole"]["substation"].supply_area_distance < 14 then
        data.raw["electric-pole"]["substation"].supply_area_distance = 14
    end
    if data.raw["electric-pole"]["substation"] and data.raw["electric-pole"]["substation"].maximum_wire_distance < 28 then
        data.raw["electric-pole"]["substation"].maximum_wire_distance = 28
    end

    if data.raw["rail-support"] and data.raw["rail-support"]["rail-support"] and data.raw["rail-support"]["rail-support"].support_range < 15 then
        data.raw["rail-support"]["rail-support"].support_range = 15
    end
    if data.raw["rail-ramp"] and data.raw["rail-ramp"]["rail-ramp"] and data.raw["rail-ramp"]["rail-ramp"].support_range < 13 then
        data.raw["rail-ramp"]["rail-ramp"].support_range = 13
    end
    if data.raw["rail-ramp"] and data.raw["rail-ramp"]["dummy-rail-ramp"] and data.raw["rail-ramp"]["dummy-rail-ramp"].support_range < 13 then
        data.raw["rail-ramp"]["dummy-rail-ramp"].support_range = 13
    end

    local auogs = {["module"] = {"auog", "auog-mk02", "auog-mk03", "auog-mk04"}, ["item"] = {"charged-auog"}}
    for kind,names in pairs(auogs) do
        for _,auog in pairs(names) do
            if data.raw[kind][auog] then
                data.raw[kind][auog].fuel_value = util.parse_energy(data.raw[kind][auog].fuel_value) * 60 * 2 .. "W"
            end
        end
    end

    if data.raw["pipe-to-ground"]["pipe-to-ground"] and data.raw["pipe-to-ground"]["niobium-pipe-to-ground"] and data.raw["pipe-to-ground"]["ht-pipes-to-ground"] then
        data:extend({
            {
                type = "recipe",
                name = "niobium-pipe-to-ground-upgrading",
                enabled = false,
                energy_required = 4,
                crafting_categories = {"crafting"},
                ingredients = {
                    { type = "item", name = "pipe-to-ground", amount = 2 },
                    { type = "item", name = "niobium-plate", amount = 5 },
                },
                results = {
                    { type = "item", name = "niobium-pipe-to-ground", amount = 2 }
                }
            },
            {
                type = "recipe",
                name = "ht-pipe-to-ground-upgrading",
                enabled = false,
                energy_required = 4,
                crafting_categories = {"crafting"},
                ingredients = {
                    { type = "item", name = "niobium-pipe-to-ground", amount = 2 },
                    { type = "item", name = "titanium-plate", amount = 3 },
                    { type = "item", name = "plastic-bar", amount = 3 },
                    { type = "item", name = "rubber", amount = 13 },
                },
                results = {
                    { type = "item", name = "ht-pipes-to-ground", amount = 2 }
                }
            },
        })
        table.insert( data.raw.technology["niobium"].effects, {type = "unlock-recipe", recipe = "niobium-pipe-to-ground-upgrading"} )
        table.insert( data.raw.technology["coal-processing-3"].effects, {type = "unlock-recipe", recipe = "ht-pipe-to-ground-upgrading"} )
    end
end
