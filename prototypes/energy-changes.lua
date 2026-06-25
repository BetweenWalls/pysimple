--- energy-changes.lua

local module_info = {
    {modules={"vrauks", "vrauks-mk02", "vrauks-mk03", "vrauks-mk04"}, buildings={"vrauks-paddock-mk01", "vrauks-paddock-mk02", "vrauks-paddock-mk03", "vrauks-paddock-mk04"}},
    {modules={"auog", "auog-mk02", "auog-mk03", "auog-mk04"}, buildings={"auog-paddock-mk01", "auog-paddock-mk02", "auog-paddock-mk03", "auog-paddock-mk04"}},
    {modules={"cottongut-mk01", "cottongut-mk02", "cottongut-mk03", "cottongut-mk04"}, buildings={"prandium-lab-mk01", "prandium-lab-mk02", "prandium-lab-mk03", "prandium-lab-mk04"}},
    {modules={"ulric", "ulric-mk02", "ulric-mk03", "ulric-mk04"}, buildings={"ulric-corral-mk01", "ulric-corral-mk02", "ulric-corral-mk03", "ulric-corral-mk04"}},
    {modules={"arqad", "arqad-mk02", "arqad-mk03", "arqad-mk04"}, buildings={"arqad-hive-mk01", "arqad-hive-mk02", "arqad-hive-mk03", "arqad-hive-mk04"}},
    {modules={"korlex", "korlex-mk02", "korlex-mk03", "korlex-mk04"}, buildings={"ez-ranch-mk01", "ez-ranch-mk02", "ez-ranch-mk03", "ez-ranch-mk04"}},
    {modules={"mukmoux", "mukmoux-mk02", "mukmoux-mk03", "mukmoux-mk04"}, buildings={"mukmoux-pasture-mk01", "mukmoux-pasture-mk02", "mukmoux-pasture-mk03", "mukmoux-pasture-mk04"}},
    {modules={"phagnot", "phagnot-mk02", "phagnot-mk03", "phagnot-mk04"}, buildings={"phagnot-corral-mk01", "phagnot-corral-mk02", "phagnot-corral-mk03", "phagnot-corral-mk04"}},
    {modules={"arthurian", "arthurian-mk02", "arthurian-mk03", "arthurian-mk04"}, buildings={"arthurian-pen-mk01", "arthurian-pen-mk02", "arthurian-pen-mk03", "arthurian-pen-mk04"}},
    {modules={"scrondrix", "scrondrix-mk02", "scrondrix-mk03", "scrondrix-mk04"}, buildings={"scrondrix-pen-mk01", "scrondrix-pen-mk02", "scrondrix-pen-mk03", "scrondrix-pen-mk04"}},
    {modules={"dingrits", "dingrits-mk02", "dingrits-mk03", "dingrits-mk04"}, buildings={"dingrits-pack-mk01", "dingrits-pack-mk02", "dingrits-pack-mk03", "dingrits-pack-mk04"}},
    {modules={"kmauts", "kmauts-mk02", "kmauts-mk03", "kmauts-mk04"}, buildings={"kmauts-enclosure-mk01", "kmauts-enclosure-mk02", "kmauts-enclosure-mk03", "kmauts-enclosure-mk04"}},
    {modules={"phadai", "phadai-mk02", "phadai-mk03", "phadai-mk04"}, buildings={"phadai-enclosure-mk01", "phadai-enclosure-mk02", "phadai-enclosure-mk03", "phadai-enclosure-mk04"}},
    {modules={"simik", "simik-mk02", "simik-mk03", "simik-mk04"}, buildings={"simik-den-mk01", "simik-den-mk02", "simik-den-mk03", "simik-den-mk04"}},
    {modules={"vonix", "vonix-mk02", "vonix-mk03", "vonix-mk04"}, buildings={"vonix-den-mk01", "vonix-den-mk02", "vonix-den-mk03", "vonix-den-mk04"}},
    {modules={"zungror", "zungror-mk02", "zungror-mk03", "zungror-mk04"}, buildings={"zungror-lair-mk01", "zungror-lair-mk02", "zungror-lair-mk03", "zungror-lair-mk04"}},
    {modules={"xeno", "xeno-mk02", "xeno-mk03", "xeno-mk04"}, buildings={"xenopen-mk01", "xenopen-mk02", "xenopen-mk03", "xenopen-mk04"}},
    {modules={"zipir1", "zipir2", "zipir3", "zipir4"}, buildings={"zipir-reef-mk01", "zipir-reef-mk02", "zipir-reef-mk03", "zipir-reef-mk04"}},
    {modules={"trits", "trits-mk02", "trits-mk03", "trits-mk04"}, buildings={"trits-reef-mk01", "trits-reef-mk02", "trits-reef-mk03", "trits-reef-mk04"}},
    {modules={"xyhiphoe", "xyhiphoe-mk02", "xyhiphoe-mk03", "xyhiphoe-mk04"}, buildings={"xyhiphoe-pool-mk01", "xyhiphoe-pool-mk02", "xyhiphoe-pool-mk03", "xyhiphoe-pool-mk04"}},
    {modules={"dhilmos", "dhilmos-mk02", "dhilmos-mk03", "dhilmos-mk04"}, buildings={"dhilmos-pool-mk01", "dhilmos-pool-mk02", "dhilmos-pool-mk03", "dhilmos-pool-mk04"}},
    {modules={"numal", "numal-mk02", "numal-mk03", "numal-mk04"}, buildings={"numal-reef-mk01", "numal-reef-mk02", "numal-reef-mk03", "numal-reef-mk04"}},
    {modules={"fish", "fish-mk02", "fish-mk03", "fish-mk04"}, buildings={"fish-farm-mk01", "fish-farm-mk02", "fish-farm-mk03", "fish-farm-mk04"}},
    {modules={"sea-sponge", "sea-sponge-mk02", "sea-sponge-mk03", "sea-sponge-mk04"}, buildings={"sponge-culture-mk01", "sponge-culture-mk02", "sponge-culture-mk03", "sponge-culture-mk04"}},
    {modules={"moss", "moss-mk02", "moss-mk03", "moss-mk04"}, buildings={"moss-farm-mk01", "moss-farm-mk02", "moss-farm-mk03", "moss-farm-mk04"}},
    {modules={"seaweed", "seaweed-mk02", "seaweed-mk03", "seaweed-mk04"}, buildings={"seaweed-crop-mk01", "seaweed-crop-mk02", "seaweed-crop-mk03", "seaweed-crop-mk04"}},
    {modules={"tree-mk01", "tree-mk02", "tree-mk03", "tree-mk04"}, buildings={"fwf-mk01", "fwf-mk02", "fwf-mk03", "fwf-mk04"}},
    {modules={"sap-tree", "sap-tree-mk02", "sap-tree-mk03", "sap-tree-mk04"}, buildings={"sap-extractor-mk01", "sap-extractor-mk02", "sap-extractor-mk03", "sap-extractor-mk04"}},
    {modules={"moondrop", "moondrop-mk02", "moondrop-mk03", "moondrop-mk04"}, buildings={"moondrop-greenhouse-mk01", "moondrop-greenhouse-mk02", "moondrop-greenhouse-mk03", "moondrop-greenhouse-mk04"}},
    {modules={"ralesia", "ralesia-mk02", "ralesia-mk03", "ralesia-mk04"}, buildings={"ralesia-plantation-mk01", "ralesia-plantation-mk02", "ralesia-plantation-mk03", "ralesia-plantation-mk04"}},
    {modules={"fawogae", "fawogae-mk02", "fawogae-mk03", "fawogae-mk04"}, buildings={"fawogae-plantation-mk01", "fawogae-plantation-mk02", "fawogae-plantation-mk03", "fawogae-plantation-mk04"}},
    {modules={"tuuphra", "tuuphra-mk02", "tuuphra-mk03", "tuuphra-mk04"}, buildings={"tuuphra-plantation-mk01", "tuuphra-plantation-mk02", "tuuphra-plantation-mk03", "tuuphra-plantation-mk04"}},
    {modules={"kicalk", "kicalk-mk02", "kicalk-mk03", "kicalk-mk04"}, buildings={"kicalk-plantation-mk01", "kicalk-plantation-mk02", "kicalk-plantation-mk03", "kicalk-plantation-mk04"}},
    {modules={"yaedols", "yaedols-mk02", "yaedols-mk03", "yaedols-mk04"}, buildings={"yaedols-culture-mk01", "yaedols-culture-mk02", "yaedols-culture-mk03", "yaedols-culture-mk04"}},
    {modules={"rennea", "rennea-mk02", "rennea-mk03", "rennea-mk04"}, buildings={"rennea-plantation-mk01", "rennea-plantation-mk02", "rennea-plantation-mk03", "rennea-plantation-mk04"}},
    {modules={"yotoi", "yotoi-mk02", "yotoi-mk03", "yotoi-mk04"}, buildings={"yotoi-aloe-orchard-mk01", "yotoi-aloe-orchard-mk02", "yotoi-aloe-orchard-mk03", "yotoi-aloe-orchard-mk04"}},
    {modules={"navens", "navens-mk02", "navens-mk03", "navens-mk04"}, buildings={"navens-culture-mk01", "navens-culture-mk02", "navens-culture-mk03", "navens-culture-mk04"}},
    {modules={"grod", "grod-mk02", "grod-mk03", "grod-mk04"}, buildings={"grods-swamp-mk01", "grods-swamp-mk02", "grods-swamp-mk03", "grods-swamp-mk04"}},
    {modules={"cadaveric-arum", "cadaveric-arum-mk02-a", "cadaveric-arum-mk03-a", "cadaveric-arum-mk04-a"}, buildings={"cadaveric-arum-mk01", "cadaveric-arum-mk02", "cadaveric-arum-mk03", "cadaveric-arum-mk04"}},
    {modules={"guar", "guar-mk02", "guar-mk03", "guar-mk04"}, buildings={"guar-gum-plantation", "guar-gum-plantation-mk02", "guar-gum-plantation-mk03", "guar-gum-plantation-mk04"}},
    {modules={"py-sawblade-module-mk01", "py-sawblade-module-mk02", "py-sawblade-module-mk03", "py-sawblade-module-mk04"}, buildings={"wpu-mk01-turd", "wpu-mk02-turd", "wpu-mk03-turd", "wpu-mk04-turd"}},
}

