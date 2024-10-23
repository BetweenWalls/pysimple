--- data-final-fixes.lua

local debug_errors = false

--- Adds and/or removes a technology as a prerequisite
--- @param tech string
--- @param new_prereq string? if provided, will be added to tech
--- @param old_prereq string? if provided, will be removed from tech
function adjust_prerequisites(tech, new_prereq, old_prereq)
    if data.raw.technology[tech] and data.raw.technology[tech].prerequisites then
        local prereqs = data.raw.technology[tech].prerequisites or {}
        if old_prereq then
            local found = false
            for i,prereq in pairs(prereqs) do
                if prereq == old_prereq then table.remove(prereqs, i); found = true end
            end
            if debug_errors and not found then error("incorrect technology assumption: "..old_prereq) end
        end
        if new_prereq then
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
    if data.raw.recipe[recipe] and (data.raw.technology[new_tech] or data.raw.technology[old_tech]) then
        local found = false
        if old_tech and data.raw.technology[old_tech] then
            for i,effect in pairs(data.raw.technology[old_tech].effects) do
                if effect.type == "unlock-recipe" and effect.recipe == recipe then
                    table.remove(data.raw.technology[old_tech].effects, i)
                    found = true
                end
            end
            if debug_errors and not found then error("incorrect recipe assumption: "..recipe) end
        end
        if new_tech and data.raw.technology[new_tech] and not (new_tech == old_tech and not found) then
            if index then
                table.insert( data.raw.technology[new_tech].effects, index, {type = "unlock-recipe", recipe = recipe} )
            else
                table.insert( data.raw.technology[new_tech].effects, {type = "unlock-recipe", recipe = recipe} )
            end
        end
    elseif data.raw.recipe[recipe] and data.raw.technology[old_tech] then

    elseif debug_errors then
        error("invalid recipe or technology: "..recipe..", "..tech)
    end
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

