--- data-final-fixes.lua

--- Adds a technology as a prerequisite
--- @param tech string
--- @param new_prereq string
--- @param old_prereq string? if provided, will be removed from this technology
function add_prerequisite(tech, new_prereq, old_prereq)
    if data.raw.technology[tech] and data.raw.technology[tech].prerequisites then
        local already_exists = false
        local prereqs = data.raw.technology[tech].prerequisites or data.raw.technology[tech].normal.prerequisites or {}
        for i,prereq in pairs(prereqs) do
            if prereq == new_prereq then already_exists = true end
            if old_prereq and prereq == old_prereq then
                table.remove(data.raw.technology[tech].prerequisites, i)
            end
        end
        if not already_exists then
            table.insert(data.raw.technology[tech].prerequisites, new_prereq)
        end
        data.raw.technology[tech].prerequisites = remove_duplicates(data.raw.technology[tech].prerequisites)
    end
end

--- Changes where a recipe gets unlocked
--- @param recipe string
--- @param new_tech string
--- @param old_tech string? if provided, recipe will be removed from this technology
--- @param index int? if provided, recipe will be inserted into this index
function add_unlock(recipe, new_tech, old_tech, index)
    if data.raw.technology[new_tech] then
        if old_tech and data.raw.technology[old_tech] then
            for i,effect in pairs(data.raw.technology[old_tech].effects) do
                if effect.type == "unlock-recipe" and effect.recipe == recipe then
                    table.remove(data.raw.technology[old_tech].effects, i)
                end
            end
        end
        if index then
            table.insert( data.raw.technology[new_tech].effects, index, {type = "unlock-recipe", recipe = recipe} )
        else
            table.insert( data.raw.technology[new_tech].effects, {type = "unlock-recipe", recipe = recipe} )
        end
    end
end

--- Removes ingredients from the given recipe
--- @param recipe string
--- @param target_ingredients table
function remove_ingredients(recipe, target_ingredients)
    if data.raw.recipe[recipe].ingredients then
        for i,ingredient in pairs(data.raw.recipe[recipe].ingredients) do
            for j,target in pairs(target_ingredients) do
                if (ingredient.name and ingredient.name == target) or ingredient[1] == target then
                    table.remove(data.raw.recipe[recipe].ingredients, i)
                    i = i - 1
                end
            end
        end
    end
end

--- Replaces ingredients for the given recipes
--- @param recipes table strings
--- @param replacees table strings - ingredients to be replaced
--- @param replacement string ingredient which will replace the others
function replace_ingredients(recipes, replacees, replacement)
    for i,recipe in pairs(recipes) do
        for j,ingredient in pairs(data.raw.recipe[recipe].ingredients) do
            if ingredient.name and replacees[ingredient.name] then
                data.raw.recipe[recipe].ingredients[j].name = replacement
            elseif ingredient.name == nil and replacees[ ingredient[1] ] then
                data.raw.recipe[recipe].ingredients[j][1] = replacement
            end
        end
    end
end

--- Convert an ordered table to a key-value table with values of "true"
--- @param input table
--- @return table
function key_list(input)
    local output = {}
    for _,v in ipairs(input) do
        output[v] = true
    end
    return output
end

