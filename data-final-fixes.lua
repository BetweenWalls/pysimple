--- data-final-fixes.lua

local debug_errors = false

--- Adds and/or removes a technology as a prerequisite
--- @param tech string
--- @param new_prereq string? if provided, will be added to tech
--- @param old_prereq string? if provided, will be removed from tech
function adjust_prerequisites(tech, new_prereq, old_prereq)
    if data.raw.technology[tech] and data.raw.technology[tech].prerequisites then
        local prereqs = data.raw.technology[tech].prerequisites or {}
        if old_prereq and data.raw.technology[old_prereq] then
            local found = false
            for i,prereq in pairs(prereqs) do
                if prereq == old_prereq then table.remove(prereqs, i); found = true end
            end
            if debug_errors and not found then error("incorrect technology assumption: "..old_prereq) end
        end
        if new_prereq and data.raw.technology[new_prereq] then
            table.insert(prereqs, new_prereq)
            data.raw.technology[tech].prerequisites = remove_duplicates(prereqs)
        end
    elseif debug_errors then
        error("invalid target technology: "..tech)
    end
end

--- Changes where a recipe gets unlocked
--- @param recipe string
--- @param new_tech string? if provided, recipe will be added to this technology
--- @param old_tech string? if provided, recipe will be removed from this technology; if old_tech and new_tech are the same, the recipe will only be reordered (it won't be added if it wasn't already present)
--- @param index int? if provided, recipe will be inserted into this index
function add_unlock(recipe, new_tech, old_tech, index)
    local added = false
    if data.raw.recipe[recipe] and (data.raw.technology[new_tech] or data.raw.technology[old_tech]) then
        if new_tech and not data.raw.technology[new_tech] then return end
        if old_tech and not data.raw.technology[old_tech] then return end
        local found = false
        if old_tech and data.raw.technology[old_tech] and data.raw.technology[old_tech].effects then
            for i,effect in pairs(data.raw.technology[old_tech].effects) do
                if effect.type == "unlock-recipe" and effect.recipe == recipe then
                    table.remove(data.raw.technology[old_tech].effects, i)
                    found = true
                end
            end
            if debug_errors and not found then error("incorrect recipe assumption: "..recipe) end
        end
        if found and new_tech and data.raw.technology[new_tech] and data.raw.technology[new_tech].effects and not (new_tech == old_tech and not found) then
            if index then
                table.insert( data.raw.technology[new_tech].effects, index, {type = "unlock-recipe", recipe = recipe} )
                added = true
            else
                table.insert( data.raw.technology[new_tech].effects, {type = "unlock-recipe", recipe = recipe} )
                added = true
            end
        end
    elseif debug_errors then
        error("invalid recipe or technology: "..(recipe or "")..", "..(new_tech or "").."/"..(old_tech or ""))
    end
    return added
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

technology_adjustments = settings.startup["pysimple-tech-tree"].value
if mods["PyBlock"] or mods["pystellarexpedition"] then technology_adjustments = "1" end

-- repositions military technologies deeper in the tech tree (if biters are disabled)
if technology_adjustments == "3" then
    local military_groups = {
        ["py1_science"] = {
            ingredients = {{"automation-science-pack", 2}, {"py-science-pack-1", 1}},
            techs = {"military", "military-2", "stone-wall", "gate"}
        },
        ["military_science"] = {
            ingredients = {{"automation-science-pack", 3}, {"py-science-pack-1", 2}, {"logistic-science-pack", 1}, {"military-science-pack", 1}},
            techs = {"physical-projectile-damage-1", "weapon-shooting-speed-1", "physical-projectile-damage-2", "weapon-shooting-speed-2", "stronger-explosives-1", "gun-turret"}
        }
    }
    for _,group in pairs(military_groups) do
        for _,tech in pairs(group.techs) do
            data.raw.technology[tech].unit.ingredients = group.ingredients
        end
    end
    data.raw.technology["physical-projectile-damage-2"].unit.count = 70
    data.raw.technology["weapon-shooting-speed-2"].unit.count = 70
    data.raw.technology["stronger-explosives-1"].unit.count = 70
    adjust_prerequisites("military", "py-science-pack-mk01", "solder-mk01")
    adjust_prerequisites("py-asphalt", "gate", "py-science-pack-mk01")
    adjust_prerequisites("stone-wall", "py-science-pack-mk01")
    adjust_prerequisites("gun-turret", "military-science-pack")
    adjust_prerequisites("heavy-armor", nil, "military")
    adjust_prerequisites("physical-projectile-damage-1", "military-science-pack", "military")
    adjust_prerequisites("weapon-shooting-speed-1", "military-science-pack", "military")
    adjust_prerequisites("stronger-explosives-1", "military-science-pack", "military-2")
    adjust_prerequisites("military-science-pack", "py-asphalt-mk02", "logistic-science-pack")
    -- Note: While turrets are available very early, ammo cannot be made until after lead processing

    if mods["blueprint-shotgun"] then
        table.insert( data.raw.technology["blueprint-shotgun"].effects, {type = "unlock-recipe", recipe = "shotgun"} )
        adjust_prerequisites("blueprint-shotgun", "electronics", "military")
        adjust_prerequisites("blueprint-shotgun-upgrade-1", "logistics")
        adjust_prerequisites("blueprint-shotgun-upgrade-2", "military-2", "logistic-science-pack")
        data.raw.technology["blueprint-shotgun-upgrade-2"].unit.ingredients = {{"automation-science-pack", 2}, {"py-science-pack-1", 1}}
    end