-- repositions military technologies deeper in the tech tree (if biters are disabled)
if settings.startup["pysimple-tech-tree"].value == "3" then
    local military_groups = {
        ["py1_science"] = {
            ingredients = {{"automation-science-pack", 2}, {"py-science-pack-1", 1}},
            techs = {"fluid-processing-machines-1", "military", "military-2", "stone-wall", "gate"}
        },
        ["military_science"] = {
            ingredients = {{"automation-science-pack", 6}, {"py-science-pack-1", 3}, {"logistic-science-pack", 2}, {"military-science-pack", 2}, {"py-science-pack-2", 1}},
            techs = {   "physical-projectile-damage-1", "weapon-shooting-speed-1", "physical-projectile-damage-2", "weapon-shooting-speed-2", "stronger-explosives-1",
                        "physical-projectile-damage-3", "weapon-shooting-speed-3", "physical-projectile-damage-4", "weapon-shooting-speed-4", "stronger-explosives-2", "gun-turret",
                        "defender", "follower-robot-count-1", "follower-robot-count-2", "flamethrower", "refined-flammables-1", "refined-flammables-2", "land-mine", "rocketry"
            }
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
    adjust_prerequisites("fluid-processing-machines-1", "py-science-pack-mk01")
    adjust_prerequisites("py-asphalt", "gate", "py-science-pack-mk01")
    adjust_prerequisites("stone-wall", "py-science-pack-mk01")
    adjust_prerequisites("gun-turret", "military-science-pack")
    adjust_prerequisites("heavy-armor", nil, "military")
    adjust_prerequisites("physical-projectile-damage-1", "military-science-pack", "military")
    adjust_prerequisites("weapon-shooting-speed-1", "military-science-pack", "military")
    adjust_prerequisites("stronger-explosives-1", "military-science-pack", "military-2")
    --NOTE: While turrets are available very early, ammo cannot be made until after lead processing
end

if settings.startup["pysimple-tech-tree"].value ~= "1" then
    -- Adds appropriate prerequisites to some early techs so they don't appear until needed (these kind of adjustments would normally be made programmatically in trim-tech-tree.lua)
    -- TODO: Update trim-tech-tree.lua for Factorio 2.0
    adjust_prerequisites("nexelit-mk01", "py-science-pack-mk01")
    adjust_prerequisites("oil-gathering", "logistic-science-pack")
    adjust_prerequisites("efficiency-module", "py-science-pack-mk02")
    adjust_prerequisites("bulk-inserter", "py-science-pack-mk02")
    adjust_prerequisites("uranium-mining", "py-science-pack-mk02")
    adjust_prerequisites("inserter-capacity-bonus-1", "py-science-pack-mk02")
    adjust_prerequisites("bulk-inserter-2", "py-science-pack-mk03")

    -- Fixes some technology issues new in Factorio 2.0
    adjust_prerequisites("lamp", "glass", "automation-science-pack")
    adjust_prerequisites("radar", "vacuum-tube-electronics", "automation-science-pack")
    data.raw.technology["radar"].hidden = true
    add_unlock("iron-stick", nil, "concrete")
    add_unlock("iron-stick", nil, "circuit-network")
    add_unlock("iron-stick", nil, "railway")
    add_unlock("niobium-pipe", nil, "py-storage-tanks")
    add_unlock("niobium-pipe-to-ground", nil, "py-storage-tanks")

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
    adjust_prerequisites("electrolysis", "alloys-mk01", "vacuum-tube-electronics")
    adjust_prerequisites("basic-substrate", "genetics-mk01", "vacuum-tube-electronics")
    adjust_prerequisites("land-animals-mk01", "xenobiology", "alloys-mk01")
    adjust_prerequisites("vrauks", "land-animals-mk01", "xenobiology")

    -- repositions recipe unlocks
    add_unlock("extract-limestone-01", "steel-processing", "coal-processing-1", 1)
    add_unlock("hpf", "concrete", nil, 1)
    add_unlock("hpf", "mining-with-fluid", "coal-processing-1")
    add_unlock("coke-co2", "mining-with-fluid", "coal-processing-1")
    --add_unlock("gasifier", "acetylene", "tar-processing", 2)
    add_unlock("tinned-cable", "petri-dish", "mining-with-fluid", 1)
    add_unlock("zinc-plate-1", "solder-mk01", "vacuum-tube-electronics", 1)
    add_unlock("methanal", "moondrop", "vacuum-tube-electronics")
    add_unlock("cellulose-00", "wood-processing", "vacuum-tube-electronics")
    add_unlock("graphite", "fluid-pressurization", "vacuum-tube-electronics")
    add_unlock("vacuum-tube", "fluid-pressurization", "vacuum-tube-electronics")
    add_unlock("saline-water", "fluid-pressurization", "vacuum-tube-electronics")
    add_unlock("gravel-saline-water", "fluid-pressurization", "crusher")
    add_unlock("pressured-air", "hot-air-mk01", "fluid-pressurization", 1)
    add_unlock("pressured-water", "hot-air-mk01", "fluid-pressurization", 2)
    -- TDOO: remove iron stick recipe unlock from concrete technology (it is available without any research)
    -- TDOO: remove duplicate gasifier recipe unlock from acetylene

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
        {id="py-tank-3000", tiles=4, original=300, adjusted=100, new=100},     -- 20 iron,  30 copper,  60 aluminium,  10 lead              ...used in  6 recipes (+1 indirectly)
        {id="py-tank-1000", tiles=9, original=100, adjusted=100, new=250},     -- 10 iron,  10 copper,  20 aluminium,  10 lead              ...used in  0 recipes
        {id="py-tank-1500", tiles=9, original=150, adjusted=150, new=250},     -- 10 iron,  40 copper,  80 aluminium,  10 lead              ...used in  1 recipe  (+5 indirectly)
        {id="storage-tank", tiles=9, original=250, adjusted=250, new=250},     --           40 copper,  80 aluminium,  10 lead,  5 steel    ...used in 14 recipes (+5 indirectly)
        {id="py-tank-4000", tiles=9, original=400, adjusted=275, new=250},     -- 28 iron,                             30 lead              ...used in  3 recipes (+18 indirectly)
        {id="py-tank-7000", tiles=21, original=700, adjusted=700, new=700},    -- 38 iron,  40 copper,  80 aluminium,  40 lead              ...used in  5 recipes
        {id="py-tank-5000", tiles=25, original=500, adjusted=650, new=750},    -- 10 iron,  80 copper, 160 aluminium,  20 lead,  5 steel    ...used in  4 recipes (+1 indirectly)
        {id="py-tank-6500", tiles=25, original=650, adjusted=750, new=750},    -- 51 iron,                             60 lead              ...used in  7 recipes
        {id="py-tank-8000", tiles=36, original=800, adjusted=1250, new=1250},  -- 60 iron,                             70 lead              ...used in 10 recipes
        {id="py-tank-9000", tiles=49, original=900, adjusted=1800, new=1800},  -- 45 iron, 110 copper, 220 aluminium,  30 lead, 35 steel    ...used in  1 recipe
        {id="py-tank-10000", tiles=64, original=1000, adjusted=2500, new=2500} -- 56 iron,  40 copper,  80 aluminium, 105 lead              ...used in  1 recipe
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
                capacity = tonumber(tank[cap])
                data.raw["storage-tank"][tank.id].fluid_box.volume = capacity
            end
            data.raw["storage-tank"][tank.id].localised_name = {"name.storage", tostring(capacity/10)}
            data.raw.recipe[tank.id].localised_name = {"name.storage", tostring(capacity/10)}
            if tank.id ~= "storage-tank" then
                local order = tostring(capacity)
                if capacity < 1000 then order = "0"..order end
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
                "urea-decomposition", "melamine", "fiberboard", "black-liquor", "starch", "he-01", "tar-to-carbolic", "anthracene-gasoline-cracking",
                "boric-acid-hcl", "cobalt-extract", "fish-emulsion", "acidgas-2", "coal-slurry-fuel", "coalbed-gas-to-acidgas", "crude-from-manure", "eg-si", "organic-solvent","petgas-methanol",
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
                "niobium-dust", "powdered-quartz","grade-1-u-recrush", "grade-2-chromite-beneficiation", "grade-2-nickel-recrush", "milling-ree", "niobium-powder",
                "battery-mk00", "dried-meat-01", "guts-to-jerky", "portable-gasolene-generator", "nexelit-battery-recharge", "nexelit-battery", "quantum-battery-recharge", "quantum-battery", "poorman-wood-fence",
                "collector", "collector-mk02", "collector-mk03", "collector-mk04", "py-gas-vent", "py-sinkhole", "py-burner", "tailings-pond", "multiblade-turbine-mk01", "dino-dig-site",
            },
            ["item"] = { "battery-mk00", "portable-gasolene-generator", "used-nexelit-battery", "nexelit-battery", "used-quantum-battery", "quantum-battery", },
            ["capsule"] = { "dried-meat", },
            ["wall"] = { "poorman-wood-fence", },
            ["mining-drill"] = { "collector", "collector-mk02", "collector-mk03", "collector-mk04", },
            ["storage-tank"] = { "tailings-pond", },
            ["furnace"] = { "py-gas-vent", "py-sinkhole", "py-burner", },
            ["electric-energy-interface"] = { "multiblade-turbine-mk01", },
            ["assembling-machine"] = { "dino-dig-site", },
        },
        ["description"] = {
            ["recipe"] = { "nexelit-battery-recharge", "quantum-battery-recharge", },
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
        ["technology"] = "technology", ["recipe"] = "recipe", ["item"] = "item", ["capsule"] = "item",
        ["wall"] = "entity", ["mining-drill"] = "entity", ["furnace"] = "entity", ["storage-tank"] = "entity", ["electric-energy-interface"] = "entity", ["assembling-machine"] = "entity", ["radar"] = "entity",
    }
    -- adjusts names and descriptions for clarity, such as making multi-product recipes include each product so they can be searched the same way as other recipes
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
end