if settings.startup["pysimple-energy"].value then
    for _,info in pairs(module_info) do -- makes higher tier modules' electricity consumption match the production they provide
        local modules = info.modules
        if data.raw.module[modules[1]] and data.raw.module[modules[2]] and data.raw.module[modules[4]] and data.raw["assembling-machine"][info.buildings[4]] then
            local base_t4 = data.raw["assembling-machine"][info.buildings[4]].crafting_speed * data.raw.module[modules[1]].effect.speed * ((data.raw.module[modules[1]].effect.productivity or 0)+1)
            local min_t4 = base_t4 + data.raw["assembling-machine"][info.buildings[4]].crafting_speed * data.raw.module[modules[1]].effect.speed * ((data.raw.module[modules[1]].effect.productivity or 0)+1) * data.raw["assembling-machine"][info.buildings[4]].module_slots
            local max_t4 = base_t4 + data.raw["assembling-machine"][info.buildings[4]].crafting_speed * data.raw.module[modules[4]].effect.speed * ((data.raw.module[modules[4]].effect.productivity or 0)+1) * data.raw["assembling-machine"][info.buildings[4]].module_slots
            local desired_energy = ((max_t4/min_t4) / data.raw["assembling-machine"][info.buildings[4]].module_slots)/3
            for t=2,4 do
                data.raw.module[modules[t]].effect.consumption = math.max((t-1)*math.floor(100*desired_energy)/100, (t-1)*0.01)
            end
        end
    end
    data.raw.module["dingrits-alpha"].effect.consumption = data.raw.module["dingrits-mk04"].effect.consumption
end
