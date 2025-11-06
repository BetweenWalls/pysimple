--- drawing-box-extensions.lua

local tiered_buildings = {
    ["mining-drill"] = {
        ["fluid-drill-mk0"] = 1.6,
        ["natural-gas-derrick-mk0"] = 1.9,
    },
    ["assembling-machine"] = {
        ["prandium-lab-mk0"] = 0.2,
        ["ulric-corral-mk0"] = 0.8,
        ["arqad-hive-mk0"] = 2.3,
        ["phagnot-corral-mk0"] = 0.2,
        ["scrondrix-pen-mk0"] = 1.1,
        ["phadai-enclosure-mk0"] = 0.8,
        ["vonix-den-mk0"] = 2.3,
        ["zungror-lair-mk0"] = 2.5,
        ["xenopen-mk0"] = 0.1,
        ["trits-reef-mk0"] = 4,
        ["xyhiphoe-pool-mk0"] = 1,
        ["moss-farm-mk0"] = 1.1,
        ["sap-extractor-mk0"] = 0.1,
        ["tuuphra-plantation-mk0"] = 0.1,
        ["bhoddos-culture-mk0"] = 0.1,
        ["cridren-enclosure-mk0"] = 0.2,
        ["bio-printer-mk0"] = 1.9,
        ["biofactory-mk0"] = 0.3,
        ["micro-mine-mk0"] = 1.4,
        ["genlab-mk0"] = 1.6,
        ["research-center-mk0"] = 5,
        ["neutron-absorber-mk0"] = 2.5,
        ["neutron-moderator-mk0"] = 2.4,
        ["py-biomass-powerplant-mk0"] = 3,
        ["py-coal-powerplant-mk0"] = 4,
        ["py-gas-powerplant-mk0"] = 3.5,
        ["py-oil-powerplant-mk0"] = 8.5,
        ["soil-extractor-mk0"] = 0.5,
        ["coalbed-mk0"] = 1.4,
        ["spore-collector-mk0"] = 2.5,
        ["tholin-atm-mk0"] = 11.5,
        ["automated-screener-mk0"] = 0.2,
        ["advanced-foundry-mk0"] = 1.3,
        ["bof-mk0"] = 1,
        ["eaf-mk0"] = 0.5,
        ["smelter-mk0"] = 2.7,
        ["classifier-mk0"] = 0.4,
        ["grease-table-mk0"] = 1.2,
        ["scrubber-mk0"] = 1.9,
        ["wet-scrubber-mk0"] = 3.8,
        ["thickener-mk0"] = 0.4,
        ["hydrocyclone-mk0"] = 1.7,
        ["wpu-mk0"] = 1.8,
        ["hpf-mk0"] = 2.8,
        ["washer-mk0"] = 0.5,
        ["pulp-mill-mk0"] = 2,
        ["solid-separator-mk0"] = 1.2,
        ["centrifuge-mk0"] = 1.6,
        ["vacuum-pump-mk0"] = 0.8,
        ["distilator-mk0"] = 2.2,
        ["fluid-separator-mk0"] = 0.4,
        ["quenching-tower-mk0"] = 0.4,
        ["methanol-reactor-mk0"] = 0.9,
        ["olefin-plant-mk0"] = 0.4,
        ["fts-reactor-mk0"] = 6,
        ["reformer-mk0"] = 9.5,
        ["lor-mk0"] = 1.2,
        ["heavy-oil-refinery-mk0"] = 3,
        ["gas-refinery-mk0"] = 2,
        ["automated-factory-mk0"] = 0.8,
        ["electronics-factory-mk0"] = 0.6,
        ["chipshooter-mk0"] = 2.9,
        ["chemical-plant-mk0"] = 1.9,
        ["fbreactor-mk0"] = 1,
        ["gas-separator-mk0"] = 0.5,
        ["upgrader-mk0"] = 3.2,
        ["tholin-plant-mk0"] = 2.8,
    },
    ["furnace"] = {
        ["compost-plant-mk0"] = 4.3,
    },
    ["simple-entity-with-owner"] = {
        ["solar-tower-panel"] = 1.1,
    }
}
local untiered_buildings = {
    ["mining-drill"] = {
        ["coal-mine"] = 0.3,
        ["aluminium-mine"] = 5.5,
        ["mo-mine"] = 0.7,
        ["uranium-mining-drill"] = 2.3,
        ["uranium-mine"] = 0.4,
        ["geothermal-plant-mk01"] = 3.6,
        ["oil-derrick-mk01"] = 0.2,
        ["oil-derrick-mk02"] = 5.3,
        ["oil-derrick-mk03"] = 7.4,
        ["oil-derrick-mk04"] = 1.3,
    },
    ["assembling-machine"] = {
        ["classifier"] = 0.4,
        ["hpf"] = 2.8,
        ["washer"] = 0.5,
        ["solid-separator"] = 1.2,
        ["distilator"] = 2.2,
        ["fluid-separator"] = 0.4,
        ["quenching-tower"] = 0.4,
        ["methanol-reactor"] = 0.9,
        ["olefin-plant"] = 0.4,
        ["fts-reactor"] = 6,
        ["data-array"] = 1,
        ["simik-boiler"] = 4,
        ["dino-dig-site"] = 1.4,
        ["antelope-enclosure-mk01"] = 4.5,
        ["bioport"] = 2.9,
        ["vat-brain"] = 2.2,
        ["py-electric-boiler"] = 3.4,
        ["rhe"] = 1,
        ["py-rtg"] = 0.2,
        ["lrf-building-mk01"] = 1.5,
        ["fracking-rig"] = 1.8,
        ["drp"] = 3.6,
        ["sinter-unit"] = 3.3,
        ["cooling-tower-mk01"] = 0.5,
        ["cooling-tower-mk02"] = 1.8,
        ["pumpjack-mk02"] = 1,
        ["pumpjack-mk03"] = 2.1,
        ["pumpjack-mk04"] = 0.5,
        ["nuclear-reactor-mk01"] = 5,
        ["nuclear-reactor-mk02"] = 3.8,
        ["nuclear-reactor-mk03"] = 1.8,
        ["nuclear-reactor-mk04"] = 0.2,
        ["nuclear-reactor-mox-mk01"] = 5,
        ["nuclear-reactor-mox-mk02"] = 3.8,
        ["nuclear-reactor-mox-mk03"] = 1.8,
        ["nuclear-reactor-mox-mk04"] = 0.2,
        ["wpu-mk01-turd"] = 1.8,
        ["wpu-mk02-turd"] = 1.8,
        ["wpu-mk03-turd"] = 1.8,
        ["wpu-mk04-turd"] = 1.8,
    },
    ["furnace"] = {
        ["barrel-machine-mk01"] = 2,
        ["py-gas-vent"] = 3.9,
        ["py-burner"] = 2.1,
        ["co2-absorber"] = 0.2,
        ["compost-plant-mk01-turd"] = 4.3,
        ["compost-plant-mk02-turd"] = 4.3,
        ["compost-plant-mk03-turd"] = 4.3,
        ["compost-plant-mk04-turd"] = 4.3,
    },
    ["boiler"] = {
        ["oil-boiler-mk01"] = 2.7,
        ["lrf-panel-mk01"] = 0.8,
        ["stirling-concentrator"] = 2.4,
        ["solar-tower-building"] = 17.3,
    },
    ["storage-tank"] = {
        ["py-tank-1000"] = 6.2,
        ["py-tank-1500"] = 1,
        ["py-tank-4000"] = 2.7,
        ["py-tank-7000"] = 0.7,
        ["py-tank-5000"] = 6,
        ["py-tank-6500"] = 0.5,
        ["py-tank-8000"] = 0.9,
        ["py-tank-9000"] = 1.3,
        ["py-tank-10000"] = 0.4,
        ["tailings-pond"] = 0.5,
        ["outpost-fluid"] = 0.4,
    },
    ["container"] = {
        ["py-storehouse-basic"] = 0.7,
        ["py-deposit-basic"] = 0.3,
        ["outpost"] = 0.4,
        ["outpost-aerial"] = 1.4,
    },
    ["logistic-container"] = {
        ["py-storehouse-storage"] = 0.7,
        ["py-storehouse-passive-provider"] = 0.7,
        ["py-storehouse-requester"] = 0.7,
        ["py-storehouse-buffer"] = 0.7,
        ["py-storehouse-active-provider"] = 0.7,
        ["py-deposit-storage"] = 0.3,
        ["py-deposit-passive-provider"] = 0.3,
        ["py-deposit-requester"] = 0.3,
        ["py-deposit-buffer"] = 0.3,
        ["py-deposit-active-provider"] = 0.3,
    },
    ["linked-container"] = {
        ["wyrmhole"] = 1.6,
    },
    ["roboport"] = {
        ["py-recharge-station-mk01"] = 2.8,
        ["py-roboport-mk02"] = 2,
        ["py-ze"] = 4.4,
        ["py-ze-mk02"] = 4.7,
        ["py-ze-mk03"] = 3.8,
        ["py-ze-mk04"] = 2.2,
    },
    ["accumulator"] = {
        ["accumulator-mk01"] = 2.2,
        ["accumulator-mk02"] = 2.5,
        ["accumulator-mk03"] = 2.8,
    },
    ["radar"] = {
        ["py-local-radar"] = 0.5,
        ["radar"] = 0.5,
        ["megadar"] = 1.9,
    },
    ["constant-combinator"] = {
        ["aerial-base-combinator"] = 1.2,
    },
    ["burner-generator"] = {
        ["py-rtg"] = 0.5,
    },
    ["generator"] = {
        ["steam-turbine-mk02"] = 2.8,
        ["steam-turbine-mk04"] = 2,
        ["mdh"] = 1.3,
    },
    ["solar-panel"] = {
        ["solar-panel-mk01"] = 1.3,
        ["solar-panel-mk04"] = 0.2,
    },
    ["electric-energy-interface"] = {
        ["solar-panel-mk02"] = 3,
        ["solar-panel-mk03"] = 1,
        ["vawt-turbine-mk01"] = 4,
        ["vawt-turbine-mk02"] = 2,
        ["vawt-turbine-mk03"] = 4,
        ["vawt-turbine-mk04"] = 12,
        ["microwave-receiver"] = 4.6,
        ["sut"] = 16.5,
        -- Note: Multiblade turbines and HAWTs don't display properly in the drawing box or factoriopedia (the rotating turbine part is missing)
    },
    ["electric-pole"] = {
        ["nexelit-power-pole"] = 1.7,
        ["nexelit-substation"] = 0.8,
    },
    ["rocket-silo"] = {
        ["mega-farm"] = 1.7,
    },
    ["cargo-wagon"] = {
        ["mk04-wagon"] = 1,
    },
    ["fluid-wagon"] = {
        ["mk04-fluid-wagon"] = 1,
    },
}

if settings.startup["pysimple-graphics"].value then
    for kind,buildings in pairs(tiered_buildings) do
        for name,extension in pairs(buildings) do
            local min = 1
            local max = 4
            if kind == "simple-entity-with-owner" then
                min = 0
                max = 32
            end
            for i=min,max do
                if data.raw[kind][name..i] then
                    data.raw[kind][name..i].drawing_box_vertical_extension = extension
                end
            end
        end
    end
    for kind,buildings in pairs(untiered_buildings) do
        for name,extension in pairs(buildings) do
            if data.raw[kind][name] and extension > 0 then
                data.raw[kind][name].drawing_box_vertical_extension = extension
            end
        end
    end
end