if settings.startup["pysimple-descriptions"].value or settings.startup["pysimple-tech-tree"].value ~= "1" then
    local tech_unlocks = {
        ["automation-science-pack"] = {"collector", "soil-extractor-mk01", "soil", "wpu", "log-wood", "empty-planter-box", "planter-box", "automation-science-pack", "lab"},
        ["coal-processing-1"] = {"distilator", "distilled-raw-coal", "coal-gas", "coal-gas-from-coke", "coal-gas-from-wood", "py-gas-vent", "tailings-pond", "iron-oxide-smelting"},
        ["ceramic"] = {"clay-pit-mk01", "clay", "ceramic", "electronics-factory-mk01", "inductor1"},
        ["crusher"] = {"jaw-crusher", "bricks-to-stone", "stone-to-gravel", "gravel-to-sand", "grade-1-iron-crush", "low-grade-smelting-iron"},
        ["concrete"] = {"hpf", "lime", "concrete", "hazard-concrete", "refined-concrete", "refined-hazard-concrete"},
        ["tar-processing"] = {"tar-distilation", "sand-brick", "tar-processing-unit", "tar-refining", "tar-refining-tops", "stone-brick-2", "pitch-refining", "light-oil-aromatics", "quenching-tower", "tar-quenching"},
        ["acetylene"] = {"calcium-carbide", "gasifier", "acetylene"},
        ["creosote"] = {"carbolic-oil-creosote", "naphthalene-oil-creosote", "treated-wood", "small-electric-pole-2"},
        ["moondrop"] = {"moondrop-codex", "moondrop-sample", "moondrop-seeds", "moondrop-greenhouse-mk01", "moondrop-1", "methane-co2", "methanal"},
        ["sap-mk01"] = {"sap-seeds", "sap-tree", "sap-extractor-mk01", "sap-01"},
        ["wood-processing"] = {"wood-seeds", "wood-seedling", "tree", "fwf-mk01", "log1", "log2", "log3", "fiber-01", "cellulose-00"},
        ["fluid-pressurization"] = {"vacuum-pump-mk01", "vacuum", "graphite", "vacuum-tube", "saline-water", "gravel-saline-water"},
        ["vacuum-tube-electronics"] = {"battery-mk00", "capacitor1", "resistor1", "pulp-mill-mk01", "formica", "pcb-factory-mk01", "pcb1", "chipshooter-mk01", "electronic-circuit"},
        ["copper-mk01"] = {"automated-screener-mk01", "grade-2-copper", "grade-1-copper-crush", "copper-plate-4"},
        ["scrude"] = {"reformer-mk01", "scrude-refining", "olefin-plant", "heavy-oil-to-kerosene"},
        ["vrauks"] = {"vrauks-codex", "vrauks", "vrauks-cocoon-1", "vrauks-paddock-mk01", "vrauks-1", "caged-vrauks", "uncaged-vrauks"},
        ["rendering"] = {"slaughterhouse-mk01", "full-render-vrauks", "dried-meat-01"},
        ["py-science-pack-mk01"] = {"stopper", "flask", "research-center-mk01", "py-science-pack-1"},
        ["fluid-processing-machines-1"] = {"evaporator", "tailings-dust", "extract-sulfur"},
        ["military"] = {"submachine-gun", "shotgun", "gun-powder", "shotgun-shell", "firearm-magazine"},
        ["boron"] = {"borax-washing", "diborane", "boric-acid", "boron-trioxide"},
        ["electric-mining-drill"] = {"electric-mining-drill", "fluid-drill-mk02"},
        ["geothermal-power-mk01"] = {"geothermal-plant-mk01", "geo-he-00"},
        ["antimony-mk01"] = {"antimonium-drill-mk01", "sb-grade-01", "sb-grade-02", "sb-grade-03", "sb-grade-04", "sb-oxide-01", "pbsb-alloy"},
        ["nexelit-mk01"] = {"nexelit-ore-1", "dino-dig-site", "digosaurus", "clean-nexelit", "nexelit-plate-2"},
        ["casting-mk01"] = {"sand-casting", "casting-unit-mk01"},
        ["separation"] = {"soil-separation-2", "classifier", "coarse-classification", "sand-classification", "tailings-classification"},
        ["mycology-mk01"] = {"ground-sample01", "spore-collector-mk01"},
        ["fawogae-mk01"] = {"fawogae-codex", "earth-shroom-sample", "fawogae-spore", "fawogae-sample", "fawogae-plantation-mk01", "fawogae-1", "coal-fawogae"},
        ["vrauks-mk02"] = {"vrauks-food-01", "vrauks-cocoon-2", "vrauks-2", "vrauks-mk02", "vrauks-mk02-cocoon", "vrauks-mk02-breeder"},
        ["rubber"] = {"carbon-black", "polybutadiene", "rubber-01", "stopper-2", "belt", "long-handed-inserter", "transport-belt-2", "engine-unit-2"},
        ["ralesia"] = {"ralesia-codex", "earth-flower-sample", "ralesia-sample", "ralesia-seeds", "ralesia-plantation-mk01", "ralesias-1"},
        ["auog"] = {"auog-codex", "earth-bear-sample", "auog", "auog-food-01", "auog-pup-breeding-1", "auog-pup-breeding-2", "auog-paddock-mk01", "auog-maturing-1", "auog-maturing-2", "auog-pooping-1", "auog-pooping-2", "caged-auog", "uncaged-auog", "full-render-auogs"},
        ["melamine"] = {"bio-reactor-mk01", "liquid-manure", "urea-from-liquid-manure", "fbreactor-mk01", "urea-decomposition", "melamine", "melamine-resin"},
        ["starch-mk01"] = {"powdered-ralesia-seeds", "starch", "workers-food"},
        ["machine-components-mk01"] = {"utility-box-mk01", "controler-mk01", "mechanical-parts-01", "electronics-mk01"},
        ["cottongut-mk01"] = {"cottongut-codex", "earth-mouse-sample", "cottongut", "cottongut-food-01", "prandium-lab-mk01", "cottongut-pup-mk01-raising", "cottongut-mature-basic-01", "caged-cottongut-1", "cottongut-cub-1", "full-render-cottongut"},
        ["energy-1"] = {"electric-boiler", "salt-mine", "water-saline", "molten-salt"},
        ["cooling-tower-1"] = {"cooling-tower-mk01", "cooling-water"},
        ["coalplant-mk01"] = {"py-coal-powerplant-mk01", "coal-molten-salt-01", "he-01"},
        ["oilplant-mk01"] = {"py-oil-powerplant-mk01", "oil-molten-salt-01", "he-01"},
        ["biomassplant-mk01"] = {"py-biomass-powerplant-mk01", "biomass-molten-salt-01", "he-01"},
        ["wind-mk01"] = {"vawt-turbine-mk01", "vane-mk01", "tower-mk01", "blade-mk01", "rotor-mk01", "yaw-drive-mk01", "nacelle-mk01", "hawt-turbine-mk01"},
        ["logistic-science-pack"] = {"rich-clay", "animal-sample-01", "bone-to-bonemeal-2", "bio-sample01", "alien-sample01", "logistic-science-pack"},
        ["plastics"] = {"biofactory-mk01", "aromatics-to-plastic", "empty-jerry-can"},
        ["compost"] = {"biomass-cooking", "flue-gas-1", "flue-gas-3", "compost-plant-mk01"},
        ["py-storage-tanks"] = {"py-tank-3000", "py-tank-1000", "py-tank-1500", "storage-tank", "py-tank-4000", "py-tank-7000", "py-tank-5000", "py-tank-6500", "py-tank-8000", "py-tank-9000", "py-tank-10000"},
        -- TODO: Reorder unlocks for stage 3 & stage 4 technologies
    }
    -- reorders recipe unlocks by priority - recipes which need to be used first will be listed first
    if not (settings.startup["py-tank-adjust"].value or settings.startup["pysimple-storage-tanks"].value) then tech_unlocks["py-storage-tanks"] = nil end
    for tech,unlocks in pairs(tech_unlocks) do
        for i,unlock in pairs(unlocks) do
            add_unlock(unlock, tech, tech, i)
        end
    end

    local tech_icons = {
        ["py-storage-tanks"] = {icon="__base__/graphics/technology/fluid-handling.png", size=256, mipmaps=1},
        ["fluid-handling"] = {icon="__base__/graphics/icons/fluid/barreling/barrel-fill.png", size=64, mipmaps=1},
    }
    -- updates some technology icons
    for tech,info in pairs(tech_icons) do
        if data.raw.technology[tech] then
            data.raw.technology[tech].icon = info.icon
            data.raw.technology[tech].icon_size = info.size
            data.raw.technology[tech].icon_mipmaps = info.mipmaps
        end
    end
end

require("prototypes/reorganize-item-groups")
--require("prototypes/trim-tech-tree")
