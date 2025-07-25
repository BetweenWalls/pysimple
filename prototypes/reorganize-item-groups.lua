--- reorganize-item-groups.lua

local debug_errors = false
local groups = {
    ["logistics"] = {
        ["py-void"] = {order="1"},
        ["storage"] = {items={"tailings-pond", "py-gas-vent", "py-sinkhole", "py-burner"}},
        ["py-pipes"] = {items={{"barrel-machine-mk01", "a"}, {"configurable-valve", "b[pipe]-b[configurable-valve]"}, {"valves-one_way", "b[pipe]-d[valves-one_way]"}, {"valves-overflow", "b[pipe]-d[valves-overflow]"}, {"valves-top_up", "b[pipe]-d[valves-top_up]"}, "py-check-valve", "py-overflow-valve", "py-underflow-valve", "niobium-pipe", "niobium-pipe-to-ground", "ht-pipes", "ht-pipes-to-ground"}, recipes={{"casting-niobium-pipe", "zpy-item-09b"}, {"hotair-casting-niobium-pipe", "zpy-item-09c"}, {"casting-niobium-pipe-underground", "zpy-item-10b"}, {"hotair-casting-niobium-pipe-underground", "zpy-item-10c"}, {"casting-ht-pipe", "zpy-item-11b"}, {"hotair-casting-ht-pipe", "zpy-item-11c"}, {"casting-ht-pipe-underground", "zpy-item-12b"}, {"hotair-casting-ht-pipe-underground", "zpy-item-12c"}}},
        ["energy-pipe-distribution"] = {items={"small-electric-pole", "medium-electric-pole", "nexelit-power-pole", "big-electric-pole", "substation", "nexelit-substation", "pipe", "pipe-to-ground", "pump"}, recipes={{"casting-pipe", "zpy-item-07b"}, {"hotair-casting-pipe", "zpy-item-07c"}, {"casting-pipe-ug", "zpy-item-08b"}, {"hotair-casting-pipe-ug", "zpy-item-08c"}}},
        ["train-transport"] = {items={"mk02-locomotive", "mk02-wagon", "mk02-fluid-wagon", "ht-locomotive", "ht-generic-wagon", "ht-generic-fluid-wagon", "mk04-locomotive", "mk04-wagon", "mk04-fluid-wagon"}},
        ["logistic-network"] = {items={"storage-chest", "passive-provider-chest", "buffer-chest", "requester-chest", "active-provider-chest"}},
        ["py-containers-shed"] = {items={"py-shed-storage", "py-shed-passive-provider", "py-shed-buffer", "py-shed-requester", "py-shed-active-provider"}},
        ["py-containers-storehouse"] = {items={"py-storehouse-storage", "py-storehouse-passive-provider", "py-storehouse-buffer", "py-storehouse-requester", "py-storehouse-active-provider"}},
        ["py-containers-warehouse"] = {items={"py-warehouse-storage", "py-warehouse-passive-provider", "py-warehouse-buffer", "py-warehouse-requester", "py-warehouse-active-provider"}},
        ["py-containers-deposit"] = {items={"py-deposit-storage", "py-deposit-passive-provider", "py-deposit-buffer", "py-deposit-requester", "py-deposit-active-provider"}},
        ["py-trains"] = {order="f"},
        ["py-stations"] = {items={"roboport"}},
        ["py-robots"] = {items={"logistic-robot", "construction-robot"}},
        ["terrain"] = {items={{"stone-brick","1"}}, recipes={{"stone-brick"}, {"sand-brick"}, {"stone-brick-2"}}},
        ["py-tiles-2"] = {items={"black-refined-concrete", "brown-refined-concrete", "red-refined-concrete", "orange-refined-concrete", "yellow-refined-concrete", "acid-refined-concrete", "green-refined-concrete", "cyan-refined-concrete", "blue-refined-concrete", "purple-refined-concrete", "pink-refined-concrete"}},
    },
    ["production"] = {
        ["energy"] = {order="zpy[general]-a[power]-1", items={"boiler", "py-electric-boiler", "oil-boiler-mk01", "steam-engine", "steam-turbine", "accumulator", "accumulator-mk01", "accumulator-mk02", "accumulator-mk03", "py-turbine"}},
        ["py-alternativeenergy-special-buildings"] = {order="zpy[general]-a[power]-2", items={"rhe", "heat-exchanger", "heat-pipe", "nuclear-reactor", "py-rtg", "fusion-reactor-mk01", "fusion-reactor-mk02", "mdh"}},
        ["py-alternativeenergy-thermosolar"] = {order="zpy[general]-a[power]-3", items={{"microwave-receiver","1"}, {"anti-solar","2"}, "aerial-base", "aerial-base-animation", "aerial-base-chest", "aerial-blimp-mk01", "aerial-blimp-mk02", "aerial-blimp-mk03", "aerial-blimp-mk04", "aerial-blimp-mk01-accumulator", "aerial-blimp-mk02-accumulator", "aerial-blimp-mk03-accumulator", "aerial-blimp-mk04-accumulator", "sut-placement-distance", "sut-panel-1", "sut-panel-2", "sut-panel-3", "sut-panel-4", "sut-panel-5", "sut-panel-6", "sut-panel-7", "sut-panel-8", "sut-panel-9", "sut-panel-10", "sut-panel-11", "sut-panel-12", "sut-panel-13", "sut-panel-14", "sut-panel-15", "sut-panel-16", "sut-panel-17", "sut-panel-18", "sut-panel-19", "sut-panel-20", "sut-panel-21", "sut-panel-22", "sut-panel-23", "sut-panel-24", "sut-panel-25", "sut-panel-26", "sut-panel-27", "sut-panel-28", "sut-panel-29", "sut-panel-30", "sut-panel-31", "sut-panel-32", "sut-panel-33", "sut-panel-34", "sut-panel-35", "sut-panel-36", "sut-panel-37", "sut-panel-38", "sut-panel-39", "sut-panel-40", "sut-panel-41", "sut-panel-42", "sut-panel-43", "sut-panel-44", "sut-panel-45", "sut-panel-46", "sut-panel-47", "sut-panel-48", "sut-panel-49", "sut-panel-50", "sut-panel-51", "sut-panel-52", "sut-panel-53", "sut-panel-54", "sut-panel-55", "sut-panel-56", "sut-panel-57", "sut-panel-58", "sut-panel-59", "sut-panel-60"}},
        ["extraction-machine"] = {order="zpy[general]-b[extraction]", items={"burner-mining-drill", "electric-mining-drill", "offshore-pump", "coal-mine", "iron-mine", "copper-mine", "aluminium-mine", "tin-mine", "lead-mine", "zinc-mine", "titanium-mine", "nickel-mine", "chromium-mine", "quartz-mine", "phosphate-mine-02", "salt-mine", "niobium-mine", "rare-earth-mine", "phosphate-mine", "mo-mine", "diamond-mine", "regolite-mine", "sulfur-mine", "geothermal-plant-mk01", "fracking-rig", "retorter", "uranium-mining-drill", "uranium-mine", "nexelit-mine"}},
        ["smelting-machine"] = {order="zpy[general]-c[smelting]", items={"stone-furnace", "steel-furnace", "electric-furnace", "drp", "sinter-unit"}},
        ["production-machine"] = {order="zpy[general]-d[assembly]", items={"assembling-machine-1", "assembling-machine-2", "assembling-machine-3", "quantum-computer", "co2-absorber"}},
        ["py-power"] = {order="zpy[general]-a"},
        ["py-fusion-reactors"] = {order="zpy[general]-a"},
        ["py-fusion-buildings-miners"] = {order="zpy[general]-b"},
        ["py-rawores-mines"] = {order="zpy[general]-b"},
        ["coal-processing"] = {order="zpy[general]-e"},
        ["py-hightech-buildings"] = {order="zpy[general]-e"},
        ["py-petroleum-handling-buildings-extras"] = {order="zpy[general]-e"},
        ["py-rawores-buildings-others"] = {order="zpy[general]-e"},
        ["module"] = {order="zpy[general]-x", items={{"beacon","a[beacon]-2"}}},
        ["science-pack"] = {order="zpy[general]-y", items={{"lab","0"}}},
        ["space-related"] = {order="zpy[general]-z", items={"rocket-part", "capsule", "microwave-satellite", "satellite", "destabilized-toxirus", "cargo-pod", "cargo-pod-container"}},
        ["py-alternativeenergy-buildings-mk01"] = {order="zpy[mk01]-a[power]", items={"steam-turbine-mk01", "py-heat-exchanger", "neutron-absorber-mk01", "neutron-moderator-mk01", "nuclear-reactor-mk01", "nuclear-reactor-mox-mk01", "nuclear-reactor-mox-mk01-uncraft", "py-biomass-powerplant-mk01", "py-coal-powerplant-mk01", "py-gas-powerplant-mk01", "py-oil-powerplant-mk01", "solar-panel-mk01", "tidal-mk01", "vawt-turbine-mk01", "hawt-turbine-mk01", "multiblade-turbine-mk01", "gasturbinemk01", "vawt-turbine-mk01-collision", "hawt-turbine-mk01-collision", "multiblade-turbine-mk01-collision", "multiblade-turbine-mk01-blank", "power-house"}},
        ["py-alternativeenergy-buildings-mk02"] = {order="zpy[mk02]-a[power]", items={"steam-turbine-mk02", "py-heat-exchanger-mk02", "neutron-absorber-mk02", "neutron-moderator-mk02", "nuclear-reactor-mk02", "nuclear-reactor-mox-mk02", "nuclear-reactor-mox-mk02-uncraft", "py-biomass-powerplant-mk02", "py-coal-powerplant-mk02", "py-gas-powerplant-mk02", "py-oil-powerplant-mk02", "solar-panel-mk02", "tidal-mk02", "vawt-turbine-mk02", "hawt-turbine-mk02", "gasturbinemk02", "vawt-turbine-mk02-collision", "hawt-turbine-mk02-collision", "power-house-mk02"}},
        ["py-alternativeenergy-buildings-mk03"] = {order="zpy[mk03]-a[power]", items={"steam-turbine-mk03", "py-heat-exchanger-mk03", "neutron-absorber-mk03", "neutron-moderator-mk03", "nuclear-reactor-mk03", "nuclear-reactor-mox-mk03", "nuclear-reactor-mox-mk03-uncraft", "py-biomass-powerplant-mk03", "py-coal-powerplant-mk03", "py-gas-powerplant-mk03", "py-oil-powerplant-mk03", "solar-panel-mk03", "tidal-mk03", "vawt-turbine-mk03", "hawt-turbine-mk03", "multiblade-turbine-mk03", "gasturbinemk03", "vawt-turbine-mk03-collision", "hawt-turbine-mk03-collision", "multiblade-turbine-mk03-collision", "multiblade-turbine-mk03-blank", "power-house-mk03"}},
        ["py-alternativeenergy-buildings-mk04"] = {order="zpy[mk04]-a[power]", items={"steam-turbine-mk04", "py-heat-exchanger-mk04", "neutron-absorber-mk04", "neutron-moderator-mk04", "nuclear-reactor-mk04", "nuclear-reactor-mox-mk04", "nuclear-reactor-mox-mk04-uncraft", "py-biomass-powerplant-mk04", "py-coal-powerplant-mk04", "py-gas-powerplant-mk04", "py-oil-powerplant-mk04", "solar-panel-mk04", "tidal-mk04", "vawt-turbine-mk04", "hawt-turbine-mk04", "vawt-turbine-mk04-collision", "hawt-turbine-mk04-collision", "power-house-mk04"}},
        ["py-mining-mk01"] = {order="zpy[mk01]-b[extraction]", items={"soil-extractor-mk01", "clay-pit-mk01", "flora-collector-mk01", "fluid-drill-mk01", "borax-mine", "antimony-drill-mk01", "ree-mining-drill-mk01", "natural-gas-derrick-mk01", "oil-derrick-mk01", "oil-sand-extractor-mk01", "tar-extractor-mk01", "coalbed-mk01", "pumpjack-mk01", "sand-extractor", "ground-borer", "spore-collector-mk01", "tholin-atm-mk01", "soil-extractor-mk01-legacy", "antimonium-drill-mk01", "ground-borer-legacy", "sand-extractor-legacy", "natural-gas-derrick-mk01-base", "oil-derrick-mk01-base", "tar-extractor-mk01-base"}},
        ["py-mining-mk02"] = {order="zpy[mk02]-b[extraction]", items={"soil-extractor-mk02", "clay-pit-mk02", "flora-collector-mk02", "fluid-drill-mk02", "borax-mine-mk02", "antimony-drill-mk02", "ree-mining-drill-mk02", "natural-gas-derrick-mk02", "oil-derrick-mk02", "oil-sand-extractor-mk02", "tar-extractor-mk02", "coalbed-mk02", "pumpjack-mk02", "sand-extractor-mk02", "ground-borer-mk02", "spore-collector-mk02", "tholin-atm-mk02", "soil-extractor-mk02-legacy", "antimonium-drill-mk02", "ground-borer-mk02-legacy", "sand-extractor-mk02-legacy", "natural-gas-derrick-mk02-base", "oil-derrick-mk02-base", "tar-extractor-mk02-base"}},
        ["py-mining-mk03"] = {order="zpy[mk03]-b[extraction]", items={"soil-extractor-mk03", "clay-pit-mk03", "flora-collector-mk03", "fluid-drill-mk03", "borax-mine-mk03", "antimony-drill-mk03", "ree-mining-drill-mk03", "natural-gas-derrick-mk03", "oil-derrick-mk03", "oil-sand-extractor-mk03", "tar-extractor-mk03", "coalbed-mk03", "pumpjack-mk03", "sand-extractor-mk03", "ground-borer-mk03", "spore-collector-mk03", "tholin-atm-mk03", "soil-extractor-mk03-legacy", "antimonium-drill-mk03", "ground-borer-mk03-legacy", "sand-extractor-mk03-legacy", "natural-gas-derrick-mk03-base", "oil-derrick-mk03-base", "tar-extractor-mk03-base"}},
        ["py-mining-mk04"] = {order="zpy[mk04]-b[extraction]", items={"soil-extractor-mk04", "clay-pit-mk04", "flora-collector-mk04", "fluid-drill-mk04", "borax-mine-mk04", "antimony-drill-mk04", "ree-mining-drill-mk04", "natural-gas-derrick-mk04", "oil-derrick-mk04", "oil-sand-extractor-mk04", "tar-extractor-mk04", "coalbed-mk04", "pumpjack-mk04", "sand-extractor-mk04", "ground-borer-mk04", "spore-collector-mk04", "tholin-atm-mk04", "soil-extractor-mk04-legacy", "antimonium-drill-mk04", "ground-borer-mk04-legacy", "sand-extractor-mk04-legacy", "natural-gas-derrick-mk04-base", "oil-derrick-mk04-base", "tar-extractor-mk04-base"}},
        ["py-rawores-buildings-mk01"] = {order="zpy[mk01]-c[smelting]", items={"jaw-crusher", "impact-crusher-mk01", "secondary-crusher-mk01", "ball-mill-mk01", "automated-screener-mk01", "advanced-foundry-mk01", "bof-mk01", "eaf-mk01", "casting-unit-mk01", "smelter-mk01", "casting-unit-mk01-legacy"}},
        ["py-rawores-buildings-mk02"] = {order="zpy[mk02]-c[smelting]", items={"jaw-crusher-mk02", "impact-crusher-mk02", "secondary-crusher-mk02", "ball-mill-mk02", "automated-screener-mk02", "advanced-foundry-mk02", "bof-mk02", "eaf-mk02", "casting-unit-mk02", "smelter-mk02", "casting-unit-mk02-legacy"}},
        ["py-rawores-buildings-mk03"] = {order="zpy[mk03]-c[smelting]", items={"jaw-crusher-mk03", "impact-crusher-mk03", "secondary-crusher-mk03", "ball-mill-mk03", "automated-screener-mk03", "advanced-foundry-mk03", "bof-mk03", "eaf-mk03", "casting-unit-mk03", "smelter-mk03", "casting-unit-mk03-legacy"}},
        ["py-rawores-buildings-mk04"] = {order="zpy[mk04]-c[smelting]", items={"jaw-crusher-mk04", "impact-crusher-mk04", "secondary-crusher-mk04", "ball-mill-mk04", "automated-screener-mk04", "advanced-foundry-mk04", "bof-mk04", "eaf-mk04", "casting-unit-mk04", "smelter-mk04", "casting-unit-mk04-legacy"}},
        ["py-cp-buildings-mk00"] = {order="zpy[mk00]-d", items={"soil-extractor-mk00", "wpu-mk00", "automated-screener-mk00", "washer-mk00", "solid-separator-mk00", "ddc-mk00"}}, -- pyblock only
        ["py-cp-buildings-mk01"] = {order="zpy[mk01]-d", items={"classifier", "hydroclassifier-mk01", "grease-table-mk01", "flotation-cell-mk01", "leaching-station-mk01", "scrubber-mk01", "wet-scrubber-mk01", "agitator-mk01", "thickener-mk01", "hydrocyclone-mk01", "centrifugal-pan-mk01", "jig-mk01", "classifier-legacy"}},
        ["py-cp-buildings-mk02"] = {order="zpy[mk02]-d", items={"classifier-mk02", "hydroclassifier-mk02", "grease-table-mk02", "flotation-cell-mk02", "leaching-station-mk02", "scrubber-mk02", "wet-scrubber-mk02", "agitator-mk02", "thickener-mk02", "hydrocyclone-mk02", "centrifugal-pan-mk02", "jig-mk02", "classifier-mk02-legacy"}},
        ["py-cp-buildings-mk03"] = {order="zpy[mk03]-d", items={"classifier-mk03", "hydroclassifier-mk03", "grease-table-mk03", "flotation-cell-mk03", "leaching-station-mk03", "scrubber-mk03", "wet-scrubber-mk03", "agitator-mk03", "thickener-mk03", "hydrocyclone-mk03", "centrifugal-pan-mk03", "jig-mk03", "classifier-mk03-legacy"}},
        ["py-cp-buildings-mk04"] = {order="zpy[mk04]-d", items={"classifier-mk04", "hydroclassifier-mk04", "grease-table-mk04", "flotation-cell-mk04", "leaching-station-mk04", "scrubber-mk04", "wet-scrubber-mk04", "agitator-mk04", "thickener-mk04", "hydrocyclone-mk04", "centrifugal-pan-mk04", "jig-mk04", "classifier-mk04-legacy"}},
        ["py-fusion-buildings-mk00"] = {order="zpy[mk00]-e"},
        ["py-fusion-buildings-mk01"] = {order="zpy[mk01]-e", items={"wpu", "turd-wpu", "glassworks-mk01", "hpf", "washer", "evaporator", "carbon-filter", "pulp-mill-mk01", "solid-separator", "electrolyzer-mk01", "centrifuge-mk01", "vacuum-pump-mk01", "cooling-tower-mk01", "evaporator-legacy", "wpu-legacy"}},
        ["py-fusion-buildings-mk02"] = {order="zpy[mk02]-e", items={"wpu-mk02", "turd-wpu-mk02", "glassworks-mk02", "hpf-mk02", "washer-mk02", "evaporator-mk02", "carbon-filter-mk02", "pulp-mill-mk02", "solid-separator-mk02", "electrolyzer-mk02", "centrifuge-mk02", "vacuum-pump-mk02", "cooling-tower-mk02", "evaporator-mk02-legacy", "wpu-mk02-legacy"}},
        ["py-fusion-buildings-mk03"] = {order="zpy[mk03]-e", items={"wpu-mk03", "turd-wpu-mk03", "glassworks-mk03", "hpf-mk03", "washer-mk03", "evaporator-mk03", "carbon-filter-mk03", "pulp-mill-mk03", "solid-separator-mk03", "electrolyzer-mk03", "centrifuge-mk03", "vacuum-pump-mk03", "evaporator-mk03-legacy", "wpu-mk03-legacy"}},
        ["py-fusion-buildings-mk04"] = {order="zpy[mk04]-e", items={"wpu-mk04", "turd-wpu-mk04", "glassworks-mk04", "hpf-mk04", "washer-mk04", "evaporator-mk04", "carbon-filter-mk04", "pulp-mill-mk04", "solid-separator-mk04", "electrolyzer-mk04", "centrifuge-mk04", "vacuum-pump-mk04", "evaporator-mk04-legacy", "wpu-mk04-legacy"}},
        ["py-petroleum-handling-buildings-mk01"] = {order="zpy[mk01]-f", items={"distilator", "tar-processing-unit", "gasifier", "compressor-mk01", "fluid-separator", "quenching-tower", "methanol-reactor", "olefin-plant", "desulfurizator-unit", "cracker-mk01", "rectisol", "fts-reactor", "reformer-mk01", "lor-mk01", "heavy-oil-refinery-mk01", "gas-refinery-mk01"}},
        ["py-petroleum-handling-buildings-mk02"] = {order="zpy[mk02]-f", items={"distilator-mk02", "tar-processing-unit-mk02", "gasifier-mk02", "compressor-mk02", "fluid-separator-mk02", "quenching-tower-mk02", "methanol-reactor-mk02", "olefin-plant-mk02", "desulfurizator-unit-mk02", "cracker-mk02", "rectisol-mk02", "fts-reactor-mk02", "reformer-mk02", "lor-mk02", "heavy-oil-refinery-mk02", "gas-refinery-mk02"}},
        ["py-petroleum-handling-buildings-mk03"] = {order="zpy[mk03]-f", items={"distilator-mk03", "tar-processing-unit-mk03", "gasifier-mk03", "compressor-mk03", "fluid-separator-mk03", "quenching-tower-mk03", "methanol-reactor-mk03", "olefin-plant-mk03", "desulfurizator-unit-mk03", "cracker-mk03", "rectisol-mk03", "fts-reactor-mk03", "reformer-mk03", "lor-mk03", "heavy-oil-refinery-mk03", "gas-refinery-mk03"}},
        ["py-petroleum-handling-buildings-mk04"] = {order="zpy[mk04]-f", items={"distilator-mk04", "tar-processing-unit-mk04", "gasifier-mk04", "compressor-mk04", "fluid-separator-mk04", "quenching-tower-mk04", "methanol-reactor-mk04", "olefin-plant-mk04", "desulfurizator-unit-mk04", "cracker-mk04", "rectisol-mk04", "fts-reactor-mk04", "reformer-mk04", "lor-mk04", "heavy-oil-refinery-mk04", "gas-refinery-mk04"}},
        ["py-hightech-buildings-mk01"] = {order="zpy[mk01]-g", items={"automated-factory-mk01", "electronics-factory-mk01", "pcb-factory-mk01", "chipshooter-mk01", "nano-assembler-mk01", "nmf-mk01", "chemical-plant-mk01", "fbreactor-mk01", "gas-separator-mk01", "mixer-mk01", "upgrader-mk01", "particle-accelerator-mk01", "tholin-plant-mk01"}},
        ["py-hightech-buildings-mk02"] = {order="zpy[mk02]-g", items={"automated-factory-mk02", "electronics-factory-mk02", "pcb-factory-mk02", "chipshooter-mk02", "nano-assembler-mk02", "nmf-mk02", "chemical-plant-mk02", "fbreactor-mk02", "gas-separator-mk02", "mixer-mk02", "upgrader-mk02", "particle-accelerator-mk02", "tholin-plant-mk02"}},
        ["py-hightech-buildings-mk03"] = {order="zpy[mk03]-g", items={"automated-factory-mk03", "electronics-factory-mk03", "pcb-factory-mk03", "chipshooter-mk03", "nano-assembler-mk03", "nmf-mk03", "chemical-plant-mk03", "fbreactor-mk03", "gas-separator-mk03", "mixer-mk03", "upgrader-mk03", "particle-accelerator-mk03", "tholin-plant-mk03"}},
        ["py-hightech-buildings-mk04"] = {order="zpy[mk04]-g", items={"automated-factory-mk04", "electronics-factory-mk04", "pcb-factory-mk04", "chipshooter-mk04", "nano-assembler-mk04", "nmf-mk04", "chemical-plant-mk04", "fbreactor-mk04", "gas-separator-mk04", "mixer-mk04", "upgrader-mk04", "particle-accelerator-mk04", "tholin-plant-mk04"}},
    },
    ["intermediate-products"] = {},
    ["coal-processing"] = {},
    ["fusion-energy"] = {},
    ["py-alternativeenergy"] = {},
    ["py-hightech"] = { -- renamed "intermediate products"
        ["raw-material"] = {order="zpy-00"},
        ["recipe-raw-material"] = {order="zpy-00"},
        ["py-intermediates-1"] = {order="zpy-01", items={"raw-fish", "wood", "bolts", "small-parts-01", "small-parts-02", "small-parts-03", "iron-stick", "iron-gear-wheel", "copper-cable", "tinned-cable", "battery"}, recipes={{"casting-small-parts"}, {"hotair-casting-small-parts"}, {"casting-sticks"}, {"hotair-casting-sticks"}, {"casting-gear"}, {"hotair-casting-gear"}, {"casting-copper-cable"}, {"hotair-casting-copper-cable"}, {"casting-tin-cable"}, {"hotair-casting-tin-cable"}}},
        ["py-hightech-tier-1"] = {order="zpy-02", items={"inductor1", "capacitor1", "resistor1", "formica", "pcb1", "battery-mk00", "vacuum-tube", "electronic-circuit"}, recipes={{"hotair-lens"}}},
        ["py-intermediates-2"] = {order="zpy-03", items={"empty-planter-box", "planter-box", "stopper", "flask", "lens", "equipment-chassi", "lab-instrument"}, recipes={{"hotair-lens"}, {"casting-equipment-chassi"}, {"hotair-casting-equipment-chassi"}}},
        ["py-alternativeenergy-engine-units"] = {order="zpy-04", items={"belt", "engine-unit", "rotor", "stator", "electric-engine-unit"}, recipes={{"casting-engine-unit"}, {"hotair-casting-engine-unit"}}},
        ["py-alternativeenergy-parts"] = {order="zpy-05", items={"brake-mk01", "shaft-mk01", "gearbox-mk01", "utility-box-mk01", "controler-mk01", "electronics-mk01", "mechanical-parts-01", "vane-mk01", "tower-mk01", "anemometer-mk01", "blade-mk01", "rotor-mk01", "yaw-drive-mk01", "nacelle-mk01", "additional-part-mk01"}},
        ["py-alternativeenergy-parts-2"] = {order="zpy-06", items={"brake-mk02", "shaft-mk02", "gearbox-mk02", "utility-box-mk02", "controler-mk02", "electronics-mk02", "mechanical-parts-02", "vane-mk02", "tower-mk02", "anemometer-mk02", "blade-mk02", "rotor-mk02", "yaw-drive-mk02", "nacelle-mk02", "additional-part-mk02"}, recipes={{"hotair-shaft-mk02"}, {"hotair-vane-mk02"}}},
        ["py-alternativeenergy-parts-3"] = {order="zpy-07", items={"brake-mk03", "shaft-mk03", "gearbox-mk03", "utility-box-mk03", "controler-mk03", "electronics-mk03", "mechanical-parts-03", "hydraulic-system-mk01", "vane-mk03", "tower-mk03", "anemometer-mk03", "blade-mk03", "rotor-mk03", "yaw-drive-mk03", "nacelle-mk03"}, recipes={{"hotair-shaft-mk03"}}},
        ["py-alternativeenergy-parts-4"] = {order="zpy-08", items={"brake-mk04", "shaft-mk04", "gearbox-mk04", "utility-box-mk04", "controler-mk04", "electronics-mk04", "mechanical-parts-04", "fes", "hydraulic-system-mk02", "tower-mk04", "anemometer-mk04", "yaw-drive-mk04", "heating-system", "inside-turbine", "nacelle-mk04"}, recipes={{"hotair-shaft-mk04"}}},
        ["py-intermediates-3"] = {order="zpy-09", items={"melamine", "melamine-resin", "resorcinol", "treated-wood", "sodium-bisulfate", "sodium-sulfate", "sodium-carbonate", "fiberboard"}, recipes={{"fiberboard-3"}}},
        ["py-intermediates-4"] = {order="zpy-10", items={"ticl4", "plastic-bar"}},
        ["py-intermediates-5"] = {order="zpy-11", items={"carbon-black", "latex", "rubber", "graphite", "sb-oxide", "pyrite", "iron-oxide"}},
        ["py-intermediates-6"] = {order="zpy-12", items={"solder", "molten-solder", "duralumin", "vitreloy", "intermetallics", "fenxsb-alloy"}, recipes={{"solder"}, {"hotair-solder"}}},
        ["py-rawores-solder"] = {order="zpy-12b"},
        ["py-intermediates-7"] = {order="zpy-13", items={"nichrome", "pbsb-alloy", "nbfe-alloy", "sncr-alloy", "eva", "crmoni", "nbalti", "nxsb-alloy", "fecr-alloy", "ferrite"}},
        ["py-alternativeenergy-intermetallics-1"] = {order="zpy-14"},
        ["py-intermediates-8"] = {order="zpy-15", items={"sodium-hydroxide", "sodium-silicate", "silica-powder", "nisi", "sodium-chlorate", "ammonium-chloride"}},
        ["py-intermediates-9"] = {order="zpy-16", items={"sand-casting", "mold", "lead-container", "coated-container", "crucible", "quartz-crucible"}, recipes={{"casting-lead-container"}, {"hotair-casting-lead-container"}}},
        ["py-intermediates-10"] = {order="zpy-17", items={"phenol", "bakelite", "bisphenol-a", "epoxy", "nexelit-matrix", "nylon", "nylon-parts"}},
        ["py-intermediates-11"] = {order="zpy-18", items={"glass-core", "cladding", "cladded-core", "copper-coating", "ppd", "kevlar", "kevlar-coating", "nbfe-coating", "optical-fiber"}},
        ["py-intermediates-12"] = {order="zpy-19", items={"eg-si", "arsenic", "zinc-acetate", "silicon-wafer", "lithium-carbonate", "lithium-hydroxide", "lithium", "p-dope", "heavy-p-type", "light-n", "heavy-n"}},
        ["py-hightech-tier-2"] = {order="zpy-20", items={"crude-cermet", "cermet", "inductor2", "capacitor2", "resistor2", "transistor", "phenolicboard", "pcb2", "mosfet", "diode", "microchip", "advanced-circuit"}},
        ["py-intermediates-13"] = {order="zpy-21", items={"micro-fiber", "zinc-chloride", "active-carbon", "filtration-media"}},
        ["py-intermediates-14"] = {order="zpy-22", items={"silver-nitrate", "cerium-oxide", "polishing-wheel", "polished-glass-surface", "clean-glass-sheet", "stannous-chloride","prepared-glass", "crude-mirror", "mirror-mk01", "mirror-mk02", "mirror-mk03", "ometad", "mirror-mk04"}},
        ["py-intermediates-15"] = {order="zpy-23", items={"flying-robot-frame", "rayon", "aramid", "biofilm", "ptcda", "self-assembly-monolayer"}},
        ["py-intermediates-16"] = {order="zpy-24", items={"agzn-alloy", "alag-alloy", "crco-alloy", "mositial-nx", "nbti-alloy", "ndfeb-alloy", "re-tin"}, recipes={{"hotair-ndfeb-alloy"}, {"hotair-re-tin"}}},
        ["py-intermediates-17"] = {order="zpy-25", items={"anti-reflex-glass", "monocrystalline-slab", "polycrystalline-slab", "diamond-wire", "monocrystalline-plate", "polycrystalline-plate", "passivation-layer", "monocrystalline-cell", "polycrystalline-cell"}},
        ["py-intermediates-18"] = {order="zpy-26", items={"quartz-tube", "heatsink", "displacer", "stirling-engine", "regenerator", "axis-tracker"}},
        ["py-intermediates-19"] = {order="zpy-27", items={"dodecanoic-acid", "dodecylamine", "iron-nanoparticles", "milfe", "paramagnetic-material", "metallic-glass", "nanocarrier"}},
        ["py-alternativeenergy-intermetallics-2"] = {order="zpy-28", items={"diethylaniline", "3-diethylaminophenol", "phthalic-anhydride", "rhodamine-b", "fluorophore", "citric-acid", "sodium-citrate", "metallic-core", "silica-shell", "plasmonic-core", "lithium-niobate-nano", "dieletric-layer", "core-shell", "ns-material"}},
        ["py-intermediates-20"] = {order="zpy-29", items={"coil-core", "sc-coil", "magnetic-core", "vanadium-oxide", "deposited-core", "sc-unit"}, recipes={{"pa-vanadium"}, {"pa-vanadium2"}}},
        ["py-intermediates-21"] = {order="zpy-30", items={"nenbit-matrix", "sc-wire", "science-coating", "silver-foam", "biopolymer", "ndfeb-powder", "re-magnet", "sc-substrate", "superconductor"}},
        ["py-intermediates-22"] = {order="zpy-31", items={"ernico", "ticocr-alloy", "super-alloy", "nxzngd", "molten-nxzngd"}, recipes={{"hotair-super-alloy"}, {"hotair-nxzngd"}}},
        ["py-intermediates-23"] = {order="zpy-32", items={"cyanoacetate", "cyanoacrylate", "lithium-carbonate", "lithium-hydroxide", "lithium", "blanket-chassi", "blanket", "divertor", "wall-shield", "reinforced-wall-shield", "heavy-fermion"}},
        ["py-intermediates-24"] = {order="zpy-33", items={"nic-core", "pdms", "pdms-graphene", "graphene-sheet", "graphene-roll", "cooling-system"}},
        ["py-intermediates-25"] = {order="zpy-34", items={"methyl-acrylate", "acrylonitrile", "acrylic", "pan", "oxidized-pan-fiber", "pre-carbon-fiber", "oxalic-acid", "ammonium-oxalate", "cf1", "cf2", "dry-cf", "cf"}},
        ["py-hightech-aerogel"] = {order="zpy-35", items={"rf-gel", "clean-rf-gel", "soaked-gel", "aerogel", "carbon-aerogel", "sub-denier-microfiber", "low-density-structure"}},
        ["py-hightech-tier-3"] = {order="zpy-36", items={"glass-fiber", "fiberglass", "pcb3", "pcb3-2", "high-flux-core", "inductor3", "capacitor-termination", "capacitor-core", "capacitor3", "capacitor3", "resistor3", "processor-core", "processor", "diode-core", "diode3", "processing-unit"}},
        ["py-intermediates-26"] = {order="zpy-37", items={"lithium-peroxide", "nexelit-cartridge", "saturated-nexelit-cartridge", "control-unit"}},
        ["py-intermediates-27"] = {order="zpy-38", items={"magnetic-ring", "sc-wire", "hts-coil", "sc-stator", "cryocooler", "czts-slab", "czts-plate", "cryostat", "ybco-monocrystal", "rotor-m", "air-duct", "fan", "sc-engine"}},
        ["py-intermediates-28"] = {order="zpy-39", items={"ammonium-mixture", "crude-salt", "hbr", "libr", "hexafluoroacetone", "hfip", "guhcl", "rpc-mesh", "nano-mesh", "lithium-chloride", "volumetric-capacitor"}},
        ["py-intermediates-29"] = {order="zpy-40", items={"neodymium-nitrate", "nickel-nitrate", "perovskite-nickelate", "bioreceptor", "phenothiazine", "sb-silicate", "triethoxysilane", "aptes", "butynediol", "gbl", "pvp", "biofet"}},
        ["py-intermediates-30"] = {order="zpy-41", items={"zinc-nanocompound", "zinc-nanocomplex", "zno-nanoparticles", "crude-top-layer", "tio2", "transparent-anode", "hyperelastic-material"}},
        ["py-intermediates-31"] = {order="zpy-42", items={"bt", "triphenylanime", "photosensitive-dye", "conductive-sheet", "dsnc-cell", "glycidylamine"}},
        ["py-intermediates-32"] = {order="zpy-43", items={"ti-n", "sodium-cyanate", "yellow-dextrine", "acetaldehyde", "pyridine", "tbp", "sb-chloride"}},
        ["py-hightech-earnshaw"] = {order="zpy-44", items={"carbon-nanotube", "nano-wires", "nems", "pyrolytic-carbon", "diamagnetic-material", "harmonic-absorber", "superconductor-servomechanims", "antimatter"}},
        ["py-hightech-tier-4"] = {order="zpy-45", items={"laser-module", "yag-laser-module", "animal-reflectors", "glycidylamine", "colloidal-silica", "hardener", "inverse-opal", "photonic-crystal", "dieletric-mirror", "nanocrystaline-core", "1d-photonic-crystal", "dbr", "gaas", "fbg", "fdtd", "photonic-chip"}},
        ["py-intermediates-33"] = {order="zpy-46", items={"supercapacitor-core", "supercapacitor-shell", "supercapacitor", "pcb4", "nxag-matrix", "paradiamatic-resistor", "ingap", "quantum-well", "quantum-dots", "nanochip", "kondo-substrate", "kondo-core", "kondo-processor", "fault-current-inductor", "csle-diode", "intelligent-unit"}},
        ["py-alternativeenergy-intermetallics-3"] = {order="zpy-47", items={"parametric-oscilator", "flo", "lfo", "micro-cavity-core", "photon-deposited-quartz", "time-crystal", "quasicrystal", "metastable-quasicrystal"}},
        ["py-hightech-quantum"] = {order="zpy-48", items={"bose-einstein-superfluid", "quantum-vortex-storage-system", "alag-grid", "ingaas", "mqdc", "nv-center", "var-josephson-junction", "pi-josephson-junction", "quantum-simulation-data", "macguffin"}}, -- hardmode only: quantum-simulation-data, macguffin
        ["py-intermediates-34"] = {order="zpy-49", items={"crystallographic-substrate", "proton-donor", "proton-receiver"}},
        ["py-intermediates-34b"] = {order="zpy-50", items={"sodium-acetate", "fecl2", "fecl3", "nylon-rope", "nylon-rope-coated", "nylon-rope-uranyl-soaked", "uranyl-nitrate"}},
        ["py-nuclear"] = {order="zpy-51", items={"po-210", "pa-233", "americium-oxide", "am-241", "am-243", "uranium-oxide", "u-232", "u-233", "u-234", "u-235", "uranium-235", "u-236", "u-237", "u-238", "uranium-238", "plutonium-oxide", "plutonium-oxide-mox", "pu-238", "pu-239", "pu-240", "pu-241", "pu-242", "cm-250", "plutonium", "vitrified-glass", "nuclear-sample"}, recipes={"uranium-processing"}},
        ["recipe-py-nuclear"] = {order="zpy-52"},
        ["py-nuclear-waste"] = {order="zpy-53"},
        ["recipe-py-nuclear-waste"] = {order="zpy-54"},
        ["py-intermediates-35"] = {order="zpy-55", items={"control-rod", "used-control-rod", "nuclear-fuel", "used-nuclear-fuel", "fuelrod-mk01", "fuelrod-mk02", "fuelrod-mk03", "fuelrod-mk04", "fuelrod-mk05", "mox-fuel-cell", "used-up-mox-fuel-cell", "uranium-fuel-cell", "depleted-uranium-fuel-cell", "uranium-fuel-cell-mk02", "used-up-uranium-fuel-cell-mk02", "uranium-fuel-cell-mk03", "used-up-uranium-fuel-cell-mk03", "uranium-fuel-cell-mk04", "used-up-uranium-fuel-cell-mk04", "uranium-fuel-cell-mk05", "used-up-uranium-fuel-cell-mk05"}},
        ["uranium-processing"] = {order="zpy-56"},
        ["py-intermediates-36"] = {order="zpy-57", items={"warm-stone-brick", "warmer-stone-brick", "hot-stone-brick"}},
        ["py-intermediates-37"] = {order="zpy-58", items={"coal-briquette", "charcoal-briquette", "rocket-fuel", "nuclear-fuel", "used-nuclear-fuel", "solid-fuel"}},
        ["py-intermediates-38"] = {order="zpy-59", items={"drill-head", "mega-drill-head"}, recipes={{"casting-drill-heads"}, {"hotair-casting-drill-heads"}}},
        ["py-intermediates-39"] = {order="zpy-60", items={"gunpowder", "explosives"}},
        ["py-intermediates-40"] = {order="zpy-61", items={"barrel", "empty-fuel-canister", "empty-gas-canister", "methanol-gas-canister", "empty-proto-tholins-vessel", "filled-proto-tholins-vessel", "filled-tholins-vessel"}, recipes={"empty-methanol-gas-canister", "barrel-milk", "empty-milk-barrel", "empty-proto-tholins-vessel", "fill-proto-tholins-vessel", "empty-tholins-vessel"}},
        ["py-intermediates-41"] = {order="zpy-62", recipes={"simik-molybdenum", "simik-coal", "simik-nickel", "cridren-sixth-layer-ethylene-chlorohydrin", "cridren-sixth-layer-organic-acid-anhydride"}},
        ["py-rawores-casting"] = {order="zpy-x"},
        ["py-items-hpf"] = {order="zpy-x"},
        ["py-petroleum-handling-items"] = {order="zpy-x"},
        ["py-petroleum-handling-plastic-recipes"] = {order="zpy-x"},
        ["py-hightech-kicalk"] = {order="zpy-x"},
        ["py-hightech-zipir"] = {order="zpy-x"},
        ["recipe-py-hightech-zipir"] = {order="zpy-x"},
        ["py-hightech-ores"] = {order="zpy-x"},
        ["py-rawores-recipes"] = {order="zpy-x"},
        ["recipe-py-rawores-recipes"] = {order="zpy-x"},
        ["py-rawores-items"] = {order="zpy-x"},
        ["py-items"] = {order="zpy-x"},
        ["recipe-py-items"] = {order="zpy-x"},
        ["py-hightech-items"] = {order="zpy-x"},
        ["py-fusion-items"] = {order="zpy-x"},
        ["recipe-py-fusion-items"] = {order="zpy-x"},
        ["py-alternativeenergy-items"] = {order="zpy-x"},
        ["intermediate-product"] = {order="zpy-x"},
        ["recipe-intermediate-product"] = {order="zpy-x"},
        ["barrel"] = {order="zpy-ya"},
        ["empty-barrel"] = {order="zpy-yb"},
        ["py-cans"] = {order="zpy-yc"},
    },
    ["py-rawores"] = { -- renamed "materials"
        ["raw-resource"] = {order="zpy-00"},
        ["py-rawores-natural-1"] = {order="zpy-02", items={"stone", "gravel", "sand", "pure-sand", "silicon", "kerogen", "oil-sand", "crushed-oil-sand"}, recipes={{"pa-silicon"}}},
        ["py-rawores-natural-2"] = {order="zpy-03", items={"soil", "coarse", "limestone", "lime", "calcium-carbide", "clay", "rich-clay", "ceramic"}},
        ["py-items-class"] = {order="zpy-04", items={"soot", "rich-dust", "tailings-dust"}, recipes={"soil-separation-2", "coarse-classification", "sand-classification", "ash-separation", "soot-separation", "calcinate-separation", "richdust-separation", "tailings-classification", "tailings-separation"}},
        ["recipe-py-items-class"] = {order="zpy-04"},
        ["py-washer"] = {order="zpy-05"},
        ["py-crusher"] = {order="zpy-06"},
        ["py-rawores-iron-alloys"] = {order="zpy-08", items={"steel-plate", "stainless-steel", "super-steel", "molten-steel", "molten-stainless-steel-p1", "molten-stainless-steel-p2", "molten-stainless-steel-p3", "molten-stainless-steel", "molten-super-steel-p1", "molten-super-steel-p2", "molten-super-steel"}, recipes={{"steel-20"}, {"hotair-steel-20"}, {"hotair-stainless-steel"}, {"hotair-super-steel"}}},
        ["py-rawores-coal"] = {order="zpy-09", items={"raw-coal", "coal", "crushed-coal", "coarse-coal", "coal-dust", "fines-pulp", "high-ash-fines", "thickened-coal-fines", "coal-fines", "conditioned-fines", "coal-slime-overflow", "coal-under-pulp", "coal-pulp-01", "coal-pulp-02", "coal-pulp-03", "coal-pulp-04", "coal-pulp-05", "coke", "carbon-dust", "redhot-coke"}, recipes={{"coal-fawogae"}, {"pa-coal2"}}},
        ["py-rawores-coke"] = {order="zpy-10"},
        ["py-rawores-iron"] = {order="zpy-11", items={"iron-plate", "iron-ore", "processed-iron-ore", "grade-1-iron", "grade-2-iron", "grade-3-iron", "grade-4-iron", "crushed-iron", "iron-ore-dust", "iron-slime", "unslimed-iron", "iron-concentrate", "iron-dust-concentrate", "iron-pulp-01", "petroleum-sulfonates", "iron-pulp-02", "iron-pulp-03", "iron-pulp-04", "iron-pulp-05", "iron-pulp-06", "iron-pulp-07", "high-grade-iron", "reduced-iron", "sintered-iron", "molten-iron", "fe-biomass", "sponge-iron"}, recipes={{"iron-plate"}, {"low-grade-smelting-iron"}, {"iron-oxide-smelting"}, {"iron-plate-1"}, {"hotair-iron-plate-1"}, {"soot-to-iron"}, {"mining-iron"}}},
        ["py-rawores-copper"] = {order="zpy-12", items={"copper-plate", "copper-ore", "grade-1-copper", "grade-2-copper", "grade-3-copper", "grade-4-copper", "crushed-copper", "copper-rejects", "low-grade-rejects", "copper-low-dust", "low-grade-copper", "copper-solution", "copper-pulp-01", "copper-pulp-02", "copper-pulp-03", "copper-pulp-04", "copper-pregnant-solution", "high-grade-copper", "reduced-copper", "sintered-copper", "molten-copper", "cu-biomass"}, recipes={{"copper-plate"}, {"copper-plate-4"}, {"low-grade-smelting-copper"}, {"copper-plate-1"}, {"hotair-copper-plate-1"}, {"soot-to-copper"}, {"mining-copper"}}},
        ["py-rawores-aluminium"] = {order="zpy-13", items={"aluminium-plate", "ore-aluminium", "powdered-aluminium", "al-pulp-01", "al-pulp-02", "al-pulp-03", "al-pulp-04", "sodium-aluminate", "crystalized-sodium-aluminate", "high-grade-alumina", "reduced-aluminium", "sintered-aluminium", "molten-aluminium", "al-biomass", "al-tailings"}, recipes={{"mining-aluminium"}}},
        ["py-rawores-tin"] = {order="zpy-14", items={"tin-plate", "ore-tin", "grade-1-tin", "grade-2-tin", "grade-3-tin", "grade-4-tin", "tin-ore-rejects", "tin-rejects", "powdered-tin", "tin-dust", "tin-slime", "tin-slime-overflow", "tin-solution", "tin-bottom-pulp", "tin-middle-pulp", "tin-concentrate", "high-tin-concentrate", "tin-pulp-01", "tin-pulp-02", "tin-pulp-03", "high-tin-mix", "high-grade-tin", "reduced-tin", "sintered-tin", "molten-tin", "sn-biomass"}, recipes={{"tin-plate-1"}, {"tin-plate-2"}, {"tin-plate-4"}, {"tin-plate-3"}, {"hotair-tin-plate-3"}, {"mining-tin"}}},
        ["py-rawores-zinc"] = {order="zpy-15", items={"zinc-plate", "ore-zinc", "grade-1-zinc", "grade-2-zinc", "grade-3-zinc", "grade-4-zinc", "powdered-zinc", "zinc-overflow", "zinc-pulp-01", "zinc-pulp-02", "zinc-pulp-03", "zinc-waste", "zinc-pulp-04", "purified-zinc", "concentrated-zinc", "high-grade-zinc", "reduced-zinc", "sintered-zinc", "molten-zinc", "zn-biomass"}, recipes={{"zinc-plate-1"}, {"zinc-plate-2"}, {"zinc-plate-4"}, {"zinc-plate-3"}, {"hotair-zinc-plate-3"}, {"pa-zinc"}, {"soot-to-zinc"}, {"mining-zinc"}}},
        ["py-rawores-lead"] = {order="zpy-16", items={"lead-plate", "ore-lead", "grade-1-lead", "grade-2-lead", "grade-3-lead", "grade-4-lead", "lead-dust", "lead-dust", "lead-refined-dust", "lead-refined-dust-02", "lead-refined-dust-03", "slz-pulp-01", "slz-pulp-02", "sl-01", "sl-02", "sl-03", "sl-concentrate", "high-grade-lead", "reduced-lead", "sintered-lead", "molten-lead", "pb-biomass", "lead-acetate"}, recipes={{"lead-plate-1"}, {"lead-plate-2"}, {"lead-plate-3"}, {"hotair-lead-plate-3"}, {"mining-lead"}}},
        ["py-rawores-titanium"] = {order="zpy-17", items={"titanium-plate", "ore-titanium", "grade-1-ti", "grade-2-ti", "grade-3-ti", "grade-4-ti", "ti-rejects", "powdered-ti", "ti-enriched-dust", "ti-pulp-01", "ti-pulp-02", "ti-residue", "ti-pulp-03", "ti-pulp-04", "ti-pulp-05", "ti-pulp-06", "ti-solution", "ti-solution-02", "purified-ti-pulp", "ti-overflow-waste", "high-grade-ti-powder", "concentrated-ti", "high-grade-ti", "reduced-ti", "sintered-ti", "molten-titanium", "ti-biomass"}, recipes={{"titanium-plate-1"}, {"titanium-plate-2"}, {"titanium-plate-4"}, {"titanium-plate-3"}, {"hotair-titanium-plate-3"}, {"mining-titanium"}}},
        ["py-rawores-nickel"] = {order="zpy-18", items={"nickel-plate", "ore-nickel", "grade-1-nickel", "grade-2-nickel", "grade-3-nickel", "grade-4-nickel", "nickel-rejects", "prepared-nickel-pulp", "nickel-pulp-01", "nickel-pulp-02", "nickel-overflow", "nickel-slime", "nickel-tailings", "nickel-pulp-03", "nickel-pulp-04", "nickel-prepared-solution", "high-grade-nickel", "reduced-nickel", "sintered-nickel", "molten-nickel", "ni-biomass"}, recipes={{"nickel-plate-2"}, {"nickel-plate-3"}, {"hotair-nickel-plate-3"}, {"pa-nickel"}, {"mining-nickel"}}},
        ["py-rawores-chromium"] = {order="zpy-19", items={"chromium", "ore-chromium", "grade-1-chromite", "grade-2-chromite", "grade-3-chromite", "grade-4-chromite", "chromite-rejects", "chromite-sand", "chromite-pulp-01", "high-chromite", "processed-chromite", "chromite-pulp-02", "chromite-pulp-03", "chromite-pulp-04", "chromite-pulp-05", "chromite-pulp-06", "chromite-pulp-07", "chromite-solution", "chromite-mix", "chromite-fines", "chromite-concentrate", "prepared-chromium", "chromium-rejects", "reduced-chromium", "sintered-chromium", "molten-chromium"}, recipes={{"mining-chromium"}}},
        ["py-rawores-quartz"] = {order="zpy-20", items={"glass", "ore-quartz", "crushed-quartz", "powdered-quartz", "quartz-pulp-01", "quartz-pulp-02", "prepared-quartz", "purified-quartz", "high-grade-quartz-pulp", "high-grade-quartz", "molten-glass", "green-sic", "sic"}, recipes={{"molten-glass"}, {"hotair-molten-glass"}, {"mining-quartz"}}},
        ["py-rawores-borax"] = {order="zpy-21", items={"boron", "raw-borax", "borax", "boron-trioxide", "b2o3-dust", "boron-carbide", "boron-mixture"}, recipes={{"mining-borax"}}},
        ["py-rawores-nexelit"] = {order="zpy-22", items={"nexelit-plate", "nexelit-ore", "clean-nexelit", "grade-1-nexelit", "grade-2-nexelit", "grade-3-nexelit", "nexelit-rejects", "fine-nexelit-powder", "nexelit-pulp-01", "nexelit-pulp-02", "nexelit-pulp-03", "nexelit-pulp-04", "nexelit-slurry", "nexelit-refined-pulp", "high-grade-nexelit", "reduced-nexelit", "sintered-nexelit", "molten-nexelit"}, recipes={{"hotair-nexelit-plate-3"}, {"mining-nexelit"}}},
        ["py-rawores-antimony"] = {order="zpy-23", items={"sb-oxide", "antimonium-ore", "sb-grade-01", "sb-grade-02", "sb-grade-03", "sb-grade-04", "sb-crushed", "sb-dust", "sb-pulp-01", "dowfroth-250", "sb-58-conc", "sb-pulp-02", "sb-pulp-03", "sb-pulp-04", "sb-low-conc", "sb-11-conc", "sb-pulp-05", "sb-final-conc", "sb-conc", "high-purified-sb"}, recipes={{"mining-antimony"}}},
        ["py-rawores-rare-earth"] = {order="zpy-24", items={"rare-earth-ore", "rare-earth-powder", "rare-earth-dust", "rare-earth-mud", "ree-slurry", "ree-solution", "ree-concentrate", "reo", "re-pulp-01", "re-precipitate-01", "re-pulp-02", "re-precipitate-02", "re-pulp-03", "re-pulp-04"}},
        ["recipe-py-rawores-rare-earth"] = {order="zpy-24"},
        ["py-rawores-niobium"] = {order="zpy-25", items={"niobium-plate", "niobium-ore", "niobium-powder", "niobium-dust", "niobium-concentrate", "niobium-complex", "niobium-oxide", "nb-biomass", "lithium-niobate"}, recipes={{"mining-niobium"}}},
        ["py-rawores-molybdenum"] = {order="zpy-26", items={"molybdenum-plate", "molybdenum-ore", "crushed-molybdenite", "molybdenite-dust", "molybdenite-pulp", "molybdenum-concentrate", "molybdenum-pulp", "molybdenum-sulfide", "molybdenum-oxide"}, recipes={{"mining-molybdenum"}}},
        ["py-rawores-salt"] = {order="zpy-27", items={"salt", "nacl-biomass"}},
        ["py-sulfur"] = {order="zpy-28", items={"sulfur", "s-biomass"}, recipes={{"pa-sulfur"}}},
        ["py-rawores-phosphate"] = {order="zpy-29", items={"phosphate-rock", "powdered-phosphate-rock", "p2s5", "phosphate-glass"}},
        ["py-rawores-uranium"] = {order="zpy-30", items={"uranium-ore", "grade-1-u", "grade-2-u", "powdered-u", "u-pulp-01", "u-pulp-02", "u-pulp-03", "yellow-cake", "ur-biomass"}, recipes={{"pa-uranium"}, "split-yellowcake"}},
        ["py-rawores-uranium-depleted"] = {order="zpy-31"},
        ["py-rawores-silver"] = {order="zpy-32", items={"silver-plate", "high-grade-silver", "reduced-silver", "sintered-silver", "molten-silver", "ag-biomass"}, recipes={{"silver-plate-1"}, {"silver-plate-3"}, {"hotair-silver-plate-3"}, {"silver-plate-2"}, {"pa-silver"}, {"soot-to-silver"}}},
        ["py-rawores-gold"] = {order="zpy-33", items={"gold-plate", "gold-precipitate", "gold-concentrate", "gold-precipitate-2", "gold-solution", "purified-gold", "au-biomass"}},
        ["py-rawores-cobalt"] = {order="zpy-34", items={"mixed-ores", "cobalt-extract", "cobalt-sulfate", "cobalt-sulfate-02", "cobalt-oxide", "cobalt-nx", "co-biomass"}},
        ["py-rawores-gd"] = {order="zpy-35", items={"gd-mixture", "gd-oxalate", "gd-crystal", "gd-stripped-solution", "crystalized-gd", "impure-gd", "gd-oxide", "gd-metal"}},
        ["py-rawores-erbium"] = {order="zpy-36", items={"er-oxalate", "impure-er-oxide", "er-oxide", "erbium"}},
        ["py-rawores-thorium"] = {order="zpy-37", items={"stripped-th", "th-dust", "th-oxalate", "th-oxide", "molten-fluoride-thorium"}},
        ["py-rawores-diamond"] = {order="zpy-38", items={"diamond", "kimberlite-rock", "crushed-kimberlite", "kimberlite-grade2", "pure-kimberlite-grade2", "kimberlite-grade3", "kimberlite-rejects", "diamond-reject", "processed-rejects", "kimberlite-pulp", "diamond-tailings", "kimberlite-residue", "diamond-concentrate", "jig-concentrate", "jig-grade1", "jig-grade2", "jig-grade3", "crude-diamond", "washed-diamond"}, recipes={{"rejects-separation","zpy-item-09b"}}},
        ["py-rawores-regolite"] = {order="zpy-39", items={"regolite-rock", "crushed-regolite", "powdered-regolite", "regolite-dust", "calcinates"}},
        ["py-rawores-bio"] = {order="zpy-40", items={"enriched-ash", "washed-ash", "processed-ash", "advanced-substrate", "bio-ore"}},
        ["py-void-solid"] = {order="zpy-91", items={"ash"}, recipes={{"ash","01"}, {"coal-gas-void","02"}, {"fluegas-filtration","03"}, {"ash3","04"}, {"ash-bone","05"}, {"coaldust-ash","06"}, {"cobalt-solvent","07"}, {"ash-sap","9"}}},
        ["py-alienlife-phytomining"] = {order="zpy-xa"},
        ["py-rawores-ores"] = {order="zpy-xb"},
        ["py-fusion-recipes"] = {order="zpy-xc"},
        ["recipe-py-fusion-recipes"] = {order="zpy-xc"},
        ["py-extractor"] = {order="zpy-xd"},
        ["py-drilling"] = {order="zpy-xe"},
        ["py-hightech-recipes"] = {order="zpy-xf"},
        ["recipe-transmutation"] = {order="zpy-xg"},
    },
    ["py-petroleum-handling"] = { -- renamed "fluids"
        ["py-fluids-2"] = {order="zpy-02", items={"hydrogen", "pressured-hydrogen", "oxygen", "diborane", "boric-acid"}, recipes={{"hydrogen","zpy-item-01z"}}},
        ["py-fluids-3"] = {order="zpy-03", items={"nitrogen", "purest-nitrogen-gas", "liquid-nitrogen", "tpa", "nitrous-oxide"}},
        ["py-fluids-4"] = {order="zpy-04", items={"water", "water-saline", "pressured-water", "subcritical-water", "geothermal-water", "waste-water", "dirty-water-light"}, recipes={{"muddy-sludge-void-electrolyzer"}, {"water-from-oxygen-and-hydrogen"}, {"waste-water-void"}, {"water-free"}, {"methanol-void-denitrification"}, {"filtration-dirty-water"}, {"sulfur-void-water"}, {"cooling-water"}, {"cooling-water-2"}, {"saline-water"}, {"gravel-saline-water"}, {"sodium-hydroxide-void"}, {"water-saline"}, {"water-saline-pumpjack"}, {"waste-water-recycle"}, {"frack-saline-water"}}},
        ["py-fluids-5"] = {order="zpy-05", items={"steam", "pressured-steam", "critical-steam"}, recipes={"steam-exchange1", "steam-exchange2", "steam-exchange3", "steam-exchange4", "steam-exchange5"}},
        ["py-fluids-6"] = {order="zpy-06", items={"molten-salt", "hot-molten-salt"}, recipes={"lithium-salt-fuel-seperation", "mox-fuel-seperation"}},
        ["py-fluids-7"] = {order="zpy-07", items={"vacuum", "pressured-air", "purified-air", "cold-air", "cold-clean-air", "liquid-pure-air", "coke-oven-gas", "outlet-gas-01", "outlet-gas-02", "outlet-gas-03", "outlet-gas-04", "hot-air"}, recipes={"warm-air-1", "warmer-air-2", "hot-air-3", "warm-stone-brick-1", "warm-stone-brick-2", "warmer-stone-brick-1", "warmer-stone-brick-2", "hot-stone-brick"}},
        ["py-fluids-8"] = {order="zpy-08", items={"oil-sand-slurry", "bitumen-froth", "bitumen", "scrude", "crude-oil", "light-oil", "heavy-oil", "bio-oil", "condensates", "low-distillate", "medium-distillate", "high-distillate", "stripped-distillate", "residual-oil", "residual-mixture", "hot-residual-mixture", "btx", "condensed-distillate", "naphtha"}},
        ["py-fluids-9"] = {order="zpy-09", items={"gasoline", "kerosene", "diesel", "fuel-oil"}},
        ["py-fluids-10"] = {order="zpy-10", items={"coalbed-gas", "coal-gas", "syngas", "refsyngas", "dirty-syngas", "purified-syngas", "hot-syngas", "flue-gas"}, recipes={{"distilled-raw-coal","zpy-item-01x"}}},
        ["py-fluids-11"] = {order="zpy-11", items={"tar"}, recipes={{"sulfur-void-tar"}, {"coarse-tar"}, {"stone-distilation"}, {"tar-01"}, {"tar-02"}, {"wax-to-tar"}, {"simik-blood-to-tar"}, {"tar-03"}, {"tar-04"}, {"frack-tar"}}},
        ["py-fluids-12"] = {order="zpy-12", items={"pitch", "middle-oil", "anthracene-oil", "naphthalene-oil", "carbolic-oil", "creosote", "dirty-water-heavy"}, recipes={{"tar-refining","zpy-item-00b"}, {"pitch-refining","zpy-item-00c"}, {"tar-refining-tops","zpy-item-02b"}, "tar-quenching", {"tar-to-carbolic"}, {"chitin-void"}}},
        ["py-fluids-13"] = {order="zpy-13", items={"slacked-lime", "acetylene"}},
        ["py-fluids-14"] = {order="zpy-14", items={"tall-oil", "aromatics", "polybutadiene", "black-liquor"}, recipes={{"light-oil-aromatics"}, {"black-liquor"}, {"aromatics-from-naphthalene"}, {"aromatic-organic"}, {"lignin-to-aromatics"}, {"oleo-gasification"}, {"aromatics"}, {"aromatics2"}}},
        ["py-fluids-15"] = {order="zpy-15", items={"olefin", "oleochemicals", "alamac"}},
        ["py-fluids-16"] = {order="zpy-16", items={"acidgas", "sulfuric-acid", "anthraquinone", "hydrogen-peroxide", "acid-solvent", "hydrofluoric-acid", "fluorine-gas", "molten-fluoride-thorium"}, recipes={{"tailings-dust","zpy-item-01"}}},
        ["py-fluids-17"] = {order="zpy-17", items={"carbon-dioxide", "nickel-carbonyl"}, recipes={{"coke-co2"}, {"moondrop-co2"}, {"co2-organics"}, {"coalbed-gas-to-co2"}, {"gas-bladder-to-co2"}, {"co2"}, {"tholin-to-co2"}, {"tar-distilation"}}},
        ["py-fluids-18"] = {order="zpy-18", items={"raw-gas", "natural-gas", "purified-natural-gas", "pure-natural-gas", "refined-natural-gas"}},
        ["py-fluids-19"] = {order="zpy-19", items={"methane", "methanal"}},
        ["py-fluids-20"] = {order="zpy-20", items={"methanol", "acetic-acid"}},
        ["py-fluids-21"] = {order="zpy-21", items={"lubricant", "grease"}},
        ["py-fluids-22"] = {order="zpy-22", items={"chlorine", "hydrogen-chloride", "dcm", "trichlorosilane", "pure-trichlorosilane", "phosphorus-tricloride", "phosphoryl-chloride", "phosphorus-tricloride", "chloromethane", "dimethyldichlorosilane", "ech", "chloroauric-acid"}, recipes={{"chlorine","zp-item-01b"}}},
        ["py-fluids-23"] = {order="zpy-23", items={"coal-slurry", "benzene", "cumene", "nitrobenzene", "perylene", "styrene", "bca"}, recipes={{"tall-oil-separation","zpy-item-01"}}},
        ["py-fluids-24"] = {order="zpy-24", items={"propene", "acetone", "petroleum-gas", "mibc", "carbon-sulfide", "z3-reagent", "allylamine", "butanol"}},
        ["py-fluids-25"] = {order="zpy-25", items={"ethanol", "ethylene", "ethylene-chlorohydrin", "chloroethanol", "ethylene-glycol", "nitrogen-mustard"}},
        ["py-fluids-26"] = {order="zpy-26", items={"ethane", "dichloroethane", "ethylenediamine"}},
        ["py-fluids-27"] = {order="zpy-27", items={"ammonia", "cyanic-acid", "aniline", "pre-phenothiazine", "formamide", "armac-12"}},
        ["py-fluids-28"] = {order="zpy-28", items={"organic-solvent"}},
        ["py-fluids-29"] = {order="zpy-29", items={"vanabins", "blue-liquor", "vpulp1", "vpulp2", "vpulp3", "vpulp4", "vpulp5", "pressured-vpulp", "vpulp-precip", "vanadates", "organic-vanadate", "vanadium-solution", "vanadium-concentrate", "acid-strip-solution", "pregnant-solution", "used-solvent"}},
        ["py-fluids-30"] = {order="zpy-30", items={"phosphorous-acid", "phosphine-gas", "phosphoric-acid", "etching"}},
        ["py-fluids-31"] = {order="zpy-31", items={"glycerol", "acrolein", "xylenol", "cresylic-acid", "aerofloat-15", "soda-ash", "industrial-solvent"}},
        ["py-fluids-32"] = {order="zpy-32", items={"salt-solution", "hot-solution", "mother-liquor", "teos", "silicate-solution", "filtered-silicate-solution", "anolyte", "r1", "r2", "r3", "r4"}},
        ["py-fluids-33"] = {order="zpy-33", items={"organic-pulp", "clean-organic-pulp", "middle-processed-lard", "fatty-acids", "processed-fatty-acids", "organic-acid-anhydride", "vinyl-acetate", "mutant-enzymes"}},
        ["py-fluids-34"] = {order="zpy-34", items={"xenogenic-cells", "chelator", "psc"}},
        ["py-fluids-35"] = {order="zpy-35", items={"liquid-petgas", "gas-stream", "dry-gas-stream", "high-purified-gas", "rich-gas", "liquid-rich-gas", "helium-rich-gas", "purier-helium", "liquid-helium", "helium", "helium3"}},
        ["py-fluids-36"] = {order="zpy-36", items={"hydrogen-sulfide", "deuterium-sulfide", "enriched-water", "heavy-water", "deuterium", "tritium"}},
        ["py-fluids-37"] = {order="zpy-37", items={"uf6"}, recipes={{"yellow-cake-uf6","1"}, {"u233-uf6","2"}, "depleted-uf6-0-10", "depleted-uf6-0-15", "depleted-uf6-0-21", "depleted-uf6-0-29", "depleted-uf6-0-39", "uf6-0-90", "uf6-1-15", "uf6-1-47", "uf6-1-89", "uf6-2-42", "uf6-3-10", "uf6-3-97", "uf6-5-09", "uf6-6-53", "uf6-8-37", "uf6-10-72", "uf6-13-74", "uf6-17-61", "uf6-22-57", "uf6-28-93", "uf6-37-07", "uf6-47-51", "uf6-60-88", "uf6-78-03", "uf6-100-00"}},
        ["py-fluids-38"] = {order="zpy-38", items={"proton", "neutron", "molten-fluoride-thorium-pa233"}, recipes={"neutron-absorbston", "antimatter-fusion", "b-h", "deuterium-fusion", "dt-fusion", "dt-he3"}},
        ["py-fluids-39"] = {order="zpy-39", items={"puo2", "purex-concentrate-1", "purex-concentrate-2", "purex-concentrate-3", "purex-concentrate-4", "purex-concentrate-5", "purex-pu-concentrate-1", "purex-pu-concentrate-2", "purex-pu-concentrate-3", "purex-u-concentrate-1", "purex-u-concentrate-2", "purex-u-concentrate-3", "purex-raffinate", "purex-raffinate-2", "purex-raffinate-3", "ac", "ac-oxygenated", "c-oxygenated", "plutonium-peroxide", "sb-phosphate-1", "sb-phosphate-2", "sb-phosphate-3", "reactor-waste-1", "reactor-waste-2", "purex-waste-1", "purex-waste-2", "purex-waste-3"}},
        ["py-fluids-40"] = {order="zpy-40", items={"drilling-fluid-0", "drilling-fluid-1", "drilling-fluid-2", "drilling-fluid-3"}},
        ["py-fluids-41"] = {order="zpy-41", items={"proto-tholins", "tholins"}},
        ["py-fluids-42"] = {order="zpy-42", items={"void", "combustion-mixture1", "hot-reaction-gas", "processed-light-oil"}, recipes={"advanced-oil-processing", "coal-liquefaction"}},
        ["py-fluids-43"] = {order="zpy-43", recipes={"empty-processed-light-oil-canister", "empty-scrude-canister", "empty-crude-oil-canister", "empty-light-oil-canister", "empty-heavy-oil-canister", "empty-petroleum-gas-canister", "empty-condensates-canister", "empty-low-distillate-canister", "empty-medium-distillate-canister", "empty-high-distillate-canister", "empty-stripped-distillate-canister", "empty-residual-oil-canister", "empty-residual-mixture-canister", "empty-hot-residual-mixture-canister", "empty-btx-canister", "empty-fuel-oil-canister", "empty-condensed-distillate-canister", "empty-naphtha-canister", "empty-middle-oil-canister", "empty-tall-oil-canister", "empty-bitumen-canister", "empty-bio-oil-canister", "empty-kerosene-canister", "empty-gasoline-canister", "empty-diesel-canister", "empty-tar-canister", "empty-anthracene-oil-canister", "empty-naphthalene-oil-canister", "empty-carbolic-oil-canister", "empty-pitch-canister", "empty-acetylene-canister", "empty-aromatics-canister", "empty-coalbed-gas-canister", "empty-coal-gas-canister", "empty-syngas-canister", "empty-refsyngas-canister", "empty-dirty-syngas-canister", "empty-purified-syngas-canister", "empty-hot-syngas-canister", "empty-outlet-gas-01-canister", "empty-outlet-gas-02-canister", "empty-outlet-gas-03-canister", "empty-raw-gas-canister", "empty-natural-gas-canister", "empty-purified-natural-gas-canister", "empty-pure-natural-gas-canister", "empty-refined-natural-gas-canister", "empty-methane-canister", "empty-methanol-canister", "empty-benzene-canister", "empty-propene-canister", "empty-ethylene-canister", "empty-fatty-acids-canister", "empty-high-ash-fines-canister", "empty-residual-gas-canister", "empty-acetone-canister"}}, -- hardmode only: empty-acetone-canister
        ["py-void-liquid"] = {order="zpy-91"},
        ["recipe-py-void-liquid"] = {order="zpy-91"},
        ["py-void-gas"] = {order="zpy-92"},
        ["recipe-py-void-gas"] = {order="zpy-92"},
        ["test"] = {order="zpy-xb"},
        ["fluid"] = {order="zpy-xc"},
        ["py-fluid-handling"] = {order="zpy-xd"},
        ["py-fluids"] = {order="zpy-xe"},
        ["py-quenching-ores"] = {order="zpy-xf"},
        ["recipe-py-quenching-ores"] = {order="zpy-xf"},
        ["py-syngas"] = {order="zpy-xg"},
        ["py-methanol"] = {order="zpy-xh"},
        ["py-fusion-fluids"] = {order="zpy-xi"},
        ["py-fusion-gases"] = {order="zpy-xj"},
        ["py-alternativeenergy-fluids"] = {order="zpy-xk"},
        ["py-hightech-fluids"] = {order="zpy-xl"},
        ["py-petroleum-handling-fluids"] = {order="zpy-xm"},
        ["py-petroleum-handling-oil-sand-recipes"] = {order="zpy-xn"},
        ["py-petroleum-handling-scrude-recipes"] = {order="zpy-xo"},
        ["py-petroleum-handling-lubricant-recipes"] = {order="zpy-xp"},
        ["py-petroleum-handling-recipes"] = {order="zpy-xq"},
        ["py-petroleum-handling-tholin-recipes"] = {order="zpy-xr"},
        ["py-petroleum-handling-hot-air"] = {order="zpy-xs"},
        ["py-rawores-fluids"] = {order="zpy-xt"},
        ["recipe-py-rawores-fluids"] = {order="zpy-xt"},
        ["py-alienlife-fluids"] = {order="zpy-xu"},
        ["py-alienlife-gases"] = {order="zpy-xv"},
        ["py-combustion"] = {order="zpy-xx"},
    },
    ["py-alienlife"] = { -- renamed "life"
        ["py-alienlife-buildings-mk00"] = {items={"slaughterhouse-mk00", "atomizer-mk00", "compost-plant-mk00"}}, -- pyblock only
        ["py-alienlife-buildings-mk01"] = {items={"creature-chamber-mk01", "bio-printer-mk01", "rc-mk01", "incubator-mk01", "botanical-nursery", "plankton-farm", "bio-reactor-mk01", "advanced-bio-reactor-mk01-turd1", "advanced-bio-reactor-mk01-turd2", "advanced-bio-reactor-mk01-turd3", "biofactory-mk01", "slaughterhouse-mk01", "atomizer-mk01", "compost-plant-mk01", "compost-plant-mk01-turd", "micro-mine-mk01", "genlab-mk01", "research-center-mk01"}},
        ["py-alienlife-buildings-mk02"] = {items={"creature-chamber-mk02", "bio-printer-mk02", "rc-mk02", "incubator-mk02", "botanical-nursery-mk02", "plankton-farm-mk02", "bio-reactor-mk02", "advanced-bio-reactor-mk02-turd1", "advanced-bio-reactor-mk02-turd2", "advanced-bio-reactor-mk02-turd3", "biofactory-mk02", "slaughterhouse-mk02", "atomizer-mk02", "compost-plant-mk02", "compost-plant-mk02-turd", "micro-mine-mk02", "genlab-mk02", "research-center-mk02"}},
        ["py-alienlife-buildings-mk03"] = {items={"creature-chamber-mk03", "bio-printer-mk03", "rc-mk03", "incubator-mk03", "botanical-nursery-mk03", "plankton-farm-mk03", "bio-reactor-mk03", "advanced-bio-reactor-mk03-turd1", "advanced-bio-reactor-mk03-turd2", "advanced-bio-reactor-mk03-turd3", "biofactory-mk03", "slaughterhouse-mk03", "atomizer-mk03", "compost-plant-mk03", "compost-plant-mk03-turd", "micro-mine-mk03", "genlab-mk03", "research-center-mk03"}},
        ["py-alienlife-buildings-mk04"] = {items={"creature-chamber-mk04", "bio-printer-mk04", "rc-mk04", "incubator-mk04", "botanical-nursery-mk04", "plankton-farm-mk04", "bio-reactor-mk04", "advanced-bio-reactor-mk04-turd1", "advanced-bio-reactor-mk04-turd2", "advanced-bio-reactor-mk04-turd3", "biofactory-mk04", "slaughterhouse-mk04", "atomizer-mk04", "compost-plant-mk04", "compost-plant-mk04-turd", "micro-mine-mk04", "genlab-mk04", "research-center-mk04"}},
        ["py-alienlife-farm-buildings-mk01"] = {items={"moss-farm-mk01", "seaweed-crop-mk01", "fwf-mk01", "sap-extractor-mk01", "moondrop-greenhouse-mk01", "ralesia-plantation-mk01", "fawogae-plantation-mk01", "tuuphra-plantation-mk01", "kicalk-plantation-mk01", "yaedols-culture-mk01", "rennea-plantation-mk01", "yotoi-aloe-orchard-mk01", "navens-culture-mk01", "bhoddos-culture-mk01", "grods-swamp-mk01", "cadaveric-arum-mk01", "guar-gum-plantation", "sponge-culture-mk01", "cridren-enclosure-mk01", "vrauks-paddock-mk01", "auog-paddock-mk01", "prandium-lab-mk01", "ulric-corral-mk01", "arqad-hive-mk01", "mukmoux-pasture-mk01", "phagnot-corral-mk01", "arthurian-pen-mk01", "scrondrix-pen-mk01", "dingrits-pack-mk01", "kmauts-enclosure-mk01", "phadai-enclosure-mk01", "simik-den-mk01", "vonix-den-mk01", "zungror-lair-mk01", "xenopen-mk01", "ez-ranch-mk01", "fish-farm-mk01", "turd-fish-farm-mk01", "zipir-reef-mk01", "trits-reef-mk01", "xyhiphoe-pool-mk01", "dhilmos-pool-mk01", "numal-reef-mk01", "sap-extractor-mk01-legacy"}},
        ["py-alienlife-farm-buildings-mk02"] = {items={"moss-farm-mk02", "seaweed-crop-mk02", "fwf-mk02", "sap-extractor-mk02", "moondrop-greenhouse-mk02", "ralesia-plantation-mk02", "fawogae-plantation-mk02", "tuuphra-plantation-mk02", "kicalk-plantation-mk02", "yaedols-culture-mk02", "rennea-plantation-mk02", "yotoi-aloe-orchard-mk02", "navens-culture-mk02", "bhoddos-culture-mk02", "grods-swamp-mk02", "cadaveric-arum-mk02", "guar-gum-plantation-mk02", "sponge-culture-mk02", "cridren-enclosure-mk02", "vrauks-paddock-mk02", "auog-paddock-mk02", "prandium-lab-mk02", "ulric-corral-mk02", "arqad-hive-mk02", "mukmoux-pasture-mk02", "phagnot-corral-mk02", "arthurian-pen-mk02", "scrondrix-pen-mk02", "dingrits-pack-mk02", "kmauts-enclosure-mk02", "phadai-enclosure-mk02", "simik-den-mk02", "vonix-den-mk02", "zungror-lair-mk02", "xenopen-mk02", "ez-ranch-mk02", "fish-farm-mk02", "turd-fish-farm-mk02", "zipir-reef-mk02", "trits-reef-mk02", "xyhiphoe-pool-mk02", "dhilmos-pool-mk02", "numal-reef-mk02", "sap-extractor-mk02-legacy"}},
        ["py-alienlife-farm-buildings-mk03"] = {items={"moss-farm-mk03", "seaweed-crop-mk03", "fwf-mk03", "sap-extractor-mk03", "moondrop-greenhouse-mk03", "ralesia-plantation-mk03", "fawogae-plantation-mk03", "tuuphra-plantation-mk03", "kicalk-plantation-mk03", "yaedols-culture-mk03", "rennea-plantation-mk03", "yotoi-aloe-orchard-mk03", "navens-culture-mk03", "bhoddos-culture-mk03", "grods-swamp-mk03", "cadaveric-arum-mk03", "guar-gum-plantation-mk03", "sponge-culture-mk03", "cridren-enclosure-mk03", "vrauks-paddock-mk03", "auog-paddock-mk03", "prandium-lab-mk03", "ulric-corral-mk03", "arqad-hive-mk03", "mukmoux-pasture-mk03", "phagnot-corral-mk03", "arthurian-pen-mk03", "scrondrix-pen-mk03", "dingrits-pack-mk03", "kmauts-enclosure-mk03", "phadai-enclosure-mk03", "simik-den-mk03", "vonix-den-mk03", "zungror-lair-mk03", "xenopen-mk03", "ez-ranch-mk03", "fish-farm-mk03", "turd-fish-farm-mk03", "zipir-reef-mk03", "trits-reef-mk03", "xyhiphoe-pool-mk03", "dhilmos-pool-mk03", "numal-reef-mk03", "sap-extractor-mk03-legacy"}},
        ["py-alienlife-farm-buildings-mk04"] = {items={"moss-farm-mk04", "seaweed-crop-mk04", "fwf-mk04", "sap-extractor-mk04", "moondrop-greenhouse-mk04", "ralesia-plantation-mk04", "fawogae-plantation-mk04", "tuuphra-plantation-mk04", "kicalk-plantation-mk04", "yaedols-culture-mk04", "rennea-plantation-mk04", "yotoi-aloe-orchard-mk04", "navens-culture-mk04", "bhoddos-culture-mk04", "grods-swamp-mk04", "cadaveric-arum-mk04", "guar-gum-plantation-mk04", "sponge-culture-mk04", "cridren-enclosure-mk04", "vrauks-paddock-mk04", "auog-paddock-mk04", "prandium-lab-mk04", "ulric-corral-mk04", "arqad-hive-mk04", "mukmoux-pasture-mk04", "phagnot-corral-mk04", "arthurian-pen-mk04", "scrondrix-pen-mk04", "dingrits-pack-mk04", "kmauts-enclosure-mk04", "phadai-enclosure-mk04", "simik-den-mk04", "vonix-den-mk04", "zungror-lair-mk04", "xenopen-mk04", "ez-ranch-mk04", "fish-farm-mk04", "turd-fish-farm-mk04", "zipir-reef-mk04", "trits-reef-mk04", "xyhiphoe-pool-mk04", "dhilmos-pool-mk04", "numal-reef-mk04", "sap-extractor-mk04-legacy"}},
        ["py-alienlife-buildings-others"] = {items={"data-array", "simik-boiler", "generator-1", "generator-1-turd", "generator-2", "pyphoon-bay", "outpost", "outpost-aerial", "pydrive", "wyrmhole", "ipod", "dino-dig-site", "mega-farm", "harvester", "antelope-enclosure-mk01", "pipette-dino-dig-site", "dino-dig-site-food-input"}},
        ["py-alienlife-special-creatures"] = {items={"caravan", "caravan-turd", "flyavan", "flyavan-turd", "nukavan", "nukavan-turd", "ocula", "digosaurus", "digosaurus-turd", "thikat", "thikat-turd", "work-o-dile", "work-o-dile-turd", "workers-food", "workers-food-02", "workers-food-03", "gastrocapacitor", "crawdad", "dingrido", "spidertron", "phadaisus"}},
        ["py-alienlife-biofluid-network"] = {items={"bioport", "provider-tank", "requester-tank", "vessel", "vessel-to-ground", "gobachov", "huzu", "chorkok"}},
        ["py-alienlife-vatbrain"] = {items={"vatbrain-1", "vatbrain-2", "vatbrain-3", "vatbrain-4", "brain-cartridge-01", "brain-cartridge-02", "brain-cartridge-03", "brain-cartridge-04"}},
        ["py-alienlife-items"] = {items={{"biocarnation","7"}, {"biocrud","8"}, {"rich-biocrud","9"}, {"cage","a"}, "ulric-infusion", "ulric-infusion-equipment", "energy-drink", "dried-meat", "seeds-extract-01", "syrup-01", "bedding", "sporopollenin", "cellulose", "lignin", "fungal-substrate", "fungal-substrate-02", "fungal-substrate-03", "urea", "guano", "ammonium-nitrate", "manure", "liquid-manure", "depolymerized-organics", "manure-bacteria", "zogna-bacteria", "fertilizer", "guar-gum", "stone-wool", "raw-fiber", "fiber", "powdered-ralesia-seeds", "starch", "blood-meal", "albumin", "sugar", "sodium-alginate", "creamy-latex", "formic-acid", "latex-slab", "myoglobin", "resilin", "casein", "mcb", "chloral", "pre-pesticide-01", "pesticide-mk01", "ethyl-mercaptan", "dda", "pre-pesticide-02", "pesticide-mk02", "nano-cellulose", "magnetic-beads", "hmas", "empty-neuromorphic-chip", "neuromorphic-chip", "neuroprocessor", "pheromones", "perfect-samples"}, recipes={{"cage-recycle-into-titanium", "ab"}, {"biocarnation-harvesting", "7b"}, {"biocrud-reprocessing", "8b"}, {"rich-biocrud-reprocessing", "9b"}}},
        ["recipe-py-alienlife-items"] = {order="bb"},
        ["py-alienlife-body-parts"] = {order="bb-2", items={{"blood","aa"}, {"arthropod-blood","ab"}, {"bones","ac"}, {"bonemeal","ac2"}, {"brain","ad"}, {"mukmoux-fat","ae"}, {"guts","af"}, {"meat","ag"}, {"skin","ah"}, {"chitin","ai"}, {"animal-eye","aj"}, "chitosan", "collagen", "nanofibrils", "bio-scafold", "bioartificial-guts", "biomimetic-skin", "in-vitro-meat", "laboratory-grown-brain", "scafold-free-bones", "tissue-engineered-fat"}},
        ["py-alienlife-science"] = {order="bc", items={"agar", "empty-petri-dish", "petri-dish", "petri-dish-bacteria", "fawogae-substrate", "ground-sample01", "bio-sample01", "bio-container", "bio-sample", "alien-sample01", "alien-sample-02", "alien-sample-03", "alien-enzymes", "animal-sample-01", "cobalt-fluoride", "decalin", "flutec-pp6", "artificial-blood", "solidified-sarcorus", "paragen", "negasium", "nonconductive-phazogen", "denatured-seismite"}},
        ["py-alienlife-genetics"] = {items={"fetal-serum", "bacteria-2", "bacteria-1", "ethanolamine", "gta", "retrovirus", "resveratrol", "enzyme-pks", "bioreceptor", "cysteine", "serine", "purine-analogues", "zinc-finger-proteins", "moss-gen", "plasmids", "cdna", "enediyne", "mpa", "nanozymes", "pacifastin", "cytostatics", "microcin-j25", "chimeric-proteins", "zymogens", "primers", "dna-polymerase", "adam42-gen", "mmp", "peptidase-m58", "propeptides", "immunosupressants", "nanochondria", "recombinant-ery", "anabolic-rna", "dynemicin", "antitumor", "antiviral", "hyaline", "bmp", "gh", "orexigenic", "reca", "cbp"}},
        ["py-alienlife-food"] = {items={"vrauks-food-01", "vrauks-food-02", "auog-food-01", "auog-food-02", "cottongut-food-01", "cottongut-food-02", "cottongut-food-03", "ulric-food-01", "ulric-food-02", "korlex-food-01", "korlex-food-02", "mukmoux-food-01", "mukmoux-food-02", "phagnot-food-01", "phagnot-food-02", "arthurian-food-01", "arthurian-food-02", "dingrits-food-01", "dingrits-food-02", "kmauts-ration", "phadai-food-01", "phadai-food-02", "simik-food-01", "simik-food-02", "fish-food-01", "fish-food-02", "zipir-food-01", "zipir-food-02", "dhilmos-food-01", "dhilmos-food-02", "numal-food-01", "numal-food-02"}},
        ["py-alienlife-biomass-special"] = {order="bf", items={"worm", "powdered-biomass", "fine-powdered-biomass", "dried-biomass"}, recipes={"biomass-destruction"}},
        ["py-alienlife-biomass"] = {order="bg", items={"biomass"}},
        --["py-alienlife-recipes"] = {},
        ["py-alienlife-samples"] = {items={"earth-generic-sample", "earth-bear-sample", "earth-mouse-sample", "earth-horse-sample", "earth-bee-sample", "earth-cow-sample", "earth-crustacean-sample", "earth-antelope-sample", "earth-giraffe-sample", "earth-lizard-sample", "earth-roadrunner-sample", "earth-wolf-sample", "earth-tiger-sample", "earth-goat-sample", "earth-spider-sample", "earth-antelope-sample", "earth-sea-sponge-sample", "earth-venus-fly-sample", "earth-flower-sample", "earth-shroom-sample", "earth-potato-sample", "earth-palmtree-sample", "earth-jute-sample", "earth-sunflower-sample", "earth-tropical-tree-sample", "earth-bat-sample", "strorix-unknown-sample"}},
        ["py-alienlife-codex"] = {items={"vrauks-codex", "auog-codex", "cottongut-codex", "ulric-codex", "arqad-codex", "korlex-codex", "mukmoux-codex", "phagnot-codex", "arthurian-codex", "scrondrix-codex", "dingrits-codex", "kmauts-codex", "phadai-codex", "simik-codex", "vonix-codex", "zungror-codex", "xeno-codex", "antelope-codex", "zipir-codex", "trits-codex", "xyhiphoe-codex", "dhilmos-codex", "numal-codex", "sea-sponge-codex", "cridren-codex", "moondrop-codex", "ralesia-codex", "fawogae-codex", "tuuphra-codex", "kicalk-codex", "yaedols-codex", "rennea-codex", "yotoi-codex", "navens-codex", "bhoddos-codex", "grod-codex", "cadaveric-arum-codex", "guar-codex", "bat-codex"}},
        ["py-alienlife-codex-mk02"] = {items={"zipir-codex-mk02", "trits-codex-mk02", "dhilmos-codex-mk02", "numal-codex-mk02", "korlex-codex-mk02", "mukmoux-codex-mk02", "scrondrix-codex-mk02", "dingrits-codex-mk02", "kmauts-codex-mk02", "phadai-codex-mk02", "simik-codex-mk02", "vonix-codex-mk02", "zungror-codex-mk02", "xeno-codex-mk02"}},
        ["py-alienlife-codex-mk03"] = {items={"zipir-codex-mk03", "trits-codex-mk03", "dhilmos-codex-mk03", "numal-codex-mk03", "korlex-codex-mk03", "mukmoux-codex-mk03", "scrondrix-codex-mk03", "dingrits-codex-mk03", "kmauts-codex-mk03", "phadai-codex-mk03", "simik-codex-mk03", "vonix-codex-mk03", "zungror-codex-mk03", "xeno-codex-mk03"}},
        ["py-alienlife-codex-mk04"] = {items={"zipir-codex-mk04", "trits-codex-mk04", "dhilmos-codex-mk04", "numal-codex-mk04", "korlex-codex-mk04", "mukmoux-codex-mk04", "scrondrix-codex-mk04", "dingrits-codex-mk04", "kmauts-codex-mk04", "phadai-codex-mk04", "simik-codex-mk04", "vonix-codex-mk04", "zungror-codex-mk04", "xeno-codex-mk04"}},
        ["py-alienlife-replicators"] = {order="dx", items={"replicator-bioreserve", "replicator-ralesia", "replicator-tuuphra", "replicator-kicalk", "replicator-rennea", "replicator-yotoi", "replicator-yotoi-fruit", "replicator-grod", "replicator-cadaveric-arum", "replicator-mova"}},
        ["py-alienlife-used"] = {order="dy"},
        ["py-alienlife-vrauks"] = {order="e-a", items={"blood-caged-vrauks", "brain-caged-vrauks", "guts-caged-vrauks", "meat-caged-vrauks", "chitin-caged-vrauks", "caged-vrauks", "cocoon", "cocoon-mk02", "cocoon-mk03", "cocoon-mk04", "vrauks", "vrauks-mk02", "vrauks-mk03", "vrauks-mk04"}, recipes={{"full-render-vrauks",""}, {"full-render-vrauks-lard",""}, {"full-render-vrauks-laser",""}, {"full-render-vrauks-music",""}, {"ex-blo-vrauks"}, {"ex-bra-vrauks","a-06"}, {"ex-gut-vrauks"}, {"ex-me-vrauks"}, {"ex-ski-vrauks"}, {"vrauks"}, {"vrauks-earth-sample-turd"}, {"vrauks-1"}, {"vrauks-1-no-water"}, {"vrauks-2"}, {"vrauks-2-no-water"}, {"vrauks-3"}, {"vrauks-3-no-water"}, {"vrauks-4"}, {"vrauks-4-no-water"}, {"vrauks-5"}, {"vrauks-5-no-water"}, {"art-vrauks"}, {"uncaged-vrauks"}}},
        ["py-alienlife-auog"] = {order="e-b", items={"blood-caged-auog", "bone-caged-auog", "brain-caged-auog", "fat-caged-auog", "guts-caged-auog", "meat-caged-auog", "skin-caged-auog", {"glandular-myocluster","b2"}, "caged-auog", "auog-pup", "auog-pup-mk02", "auog-pup-mk03", "auog-pup-mk04", "charged-auog", "auog", "auog-mk02", "auog-mk03", "auog-mk04", "used-auog", "used-auog-mk02", "used-auog-mk03", "used-auog-mk04"}, recipes={{"full-render-auogs",""}, {"full-render-auogs-lard",""}, {"full-render-auogs-laser",""}, {"full-render-auogs-music",""}, {"ex-used-auog","2"}, {"ex-used-auog-lard","2b"}, {"ex-used-auog-laser","2c"}, {"ex-used-auog-music","2d"}, {"ex-blo-auog"}, {"ex-bon-auog"}, {"ex-bra-auog","a-11"}, {"ex-fat-auog"}, {"ex-gut-auog"}, {"ex-me-auog"}, {"ex-ski-auog"}, {"extract-auog-eye"}, {"auog"}, {"auog-earth-sample-turd"}, {"auog-recharge-00"}, {"auog-recharge-0"}, {"auog-recharge"}, {"auog-recharge-glowing-mushroom-mk01"}, {"auog-maturing-1"}, {"auog-maturing-2"}, {"auog-maturing-3"}, {"auog-maturing-4"}, {"auog-maturing-5"}, {"art-auog"}, {"uncaged-auog"}, "auog-pooping-1", "auog-pooping-2", "auog-pooping-3", "auog-pooping-4", "auog-pooping-5"}},
        ["py-alienlife-cottongut"] = {order="e-c", items={"blood-cottongut", "bone-cottongut", "brain-cottongut", "fat-cottongut", "guts-cottongut", "meat-cottongut", "skin-cottongut", {"lcc","b"}, "cottongut-pup", "cottongut-pup-mk01", "cottongut-pup-mk02", "cottongut-pup-mk03", "cottongut-pup-mk04", "cottongut-mk01", "cottongut-mk02", "cottongut-mk03", "cottongut-mk04", "cottongut"}, recipes={{"full-render-cottongut",""}, {"full-render-cottongut-lard",""}, {"full-render-cottongut-laser",""}, {"full-render-cottongut-music",""}, {"ex-blo-cot"}, {"ex-bon-cot"}, {"ex-bra-cot"}, {"ex-fat-cot"}, {"ex-gut-cot"}, {"ex-me-cot"}, {"ex-ski-cot"}, {"art-cottongut"}}},
        ["py-alienlife-ulric"] = {order="e-d", items={"blood-caged-ulric", "bone-caged-ulric", "brain-caged-ulric", "fat-caged-ulric", "guts-caged-ulric", "meat-caged-ulric", "skin-caged-ulric", {"magnetic-organ","b2"}, "caged-ulric", "ulric-cub", "ulric-cub-mk02", "ulric-cub-mk03", "ulric-cub-mk04", "ulric", "ulric-mk02", "ulric-mk03", "ulric-mk04", "used-ulric", "used-ulric-mk02", "used-ulric-mk03", "used-ulric-mk04", "sample-cup", "ulric-mk02-dna-sample", "ulric-mk03-dna-sample", "ulric-mk04-dna-sample", {"saddle","zpy-turd"}}, recipes={{"full-render-ulrics",""}, {"full-render-ulrics-lard",""}, {"full-render-ulrics-laser",""}, {"full-render-ulrics-music",""}, {"ex-blo-ulr"}, {"ex-bon-ulr"}, {"ex-bra-ulr"}, {"ex-fat-ulr"}, {"ex-gut-ulr"}, {"ex-me-ulr"}, {"ex-ski-ulr"}, {"extract-ulric-eye"}, {"ulric"}, {"ulric-earth-sample-turd"}, {"ulric-1"}, {"ulric-1-manure"}, {"ulric-2"}, {"ulric-2-manure"}, {"ulric-3"}, {"ulric-3-manure"}, {"ulric-4"}, {"ulric-4-manure"}, {"art-ulric"}, {"uncaged-ulric"}, "ulric-manure-1", "ulric-manure-2", "ulric-manure-3", "ulric-manure-4"}},
        ["py-alienlife-arqad"] = {order="e-e", items={"blood-arqad", "guts-arqad", "meat-arqad", "chitin-arqad", {"bee-venom","b1"}, {"sternite-lung","b2"}, "arqad-egg-nest", "arqad-egg-nest-2", "arqad-egg-nest-3", "arqad-egg-nest-4", "arqad-egg", "arqad-egg-2", "arqad-egg-3", "arqad-egg-4", "arqad-maggot", "arqad-maggot-2", "arqad-maggot-3", "arqad-maggot-4", "arqad-queen", "arqad", "arqad-mk02", "arqad-mk03", "arqad-mk04", "empty-comb", "filled-comb", "used-comb", "wax", "wax-barrel", "empty-honeycomb", "honeycomb", "arqad-honey", "arqad-propolis", "arqad-jelly-barrel", "arqad-jelly", "cags"}, recipes={{"full-render-arqads",""}, {"full-render-arqads-lard",""}, {"full-render-arqads-laser",""}, {"full-render-arqads-music",""}, {"ex-blo-arq"}, {"ex-gut-arq"}, {"ex-me-arq"}, {"ex-chi-arq"}, {"art-arqad"}}},
        ["py-alienlife-korlex"] = {order="e-f", items={"blood-caged-korlex", "bone-caged-korlex", "brain-caged-korlex", "fat-caged-korlex", "guts-caged-korlex", "meat-caged-korlex", "skin-caged-korlex", {"cryogland","b"}, "caged-korlex", "korlex-pup", "korlex", "korlex-mk02", "korlex-mk03", "korlex-mk04", "milk", "empty-barrel-milk", "barrel-milk", "casein-mixture", "casein-pulp-01", "casein-pulp-02", "casein-solution"}, recipes={{"full-render-kor",""}, {"full-render-kor-lard",""}, {"full-render-kor-laser",""}, {"full-render-kor-music",""}, {"ex-blo-kor"}, {"ex-bon-kor"}, {"ex-bra-kor"}, {"ex-fat-kor"}, {"ex-gut-kor"}, {"ex-me-kor"}, {"ex-ski-kor"}, {"korlex"}, {"korlex-earth-sample-turd"}, {"korlex-1"}, {"korlex-1-slowed"}, {"korlex-2"}, {"korlex-2-slowed"}, {"korlex-3"}, {"korlex-3-slowed"}, {"korlex-4"}, {"korlex-4-slowed"}, {"uncaged-korlex"}}},
        ["py-alienlife-mukmoux"] = {order="e-g", items={"blood-caged-mukmoux", "bone-caged-mukmoux", "brain-caged-mukmoux", "fat-caged-mukmoux", "guts-caged-mukmoux", "meat-caged-mukmoux", "skin-caged-mukmoux", "caged-mukmoux", "mukmoux-calf", "mukmoux", "mukmoux-mk02", "mukmoux-mk03", "mukmoux-mk04"}, recipes={{"full-render-mukmoux",""}, {"full-render-mukmoux-lard",""}, {"full-render-mukmoux-laser",""}, {"full-render-mukmoux-music",""}, {"ex-blo-muk"}, {"ex-bon-muk"}, {"ex-bra-muk"}, {"ex-fat-muk"}, {"ex-gut-muk"}, {"ex-me-muk"}, {"ex-ski-muk"}, {"extract-mukmoux-eye"}, {"mukmoux"}, {"mukmoux-earth-sample-turd"}, {"mukmoux-1"}, {"mukmoux-1-bip"}, {"mukmoux-2"}, {"mukmoux-2-bip"}, {"mukmoux-3"}, {"mukmoux-3-bip"}, {"mukmoux-4"}, {"mukmoux-4-bip"}, {"art-mukmoux"}, {"uncaged-mukmoux"}, "mukmoux-manure-1", "mukmoux-manure-1-mukmoux-turd", "mukmoux-manure-2", "mukmoux-manure-2-mukmoux-turd", "mukmoux-manure-3", "mukmoux-manure-3-mukmoux-turd", "mukmoux-manure-4", "mukmoux-manure-4-mukmoux-turd"}},
        ["py-alienlife-phagnot"] = {order="e-h", items={"blood-caged-phagnot", "bone-caged-phagnot", "brain-caged-phagnot", "guts-caged-phagnot", "meat-caged-phagnot", {"geostabilization-tissue","b"}, "skin-caged-phagnot", "caged-phagnot", "phagnot-cub", "phagnot-cub-mk02", "phagnot-cub-mk03", "phagnot-cub-mk04", "phagnot", "phagnot-mk02", "phagnot-mk03", "phagnot-mk04", "gas-bladder"}, recipes={{"full-render-phagnots",""}, {"full-render-phagnots-lard",""}, {"full-render-phagnots-laser",""}, {"full-render-phagnots-music",""}, {"ex-blo-phag"}, {"ex-bon-phag"}, {"ex-bra-phag"}, {"ex-gut-phag"}, {"ex-me-phag"}, {"ex-ski-phag"}, {"phagnot"}, {"phagnot-earth-sample-turd"}, {"phagnot-mature-basic-01"}, {"phagnot-1"}, {"phagnot-1-kicalk"}, {"phagnot-2"}, {"phagnot-2-kicalk"}, {"phagnot-3"}, {"phagnot-3-kicalk"}, {"phagnot-4"}, {"phagnot-4-kicalk"}, {"art-phagnot"}, {"uncaged-phagnot"}}},
        ["py-alienlife-arthurian"] = {order="e-i", items={"blood-caged-arthurian", "bone-caged-arthurian", "brain-caged-arthurian", "fat-caged-arthurian", "guts-caged-arthurian", "meat-caged-arthurian", "skin-caged-arthurian", {"polynuclear-ganglion","b"}, "caged-arthurian", "arthurian-egg", "arthurian-egg-mk02", "arthurian-egg-mk03", "arthurian-egg-mk04", "arthurian-pup", "arthurian-pup-mk02", "arthurian-pup-mk03", "arthurian-pup-mk04", "arthurian", "arthurian-mk02", "arthurian-mk03", "arthurian-mk04", "abacus"}, recipes={{"full-render-arthurian",""}, {"full-render-arthurian-lard",""}, {"full-render-arthurian-laser",""}, {"full-render-arthurian-music",""}, {"ex-blo-art"}, {"ex-bon-art"}, {"ex-bra-art"}, {"ex-fat-art"}, {"ex-gut-art"}, {"ex-me-art"}, {"ex-ski-art"}, {"arthurian"}, {"arthurian-earth-sample-turd"}, {"arthurian-maturing-1"}, {"arthurian-maturing-1-abacus"}, {"arthurian-maturing-2"}, {"arthurian-maturing-2-abacus"}, {"arthurian-maturing-3"}, {"arthurian-maturing-3-abacus"}, {"arthurian-maturing-4"}, {"arthurian-maturing-4-abacus"}, {"art-arthurian"}, {"uncaged-arthurian"}}},
        ["py-alienlife-scrondrix"] = {order="e-j", items={"blood-caged-scrondrix", "bone-caged-scrondrix", "brain-caged-scrondrix", "fat-caged-scrondrix", "guts-caged-scrondrix", "meat-caged-scrondrix", "skin-caged-scrondrix", {"intestinal-ee","b2"}, "caged-scrondrix", "scrondrix-pup", "scrondrix", "scrondrix-mk02", "scrondrix-mk03", "scrondrix-mk04", {"pineal-gland","zpye"}}, recipes={{"full-render-scrondrixs",""}, {"full-render-scrondrixs-lard",""}, {"full-render-scrondrixs-laser",""}, {"full-render-scrondrixs-music",""}, {"ex-blo-scro"}, {"ex-bon-scro"}, {"ex-bra-scro","a-07"}, {"scrondrix-brain-slaughterhouse-ex", "a-07"}, {"ex-fat-scro"}, {"ex-gut-scro"}, {"ex-me-scro"}, {"ex-ski-scro"}, {"extract-scrondrix-eye"}, {"scrondrix"}, {"scrondrix-earth-sample-turd"}, {"Scrondrix-1"}, {"Scrondrix-1-boron"}, {"Scrondrix-1-vegan"}, {"Scrondrix-2"}, {"Scrondrix-2-boron"}, {"Scrondrix-2-vegan"}, {"Scrondrix-3"}, {"Scrondrix-3-boron"}, {"Scrondrix-3-vegan"}, {"Scrondrix-4"}, {"Scrondrix-4-boron"}, {"Scrondrix-4-vegan"}, {"art-scrondrix"}, {"uncaged-scrondrix"}, "Scrondrix-Manure-1", "Scrondrix-Manure-2", "Scrondrix-Manure-3", "Scrondrix-Manure-4"}},
        ["py-alienlife-dingrits"] = {order="e-k", items={"blood-caged-dingrits", "bone-caged-dingrits", "brain-caged-dingrits", "guts-caged-dingrits", "meat-caged-dingrits", "skin-caged-dingrits", "caged-dingrits", "dingrits-cub", "charged-dingrit", "dingrits", "dingrits-mk02", "dingrits-mk03", "dingrits-mk04", "used-dingrit", "used-dingrit-mk02", "used-dingrit-mk03", "used-dingrit-mk04", "dingrit-spike", "pelt", "fur", "space-suit", "space-dingrit", "space-dingrit-return", "snarer-heart", "dingrits-alpha"}, recipes={{"full-render-dingrits",""}, {"full-render-dingrits-lard",""}, {"full-render-dingrits-laser",""}, {"full-render-dingrits-music",""}, {"ex-used-dingrits","2"}, {"ex-used-dingrits-lard","2b"}, {"ex-used-dingrits-laser","2c"}, {"ex-used-dingrits-music","2d"}, {"ex-blo-din"}, {"ex-bon-din"}, {"ex-bra-din"}, {"ex-gut-din"}, {"ex-me-din"}, {"ex-pelt-din","b1"}, {"dingrits"}, {"dingrits-earth-sample-turd"}, {"dingrit-recharge"}, {"dingrit-recharge-2"}, {"dingrits-1"}, {"dingrits-1-training"}, {"dingrits-2"}, {"dingrits-2-training"}, {"dingrits-3"}, {"dingrits-3-training"}, {"dingrits-4"}, {"dingrits-4-training"}, {"art-dingrits"}, {"uncaged-dingrits"}}},
        ["py-alienlife-kmauts"] = {order="e-l", items={"blood-caged-kmauts", "brain-caged-kmauts", "fat-caged-kmauts", "guts-caged-kmauts", "meat-caged-kmauts", "caged-kmauts", "kmauts-cub", "kmauts", "kmauts-mk02", "kmauts-mk03", "kmauts-mk04", "tendon"}, recipes={{"full-render-kmauts",""}, {"full-render-kmauts-lard",""}, {"full-render-kmauts-laser",""}, {"full-render-kmauts-music",""}, {"ex-blo-kma"}, {"ex-bra-kma"}, {"ex-fat-kma"}, {"ex-gut-kma"}, {"ex-me-kma"}, {"kmauts"}, {"kmauts-1"}, {"kmauts-1-ratio"}, {"kmauts-2"}, {"kmauts-2-ratio"}, {"kmauts-3"}, {"kmauts-3-ratio"}, {"kmauts-4"}, {"kmauts-4-ratio"}, {"uncaged-kmauts"}}},
        ["py-alienlife-phadai"] = {order="e-m", items={"blood-caged-phadai", "bone-caged-phadai", "brain-caged-phadai", "fat-caged-phadai", "guts-caged-phadai", "meat-caged-phadai", "skin-caged-phadai", {"subdermal-chemosnare","b"}, "caged-phadai", "phadai-pup", "phadai", "phadai-mk02", "phadai-mk03", "phadai-mk04", "used-phadai", "carapace"}, recipes={{"full-render-phadais",""}, {"full-render-phadais-lard",""}, {"full-render-phadais-laser",""}, {"full-render-phadais-music",""}, {"ex-blo-pha"}, {"ex-bon-pha"}, {"ex-bra-pha"}, {"ex-fat-pha"}, {"ex-gut-pha"}, {"ex-me-pha"}, {"ex-ski-pha"}, {"phadai"}, {"phadai-earth-sample-turd"}, {"phadai-recharge-1"}, {"phadai-1"}, {"phadai-2"}, {"phadai-3"}, {"phadai-4"}, {"art-phadai"}, {"uncaged-phadai"}}},
        ["py-alienlife-simik"] = {order="e-n", items={"blood-caged-simik", "bone-caged-simik", "brain-caged-simik", "fat-caged-simik", "guts-caged-simik", "meat-caged-simik", "skin-caged-simik", {"simik-blood","b1"}, {"simik-scales","b2"}, {"keratin","b3"}, {"hormonal","b4"}, "caged-simik", "simik-pup", "simik", "simik-mk02", "simik-mk03", "simik-mk04", "used-simik", "used-simik-mk02", "used-simik-mk03", "used-simik-mk04", "simik-poop"}, recipes={{"full-render-simik",""}, {"full-render-simik-lard",""}, {"full-render-simik-laser",""}, {"full-render-simik-music",""}, {"ex-blo-sim"}, {"ex-bon-sim"}, {"ex-bra-sim"}, {"ex-fat-sim"}, {"ex-gut-sim"}, {"ex-me-sim"}, {"ex-ski-sim"}, {"simik"}, {"simik-earth-sample-turd"}, {"simik-recharge"}, {"simik-recharge-2"}, {"caged-simik-1"}, {"caged-simik-2"}, {"caged-simik-3"}, {"caged-simik-4"}, {"art-simik"}, {"uncaged-simik"}}},
        ["py-alienlife-vonix"] = {order="e-o", items={"blood-vonix", "brain-vonix", "fat-vonix", "guts-vonix", "meat-vonix", "skin-vonix", "vonix-eggs", "vonix-cub", "vonix", "vonix-mk02", "vonix-mk03", "vonix-mk04", "venom-gland"}, recipes={{"full-render-vonix",""}, {"full-render-vonix-lard",""}, {"full-render-vonix-laser",""}, {"full-render-vonix-music",""}, {"ex-blo-von"}, {"ex-bra-von"}, {"ex-fat-von"}, {"ex-gut-von","af"}, {"ex-me-von"}, {"ex-ski-von"}, {"vonix-cub"}, {"vonix-grow-01"}, {"vonix-direct-raising"}, {"art-vonix"}}},
        ["py-alienlife-zungror"] = {order="e-p", items={"blood-caged-zungror", "bone-caged-zungror", "brain-caged-zungror", "fat-caged-zungror", "guts-caged-zungror", "meat-caged-zungror", "skin-caged-zungror", {"vsk","b"}, "caged-zungror", "zungror-cocoon", "zungror", "zungror-mk02", "zungror-mk03", "zungror-mk04", {"pre-fiber-1","zpya"}, {"pre-fiber-2","zpyb"}, {"pre-fiber-3","zpyc"}}, recipes={{"full-render-zun",""}, {"full-render-zun-lard",""}, {"full-render-zun-laser",""}, {"full-render-zun-music",""}, {"ex-blo-zun"}, {"ex-bra-zun","a-06"}, {"ex-fat-zun"}, {"ex-gut-zun"}, {"ex-me-zun"}, {"ex-ski-zun"}, {"zungror"}, {"zungror-earth-sample-turd"}, {"zungror-with-yaedols-codex"}, {"zungror-raising-1"}, {"zungror-raising-1-with-funny-rock"}, {"zungror-raising-2"}, {"zungror-raising-2-with-funny-rock"}, {"zungror-raising-3"}, {"zungror-raising-3-with-funny-rock"}, {"uncaged-zungror"}}},
        ["py-alienlife-xeno"] = {order="e-q", items={"sulfuric-caged-xeno", "bone-caged-xeno", "brain-caged-xeno", "meat-caged-xeno", "chitin-caged-xeno", {"cognition-osteochain","b"}, "caged-xeno", "xeno-egg", "xeno", "xeno-mk02", "xeno-mk03", "xeno-mk04"}, recipes={{"full-render-xenos",""}, {"full-render-xenos-lard",""}, {"full-render-xenos-laser",""}, {"full-render-xenos-music",""}, {"ex-blo-xeno"}, {"ex-bon-xeno"}, {"ex-bra-xeno"}, {"ex-me-xeno"}, {"ex-chi-xeno"}, {"xeno"}, {"xeno-earth-sample-turd"}, {"art-xenos"}, {"uncaged-xeno"}}},
        ["py-alienlife-antelope"] = {order="e-r", items={"antelope", "anti-lope", "neutra-lope", "pos-tilope", "cage-antelope", "caged-antelope", "dimensional-gastricorg", "strangelets"}, recipes={{"full-render-antelope","a1"}, {"full-render-antelope-existential","a2"}, {"quantum-dots-folding-1","zpy-item-01x"}, {"quantum-dots-folding-2","zpy-item-02x"}, {"quantum-dots-folding-3","zpy-item-04x"}, {"quantum-dots-folding-4","zpy-item-03x"}}},
        ["py-alienlife-zipir"] = {order="e-x[water]-1", items={"blood-zipir", "brain-zipir", "fat-zipir", "guts-zipir", "meat-zipir", "skin-zipir", {"adaptable-automucosa","b"}, "zipir-eggs", "zipir-pup", "zipir1", "zipir2", "zipir3", "zipir4", "zipir-carcass"}, recipes={{"full-render-zipir",""}, {"full-render-zipir-lard",""}, {"full-render-zipir-laser",""}, {"full-render-zipir-music",""}, {"rendering","1"}, {"ex-blo-zipir"}, {"ex-bra-zipir"}, {"ex-fat-zipir"}, {"ex-gut-zipir"}, {"ex-me-zipir"}, {"ex-ski-zipir"}, {"zipir1"}, {"zipir1-earth-sample-turd"}, {"zipir-pup-maturation"}, {"zipir-a-1"}, {"zipir-a-1-suicide"}, {"zipir-a-2"}, {"zipir-a-2-suicide"}, {"zipir-a-3"}, {"zipir-a-3-suicide"}, {"zipir-a-4"}, {"zipir-a-4-suicide"}, {"zipir-a-5"}, {"zipir-a-5-suicide"}, {"zipir-a-6"}, {"zipir-a-6-suicide"}, {"art-zipir"}}},
        ["py-alienlife-trits"] = {order="e-x[water]-2", items={"blood-trits", "bone-trits", "brain-trits", "fat-trits", "guts-trits", "meat-trits", "skin-trits", {"photophore","b"}, "trits-pup", "trits", "trits-mk02", "trits-mk03", "trits-mk04"}, recipes={{"full-render-trit",""}, {"full-render-trit-lard",""}, {"full-render-trit-laser",""}, {"full-render-trit-music",""}, {"ex-blo-trit"}, {"ex-bon-trit"}, {"ex-bra-trit"}, {"ex-fat-trit"}, {"ex-gut-trit"}, {"ex-me-trit"}, {"ex-ski-trit"}, {"trits"}, {"trits"}, {"trits"}, {"trits"}, {"trits-earth-sample-turd"}, {"trits-1"}, {"trits-1-dc"}, {"trits-2"}, {"trits-2-dc"}, {"trits-3"}, {"trits-3-dc"}, {"trits-4"}, {"trits-4-dc"}, {"art-trits"}}},
        ["py-alienlife-xyhiphoe"] = {order="e-x[water]-3", items={"blood-xyhiphoe", "guts-xyhiphoe", "meat-xyhiphoe", "shell-xyhiphoe", "xyhiphoe-cub", "xyhiphoe-cub-mk02", "xyhiphoe-cub-mk03", "xyhiphoe-cub-mk04", "xyhiphoe", "xyhiphoe-mk02", "xyhiphoe-mk03", "xyhiphoe-mk04", "shell"}, recipes={{"full-render-xyhiphoe",""}, {"full-render-xyhiphoe-lard",""}, {"full-render-xyhiphoe-laser",""}, {"full-render-xyhiphoe-music",""}, {"ex-blo-xyh"}, {"ex-gut-xyh"}, {"ex-me-xyh"}, {"ex-ski-xyh","b"}, {"xyhiphoe"}, {"xyhiphoe-earth-sample-turd"}, {"xyhiphoe-single"}, {"xyhiphoe-1"}, {"xyhiphoe-1-hot-cold"}, {"xyhiphoe-2"}, {"xyhiphoe-2-hot-cold"}, {"xyhiphoe-3"}, {"xyhiphoe-3-hot-cold"}, {"xyhiphoe-4"}, {"xyhiphoe-4-hot-cold"}, {"art-xyhiphoe"}}},
        ["py-alienlife-dhilmos"] = {order="e-x[water]-4", items={"blood-dhilmos", "fat-dhilmos", "guts-dhilmos", "meat-dhilmos", {"autoantigens","b"}, "dhilmos-egg", "dhilmos-pup", "dhilmos", "dhilmos-mk02", "dhilmos-mk03", "dhilmos-mk04"}, recipes={{"full-render-dhilmoss",""}, {"full-render-dhilmoss-lard",""}, {"full-render-dhilmoss-laser",""}, {"full-render-dhilmoss-music",""}, {"ex-blo-dhi"}, {"ex-fat-dhi"}, {"ex-gut-dhi"}, {"ex-me-dhi"}, {"extract-dhilmos-eye"}, {"dhilmos"}, {"dhilmos-earth-sample-turd"}, {"dhilmos-1"}, {"dhilmos-1-cover"}, {"dhilmos-1-double-intake"}, {"dhilmos-1-skimmer"}, {"dhilmos-2"}, {"dhilmos-2-cover"}, {"dhilmos-2-double-intake"}, {"dhilmos-2-skimmer"}, {"dhilmos-3"}, {"dhilmos-3-cover"}, {"dhilmos-3-double-intake"}, {"dhilmos-3-skimmer"}, {"dhilmos-4"}, {"dhilmos-4-cover"}, {"dhilmos-4-double-intake"}, {"dhilmos-4-skimmer"}, {"art-dhilmos"}}},
        ["py-alienlife-numal"] = {order="e-x[water]-5", items={"blood-numal", "guts-numal", "meat-numal", "skin-numal", "chitin-numal", {"numal-ink","b1"}, {"aeroorgan","b2"}, "numal-egg", "numal", "numal-mk02", "numal-mk03", "numal-mk04"}, recipes={{"full-render-num",""}, {"full-render-num-lard",""}, {"full-render-num-laser",""}, {"full-render-num-music",""}, {"ex-blo-num"}, {"ex-gut-num"}, {"ex-gut-num-neodymium"}, {"ex-me-num"}, {"ex-ski-num"}}},
        ["py-alienlife-fish"] = {order="e-x[water]-6", items={"fish-egg", "fish-egg-mk02", "fish-egg-mk03", "fish-egg-mk04", "fish", "fish-mk02", "fish-mk03", "fish-mk04", "fish-oil", "fish-hydrolysate", "fishmeal", "fish-emulsion"}, recipes={{"full-render-fish",""}, {"full-render-fish-lard",""}, {"full-render-fish-laser",""}, {"full-render-fish-music",""}}},
        ["py-alienlife-plants"] = {items={"phytoplankton"}},
        ["py-alienlife-cridren"] = {order="f-1", items={"cridren", "cridren-seeds", "adrenal-cortex"}, recipes={{"cridren-sample"}, {"cridren-1"}, {"cridren-1-neural-cranio"}, {"cridren-2"}, {"cridren-2-neural-cranio"}, {"cridren-3"}, {"cridren-3-neural-cranio"}, {"cridren-4"}, {"cridren-4-neural-cranio"}}},
        ["py-alienlife-sea-sponge"] = {order="f-2", items={"sea-sponge-sprouts", "sea-sponge-sprouts-mk02", "sea-sponge-sprouts-mk03", "sea-sponge-sprouts-mk04", "sea-sponge", "sea-sponge-mk02", "sea-sponge-mk03", "sea-sponge-mk04"}, recipes={{"sea-sponge-sprouts"}, {"sea-sponge-sprouts-flagellum"}, {"sea-sponge-sprouts-2"}, {"sea-sponge-sprouts-2-flagellum"}, {"sea-sponge-sprouts-3"}, {"sea-sponge-sprouts-3-flagellum"}, {"sea-sponge-sprouts-4"}, {"sea-sponge-sprouts-4-flagellum"}, {"sea-sponge"}, {"sea-sponge-earth-sample-turd"}, {"sea-sponge-1"}, {"sea-sponge-1-no-zonga"}, {"sea-sponge-2"}, {"sea-sponge-2-no-zonga"}}},
        ["py-alienlife-sponge"] = {order="f-3"},
        ["py-alienlife-biosample"] = {order="f-a", items={"native-flora", "floraspollinin"}, recipes={{"deadhead-recycle"}, {"bioreserve-super-1"}, {"bioreserve-super-2"}, {"bioreserve-super-3"}, {"bioreserve-super-4"}, {"bioreserve-super-5"}, {"bioreserve-super-6"}, {"bioreserve-super-7"}, {"floraspollinin-reprocessing"}}},
        ["py-alienlife-moss"] = {order="f-b", items={"moss", "moss-mk02", "moss-mk03", "moss-mk04", "chlorinated-water"}},
        ["py-alienlife-seaweed"] = {order="f-c", items={"seaweed", "seaweed-mk02", "seaweed-mk03", "seaweed-mk04"}},
        ["py-alienlife-tree"] = {order="f-d", items={"tree-mk01", "tree-mk02", "tree-mk03", "tree-mk04", "wood-seedling", "wood-seedling-mk02", "wood-seedling-mk03", "wood-seedling-mk04", "wood-seeds", "wood-seeds-mk02", "wood-seeds-mk03", "wood-seeds-mk04", "log", "lacquer-resin", "py-sawblade-module-mk01", "py-sawblade-module-mk02", "py-sawblade-module-mk03", "py-sawblade-module-mk04"}, recipes={{"log7-2", "zpy-item-13x"}}},
        ["py-alienlife-sap"] = {order="f-e", items={"sap-tree", "sap-tree-mk02", "sap-tree-mk03", "sap-tree-mk04", "sap-seeds", "sap-seeds-mk02", "sap-seeds-mk03", "sap-seeds-mk04", "saps", "saps-mk02", "saps-mk03", "saps-mk04"}, recipes={"sap-tree-mulch-mk01", "sap-tree-mulch-mk02", "sap-tree-mulch-mk03", "sap-tree-mulch-mk04"}},
        ["py-alienlife-moon"] = {order="f-f", items={"moondrop", "moondrop-mk02", "moondrop-mk03", "moondrop-mk04", "moondrop-seeds", "moondrop-seeds-mk02", "moondrop-seeds-mk03", "moondrop-seeds-mk04", "moondrop-fueloil", "moondrop-diesel", "moondrop-kerosene", "moondrop-gas"}, recipes={{"moondrop-sample"}, {"moondrop-1"}, {"moondrop-1-cu"}, {"moondrop-2"}, {"moondrop-2-cu"}, {"moondrop-3"}, {"moondrop-3-cu"}, {"moondrop-4"}, {"moondrop-4-cu"}, {"moondrop-5"}, {"moondrop-5-cu"}}},
        ["py-alienlife-ralesia"] = {order="f-g", items={"ralesia", "ralesia-mk02", "ralesia-mk03", "ralesia-mk04", "ralesia-seeds", "ralesia-seeds-mk02", "ralesia-seeds-mk03", "ralesia-seeds-mk04", "dry-ralesia", "ralesia-powder", "raw-ralesia-extract", "ralesia-extract", "paper-towel"}, recipes={{"ralesia-sample"}, {"ralesia-1"}, {"ralesia-1-hydrogen-burn"}, {"ralesia-2"}, {"ralesia-2-hydrogen-burn"}, {"ralesia-3"}, {"ralesia-3-hydrogen-burn"}, {"ralesia-4"}, {"ralesia-4-hydrogen-burn"}, {"ralesia-super-1"}, {"ralesia-super-2"}, {"ralesia-super-3"}, {"ralesia-super-4"}, {"ralesia-super-5"}, {"ralesia-super-6"}, {"ralesia-super-7"}, {"ralesia-super-8"}, {"ralesia-super-9"}, {"ralesia-super-10"}}},
        ["py-alienlife-fawogae"] = {order="f-h", items={"fawogae", "fawogae-mk02", "fawogae-mk03", "fawogae-mk04", "fawogae-spore", "fawogae-spore-mk02", "fawogae-spore-mk03", "fawogae-spore-mk04"}, recipes={{"fawogae-sample"}, {"fawogae-sample-with-xeno-codex"}, {"fawogae-1"}, {"fawogae-1-nitrogen"}, {"fawogae-2"}, {"fawogae-2-nitrogen"}, {"fawogae-3"}, {"fawogae-3-nitrogen"}, {"fawogae-4"}, {"fawogae-4-nitrogen"}, {"fawogae-5"}, {"fawogae-5-nitrogen"}}},
        ["py-alienlife-tuuphra"] = {order="f-i", items={"tuuphra", "tuuphra-mk02", "tuuphra-mk03", "tuuphra-mk04", "tuuphra-seeds", "a-molasse", "b-molasse", "sweet-syrup", "alcl3", "fungicide"}, recipes={{"tuuphra-sample"}, {"tuuphra-1"}, {"tuuphra-1-fungicide"}, {"tuuphra-2"}, {"tuuphra-2-fungicide"}, {"tuuphra-3"}, {"tuuphra-3-fungicide"}, {"tuuphra-4"}, {"tuuphra-4-fungicide"}, {"tuuphra-super-1"}, {"tuuphra-super-2"}, {"tuuphra-super-3"}, {"tuuphra-super-4"}, {"tuuphra-super-5"}, {"tuuphra-super-6"}, {"tuuphra-super-7"}, {"tuuphra-super-8"}, {"tuuphra-super-9"}, {"tuuphra-super-10"}}},
        ["py-alienlife-kicalk"] = {order="f-j", items={"kicalk", "kicalk-mk02", "kicalk-mk03", "kicalk-mk04", "kicalk-seeds", "kicalk-seeds-mk02", "kicalk-seeds-mk03", "kicalk-seeds-mk04", "kicalk-dry"}, recipes={{"kicalk-sample"}, {"kicalk-1"}, {"kicalk-1-dry"}, {"kicalk-1-rotation"}, {"kicalk-1-saline"}, {"kicalk-2"}, {"kicalk-2-dry"}, {"kicalk-2-rotation"}, {"kicalk-2-saline"}, {"kicalk-3"}, {"kicalk-3-dry"}, {"kicalk-3-rotation"}, {"kicalk-3-saline"}, {"kicalk-4"}, {"kicalk-4-dry"}, {"kicalk-4-rotation"}, {"kicalk-4-saline"}, {"kicalk-5"}, {"kicalk-5-dry"}, {"kicalk-5-rotation"}, {"kicalk-5-saline"}, {"kicalk-super-1"}, {"kicalk-super-2"}, {"kicalk-super-3"}, {"kicalk-super-4"}, {"kicalk-super-5"}, {"kicalk-super-6"}, {"kicalk-super-7"}, {"kicalk-super-8"}, {"kicalk-super-9"}, {"kicalk-super-10"}}},
        ["py-alienlife-yaedols"] = {order="f-k", items={"yaedols", "yaedols-mk02", "yaedols-mk03", "yaedols-mk04", "yaedols-spores", "yaedols-spores-mk02", "yaedols-spores-mk03", "yaedols-spores-mk04", "flavonoids"}, recipes={{"yaedols-sample"}, {"yaedols-1"}, {"yaedols-1-hot-air"}, {"yaedols-2"}, {"yaedols-2-hot-air"}, {"yaedols-3"}, {"yaedols-3-hot-air"}, {"yaedols-4"}, {"yaedols-4-hot-air"}}},
        ["py-alienlife-rennea"] = {order="f-l", items={"rennea", "rennea-mk02", "rennea-mk03", "rennea-mk04", "rennea-seeds", "rennea-seeds-mk02", "rennea-seeds-mk03", "rennea-seeds-mk04", "digested-rennea-seeds-mk02", "digested-rennea-seeds-mk03", "digested-rennea-seeds-mk04", "abraded-rennea-seeds-mk02", "abraded-rennea-seeds-mk03", "abraded-rennea-seeds-mk04", "deadhead"}, recipes={{"rennea-sample"}, {"rennea-1"}, {"rennea-1-deadhead"}, {"rennea-1-hydrophile"}, {"rennea-2"}, {"rennea-2-deadhead"}, {"rennea-2-hydrophile"}, {"rennea-3"}, {"rennea-3-deadhead"}, {"rennea-3-hydrophile"}, {"rennea-4"}, {"rennea-4-deadhead"}, {"rennea-4-hydrophile"}, {"rennea-super-1"}, {"rennea-super-2"}, {"rennea-super-3"}, {"rennea-super-4"}, {"rennea-super-5"}, {"rennea-super-6"}, {"rennea-super-7"}, {"rennea-super-8"}, {"rennea-super-9"}, {"rennea-super-10"}}},
        ["py-alienlife-yotoi"] = {order="f-m", items={"yotoi", "yotoi-mk02", "yotoi-mk03", "yotoi-mk04", "yotoi-fruit", "yotoi-fruit-mk02", "yotoi-fruit-mk03", "yotoi-fruit-mk04", "yotoi-seeds", "yotoi-seeds-mk02", "yotoi-seeds-mk03", "yotoi-seeds-mk04", "yotoi-leaves", "nutrient"}, recipes={{"yotoi-sample"}, {"yotoi-1"}, {"yotoi-1-free-leaves"}, {"yotoi-2"}, {"yotoi-2-free-leaves"}, {"yotoi-2-nutrient"}, {"yotoi-3"}, {"yotoi-3-free-leaves"}, {"yotoi-3-nutrient"}, {"yotoi-4"}, {"yotoi-4-free-leaves"}, {"yotoi-4-nutrient"}, {"yotoi-super-1"}, {"yotoi-super-2"}, {"yotoi-super-3"}, {"yotoi-super-4"}, {"yotoi-super-5"}, {"yotoi-super-6"}, {"yotoi-super-7"}, {"yotoi-super-8"}, {"yotoi-super-9"}, {"yotoi-super-10"}, {"yotoi-fruit-super-10","zpy-item-05x"}}},
        ["py-alienlife-navens"] = {order="f-n", items={"navens", "navens-mk02", "navens-mk03", "navens-mk04", "navens-spore", "navens-spore-mk02", "navens-spore-mk03", "navens-spore-mk04", "navens-abomination"}, recipes={{"navens-sample"}, {"navens-sample-with-vonix-gen"}, {"navens-1"}, {"navens-2"}, {"navens-3"}, {"navens-4"}, "full-render-navens-abomination"}},
        ["py-alienlife-bhoddos"] = {order="f-o", items={"bhoddos", "bhoddos-mk02", "bhoddos-mk03", "bhoddos-mk04", "bhoddos-spore", "bhoddos-spore-mk02", "bhoddos-spore-mk03", "bhoddos-spore-mk04"}, recipes={{"bhoddos-sample"}, {"bhoddos-1"}, {"bhoddos-1-exoenzymes"}, {"bhoddos-1-meltdown"}, {"bhoddos-2"}, {"bhoddos-2-exoenzymes"}, {"bhoddos-2-meltdown"}, {"bhoddos-3"}, {"bhoddos-3-exoenzymes"}, {"bhoddos-3-meltdown"}, {"bhoddos-4"}, {"bhoddos-4-exoenzymes"}, {"bhoddos-4-meltdown"}}},
        ["py-alienlife-grod"] = {order="f-p", items={"grod", "grod-mk02", "grod-mk03", "grod-mk04", "grod-seeds-pod-mk02", "grod-seeds-pod-mk03", "grod-seeds-pod-mk04", "grod-seeds", "grod-seeds-mk02", "grod-seeds-mk03", "grod-seeds-mk04", "dried-grods"}, recipes={{"grod-sample"}, {"grod-1"}, {"grod-1-dry"}, {"grod-1-pressured"}, {"grod-2"}, {"grod-2-dry"}, {"grod-2-pressured"}, {"grod-3"}, {"grod-3-dry"}, {"grod-3-pressured"}, {"grod-4"}, {"grod-4-dry"}, {"grod-4-pressured"}, {"grod-super-1"}, {"grod-super-2"}, {"grod-super-3"}, {"grod-super-4"}, {"grod-super-5"}, {"grod-super-6"}, {"grod-super-7"}, {"grod-super-8"}, {"grod-super-9"}, {"grod-super-10"}}},
        ["py-alienlife-cadaveric"] = {order="f-q", items={"cadaveric-arum", "cadaveric-arum-mk02-a", "cadaveric-arum-mk03-a", "cadaveric-arum-mk04-a", "cadaveric-arum-seeds", "cadaveric-arum-seeds-mk02", "cadaveric-arum-seeds-mk03", "cadaveric-arum-seeds-mk04", "cadaveric-arum-mk02-seed-juice", "cadaveric-arum-mk03-seed-juice", "cadaveric-arum-mk04-seed-juice", "residual-gas", "dms", "msa"}, recipes={{"cadaveric-arum-sample"}, {"cadaveric-arum-1"}, {"cadaveric-arum-1-msa"}, {"cadaveric-arum-1-soil"}, {"cadaveric-arum-2"}, {"cadaveric-arum-2-msa"}, {"cadaveric-arum-2-soil"}, {"cadaveric-arum-3"}, {"cadaveric-arum-3-msa"}, {"cadaveric-arum-3-soil"}, {"cadaveric-arum-4"}, {"cadaveric-arum-4-msa"}, {"cadaveric-arum-4-soil"}, {"arum-super-1"}, {"arum-super-2"}, {"arum-super-3"}, {"arum-super-4"}, {"arum-super-5"}, {"arum-super-6"}, {"arum-super-7"}, {"arum-super-8"}, {"arum-super-9"}, {"arum-super-10"}}},
        ["py-alienlife-guar"] = {order="f-r", items={"guar", "guar-mk02", "guar-mk03", "guar-mk04", "guar-seeds", "guar-seeds-mk02", "guar-seeds-mk03", "guar-seeds-mk04"}, recipes={{"guar-sample"}, {"guar-1"}, {"guar-1-aquaguar"}, {"guar-1-guarpulse"}, {"guar-2"}, {"guar-2-aquaguar"}, {"guar-2-guarpulse"}, {"guar-3"}, {"guar-3-aquaguar"}, {"guar-3-guarpulse"}, {"guar-4"}, {"guar-4-aquaguar"}, {"guar-4-guarpulse"}, }},
        ["py-alienlife-mova"] = {order="f-s", items={"mova", "washed-mova", "mova-pulp1", "mova-pulp2", "mova-pulp3", "guaiacol", "buffer-solution", "pre-enzyme", "ammonium-sulfate", "crude-enzyme"}, recipes={{"mova-super-10","zpy-item-01x"}}},
        ["recipe-py-alienlife-vrauks"] = {order="e-a"},
        ["recipe-py-alienlife-auog"] = {order="e-b"},
        ["recipe-py-alienlife-cottongut"] = {order="e-c"},
        ["recipe-py-alienlife-ulric"] = {order="e-d"},
        ["recipe-py-alienlife-arqad"] = {order="e-e"},
        ["recipe-py-alienlife-korlex"] = {order="e-f"},
        ["recipe-py-alienlife-mukmoux"] = {order="e-g"},
        ["recipe-py-alienlife-phagnot"] = {order="e-h"},
        ["recipe-py-alienlife-arthurian"] = {order="e-i"},
        ["recipe-py-alienlife-scrondrix"] = {order="e-j"},
        ["recipe-py-alienlife-kmauts"] = {order="e-k"},
        ["recipe-py-alienlife-dingrits"] = {order="e-l"},
        ["recipe-py-alienlife-phadai"] = {order="e-m"},
        ["recipe-py-alienlife-simik"] = {order="e-n"},
        ["recipe-py-alienlife-vonix"] = {order="e-o"},
        ["recipe-py-alienlife-zungror"] = {order="e-p"},
        ["recipe-py-alienlife-xeno"] = {order="e-q"},
        ["recipe-py-alienlife-antelope"] = {order="e-r"},
        ["recipe-py-alienlife-zipir"] = {order="e-x[water]-1"},
        ["recipe-py-alienlife-trits"] = {order="e-x[water]-2"},
        ["recipe-py-alienlife-xyhiphoe"] = {order="e-x[water]-3"},
        ["recipe-py-alienlife-dhilmos"] = {order="e-x[water]-4"},
        ["recipe-py-alienlife-numal"] = {order="e-x[water]-5"},
        ["recipe-py-alienlife-fish"] = {order="e-x[water]-6"},
        ["recipe-py-alienlife-plants"] = {order="f"},
        ["recipe-py-alienlife-cridren"] = {order="f-1"},
        ["recipe-py-alienlife-sea-sponge"] = {order="f-2"},
        ["recipe-py-alienlife-sponge"] = {order="f-3"},
        --["recipe-py-alienlife-biosample"] = {order="f-a"},
        ["recipe-py-alienlife-moss"] = {order="f-b"},
        ["recipe-py-alienlife-seaweed"] = {order="f-c"},
        ["recipe-py-alienlife-tree"] = {order="f-d"},
        ["recipe-py-alienlife-sap"] = {order="f-e"},
        ["recipe-py-alienlife-moon"] = {order="f-f"},
        ["recipe-py-alienlife-ralesia"] = {order="f-g"},
        ["recipe-py-alienlife-fawogae"] = {order="f-h"},
        ["recipe-py-alienlife-tuuphra"] = {order="f-i"},
        ["recipe-py-alienlife-kicalk"] = {order="f-j"},
        ["recipe-py-alienlife-yaedols"] = {order="f-k"},
        ["recipe-py-alienlife-rennea"] = {order="f-l"},
        ["recipe-py-alienlife-yotoi"] = {order="f-m"},
        ["recipe-py-alienlife-navens"] = {order="f-n"},
        ["recipe-py-alienlife-bhoddos"] = {order="f-o"},
        ["recipe-py-alienlife-grod"] = {order="f-p"},
        ["recipe-py-alienlife-cadaveric"] = {order="f-q"},
        ["recipe-py-alienlife-guar"] = {order="f-r"},
        ["recipe-py-alienlife-mova"] = {order="f-s"},
    },
    ["combat"] = {
        ["tool"] = {order="1b"},
        ["gun"] = {items={"dragon-breath"}},
        ["ammo"] = {items={"dragon-breath-ammo"}},
        --["capsule"] = {order="c"},
        --["armor"] = {order="d"},
        --["equipment"] = {order="e"},
        --["equipment-military"] = {order="f"},
        ["py-generator-equipment"] = {order="fb"},
        ["py-battery-equipment"] = {order="fc"},
        ["transport"] = {order="fd"},
        ["py-walls"] = {order="fe"},
        --["defensive-structure"] = {order="g"},
        ["radar"] = {order="h", items={"py-local-radar", "radar", "megadar"}},
        --["turret"] = {order="i"},
        --["ammo-category"] = {order="j"},
    },
    ["environment"] = {
        ["planets"] = {order="1", items={"nauvis"}},
        --["cliffs"] = {order="a"},
        ["trees"] = {order="aa", items={"driftwood"}},
        --["grass"] = {order="b"},
        --["corpses"] = {order="c", items={"ulric-man-corpse"}},
        ["nauvis-tiles"] = {order="f"},
        ["special-tiles"] = {order="g", items={"polluted-ground", "polluted-ground-burnt", "out-of-map"}},
        ["artificial-tiles"] = {order="h"},
        ["mineable-fluids"] = {order="i", items={"bitumen-seep", "oil-mk01", "oil-mk02", "oil-mk03", "oil-mk04", "tar-patch", "geothermal-crack"}},
        --["mineable-materials"] = {order="i2", items={"coal-rock", "iron-rock", "copper-rock", "aluminium-rock", "tin-rock", "zinc-rock", "lead-rock", "titanium-rock", "nickel-rock", "chromium-rock", "quartz-rock", "nexelit-rock", "antimonium", "niobium", "salt-rock", "rare-earth-bolide", "sulfur-patch", "phosphate-rock-02", "uranium-rock", "volcanic-pipe", "regolites"}},
        ["enemies"] = {order="j"},
        ["creatures"] = {order="k", items={"digosaurus-mineable-proxy", "thikats-mineable-proxy", "work-o-dile-mineable-proxy"}},
    },
    ["signals"] = { -- renamed "abstract"
        ["planners"] = {order="1", items={"blueprint", "deconstruction-planner", "upgrade-planner", "blueprint-book", "copy-paste-tool", "cut-paste-tool"}},
        ["spawnables"] = {order="2"},
        --["virtual-signal-special"] = {order="a"},
        --["virtual-signal-number"] = {order="b"},
        --["virtual-signal-letter"] = {order="c"},
        --["virtual-signal-color"] = {order="d"},
        --["virtual-signal"] = {order="e"},
        --["shapes"] = {order="f"},
        --["arrows"] = {order="g"},
        --["additions"] = {order="h"},
        ["qualities"] = {order="i"},
        ["parameters"] = {order="j"},
        ["indicators"] = {order="k", items={"tile-ghost", "entity-ghost", "item-on-ground", "item-request-proxy"}},
        ["other"] = {order="z"},
    },
    ["effects"] = {
        ["particles"] = {items={"sut-smokestack", "sut-smokestack-weak"}},
    },
}
local tabs = {
    ["py-hightech"] = {order="s", rename=true},
    ["py-rawores"] = {order="t", rename=true},
    ["py-petroleum-handling"] = {order="u", rename=true},
    ["py-alienlife"] = {order="v", rename=true},
    ["combat"] = {order="x"},
    ["enemies"] = {order="xb"},
    ["tiles"] = {order="xc"},
    ["environment"] = {order="xd", icon="__base__/graphics/icons/nauvis.png", size=64},
    ["signals"] = {order="y", rename=true},
}
-- these recipes have multiple products and were missing a main_product to help categorize them
local new_main_products = {
    ["basic-oil-processing"] = "petroleum-gas",
    ["heavy-oil-cracking"] = "light-oil",
    ["light-oil-cracking"] = "petroleum-gas",
    ["kovarex-enrichment-process"] = "u-235",
    ["nuclear-fuel-reprocessing"] = "u-238",
    ["crusher-ree"] = "rare-earth-powder",
    ["syngas2"] = "syngas",
    ["py-sodium-hydroxide"] = "sodium-hydroxide",
    ["crushed-kimberlite"] = "crushed-kimberlite",
    ["kimberlite-recrushing"] = "crushed-kimberlite",
    ["screening-kimberlite"] = "kimberlite-grade2",
    ["diamond-rejects-recrushing"] = "pure-kimberlite-grade2",
    ["pure-kimberlite-recrushing"] = "kimberlite-grade3",
    ["kimberlite-washing"] = "kimberlite-grade3",
    ["screening-kimberlite-residue"] = "diamond-reject",
    ["diamond-rejects-screening"] = "processed-rejects",
    ["jig-separation"] = "jig-grade1",
    ["greasing-1"] = "crude-diamond",
    ["greasing-2"] = "crude-diamond",
    ["greasing-3"] = "crude-diamond",
    ["washing-crude"] = "washed-diamond",
    ["class-diamond"] = "diamond",
    ["rejects-separation"] = "diamond",
    ["pa-233-seperation"] = "hot-molten-salt",
    ["lithium-salt-fuel-seperation"] = "hot-molten-salt",
    ["mox-fuel-seperation"] = "hot-molten-salt",
    ["purex-raffinate-vitrification"] = "purex-u-concentrate-1",
    ["purex-waste-vitrification"] = "purex-u-concentrate-1",
    ["ulric-mk02"] = "ulric-mk02",
    ["ulric-mk02-breeding"] = "ulric-cub-mk02",
    ["ulric-mk02-raising"] = "ulric-mk02",
    ["ulric-mk02-dna-sample"] = "ulric-mk02-dna-sample",
    ["ulric-mk02-dna-sample-02"] = "ulric-mk02-dna-sample",
    ["ulric-mk03"] = "ulric-mk03",
    ["ulric-mk03-breeding"] = "ulric-cub-mk03",
    ["ulric-mk03-raising"] = "ulric-mk03",
    ["ulric-mk03-dna-sample"] = "ulric-mk03-dna-sample",
    ["ulric-mk03-dna-sample-02"] = "ulric-mk03-dna-sample",
    ["ulric-mk04"] = "ulric-mk04",
    ["ulric-mk04-breeding"] = "ulric-cub-mk04",
    ["ulric-mk04-raising"] = "ulric-mk04",
    ["ulric-mk04-dna-sample"] = "ulric-mk04-dna-sample",
    ["ulric-mk04-dna-sample-02"] = "ulric-mk04-dna-sample",
    ["auog-mk02"] = "auog-mk02",
    ["auog-mk02-breeder"] = "auog-pup-mk02",
    ["auog-pup-mk02-breeder"] = "auog-mk02",
    ["auog-mk03"] = "auog-mk03",
    ["auog-mk03-breeder"] = "auog-pup-mk03",
    ["auog-pup-mk03-breeder"] = "auog-mk03",
    ["auog-mk04"] = "auog-mk04",
    ["auog-mk04-breeder"] = "auog-pup-mk04",
    ["auog-pup-mk04-breeder"] = "auog-mk04",
    ["mukmoux-mk02"] = "mukmoux-mk02",
    ["mukmoux-mk03"] = "mukmoux-mk03",
    ["mukmoux-mk04"] = "mukmoux-mk04",
    ["vrauks-mk02"] = "vrauks-mk02",
    ["vrauks-mk02-breeder"] = "vrauks-mk02",
    ["vrauks-mk02-cocoon"] = "cocoon-mk02",
    ["vrauks-mk03"] = "vrauks-mk03",
    ["vrauks-mk03-breeder"] = "vrauks-mk03",
    ["vrauks-mk03-cocoon"] = "cocoon-mk03",
    ["vrauks-mk04"] = "vrauks-mk04",
    ["vrauks-mk04-breeder"] = "vrauks-mk04",
    ["vrauks-mk04-cocoon"] = "cocoon-mk04",
    ["arthurian-mk02"] = "arthurian-mk02",
    ["arthurian-egg-mk02-gmo"] = "arthurian-egg-mk02",
    ["arthurian-mk03"] = "arthurian-mk03",
    ["arthurian-egg-mk03-gmo"] = "arthurian-egg-mk03",
    ["arthurian-mk04"] = "arthurian-mk04",
    ["arthurian-egg-mk04-gmo"] = "arthurian-egg-mk04",
    ["dhilmos-mk02"] = "dhilmos-mk02",
    ["dhilmos-mk03"] = "dhilmos-mk03",
    ["dhilmos-mk04"] = "dhilmos-mk04",
    ["scrondrix-mk02"] = "scrondrix-mk02",
    ["scrondrix-mk03"] = "scrondrix-mk03",
    ["scrondrix-mk04"] = "scrondrix-mk04",
    ["phadai-mk02"] = "phadai-mk02",
    ["phadai-mk03"] = "phadai-mk03",
    ["phadai-mk04"] = "phadai-mk04",
    ["fish-mk02"] = "fish-mk02",
    ["fish-mk02-breeder"] = "fish-mk02",
    ["fish-egg-mk02-breeder"] = "fish-egg-mk02",
    ["fish-mk03"] = "fish-mk03",
    ["fish-mk03-breeder"] = "fish-mk03",
    ["fish-egg-mk03-breeder"] = "fish-egg-mk03",
    ["fish-mk04"] = "fish-mk04",
    ["fish-mk04-breeder"] = "fish-mk04",
    ["fish-egg-mk04-breeder"] = "fish-egg-mk04",
    ["dingrits-mk02"] = "dingrits-mk02",
    ["dingrits-mk03"] = "dingrits-mk03",
    ["dingrits-mk04"] = "dingrits-mk04",
    ["kmauts-mk02"] = "kmauts-mk02",
    ["kmauts-mk03"] = "kmauts-mk03",
    ["kmauts-mk04"] = "kmauts-mk04",
    ["phagnot-mk02"] = "phagnot-mk02",
    ["phagnot-mk03"] = "phagnot-mk03",
    ["phagnot-mk04"] = "phagnot-mk04",
    ["zipir-mk02"] = "zipir2",
    ["zipir-mk03"] = "zipir3",
    ["zipir-mk04"] = "zipir4",
    ["trits-mk02"] = "trits-mk02",
    ["trits-mk03"] = "trits-mk03",
    ["trits-mk04"] = "trits-mk04",
    ["simik-mk02"] = "simik-mk02",
    ["simik-mk03"] = "simik-mk03",
    ["simik-mk04"] = "simik-mk04",
    ["korlex-mk02"] = "korlex-mk02",
    ["korlex-mk03"] = "korlex-mk03",
    ["korlex-mk04"] = "korlex-mk04",
    ["cottongut-pup-mk01-raising"] = "cottongut-pup-mk01",
    ["cottongut-mk02"] = "cottongut-mk02",
    ["cottongut-pup-mk02-raising"] = "cottongut-pup-mk02",
    ["cottongut-mk03"] = "cottongut-mk03",
    ["cottongut-pup-mk03-raising"] = "cottongut-pup-mk03",
    ["cottongut-mk04"] = "cottongut-mk04",
    ["cottongut-pup-mk04-raising"] = "cottongut-pup-mk04",
    ["arqad-mk02"] = "arqad-mk02",
    ["arqad-mk03"] = "arqad-mk03",
    ["arqad-mk04"] = "arqad-mk04",
    ["xeno-mk02"] = "xeno-mk02",
    ["xeno-mk03"] = "xeno-mk03",
    ["xeno-mk04"] = "xeno-mk04",
    ["vonix-mk02"] = "vonix-mk02",
    ["vonix-mk03"] = "vonix-mk03",
    ["vonix-mk04"] = "vonix-mk04",
    ["abraded-rennea-seed-filtering-mk02"] = "abraded-rennea-seeds-mk02",
    ["abraded-rennea-seed-filtering-mk03"] = "abraded-rennea-seeds-mk03",
    ["abraded-rennea-seed-filtering-mk04"] = "abraded-rennea-seeds-mk04",
    ["tuuphra-mk02"] = "tuuphra-mk02",
    ["tuuphra-mk03"] = "tuuphra-mk03",
    ["tuuphra-mk04"] = "tuuphra-mk04",
    ["kicalk-mk02"] = "kicalk-mk02",
    ["kicalk-mk02-breeder"] = "kicalk-mk02",
    ["kicalk-mk03"] = "kicalk-mk03",
    ["kicalk-mk03-breeder"] = "kicalk-mk03",
    ["kicalk-mk04"] = "kicalk-mk04",
    ["kicalk-mk04-breeder"] = "kicalk-mk04",
    ["cadaveric-arum-mk02-breeder"] = "cadaveric-arum-mk02-a",
    ["cadaveric-arum-mk02-juicer"] = "cadaveric-arum-seeds-mk02",
    ["cadaveric-arum-mk03-breeder"] = "cadaveric-arum-mk03-a",
    ["cadaveric-arum-mk03-juicer"] = "cadaveric-arum-seeds-mk03",
    ["cadaveric-arum-mk04-breeder"] = "cadaveric-arum-mk04-a",
    ["cadaveric-arum-mk04-juicer"] = "cadaveric-arum-seeds-mk04",
    ["bhoddos-spore-mk02"] = "bhoddos-spore-mk02",
    ["bhoddos-spore-mk03"] = "bhoddos-spore-mk03",
    ["bhoddos-spore-mk04"] = "bhoddos-spore-mk04",
    ["yaedols-mk02"] = "yaedols-mk02",
    ["yaedols-mk03"] = "yaedols-mk03",
    ["yaedols-mk04"] = "yaedols-mk04",
    ["scrondrix-mk02-boron"] = "scrondrix-mk02",
    ["scrondrix-mk02-vegan"] = "scrondrix-mk02",
    ["scrondrix-mk03-boron"] = "scrondrix-mk03",
    ["scrondrix-mk03-vegan"] = "scrondrix-mk03",
    ["scrondrix-mk04-boron"] = "scrondrix-mk04",
    ["scrondrix-mk04-vegan"] = "scrondrix-mk04",
    ["fluidize-coke"] = "ammonia",
    -- these had main products which were more like side products
    ["Moss-1-without-sludge"] = "moss",
    ["Moss-2-without-sludge"] = "moss",
    ["Moss-3-without-sludge"] = "moss",
    ["Moss-4-without-sludge"] = "moss",
    ["Moss-5-without-sludge"] = "moss",
    ["ralesia-1-hydrogen-burn"] = "ralesia",
    ["ralesia-2-hydrogen-burn"] = "ralesia",
    ["ralesia-3-hydrogen-burn"] = "ralesia",
    ["ralesia-4-hydrogen-burn"] = "ralesia",
    ["kicalk-1-dry"] = "kicalk",
    ["kicalk-2-dry"] = "kicalk",
    ["kicalk-3-dry"] = "kicalk",
    ["kicalk-4-dry"] = "kicalk",
    ["kicalk-5-dry"] = "kicalk",
    ["yaedols-1-hot-air"] = "yaedols",
    ["yaedols-2-hot-air"] = "yaedols",
    ["yaedols-3-hot-air"] = "yaedols",
    ["yaedols-4-hot-air"] = "yaedols",
    ["yotoi-2-nutrient"] = "yotoi",
    ["yotoi-3-nutrient"] = "yotoi",
    ["yotoi-4-nutrient"] = "yotoi",
    ["yotoi-fruit-2-nutrient"] = "yotoi-fruit",
    ["yotoi-fruit-3-nutrient"] = "yotoi-fruit",
    ["yotoi-fruit-4-nutrient"] = "yotoi-fruit",
    ["yotoi-1-free-leaves"] = "yotoi",
    ["yotoi-2-free-leaves"] = "yotoi",
    ["yotoi-3-free-leaves"] = "yotoi",
    ["yotoi-4-free-leaves"] = "yotoi",
    ["rennea-1-deadhead"] = "rennea",
    ["rennea-2-deadhead"] = "rennea",
    ["rennea-3-deadhead"] = "rennea",
    ["rennea-4-deadhead"] = "rennea",
    ["guar-1-guarpulse"] = "guar",
    ["guar-2-guarpulse"] = "guar",
    ["guar-3-guarpulse"] = "guar",
    ["guar-4-guarpulse"] = "guar",
    ["bhoddos-1-exoenzymes"] = "bhoddos",
    ["bhoddos-2-exoenzymes"] = "bhoddos",
    ["bhoddos-3-exoenzymes"] = "bhoddos",
    ["bhoddos-4-exoenzymes"] = "bhoddos",
    ["sea-sponge-sprouts-flagellum"] = "sea-sponge-sprouts",
    ["sea-sponge-sprouts-2-flagellum"] = "sea-sponge-sprouts",
    ["sea-sponge-sprouts-3-flagellum"] = "sea-sponge-sprouts",
    ["sea-sponge-sprouts-4-flagellum"] = "sea-sponge-sprouts",
    ["Phadai-Dance-Dance-Revolution-1-piezoelectric"] = "carapace",
    ["Phadai-Dance-Dance-Revolution-2-piezoelectric"] = "carapace",
    ["Phadai-Dance-Dance-Revolution-3-piezoelectric"] = "carapace",
    ["Phadai-Dance-Dance-Revolution-4-piezoelectric"] = "carapace",
    ["korlex-milk-1-pressured"] = "barrel-milk",
    ["korlex-milk-2-pressured"] = "barrel-milk",
    ["korlex-milk-3-pressured"] = "barrel-milk",
    ["korlex-milk-4-pressured"] = "barrel-milk",
    ["arthurian-egg-2-hot-stones"] = "arthurian-egg",
    ["arthurian-egg-3-hot-stones"] = "arthurian-egg",
    ["arthurian-egg-4-hot-stones"] = "arthurian-egg",
    ["arthurian-egg-1-hot-stones"] = "arthurian-egg",
    ["petroleum-gas2"] = "bacteria-2",
}
local kinds = {"item", "fluid", "module", "item-with-tags", "item-with-entity-data", "capsule", "gun", "ammo", "tile", "cargo-pod", "temporary-container", "resource", "character-corpse", "planet", "tile-ghost", "entity-ghost", "item-entity", "item-request-proxy", "blueprint", "blueprint-book", "deconstruction-item", "upgrade-item", "copy-paste-tool", "mining-drill", "assembling-machine", "container", "electric-energy-interface", "simple-entity", "fire", "simple-entity-with-force", "fish", "furnace", "burner-generator", "tool"}
function organize_subgroups(groups)
    for group,subgroups in pairs(groups) do
        for subgroup,details in pairs(subgroups) do
            if not data.raw["item-subgroup"][subgroup] then
                data:extend({ {group = group, type = "item-subgroup", name = subgroup} })
            end
            if data.raw["item-subgroup"][subgroup] then
                data.raw["item-subgroup"][subgroup].group = group
                if details.order then data.raw["item-subgroup"][subgroup].order = details.order end
                if details.items then
                    for i,item in pairs(details.items) do
                        local prefix = "zpy-item-"
                        local value = i
                        if i < 10 then value = "0"..i end
                        if type(item) == "table" then
                            prefix = ""
                            value = item[2] or ("1-"..value) -- if a second value is included, it is used for ordering instead; if items are in a table without a second value, they will be placed ahead of others
                            item = item[1]
                        end
                        local found = false
                        for _,kind in pairs(kinds) do
                            if data.raw[kind][item] then
                                data.raw[kind][item].subgroup = subgroup
                                data.raw[kind][item].order = prefix..value
                                found = true
                                break
                            end
                        end
                        if debug_errors and not found then error("invalid item name: "..item) end
                    end
                end
                if details.recipes then
                    for i,recipe in pairs(details.recipes) do
                        local prefix = "zpy-recipe-"
                        local value = i
                        if i < 10 then value = "0"..i end
                        if type(recipe) == "table" then
                            prefix = ""
                            if recipe[2] then
                                value = recipe[2] -- if a second value is included, it is used for ordering instead (this allows it to be inserted into the normal ordering scheme instead of needing to "relist" all intervening recipes)
                            else
                                prefix = get_product_order(recipe[1]).."-" -- if recipes are in a table but no second value is included, the recipes will be sorted within their pre-existing order (generally based on their products' item order)
                            end
                            recipe = recipe[1]
                        end
                        if data.raw.recipe[recipe] then
                            data.raw.recipe[recipe].subgroup = subgroup
                            data.raw.recipe[recipe].order = prefix..value
                        elseif debug_errors then
                            error("invalid recipe name: "..recipe)
                        end
                    end
                end
            end
        end
    end
end
--- Returns the order of a recipe's result
--- @param recipe_name string
--- @return string
function get_product_order(recipe_name)
    local recipe = data.raw.recipe[recipe_name]
    local order
    local item
    if recipe then
        order = recipe.order
        if recipe.main_product then
            item = recipe.main_product
        else
            if recipe.result then item = recipe.result end
            if recipe.results and #recipe.results > 0 then
                if recipe.results[1].name then item = recipe.results[1].name
                else item = recipe.results[1][1] end
            end
        end
        if item then
            for _,kind in pairs(kinds) do
                if data.raw[kind][item] then
                    order = data.raw[kind][item].order
                    break
                end
            end
        end
    end
    return order or ""
end

-- comprehensive reorganization of subgroups and groups based on the above tables
if settings.startup["pysimple-recipe-menu"].value then
    for recipe,product in pairs(new_main_products) do
        if data.raw.recipe[recipe] then
            local results = data.raw.recipe[recipe].results
            if results then
                local product_valid = false
                for _,result in pairs(results) do
                    if result.name and result.name == product then product_valid = true end
                end
                if product_valid then data.raw.recipe[recipe].main_product = product end
            end
        elseif debug_errors then
            error("invalid recipe name: "..recipe)
        end
    end
    for name,tab in pairs(tabs) do
        if tab.rename then data.raw["item-group"][name].localised_name = {"name."..name} end
        if tab.icon then data.raw["item-group"][name].icon = tab.icon end
        if tab.size then data.raw["item-group"][name].icon_size = tab.size end
        if tab.order then data.raw["item-group"][name].order = tab.order end
    end
    for _,recipe in pairs(data.raw.recipe) do
        local multi = false
        local has_product = false
        if recipe.main_product then multi = true end
        if recipe.results and #recipe.results > 1 then multi = true end
        if recipe.result then has_product = true end
        if recipe.results and #recipe.results > 0 then has_product = true end
        if (recipe.main_product and multi) or (has_product and not multi) then
            recipe.subgroup = nil
        end
        recipe.order = nil
    end
    local special_recipes = {"brain-food-01", "brain-food-02", "brain-food-03", "brain-food-04"}
    for i,recipe in pairs(special_recipes) do
        if data.raw.recipe[recipe] then
            data.raw.recipe[recipe].subgroup = "py-alienlife-vatbrain"
            data.raw.recipe[recipe].order = "zpy-recipe-0"..i
        end
    end

    organize_subgroups(groups)

    -- sorts biomass recipes by how much they produce
    for name,recipe in pairs(data.raw.recipe) do
        if recipe.results and recipe.results[1] and recipe.results[1].name == "biomass" then
            local res = recipe.results[1]
            if res.amount then
                data.raw.recipe[name].order = "zpy-recipe-"..tostring(res.amount/1000)
            else
                data.raw.recipe[name].order = "zpy-recipe-"..tostring((res.probability or 1) * (res.count_min + res.count_max)/2000)
            end
        end
    end

    -- hides things which shouldn't be visible
    local to_hide = {
        ["hidden"] = {
            ["simple-entity-with-force"] = {"multiblade-turbine-mk01-collision", "multiblade-turbine-mk03-collision", "sut-placement-distance"},
            ["electric-energy-interface"] = {"multiblade-turbine-mk01-blank", "multiblade-turbine-mk03-blank"},
            ["fire"] = {"sut-smokestack", "sut-smokestack-weak"},
            ["tree"] = {"ninja-tree", "arum-fake", "kicalk-tree-fake", "mova-fake"},
            ["simple-entity-with-owner"] = {},
            ["character-corpse"] = {"ulric-man-corpse"},
            ["ammo-category"] = {"caravan-control", "ulric-infusion"},
            ["solar-panel"] = {"solar-panel"},
            ["generator"] = {"py-turbine"},
            ["mining-drill"] = {"nexelit-mine"},
            ["module"] = {"vonix-mk04", "zungror-mk04"},
            ["fluid"] = {"hot-reaction-gas", "processed-light-oil"},
            ["item"] = { -- inaccessible items
                "solar-panel", "thorium-232", "th-233", "u-239", "u-240", "plutonium", "additional-part-mk01", "additional-part-mk02", "nexelit-mine", "py-turbine", "bone-caged-zungror", "skin-numal", "zipir-carcass",
                "processed-light-oil-canister", "uranium-fuel-cell-mk02", "used-up-uranium-fuel-cell-mk02", "uranium-fuel-cell-mk05", "used-up-uranium-fuel-cell-mk05", "grade-4-iron", "grade-4-lead", "used-ulric", "zungror-codex-mk04",
            },
            ["recipe"] = { -- these recipes are unavailable - they are neither TURDs nor unlockable via any techs
                "solar-panel", "oil-refinery", "pumpjack", "py-turbine", "hot-reaction-gas-pyvoid-gas", "fill-processed-light-oil-canister", "empty-processed-light-oil-canister", "rendering", "zipir-carcass",
                "fertilizer", "urea2", "fawogae", "fawogae2", "guar-01", "guar-02", "guar-03", "guar-04", "guar-05", "guar-separation", "raw-fiber", "raw-fiber2", "raw-fiber3", "raw-fiber4",
                "bonemeal", "bonemeal-salt", "bonemeal2", "bonemeal3", "bonemeal4", "mukmoux-fat", "mukmoux-fat-salt", "mukmoux-fat2", "mukmoux-fat3", "arthropod-blood", "simik-food-01a", "simik-food-02a",
                "nuclear-fuel-reprocessing", "nuclear-fuel-reprocessing-mk02", "nuclear-fuel-reprocessing-mk03", "nuclear-fuel-reprocessing-mk04", "nuclear-fuel-reprocessing-mk05", "kovarex-enrichment-process",
                "antimatter-fusion", "uranium-fuel-cell-mk02", "uranium-fuel-cell-mk05", "u235-pulp-01", "pa-uranium-235", "pa-aromatics", "pa-benzene", "pa-propene", "pa-coal",
                "msa-void-boric-acid", "scrude-to-hydrogen", "scrude-to-fuel-oil", "crude-to-fuel-oil", "steam-exchange1", "steam-exchange2", "steam-exchange3", "steam-exchange4",
                "vonix-mk04", "zungror-mk04", "zungror-mk04r", "compile-zungror-ai", "bioreserve-super-7", "biomass-vonix-mk04",
            },
        },
        ["hidden_in_factoriopedia"] = {
            ["beacon"] = {},
            ["resource"] = {"coal"},
            ["recipe"] = {"digosaurus-helmod-recipe-dried-meat", "digosaurus-helmod-recipe-guts", "digosaurus-helmod-recipe-meat", "digosaurus-helmod-recipe-workers-food", "digosaurus-helmod-recipe-workers-food-02", "digosaurus-helmod-recipe-workers-food-03"},
            ["virtual-signal"] = {"caravan-map-tag-mk01", "caravan-map-tag-mk02", "caravan-map-tag-mk03", "ocula-map-tag"},
            ["cargo-pod"] = {"cargo-pod"},
            ["temporary-container"] = {"cargo-pod-container"},
            ["inserter"] = { -- these are from the "pycranes-spdfix" mod
                "crane-mk1u1", "crane-mk1u2", "crane-mk2u1", "crane-mk2u2", "crane-mk3u1", "crane-mk3u2", "crane-mk3u3", "crane-mk3u4", "crane-mk3u5", "crane-mk3u6", "crane-mk3u7", "crane-mk4u1", "crane-mk4u2", "crane-mk4u3", "crane-mk4u4", "crane-mk4u5", "crane-mk4u6", "crane-mk4u7",
                "crane-short-mk1u1", "crane-short-mk1u2", "crane-short-mk2u1", "crane-short-mk2u2", "crane-short-mk3u1", "crane-short-mk3u2", "crane-short-mk3u3", "crane-short-mk3u4", "crane-short-mk3u5", "crane-short-mk3u6", "crane-short-mk3u7", "crane-short-mk4u1", "crane-short-mk4u2", "crane-short-mk4u3", "crane-short-mk4u4", "crane-short-mk4u5", "crane-short-mk4u6", "crane-short-mk4u7",
            },
        }
    }
    for i=0,32,1 do
        table.insert(to_hide["hidden"]["simple-entity-with-owner"], "solar-tower-panel"..i)
    end
    for i=1,4,1 do
        table.insert(to_hide["hidden"]["simple-entity-with-force"], "hawt-turbine-mk0"..i.."-collision")
        table.insert(to_hide["hidden"]["simple-entity-with-force"], "vawt-turbine-mk0"..i.."-collision")
    end
    for am=1,5,1 do
        for fm=1,5,1 do
            table.insert(to_hide["hidden_in_factoriopedia"]["beacon"], "beacon-AM"..am.."-FM"..fm)
            table.insert(to_hide["hidden_in_factoriopedia"]["beacon"], "diet-beacon-AM"..am.."-FM"..fm)
        end
    end
    if not mods["py_liquidfuel"] then
        table.insert(to_hide["hidden"]["fluid"], "combustion-mixture1")
        for i=1,3,1 do
            table.insert(to_hide["hidden"]["generator"], "gasturbinemk0"..i)
            table.insert(to_hide["hidden"]["item"], "gasturbinemk0"..i)
        end
    end
    for hide_type,category in pairs(to_hide) do
        for type,things in pairs(category) do
            for _,thing in pairs(things) do
                if data.raw[type][thing] then
                    data.raw[type][thing][hide_type] = true
                elseif debug_errors then
                    error("invalid thing name: "..thing)
                end
            end
        end
    end

    -- exceptional cases which didn't work automatically
    if data.raw["character-corpse"]["ulric-man-corpse"] then data.raw["character-corpse"]["ulric-man-corpse"].subgroup = "corpses" end
    if data.raw["ammo-category"]["caravan-control"] then data.raw["ammo-category"]["caravan-control"].subgroup = "ammo-category" end
    if data.raw["ammo-category"]["dragon-breath"] then data.raw["ammo-category"]["dragon-breath"].subgroup = "ammo-category" end
    if data.raw["ammo-category"]["ulric-infusion"] then data.raw["ammo-category"]["ulric-infusion"].subgroup = "ammo-category" end
    if data.raw["boiler"]["lrf-panel-mk01"] then data.raw["boiler"]["lrf-panel-mk01"].subgroup = "py-alternativeenergy-thermosolar" end
    if data.raw["resource"]["borax"] then data.raw["resource"]["borax"].subgroup = "py-rawores-borax" end
    if data.raw["resource"]["stone"] then data.raw["resource"]["stone"].subgroup = "py-rawores-natural-1" end

    -- TODO: Can resources be moved in factoriopedia or are they always stuck with their item versions if they share the same internal name? It would be nice to have them all visible from the environment tab or at least have them listed first in the materials tab
    --[[
    local resources = {
        {"ore-bioreserve", "00a"},
        {"stone", "00b"},
        {"oil-sand", "00c"},
        {"raw-coal", "00y"},
        {"coal", "00x"},
        {"iron-ore", "01x"},
        {"copper-ore", "02x"},
        {"ore-aluminium", "03x"},
        {"ore-tin", "04x"},
        {"ore-zinc", "05x"},
        {"ore-lead", "06x"},
        {"ore-titanium", "07x"},
        {"ore-nickel", "08x"},
        {"ore-chromium", "09x"},
        {"ore-quartz", "10x"},
        {"borax", "11b"},
        {"nexelit-ore", "11x"},
        {"ree", "13x"},
        {"molybdenum-ore", "14x"},
        {"ore-nexelit", "16x"},
        {"phosphate-rock", "17x"},
        {"uranium-ore", "18x"},
    }
    for _,resource in pairs(resources) do
        if data.raw["resource"][ resource[1] ] then
            data.raw["resource"][ resource[1] ].subgroup = "mineable-materials"
            data.raw["resource"][ resource[1] ].order = "zpy-item-"..resource[2]
        end
    end
    ]]

    -- ensures modded things in merged groups also get merged
    local merges = {
        ["enemies"] = {group="environment", order="zza"},
        ["tiles"] = {group="environment", order="zzb"},
        ["intermediate-products"] = {group="py-hightech", order="zza"},
        ["coal-processing"] = {group="py-hightech", order="zzb"},
        ["fusion-energy"] = {group="py-hightech", order="zzc"},
        ["py-alternativeenergy"] = {group="py-hightech", order="zzd"},
    }
    for _,subgroup in pairs(data.raw["item-subgroup"]) do
        for group,merge in pairs(merges) do
            if subgroup.group == group then
                subgroup.group = merge.group
                if not subgroup.order then subgroup.order = "" end
                subgroup.order = merge.order.."-"..group.."-"..subgroup.order
            end
        end
    end

end