end

if technology_adjustments ~= "1" then
    -- Adds appropriate prerequisites to some techs so they don't appear until needed (these kind of adjustments would normally be made programmatically in trim-tech-tree.lua)
    -- TODO: Update trim-tech-tree.lua for Factorio 2.0
    --adjust_prerequisites("oil-gathering", "niobium")
    --adjust_prerequisites("uranium-mining", "py-science-pack-mk02")
    adjust_prerequisites("nexelit-mk01", "py-science-pack-mk01")

    -- Fixes some technology issues new in Factorio 2.0
    adjust_prerequisites("lamp", "glass", "automation-science-pack")
    if data.raw.technology["vacuum-tube-electronics"] then adjust_prerequisites("radar", "vacuum-tube-electronics", "automation-science-pack") end
    data.raw.technology["radar"].hidden = true
    -- TODO: Remove iron stick from concrete and circuit network technologies (these lines don't work)
    --add_unlock("iron-stick", nil, "concrete")
    --add_unlock("iron-stick", nil, "circuit-network")
    --add_unlock("iron-stick", nil, "railway")

    -- repositions other technologies
    adjust_prerequisites("coal-processing-1", "automation")
    adjust_prerequisites("soil-washing", "steel-processing")
    adjust_prerequisites("fluid-pressurization", "ceramic")
    adjust_prerequisites("fluid-pressurization", "wood-processing", "steel-processing")
    adjust_prerequisites("moss-mk01", "mining-with-fluid", "botany-mk01")
    adjust_prerequisites("wood-processing", "botany-mk01")
    adjust_prerequisites("acetylene", "concrete", "tar-processing")
    adjust_prerequisites("solder-mk01", "tar-processing")
    adjust_prerequisites("kerogen", "glass", "steel-processing")
    adjust_prerequisites("syngas", "solder-mk01", "electronics")
    adjust_prerequisites("electrolysis", "alloys-mk01", "electronics")
    adjust_prerequisites("basic-substrate", "genetics-mk01", "electronics")
    adjust_prerequisites("land-animals-mk01", "xenobiology", "alloys-mk01")
    adjust_prerequisites("vrauks", "land-animals-mk01", "xenobiology")

    -- repositions recipe unlocks
    add_unlock("extract-limestone-01", "steel-processing", "coal-processing-1", 1)
    add_unlock("hpf", "concrete", nil, 1)
    add_unlock("hpf", "mining-with-fluid", "coal-processing-1")
    add_unlock("coke-co2", "mining-with-fluid", "coal-processing-1")
    add_unlock("tinned-cable", "petri-dish", "mining-with-fluid", 1)
    add_unlock("zinc-plate-1", "solder-mk01", "electronics", 1)
    add_unlock("methanal", "moondrop", "electronics")
    add_unlock("cellulose-00", "wood-processing", "electronics")
    add_unlock("graphite", "fluid-pressurization", "electronics")
    add_unlock("vacuum-tube", "fluid-pressurization", "electronics")
    add_unlock("saline-water", "fluid-pressurization", "electronics")
    add_unlock("gravel-saline-water", "fluid-pressurization", "crusher")
    add_unlock("pressured-air", "hot-air-mk01", "fluid-pressurization", 1)
    add_unlock("pressured-water", "hot-air-mk01", "fluid-pressurization", 2)
    add_unlock("upgrader-mk01", "petroleum-gas-mk01", "syngas")
    if technology_adjustments == "2" then add_unlock("saline-water", "fluid-processing-machines-1") end

    -- more repositioning for stage 2 techs (those requiring automation science and py science 1)
    adjust_prerequisites("microbiology-mk01", "compost")
    adjust_prerequisites("nexelit-mk01", nil, "lead-mk01")
    adjust_prerequisites("nexelit-mk01", nil, "titanium-mk01")
    adjust_prerequisites("lead-mk02", "lead-mk01")
    adjust_prerequisites("titanium-mk02", "titanium-mk01")
    adjust_prerequisites("lab-instrument", "py-asphalt")
    adjust_prerequisites("compost", "mycology-mk01")
    adjust_prerequisites("fertilizer-mk01", "logistic-science-pack")
    data.raw.technology["fertilizer-mk01"].unit.ingredients = {{"automation-science-pack", 3}, {"py-science-pack-1", 2}, {"logistic-science-pack", 1}}
    adjust_prerequisites("night-vision-equipment", "battery-mk01", "py-science-pack-mk02")
    adjust_prerequisites("night-vision-equipment", nil, "personal-roboport-equipment")
    data.raw.technology["night-vision-equipment"].unit.ingredients = {{"automation-science-pack", 2}, {"py-science-pack-1", 1}}

    adjust_prerequisites("py-transport-belt-capacity-1", "fish-mk02") -- both "fish-mk02" and "lubricant" provide a recipe for lubricant which is an ingredient in stack inserters - the former is used since it is already a requirement for progression beyond logistic science
    adjust_prerequisites("mibc", "aramid", "coal-processing-2") -- has no use til titanium-mk02
    if data.raw.technology["mibc"] then
        data.raw.technology["mibc"].unit.ingredients = {{"automation-science-pack", 6}, {"py-science-pack-1", 3}, {"logistic-science-pack", 2}, {"py-science-pack-2", 1}}
        -- TODO: This technology no longer exists with pyalternativeenergy >= 3.1.34
    end
    -- TODO: Remove "lubricant" tech prerequisite from integrated-circuits-1 since you can already make lubricant from fish oil via the fish-mk02 tech which is required to reach that point anyway?

    if mods["blueprint-shotgun"] and technology_adjustments == "2" then
        table.insert( data.raw.technology["blueprint-shotgun"].effects, {type = "unlock-recipe", recipe = "shotgun"} )
        adjust_prerequisites("blueprint-shotgun", "electronics", "military")
        adjust_prerequisites("blueprint-shotgun-upgrade-1", "military")
        adjust_prerequisites("blueprint-shotgun-upgrade-2", "military-2", "logistic-science-pack")
        data.raw.technology["blueprint-shotgun-upgrade-2"].unit.ingredients = {{"automation-science-pack", 2}, {"py-science-pack-1", 1}}
    end
    if mods["cybersyn"] then
        data.raw.technology["cybersyn-train-network"].unit.ingredients = data.raw.technology["circuit-network"].unit.ingredients
        data.raw.technology["cybersyn-train-network"].unit.count = 275
    end
    if mods["loaders-modernized"] then
        if data.raw.technology["fast-mdrn-loader"] then data.raw.technology["fast-mdrn-loader"].unit.ingredients = data.raw.technology["logistics-2"].unit.ingredients end
        if data.raw.technology["stack-mdrn-loader"] then data.raw.technology["stack-mdrn-loader"].unit.ingredients = data.raw.technology["fast-mdrn-loader"].unit.ingredients end
    end
end

-- adjusts balance slightly so the harder recipe isn't less efficient
if settings.startup["pysimple-saline-water"].value then
    if data.raw.recipe["saline-water"] and data.raw.recipe["gravel-saline-water"] then
        data.raw.recipe["saline-water"].ingredients = {{type="item", name="stone", amount=20}, {type="fluid", name="water", amount=200}}
        data.raw.recipe["gravel-saline-water"].ingredients = {{type="item", name="gravel", amount=15}, {type="fluid", name="water", amount=200}}
        data.raw.recipe["saline-water"].results = {{type="fluid", name="water-saline", amount=100}}
        data.raw.recipe["gravel-saline-water"].results = {{type="fluid", name="water-saline", amount=100}}
    end
end

if settings.startup["pysimple-descriptions"].value or settings.startup["pysimple-storage-tanks"].value then
    local storage_tanks = {
        {id="py-tank-3000", tiles=4, original=30000, adjusted=10000, new=10000},     -- 20 iron,  30 copper,  60 aluminium,  10 lead              ...used in  6 recipes (+1 indirectly)
        {id="py-tank-1000", tiles=9, original=10000, adjusted=10000, new=25000},     -- 10 iron,  10 copper,  20 aluminium,  10 lead              ...used in  0 recipes
        {id="py-tank-1500", tiles=9, original=15000, adjusted=15000, new=25000},     -- 10 iron,  40 copper,  80 aluminium,  10 lead              ...used in  1 recipe  (+5 indirectly)
        {id="storage-tank", tiles=9, original=25000, adjusted=25000, new=25000},     --           40 copper,  80 aluminium,  10 lead,  5 steel    ...used in 14 recipes (+5 indirectly)
        {id="py-tank-4000", tiles=9, original=40000, adjusted=27500, new=25000},     -- 28 iron,                             30 lead              ...used in  3 recipes (+18 indirectly)
        {id="py-tank-7000", tiles=21, original=70000, adjusted=70000, new=70000},    -- 38 iron,  40 copper,  80 aluminium,  40 lead              ...used in  5 recipes
        {id="py-tank-5000", tiles=25, original=50000, adjusted=65000, new=75000},    -- 10 iron,  80 copper, 160 aluminium,  20 lead,  5 steel    ...used in  4 recipes (+1 indirectly)
        {id="py-tank-6500", tiles=25, original=65000, adjusted=75000, new=75000},    -- 51 iron,                             60 lead              ...used in  7 recipes
        {id="py-tank-8000", tiles=36, original=80000, adjusted=125000, new=125000},  -- 60 iron,                             70 lead              ...used in 10 recipes
        {id="py-tank-9000", tiles=49, original=90000, adjusted=180000, new=180000},  -- 45 iron, 110 copper, 220 aluminium,  30 lead, 35 steel    ...used in  1 recipe
        {id="py-tank-10000", tiles=64, original=100000, adjusted=250000, new=250000} -- 56 iron,  40 copper,  80 aluminium, 105 lead              ...used in  1 recipe
    }
    -- renames and sorts storage tanks by their dimensions and capacity
    local cap = "original"
    if settings.startup["py-tank-adjust"].value then cap = "adjusted" end
    if settings.startup["pysimple-storage-tanks"].value then
        cap = "new"
        data.raw["storage-tank"]["py-tank-1000"].localised_description = {"description.medium-tank"}
        data.raw["storage-tank"]["py-tank-1500"].localised_description = {"description.medium-tank"}
        data.raw["storage-tank"]["storage-tank"].localised_description = {"description.medium-tank"}
        data.raw["storage-tank"]["py-tank-5000"].localised_description = {"description.good-tank"}
    end
    for i,tank in pairs(storage_tanks) do
        if data.raw["storage-tank"][tank.id] then
            local capacity = data.raw["storage-tank"][tank.id].fluid_box.volume
            if cap == "new" then
                capacity = tonumber(tank[cap]) or 0
                data.raw["storage-tank"][tank.id].fluid_box.volume = capacity
            end
            data.raw["storage-tank"][tank.id].localised_name = {"name.storage", tostring(capacity/1000)}
            data.raw.recipe[tank.id].localised_name = {"name.storage", tostring(capacity/1000)}
            if tank.id ~= "storage-tank" then
                local order = tostring(capacity)
                if capacity < 100000 then order = "0"..order end
                if settings.startup["py-tank-adjust"].value or settings.startup["pysimple-storage-tanks"].value then
                    order = tostring(tank.tiles).."-"..order
                    if tank.tiles < 10 then order = "0"..order end
                end
                order = "a-c[py-storage]-"..order
                data.raw.recipe[tank.id].order = order
                data.raw.item[tank.id].order = order
            end
        end
    end
end

if settings.startup["pysimple-descriptions"].value then
    local locale_entries = {
        ["name"] = {
            ["recipe"] = {
                "distilled-raw-coal", "coal-gas", "coal-gas-from-coke", "coal-gas-from-wood", "soil-washing", "ash-separation", "soot-separation", "grade-1-iron-crush", "lime", "tar-distilation",
                "pitch-refining", "tar-refining", "tar-refining-tops", "light-oil-aromatics", "tar-quenching", "tailings-dust", "acetylene", "syngas", "scrude-refining", "hydrogen", "chlorine",
                "grade-2-copper", "grade-1-copper-crush", "uncaged-vrauks", "full-render-vrauks", "crushed-coal", "coke-coal", "borax-washing", "crushing-quartz", "grade-1-zinc", "grade-2-zinc",
                "grade-1-tin", "grade-2-crush-tin", "grade-1-ti", "grade-2-ti-crush", "grade-3-ti", "ti-rejects-recrush", "grade-1-nickel", "sb-grade-01", "sb-grade-02", "sb-grade-03", "nexelit-ore-1",
                "clean-nexelit", "powdered-aluminium", "grade-1-chromite", "soil-separation-2", "coarse-classification", "sand-classification", "tailings-classification", "polybutadiene", "uncaged-auog",
                "urea-decomposition", "melamine", "fiberboard", "black-liquor", "starch", "he-01", "tar-to-carbolic", "anthracene-gasoline-cracking", "muddy-sludge-void-electrolyzer",
                "boric-acid-hcl", "cobalt-extract", "fish-emulsion", "acidgas-2", "coal-slurry-fuel", "coalbed-gas-to-acidgas", "crude-from-manure", "eg-si", "petgas-methanol",
                "syngas-distilation", "tall-oil-separation", "dedicated-oleochemicals", "grade-1-u", "he-02", "natural-gas-refining", "oleochemicals", "phosphoric-acid", "pressured-hydrogen",
                "purest-nitrogen-gas", "aromatics-from-naphthalene", "hot-syngas-cooldown", "light-oil_from_syngas", "liquid-nitrogen", "natural-gas-to-syngas", "oleo-gasification", "p2s5", "p2s5-2",
                "psc", "quench-ovengas", "syngas2", "coarse-coal", "formamide", "grade-2-iron", "low-distillate-to-heavy-oil", "middle-processed-lard", "nisi", "molten-steel", "rare-earth-beneficiation",
                "ree-float", "refsyngas-from-meth-canister", "silicon-wafer", "trichlorosilane", "condensed-distillate-separation", "copper-rejects-recrush", "grade-2-lead", "grade-3-chromite",
                "grade-3-copper", "grade-3-nickel", "grade-3-tin", "niobium-concentrate", "petgas-from-refsyngas", "pure-trichlorosilane", "raw-gas", "ree-slurry", "sodium-bisulfate", "vpulp3",
                "ammonium-chloride", "classify-low-grade", "grade-4-chromite", "grade-4-copper", "quenching-dirty-syngas", "ree-solution", "sodium-sulfate", "wash-grade-3-tin", "bio-oil-1",
                "bio-oil-2", "pyrite-burn", "ree-concentrate1", "ree-concentrate2", "ree-concentrate3", "scrubbing-purified-syngas", "sodium-carbonate-1", "crush-oil-sand", "powdered-ti",
                "reheat-coke-gas", "vinyl-acetate", "fluorine-gas", "molybdenum-oxide", "oil-refining", "sb-dust", "ti-enriched-dust", "outlet-gas-02", "unslimed-iron", "unslimed-iron-2",
                "wash-coper-low-dust", "residual-mixture-distillation", "used-comb-oil-recycling", "bitumen-refining", "sb-pulp-02", "classify-iron-ore-dust", "plutonium-fuel-reprocessing",
                "high-distillate-condensing", "hot-residual-mixture-to-coke", "quench-redcoke", "plutonium-oxidation", "plutonium-seperation", "purified-ti-pulp", "fluidize-coke", "redhot-coke",
                "tar-talloil", "concentrated-ti", "bitumen-froth", "bitumen", "split-yellowcake", "empty-methanol-gas-canister", "calcinate-separation", "richdust-separation", "tailings-separation",
                "mixed-ores", "py-sodium-hydroxide", "crusher-ree", "grade-2-crush", "grade-2-lead-crusher", "grade-2-u-crush", "powdered-phosphate-rock", "crushing-molybdenite", "milling-molybdenite",
                "niobium-dust", "powdered-quartz", "grade-1-u-recrush", "grade-2-chromite-beneficiation", "grade-2-nickel-recrush", "milling-ree", "niobium-powder",
                "battery-mk00", "portable-gasoline-generator", "nexelit-battery-recharge", "nexelit-battery", "quantum-battery-recharge", "quantum-battery", "poorman-wood-fence",
                "py-gas-vent", "py-sinkhole", "py-burner", "tailings-pond", "oil-boiler-mk01", "multiblade-turbine-mk01", "dino-dig-site",
                "py-science-pack-1", "py-science-pack-2", "py-science-pack-3", "py-science-pack-4", "py-science-pack-1-turd", "py-science-pack-2-turd", "py-science-pack-3-turd", "py-science-pack-4-turd",
            },
            ["technology"] = { "py-science-pack-mk01", "py-science-pack-mk02", "py-science-pack-mk03", "py-science-pack-mk04", },
            ["tool"] = { "py-science-pack-1", "py-science-pack-2", "py-science-pack-3", "py-science-pack-4", },
            ["item"] = { "battery-mk00", "portable-gasoline-generator", "used-nexelit-battery", "nexelit-battery", "used-quantum-battery", "quantum-battery", },
            ["wall"] = { "poorman-wood-fence", },
            ["storage-tank"] = { "tailings-pond", },
            ["furnace"] = { "py-gas-vent", "py-sinkhole", "py-burner", },
            ["boiler"] = { "oil-boiler-mk01", },
            ["electric-energy-interface"] = { "multiblade-turbine-mk01", "multiblade-turbine-mk01-blank", },
            ["assembling-machine"] = { "dino-dig-site", },
        },
        ["description"] = {
            ["recipe"] = { "nexelit-battery-recharge", "quantum-battery-recharge", "anthracene-gasoline-hydrogenation-new", "syngas2", "coarse-coal-to-coal", }, -- none of these have descriptions originally (not even "affected by productivity") so nothing will be overwritten
            ["technology"] = {
                "mining-with-fluid", "steel-processing", "ash-separation", "moss-mk01", "seaweed-mk01", "wood-processing", "fluid-handling", "solder-mk01", "alloys-mk01", "py-storage-tanks", "plastics",
                "zoology", "boron", "nexelit-mk01", "antimony-mk01", "nickel-mk01", "chromium-mk01",
            },
            ["mining-drill"] = { "burner-mining-drill", "fluid-drill-mk01", "borax-mine", },
            ["storage-tank"] = { "tailings-pond", },
            ["radar"] = { "py-local-radar", "radar", },
            ["assembling-machine"] = { "data-array", },
        }
    }
    local supertypes = {
        ["technology"] = "technology", ["recipe"] = "recipe", ["item"] = "item", ["fluid"] = "item", ["capsule"] = "item", ["tool"] = "item",
        ["wall"] = "entity", ["mining-drill"] = "entity", ["furnace"] = "entity", ["boiler"] = "entity", ["storage-tank"] = "entity", ["electric-energy-interface"] = "entity", ["assembling-machine"] = "entity", ["radar"] = "entity",
    }
    -- adjusts names and descriptions for clarity, such as making multi-product recipes include each product so they can be searched the same way as other recipes
    -- TODO: Should these changes be made prior to data-final-fixes so that recipes automatically incorporate item name changes?
    -- TODO: Should multi-product names including all products be a separate optional setting?
    -- TODO: Programmatically rename multi-product recipes by combining already-existing locales for the individual items
    for desc,desc_groups in pairs(locale_entries) do
        for type,items in pairs(desc_groups) do
            for _,item in pairs(items) do
                if data.raw[type][item] and supertypes[type] then
                    data.raw[type][item]["localised_"..desc] = {desc.."."..supertypes[type].."-"..item}
                elseif debug_errors then
                    error("invalid info: "..type..", "..item)
                end
            end
        end
    end
    if mods["PyBlock"] then
        -- soot-separation is the only recipe which needs a different name as it produces nickel ore in addition to the other products
        if data.raw.recipe["soot-separation"] then data.raw.recipe["soot-separation"].localised_name = {"name.recipe-soot-separation-pyblock"} end
    end

    local turd_item = {
        ["item"] = {"chlorinated-water", "lacquer-resin", "paper-towel", "kicalk-dry", "deadhead", "nutrient", "navens-abomination", "abacus", "cags", "saddle", "worm", "alcl3", "fungicide", "cottongut-food-03", "vonix-den-mk04"},
        ["module"] = {"py-sawblade-module-mk01", "py-sawblade-module-mk02", "py-sawblade-module-mk03", "py-sawblade-module-mk04", "anti-lope", "neutra-lope", "pos-tilope", "dingrits-alpha"},
        ["assembling-machine"] = {"vonix-den-mk04"},
    }
    local turd_replacement = {
        ["burner-generator"] = {"generator-1-turd"},
        ["assembling-machine"] = {
            "advanced-bio-reactor-mk01-turd1", "advanced-bio-reactor-mk02-turd1", "advanced-bio-reactor-mk03-turd1", "advanced-bio-reactor-mk04-turd1",
            "advanced-bio-reactor-mk01-turd2", "advanced-bio-reactor-mk02-turd2", "advanced-bio-reactor-mk03-turd2", "advanced-bio-reactor-mk04-turd2",
            "advanced-bio-reactor-mk01-turd3", "advanced-bio-reactor-mk02-turd3", "advanced-bio-reactor-mk03-turd3", "advanced-bio-reactor-mk04-turd3",
            "fish-farm-mk01-turd", "fish-farm-mk02-turd", "fish-farm-mk03-turd", "fish-farm-mk04-turd",
            "wpu-mk01-turd", "wpu-mk02-turd", "wpu-mk03-turd", "wpu-mk04-turd",
        },
        ["furnace"] = {"compost-plant-mk01-turd", "compost-plant-mk02-turd", "compost-plant-mk03-turd", "compost-plant-mk04-turd"},
        ["module"] = {"digosaurus-turd", "thikat-turd", "work-o-dile-turd"},
        ["item-with-tags"] = {"caravan-turd", "fluidavan-turd", "flyavan-turd", "nukavan-turd"},
        ["unit"] = {"digosaurus-turd", "thikat-turd", "work-o-dile-turd"},
    }
    -- adds "T.U.R.D." text to TURD-related items/entities
    for kind,names in pairs(turd_item) do
        for _,name in pairs(names) do
            if data.raw[kind][name] then
                py.add_to_description(kind, data.raw[kind][name], {"turd.font", {"description.pysimple-turd-item"}})
            end
        end
    end
    for kind,names in pairs(turd_replacement) do
        for _,name in pairs(names) do
            if data.raw[kind][name] then
                py.add_to_description(kind, data.raw[kind][name], {"turd.font", {"description.pysimple-turd"}})
            end
        end
    end
    if data.raw.recipe["zipir1-pyvoid-hatchery"] then py.add_to_description("recipe", data.raw.recipe["zipir1-pyvoid-hatchery"], {"turd.font", {"turd.recipe-replacement"}}) end

    -- sets "rocket capacity" to be the same as the stack size (removes "too heavy for a rocket!" text)
    if feature_flags["space_travel"] and not (mods["space-age"] or mods["pystellarexpedition"]) then
        local kinds = {"item", "module", "item-with-tags", "item-with-entity-data", "gun", "ammo", "capsule", "tool", "repair-tool", "rail-planner", "armor"}
        for _,kind in pairs(kinds) do
            for _,thing in pairs(data.raw[kind]) do
                if thing and thing.stack_size and (thing.send_to_orbit_mode == nil or thing.send_to_orbit_mode.includes == "not-sendable") and not thing.rocket_launch_products then
                    thing.weight = 1000000 / thing.stack_size
                end
            end
        end
    end
end

if settings.startup["pysimple-graphics"].value or technology_adjustments ~= "1" then
    local tech_icons = {
        ["py-storage-tanks"] = {icon="__base__/graphics/technology/fluid-handling.png", size=256},
        ["fluid-handling"] = {icon="__base__/graphics/icons/fluid/barreling/barrel-fill.png", size=64},
    }
    -- updates some technology icons
    for tech,info in pairs(tech_icons) do
        if data.raw.technology[tech] then
            data.raw.technology[tech].icon = info.icon
            data.raw.technology[tech].icon_size = info.size
        end
    end
end

if settings.startup["pysimple-graphics"].value then
    local windmill = data.raw["electric-energy-interface"]["multiblade-turbine-mk01"]
    if windmill then
        windmill.animations.layers[1].filename = "__pysimple__/graphics/base-fishturbine.png"
    end
    if data.raw.recipe["molybdenum-concentrate"] then
        data.raw.recipe["molybdenum-concentrate"].icon = data.raw.item["molybdenum-concentrate"].icon
    end
    if data.raw.recipe["pregnant-solution"] then
        data.raw.recipe["pregnant-solution"].icon = data.raw.fluid["pregnant-solution"].icon
    end
    if data.raw.recipe["raw-ralesia-extract"] then
        data.raw.recipe["raw-ralesia-extract"].icon = data.raw.fluid["raw-ralesia-extract"].icon
    end
    local colors = {
        ["tile"] = {
            ["py-coal-tile"] = {0, 0, 0, 255},
            ["py-asphalt"] = {25, 25, 25, 255},
            ["py-steel"] = {50, 50, 50, 1},
            ["py-limestone"] = {158, 139, 121, 1},
            ["py-iron-oxide"] = {101, 39, 0, 1},
            ["py-iron"] = {90, 85, 75, 1},
            ["py-aluminium"] = {140, 133, 130, 1},
            ["py-nexelit"] = {17, 83, 127, 1},
            ["black-refined-concrete"] = {40, 40, 40, 127},
            ["brown-refined-concrete"] = {73, 50, 35, 127},
            ["pink-refined-concrete"] = {153, 107, 120, 127},
            ["purple-refined-concrete"] = {121, 63, 140, 127},
            ["blue-refined-concrete"] = {58, 110, 153, 127},
            ["cyan-refined-concrete"] = {54, 153, 137, 127},
            ["green-refined-concrete"] = {30, 153, 45, 127},
            ["acid-refined-concrete"] = {112, 153, 19, 127},
            ["yellow-refined-concrete"] = {153, 123, 32, 127},
            ["orange-refined-concrete"] = {153, 95, 37, 127},
            ["red-refined-concrete"] = {153, 41, 33, 127},
        },
        ["resource"] = {
            ["ore-quartz"] = {255, 203, 251, 255},
            ["quartz-rock"] = {255, 203, 251, 255},
            ["ore-zinc"] = {38, 229, 135, 255},
            ["zinc-rock"] = {38, 229, 135, 255},
            ["ore-lead"] = {80, 80, 80, 255},
            ["lead-rock"] = {80, 80, 80, 255},
            ["ore-titanium"] = {135, 94, 166, 255},
            ["titanium-rock"] = {135, 94, 166, 255},
            ["ore-nickel"] = {3, 106, 0, 255},
            ["nickel-rock"] = {3, 106, 0, 255},
            ["ore-nexelit"] = {75, 178, 222, 255},
            ["antimonium"] = {154, 20, 48, 255},
            ["molybdenum-ore"] = {4, 66, 76, 255},
            ["niobium"] = {35, 96, 148, 255},
            ["ree"] = {101, 82, 0, 255},
            ["rare-earth-bolide"] = {101, 82, 0, 255},
            ["oil-sand"] = {113, 51, 0, 255},
            ["uranium-rock"] = {0, 178, 0, 255},
            ["copper-rock"] = {204, 98, 54, 255},
            ["iron-rock"] = {105, 133, 147, 255},
            ["salt-rock"] = {254, 254, 254, 255},
            ["phosphate-rock"] = {195, 111, 176, 255},
            ["phosphate-rock-02"] = {195, 111, 176, 255},
            ["bitumen-seep"] = {116, 0, 101, 255},
            ["tar-patch"] = {28, 73, 60, 255},
            ["natural-gas-mk01"] = {203, 142, 11, 255},
            ["natural-gas-mk02"] = {203, 142, 11, 255},
            ["natural-gas-mk03"] = {203, 142, 11, 255},
            ["natural-gas-mk04"] = {203, 142, 11, 255},
        },
    }
    for kind,things in pairs(colors) do
        for name,color in pairs(things) do
            if data.raw[kind][name] then
                data.raw[kind][name].map_color = color
            end
        end
    end
end

if data.raw["pipe"]["niobium-pipe"] and data.raw["pipe"]["ht-pipes"] then data.raw["pipe"]["niobium-pipe"].next_upgrade = "ht-pipes" end
if data.raw["pipe-to-ground"]["niobium-pipe-to-ground"] and data.raw["pipe-to-ground"]["ht-pipes-to-ground"] then data.raw["pipe-to-ground"]["niobium-pipe-to-ground"].next_upgrade = "ht-pipes-to-ground" end

-- TODO: desulfurizator-unit recipe is incorrectly listed as a T.U.R.D. recipe (it can be, but isn't necessarily and this is inconsistent with other recipes which are available either way)
-- TODO: Compost TURD upgrade for sweet tooth has redundant recipes listed - the sweet syrup and a-type molasses are already unlocked via a prerequisite technology
-- TODO: Rename "Rare-earth" mining drills to be "Rare earth" instead to be consistent with other names
-- TODO: Reduce volume of sap extractors, regenerative heat exchangers
-- TODO: Reduce overhang for: lab, smelter, chemical plant, compost plant, classifier, heavy oil refinery, solid separator, moss farm, ulric corral, spore collector, etc
-- TODO: Rename hydrogen chloride to hydrochloric acid (the former is a gas IRL, but it is a liquid in-game)
-- TODO: Many buildings have graphics with inaccurate pipe locations when flipped
-- TODO: Quantity is shown twice in factoriopedia when item & recipe are combined
-- TODO: Add a setting for additional DLC features such as toolbelt equipment, mech armor, turbo belts, tree growing/harvesting, etc ...or add compatibility for mods which implement them
-- TODO: Biomass powerplants could say "consumes biofuel" instead of "consumes biomass"? Consider renaming the "Biomass" fuel category to not be identical to a single type of fuel
-- TODO: Add a recipe use case for underground pipes and other upgradeable entities which have none currently (even if it's just recycling them)
-- TODO: The recipe names for subcritical-water-03 and subcritical-water-02 are mixed up (the mk3 version is unlocked long before the mk2 version)

require("prototypes/reorganize-item-groups")
require("prototypes/sort-recipe-unlocks")
--require("prototypes/trim-tech-tree")
require("prototypes/circuit-connections")
require("prototypes/distinct-icons")
require("prototypes/faster-recipes")
