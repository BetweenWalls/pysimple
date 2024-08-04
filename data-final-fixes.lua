--- data-final-fixes.lua

--- Adds a technology as a prerequisite
--- @param tech string
--- @param new_prereq string
--- @param old_prereq string? if provided, will be removed from this technology
function add_prerequisite(tech, new_prereq, old_prereq)
    if data.raw.technology[tech] and data.raw.technology[tech].prerequisites then
        local already_exists = false
        for i,prereq in pairs(data.raw.technology[tech].prerequisites) do
            if prereq == new_prereq then already_exists = true end
            if old_prereq and prereq == old_prereq then
                table.remove(data.raw.technology[tech].prerequisites, i)
            end
        end
        if not already_exists then
            table.insert(data.raw.technology[tech].prerequisites, new_prereq)
        end
    end
end

--- Changes where a recipe gets unlocked
--- @param recipe string
--- @param new_tech string
--- @param old_tech string? if provided, recipe will be removed from this technology
--- @param index int? if provided, recipe will be inserted into this index
function add_unlock(recipe, new_tech, old_tech, index)
    if data.raw.technology[new_tech] then
        if index then
            table.insert( data.raw.technology[new_tech].effects, index, {type = "unlock-recipe", recipe = recipe} )
        else
            table.insert( data.raw.technology[new_tech].effects, {type = "unlock-recipe", recipe = recipe} )
        end
        if old_tech and data.raw.technology[old_tech] then
            for i,effect in pairs(data.raw.technology[old_tech].effects) do
                if effect.type == "unlock-recipe" and effect.recipe == recipe then
                    table.remove(data.raw.technology[old_tech].effects, i)
                end
            end
        end
    end
end

if settings.startup["pysimple-enemies"].value == false then
    data.raw.technology["gun-turret"].unit.ingredients = {{name="automation-science-pack", amount=1}, {name="py-science-pack-1", amount=1}, {name="logistic-science-pack", amount=1}}
    data.raw.technology["stone-wall"].unit.ingredients = {{name="automation-science-pack", amount=1}, {name="py-science-pack-1", amount=1}, {name="logistic-science-pack", amount=1}}
    data.raw.technology["gate"].unit.ingredients = {{name="automation-science-pack", amount=1}, {name="py-science-pack-1", amount=1}, {name="logistic-science-pack", amount=1}}
    data.raw.technology["military"].unit.ingredients = {{name="automation-science-pack", amount=1}, {name="py-science-pack-1", amount=1}}
    add_prerequisite("gun-turret", "logistic-science-pack")
    add_prerequisite("stone-wall", "logistic-science-pack")
    add_prerequisite("military", "py-science-pack-mk01")
end
add_prerequisite("coal-processing-1", "automation")
add_prerequisite("soil-washing", "steel-processing")
add_prerequisite("fluid-pressurization", "acetylene")
add_prerequisite("basic-substrate", "xenobiology", "vacuum-tube-electronics")

add_unlock("extract-limestone-01", "steel-processing", "coal-processing-1", 1)
add_unlock("coke-co2", "botany-mk01", "coal-processing-1")
add_unlock("hpf", "botany-mk01", "coal-processing-1")
add_unlock("hpf", "concrete")

local recipes = {
    "distilled-raw-coal",
    "coal-gas",
    "coal-gas-from-coke",
    "coal-gas-from-wood",
    "soil-washing",
    "grade-1-iron-crush",
    "lime",
    "tar-distilation",
    "tailings-dust",
    "acetylene",
    "pitch-refining",
    "tar-refining",
    "tar-refining-tops",
    "light-oil-aromatics",
    "ash-separation",
    "soot-separation",
    "tar-quenching",
    "syngas",
    "scrude-refining",
    "hydrogen",
    "chlorine",
    "grade-2-copper",
    "grade-1-copper-crush",
    "full-render-vrauks",
    "uncaged-vrauks",
}
for i,recipe in pairs(recipes) do
    data.raw.recipe[recipe].localised_name = {"recipe-name."..recipe}
end


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