--- Removes duplicate values from a table
--- @param input table
--- @return table
function remove_duplicates(input)
    local output = {}
    local hash = {}
    for _,v in ipairs(input) do
        if (not hash[v]) then
            output[#output+1] = v
            hash[v] = true
        end
    end
    return output
end

-- repositions military technologies deeper into the tech tree (if biters are disabled)
if settings.startup["pysimple-enemies"].value == false then
    data.raw.technology["gun-turret"].unit.ingredients = {{name="automation-science-pack", amount=3}, {name="py-science-pack-1", amount=2}, {name="logistic-science-pack", amount=1}}
    data.raw.technology["stone-wall"].unit.ingredients = {{name="automation-science-pack", amount=3}, {name="py-science-pack-1", amount=2}, {name="logistic-science-pack", amount=1}}
    data.raw.technology["gate"].unit.ingredients = {{name="automation-science-pack", amount=3}, {name="py-science-pack-1", amount=2}, {name="logistic-science-pack", amount=1}}
    data.raw.technology["fluid-processing-machines-1"].unit.ingredients = {{name="automation-science-pack", amount=2}, {name="py-science-pack-1", amount=1}}
    data.raw.technology["military"].unit.ingredients = {{name="automation-science-pack", amount=2}, {name="py-science-pack-1", amount=1}}
    data.raw.technology["physical-projectile-damage-1"].unit.ingredients = {{name="automation-science-pack", amount=3}, {name="py-science-pack-1", amount=2}, {name="logistic-science-pack", amount=1}}
    data.raw.technology["weapon-shooting-speed-1"].unit.ingredients = {{name="automation-science-pack", amount=3}, {name="py-science-pack-1", amount=2}, {name="logistic-science-pack", amount=1}}
    add_prerequisite("gun-turret", "logistic-science-pack")
    add_prerequisite("stone-wall", "logistic-science-pack")
    add_prerequisite("fluid-processing-machines-1", "py-science-pack-mk01")
end

add_prerequisite("coal-processing-1", "automation")
add_prerequisite("soil-washing", "steel-processing")
add_prerequisite("fluid-pressurization", "acetylene")
add_prerequisite("fluid-pressurization", "glass", "steel-processing")
add_prerequisite("basic-substrate", "genetics-mk01", "vacuum-tube-electronics")
add_prerequisite("moss-mk01", "mining-with-fluid", "botany-mk01")
add_prerequisite("wood-processing", "botany-mk01")
add_prerequisite("acetylene", "concrete", "tar-processing")
add_prerequisite("solder-mk01", "tar-processing")
add_prerequisite("kerogen", "glass", "steel-processing")

add_unlock("extract-limestone-01", "steel-processing", "coal-processing-1", 1)
add_unlock("hpf", "concrete", nil, 1)
add_unlock("hpf", "mining-with-fluid", "coal-processing-1")
add_unlock("coke-co2", "mining-with-fluid", "coal-processing-1")
add_unlock("gasifier", "acetylene", "tar-processing", 2)
add_unlock("tinned-cable", "petri-dish", "mining-with-fluid", 1)
add_unlock("zinc-plate-1", "solder-mk01", "vacuum-tube-electronics", 1)
add_unlock("methanal", "moondrop", "vacuum-tube-electronics")
add_unlock("graphite", "fluid-pressurization", "vacuum-tube-electronics")
add_unlock("vacuum-tube", "fluid-pressurization", "vacuum-tube-electronics")
add_unlock("cellulose-00", "wood-processing", "vacuum-tube-electronics")
add_unlock("saline-water", "crusher", "vacuum-tube-electronics", 7)

-- adjusts balance slightly so that the recipe which uses more processing isn't less efficient
data.raw.recipe["saline-water"].ingredients = {{type="item", name="stone", amount=20}, {type="fluid", name="water", amount=200}}
data.raw.recipe["gravel-saline-water"].ingredients = {{type="item", name="gravel", amount=15}, {type="fluid", name="water", amount=200}}
data.raw.recipe["saline-water"].results = {{type="fluid", name="water-saline", amount=100}}
data.raw.recipe["gravel-saline-water"].results = {{type="fluid", name="water-saline", amount=100}}

local multi_recipes = {
    "distilled-raw-coal", "coal-gas", "coal-gas-from-coke", "coal-gas-from-wood",
    "soil-washing",
    "ash-separation", "soot-separation",
    "grade-1-iron-crush", "lime",
    "tar-distilation", "tar-refining", "tar-refining-tops", "light-oil-aromatics", "pitch-refining", "tar-quenching",
    "tailings-dust",
    "acetylene",
    "syngas",
    "scrude-refining",
    "hydrogen", "chlorine",
    "grade-2-copper", "grade-1-copper-crush",
    "full-render-vrauks",
    "uncaged-vrauks",
}
for i,recipe in pairs(multi_recipes) do
    data.raw.recipe[recipe].localised_name = {"recipe-name."..recipe}
end

-- optional storage tank adjustments (work-in-progress)
if settings.startup["pysimple-storage-tanks"].value == true then
    local storage_tanks = {
        {id="storage-tank", capacity=150, ingredients={{"pipe", 5}, {"iron-stick", 10}, {"steel-plate", 15}, {"iron-plate", 20}}},
        {id="py-tank-1000", capacity=250, order="b", ingredients={{"pipe", 10}, {"iron-stick", 40}, {"lead-plate", 20}}},
        {id="py-tank-1500", capacity=250, order="b", ingredients={{"pipe", 10}, {"iron-stick", 40}, {"lead-plate", 20}}},
        {id="py-tank-3000", capacity=100, order="a", ingredients={{"pipe", 5}, {"duralumin", 5}, {"lead-plate", 10}}},
        {id="py-tank-4000", capacity=250, order="b", ingredients={{"pipe", 10}, {"iron-stick", 40}, {"lead-plate", 20}}},
        {id="py-tank-5000", capacity=750, order="d", ingredients={{"storage-tank", 1}, {"pipe", 10}, {"iron-stick", 30}, {"lead-plate", 30}}},
        {id="py-tank-6500", capacity=750, order="d", ingredients={{"storage-tank", 1}, {"pipe", 10}, {"iron-stick", 30}, {"lead-plate", 30}}},
        {id="py-tank-7000", capacity=700, order="c", ingredients={{"storage-tank", 1}, {"pipe", 10}, {"iron-stick", 20}, {"lead-plate", 20}}},
        {id="py-tank-8000", capacity=1250, order="e", ingredients={{"storage-tank", 2}, {"pipe", 10}, {"iron-stick", 20}, {"duralumin", 10}, {"lead-plate", 20}}},
        {id="py-tank-9000", capacity=1800, order="f", ingredients={{"storage-tank", 3}, {"pipe", 10}, {"iron-stick", 20}, {"iron-plate", 20}, {"duralumin", 15}, {"lead-plate", 20}}},
        {id="py-tank-10000", capacity=2500, order="g", ingredients={{"storage-tank", 4}, {"pipe", 10}, {"iron-stick", 20}, {"steel-plate", 20}, {"duralumin", 20}, {"lead-plate", 20}}},
    }
    -- capacities and recipes are standardized
    for i,tank in pairs(storage_tanks) do
        data.raw["storage-tank"][tank.id].fluid_box.base_area = tank.capacity
        data.raw["storage-tank"][tank.id].localised_name = {"name.storage", tank.capacity/10}
        data.raw.recipe[tank.id].ingredients = tank.ingredients
        if i > 1 then data.raw.recipe[tank.id].order = "a-c"..tank.order.."[py-items]" end
    end

    -- both disposal entities become available at the same time, a basic low-efficiency storage tank becomes available soon after, and the tailings pond can be moved deeper into the tech tree and made more expensive to reflect its enormous capacity
    data.raw.recipe["py-sinkhole"].ingredients = {{"pipe", 20}, {"stone-brick", 50}, {"offshore-pump", 5}, {"iron-plate", 20}}
    data.raw.recipe["tailings-pond"].ingredients = {{"pipe", 15}, {"refined-concrete", 100}, {"iron-stick", 40}, {"steel-plate", 30}}
    add_unlock("py-sinkhole", "coal-processing-1", "steel-processing")
    add_unlock("storage-tank", "steel-processing", "py-storage-tanks")
    add_unlock("tailings-pond", "concrete", "coal-processing-1")

    add_unlock("py-tank-3000", "py-storage-tanks", "py-storage-tanks", 1)
    add_unlock("py-tank-7000", "py-storage-tanks", "py-storage-tanks", 5)

    -- each tier of machines uses a different storage tank
    local replacees = key_list({"storage-tank", "py-tank-1000", "py-tank-1500", "py-tank-3000", "py-tank-4000", "py-tank-5000", "py-tank-6500", "py-tank-7000", "py-tank-8000", "py-tank-9000", "py-tank-10000"})
    local recipes_using_storage = {"genlab-mk01", "leaching-station-mk01", "wet-scrubber-mk01", "py-heat-exchanger", "mixer-mk01"}
    replace_ingredients(recipes_using_storage, replacees, "storage-tank")
    recipes_using_storage = {"fluid-separator-mk02", "gasifier-mk02", "olefin-plant-mk02", "rectisol-mk02", "flotation-cell-mk02", "leaching-station-mk02", "wet-scrubber-mk02", "py-heat-exchanger-mk02", "reformer-mk02", "cooling-tower-mk02", "rennea-plantation-mk02"}
    replace_ingredients(recipes_using_storage, replacees, "py-tank-3000")
    recipes_using_storage = {"fluid-separator-mk03", "gasifier-mk03", "olefin-plant-mk03", "rectisol-mk03", "flotation-cell-mk03", "leaching-station-mk03", "wet-scrubber-mk03", "py-heat-exchanger-mk03", "casting-unit-mk03", "smelter-mk03"}
    replace_ingredients(recipes_using_storage, replacees, "py-tank-6500")
    recipes_using_storage = {"fluid-separator-mk04", "gasifier-mk04", "olefin-plant-mk04", "rectisol-mk04", "flotation-cell-mk04", "leaching-station-mk04", "wet-scrubber-mk04", "py-heat-exchanger-mk04", "casting-unit-mk04", "ree-mining-drill-mk04"}
    replace_ingredients(recipes_using_storage, replacees, "py-tank-8000")

    -- since the basic storage tank is guaranteed to be unlocked before this point, some adjustments are made to remove redundant connections and one related ingredient
    remove_ingredients("genlab-mk01", {"plastic-bar"})
    add_prerequisite("genetics-mk01", "alloys-mk01", "py-storage-tanks")
    add_prerequisite("genetics-mk01", "alloys-mk01", "plastics")
    add_prerequisite("biotech-machines-mk01", "plastics")
    add_prerequisite("scrude", "electrolysis", "py-storage-tanks")
    add_prerequisite("py-science-pack-mk02", "py-storage-tanks")
elseif settings.startup["py-tank-adjust"].value then
    -- renames and sorts storage tanks by their capacity and dimensions
    local storage_tanks = {
        {id="py-tank-1000", capacity=100, order="ab"},
        {id="py-tank-1500", capacity=150, order="b"},
        {id="py-tank-3000", capacity=100, order="aa"},
        {id="py-tank-4000", capacity=275, order="c"},
        {id="py-tank-5000", capacity=650, order="d"},
        {id="py-tank-6500", capacity=750, order="f"},
        {id="py-tank-7000", capacity=700, order="e"},
        {id="py-tank-8000", capacity=1250, order="g"},
        {id="py-tank-9000", capacity=1800, order="h"},
        {id="py-tank-10000", capacity=2500, order="i"}
    }
    for i,tank in pairs(storage_tanks) do
        data.raw["storage-tank"][tank.id].localised_name = {"name.storage", data.raw["storage-tank"][tank.id].fluid_box.base_area/10}
        data.raw.recipe[tank.id].order = "a-c"..tank.order.."[py-items]"
    end
    add_unlock("py-tank-3000", "py-storage-tanks", "py-storage-tanks", 1)
    add_unlock("py-tank-7000", "py-storage-tanks", "py-storage-tanks", 6)
end

-- reordering recipe unlocks by priority - recipes which need to be used first will be listed first
add_unlock("distilator", "coal-processing-1", "coal-processing-1", 1)
add_unlock("distilled-raw-coal", "coal-processing-1", "coal-processing-1", 2)
add_unlock("coal-gas", "coal-processing-1", "coal-processing-1", 3)
add_unlock("coal-gas-from-coke", "coal-processing-1", "coal-processing-1", 4)
add_unlock("coal-gas-from-wood", "coal-processing-1", "coal-processing-1", 5)
add_unlock("py-gas-vent", "coal-processing-1", "coal-processing-1", 6)
add_unlock("iron-oxide-smelting", "coal-processing-1", "coal-processing-1")

add_unlock("clay-pit-mk01", "ceramic", "ceramic", 1)

add_unlock("jaw-crusher", "crusher", "crusher", 1)
add_unlock("bricks-to-stone", "crusher", "crusher", 2)

add_unlock("lime", "concrete", "concrete", 2)
add_unlock("refined-concrete", "concrete", "concrete", 5)
add_unlock("refined-hazard-concrete", "concrete", "concrete", 6)

add_unlock("sand-brick", "tar-processing", "tar-processing", 2)
add_unlock("stone-brick-2", "tar-processing", "tar-processing", 7)
add_unlock("light-oil-aromatics", "tar-processing", "tar-processing", 8)
add_unlock("tar-quenching", "tar-processing", "tar-processing")

add_unlock("treated-wood", "creosote", "creosote")
add_unlock("small-electric-pole-2", "creosote", "creosote")

add_unlock("moondrop-codex", "moondrop", "moondrop", 1)
add_unlock("moondrop-sample", "moondrop", "moondrop", 2)
add_unlock("moondrop-seeds", "moondrop", "moondrop", 3)
add_unlock("moondrop-1", "moondrop", "moondrop", 5)

add_unlock("sap-extractor-mk01", "sap-mk01", "sap-mk01")
add_unlock("sap-01", "sap-mk01", "sap-mk01")

add_unlock("vacuum-pump-mk01", "fluid-pressurization", "fluid-pressurization", 1)
add_unlock("pressured-water", "fluid-pressurization", "fluid-pressurization", 4)

add_unlock("wood-seeds", "wood-processing", "wood-processing", 1)
add_unlock("wood-seedling", "wood-processing", "wood-processing", 2)
add_unlock("tree", "wood-processing", "wood-processing", 3)
add_unlock("fwf-mk01", "wood-processing", "wood-processing", 4)

add_unlock("evaporator", "fluid-processing-machines-1", "fluid-processing-machines-1", 1)
add_unlock("gun-powder", "military", "military", 3)

add_unlock("battery-mk00", "vacuum-tube-electronics", "vacuum-tube-electronics", 3)
add_unlock("pulp-mill-mk01", "vacuum-tube-electronics", "vacuum-tube-electronics", 4)
add_unlock("pcb-factory-mk01", "vacuum-tube-electronics", "vacuum-tube-electronics", 6)
add_unlock("chipshooter-mk01", "vacuum-tube-electronics", "vacuum-tube-electronics", 8)

add_unlock("automated-screener-mk01", "copper-mk01", "copper-mk01", 1)

add_unlock("biofactory-mk01", "plastics", "plastics", 1)

add_unlock("reformer-mk01", "scrude", "scrude", 1)

add_unlock("py-tank-10000", "py-storage-tanks", "py-storage-tanks", 10)

add_unlock("vrauks-codex", "vrauks", "vrauks", 1)
add_unlock("vrauks-paddock-mk01", "vrauks", "vrauks", 3)
add_unlock("vrauks-cocoon-1", "vrauks", "vrauks", 3)
add_unlock("vrauks-1", "vrauks", "vrauks", 5)

add_unlock("dried-meat-01", "rendering", "rendering")

add_unlock("research-center-mk01", "py-science-pack-mk01", "py-science-pack-mk01")
add_unlock("py-science-pack-1", "py-science-pack-mk01", "py-science-pack-mk01")


--- The following code is copied from Tech Tree Trimmer by _CodeGreen:

-- fetch all science packs
local pack_names = {} ---@type table<string, true>
for _, lab in pairs(data.raw.lab) do
    for _, input in pairs(lab.inputs) do
        pack_names[input] = true
    end
end

-- fetch pack unlock technologies
local pack_technologies = {} ---@type table<string, string>
for tech_name, technology in pairs(data.raw.technology) do
    local normal, expensive = technology.normal, technology.expensive
    if normal then
        for k, v in pairs(normal) do
            technology[k] = v
        end
    elseif expensive then
        for k, v in pairs(expensive) do
            technology[k] = v
        end
    end
    technology.normal, technology.expensive = nil, nil
    if technology.effects then
        for _, effect in pairs(technology.effects) do
            if effect.recipe and pack_names[effect.recipe] then
                pack_technologies[effect.recipe] = tech_name
            end
        end
    end
end

-- generate table of dependencies
local dependencies = {} ---@type table<string, table<string, true>>
local base_technologies = {} ---@type table<string, true>
local function generate_dependencies()
    dependencies = {}
    base_technologies = {}
    for name, technology in pairs(data.raw.technology) do
        local prerequisites = technology.prerequisites
        if prerequisites and type(prerequisites) == "table" and #prerequisites == 0 then
            technology.prerequisites = nil
            prerequisites = nil
        end
        if technology.prerequisites then
            for _, prerequisite in pairs(technology.prerequisites) do
                dependencies[prerequisite] = dependencies[prerequisite] or {}
                dependencies[prerequisite][technology.name] = true
            end
        else
            for _, ingredient in pairs(technology.unit.ingredients) do
                local pack = ingredient[1] or ingredient.name
                local pack_technology = pack_technologies[pack]
                if pack_technology then
                    prerequisites = technology.prerequisites or {}
                    technology.prerequisites = prerequisites
                    for _, prerequisite in pairs(technology.prerequisites) do
                        if prerequisite == pack_technology then goto forelse end
                    end
                    prerequisites[#prerequisites+1] = pack_technology
                    dependencies[pack_technology] = dependencies[pack_technology] or {}
                    dependencies[pack_technology][technology.name] = true
                    ::forelse::
                end
            end
            if not technology.prerequisites then
                base_technologies[technology.name] = true
            end
        end
    end
end
generate_dependencies()

-- propogate required packs to dependency technologies
local requirements = {} ---@type table<string, table<string, true>>
local checked = {} ---@type table<string, true>
local function propogate_requirements(name)
    local technology = data.raw.technology[name]
    if technology.prerequisites then
        for _, prerequisite in pairs(technology.prerequisites) do
            if not checked[prerequisite] then return end
        end
    end
    if dependencies[name] then
        for dependency in pairs(dependencies[name]) do
            requirements[dependency] = requirements[dependency] or {}
            for _, ingredient in pairs(technology.unit.ingredients) do
                local pack = ingredient[1] or ingredient.name
                requirements[dependency][pack] = true
            end
            if requirements[name] then
                for ingredient in pairs(requirements[name]) do
                    requirements[dependency][ingredient] = true
                end
            end
            if technology.effects then
                for _, effect in pairs(technology.effects) do
                    if effect.recipe and pack_names[effect.recipe] then
                        requirements[dependency][effect.recipe] = true
                    end
                end
            end
        end
        checked[name] = true
        for dependency in pairs(dependencies[name]) do
            propogate_requirements(dependency)
        end
    end
end
for name in pairs(base_technologies) do
    propogate_requirements(name)
end

-- add missing prerequisites to technologies
local checked = {} ---@type table<string, true>
local function propogate_prerequisites(name)
    local technology = data.raw.technology[name]
    if technology.prerequisites then
        for _, prerequisite in pairs(technology.prerequisites) do
            if not checked[prerequisite] then return end
        end
        requirements[name] = requirements[name] or {}
        for _, prerequisite in pairs(technology.prerequisites) do
            if requirements[prerequisite] then
                for requirement in pairs(requirements[prerequisite]) do
                    requirements[name][requirement] = true
                end
            end
            for _, ingredient in pairs(data.raw.technology[prerequisite].unit.ingredients) do
                local pack = ingredient[1] or ingredient.name
                requirements[name][pack] = true
            end
        end
    end
    for _, ingredient in pairs(technology.unit.ingredients) do
        if not requirements[name] then goto continue end
        local pack = ingredient[1] or ingredient.name
        if requirements[name][pack] then goto continue end
        local pack_technology = pack_technologies[pack]
        local has_prerequisite = false
        if technology.prerequisites then
            for _, prerequisite in pairs(technology.prerequisites) do
                if prerequisite == pack_technology then has_prerequisite = true end
            end
        end
        if not has_prerequisite and pack_technology then
            technology.prerequisites = technology.prerequisites or {}
            technology.prerequisites[#technology.prerequisites+1] = pack_technology
            if requirements[pack_technology] then
                for requirement in pairs(requirements[pack_technology]) do
                    requirements[name][requirement] = true
                end
            end
            for _, ingredient in pairs(data.raw.technology[pack_technology].unit.ingredients) do
                local pack = ingredient[1] or ingredient.name
                requirements[name][pack] = true
            end
        end
        ::continue::
    end
    checked[name] = true
    if dependencies[name] then
        for dependency in pairs(dependencies[name]) do
            propogate_prerequisites(dependency)
        end
    end
end
for name in pairs(base_technologies) do
    propogate_prerequisites(name)
end

-- trim redundant prerequisites
local checked = {} ---@type table<string, true>
local requirements = {} ---@type table<string, table<string, true>>
local function trim_prerequisites(current_techs)
    local next_techs = {}
    for name in pairs(current_techs) do
        local technology = data.raw.technology[name]
        if not technology.prerequisites then goto continue end
        local prerequisites = technology.prerequisites --[[@as string[] ]]
        for i, prerequisite in pairs(prerequisites) do
            for _, prereq in pairs(prerequisites) do
                if requirements[prereq] and requirements[prereq][prerequisite] then
                    prerequisites[i] = nil
                    dependencies[prereq][name] = nil
                end
            end
        end
        ::continue::
    end
    for name in pairs(current_techs) do
        checked[name] = true
    end
    for name in pairs(current_techs) do
        if not dependencies[name] then goto continue end
        for dependency in pairs(dependencies[name]) do
            requirements[dependency] = requirements[dependency] or {}
            requirements[dependency][name] = true
            for requirement in pairs(requirements[name]) do
                requirements[dependency][requirement] = true
            end
            for _, prerequisite in pairs(data.raw.technology[dependency].prerequisites) do
                if not checked[prerequisite] then goto skip end
            end
            next_techs[dependency] = true
            ::skip::
        end
        ::continue::
    end
    if next(next_techs) then
        trim_prerequisites(next_techs)
    end
end

generate_dependencies()
for name in pairs(base_technologies) do
    requirements[name] = {}
end
trim_prerequisites(base_technologies)
