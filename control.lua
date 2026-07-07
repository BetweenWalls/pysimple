--- control.lua

script.on_init(
  function()
    initialize()
  end
)
script.on_configuration_changed(
  function()
    initialize()
  end
)

--- Saves settings and handles recharting, tech validation, and clearing turd notifications
function initialize()
  if not storage.graphics then
    storage = { graphics = {}, version = 1 }
    storage.graphics = settings.startup["pysimple-graphics"].value
    rechart()
  end
  if storage.graphics ~= settings.startup["pysimple-graphics"].value then
    rechart()
  end
  if not storage.version then
    storage.version = 1
    rechart()
  end
  if storage.version ~= 1 then
    storage.version = 1
    rechart()
  end
  storage.graphics = settings.startup["pysimple-graphics"].value
  validate_technology_effects()
  clear_notifications()
end

--- Updates map colors
function rechart()
  for _,force in pairs(game.forces) do
    for _,surface in pairs(game.surfaces) do
      force.rechart(surface)
    end
  end
end

--- Enables recipes which should be enabled but aren't due to technology changes and clears notifications for turd recipes
function validate_technology_effects()
  local altered_techs = {
    "coal-processing-1",
    "steel-processing",
    "crusher",
    "concrete",
    "mining-with-fluid",
    "tar-processing",
    "acetylene",
    "moondrop",
    "solder-mk01",
    "moondrop",
    "wood-processing",
    "fluid-pressurization",
    "vacuum-tube-electronics",
    "electronics",
    "hot-air-mk01",
    "fluid-processing-machines-1",
    "military",
    "blueprint-shotgun",
    "niobium",
    "coal-processing-3",
    "bioprocessing",
    "light-oil-mk02",
    "chemical-science-pack",
    "uranium-processing",
    "epoxy",
    "collagen",
    "salts",
    "additives",
    "nonrenewable-mk01",
    "nonrenewable-mk02",
    "nonrenewable-mk03",
    "nonrenewable-mk04",
  }
  for _,force in pairs(game.forces) do
    for _,tech in pairs(altered_techs) do
      if force.technologies[tech] and force.technologies[tech].researched then
        for _,effect in pairs(force.technologies[tech].prototype.effects) do
          if effect.type == "unlock-recipe" and force.recipes[effect.recipe] and not force.recipes[effect.recipe].enabled then
            if not (effect.recipe == "fwf-mk01" or effect.recipe == "log3" or effect.recipe == "fiber-01") then -- these recipes could be replaced with TURDs and be intentionally inaccessible
              force.recipes[effect.recipe].enabled = true
            end
          end
        end
      end
    end
  end
end

-- Clears notifications for turds
function clear_notifications()
  local turd_recipes = {
    "arqad-egg-1-cold", "arqad-egg-2-cold", "arqad-egg-3-cold", "arqad-egg-4-cold", "arqad-egg-5-cold", "wax-buffed", "wax-to-lube-buffed", "honey-comb-buffed", "cags", "arqad-hive-mk01-with-cags", "arqad-hive-mk02-with-cags", "arqad-hive-mk03-with-cags", "arqad-hive-mk04-with-cags", "ez-queen",
    "abacus", "arthurian-maturing-1-abacus", "arthurian-maturing-2-abacus", "arthurian-maturing-3-abacus", "arthurian-maturing-4-abacus", "arthurian-egg-1-hot-stones", "arthurian-egg-2-hot-stones", "arthurian-egg-3-hot-stones", "arthurian-egg-4-hot-stones", "arthurian-cannibalism",
    "venom-gland-to-dynemicin", "cognition-osteochain-to-kondo-substrate", "dimensional-gastricorg-to-inverse-opal",
    "auog-food-01-sawdust", "auog-food-01-sawdust", "auog-recharge-glowing-mushroom-mk01", "auog-recharge-glowing-mushroom-mk02", "auog-recharge-glowing-mushroom-mk03", "auog-recharge-glowing-mushroom-mk04", "auog-paddock-mk01-with-dirt", "auog-paddock-mk02-with-dirt", "auog-paddock-mk03-with-dirt", "auog-paddock-mk04-with-dirt",
    "bhoddos-1-meltdown", "bhoddos-2-meltdown", "bhoddos-3-meltdown", "bhoddos-4-meltdown", "bhoddos-1-exoenzymes", "bhoddos-2-exoenzymes", "bhoddos-3-exoenzymes", "bhoddos-4-exoenzymes", "bhoddos-spore-upgraded", "sporopollenin-gills", "biomass-sporopollenin-nerfed",
    "naphtha-arqad", "carbon-black-phytoplankton", "nanofibrils-xyhiphoe",
    "bio-scafold-with-lamp", "bio-scafold-2-with-lamp", "bio-scafold-3-with-lamp", "bio-scafold-4-with-lamp", "bio-printer-mk01-yag", "bio-printer-mk02-yag", "bio-printer-mk03-yag", "bio-printer-mk04-yag", "stem-cell-recycle-1", "stem-cell-recycle-2", "stem-cell-recycle-3",
    "path-1-advanced-recipe", "path-2-advanced-recipe", "path-3-advanced-recipe",
    "cadaveric-arum-1-soil", "cadaveric-arum-2-soil", "cadaveric-arum-3-soil", "cadaveric-arum-4-soil", "cadaveric-arum-mk01-with-nanofibrils", "cadaveric-arum-mk02-with-nanofibrils", "cadaveric-arum-mk03-with-nanofibrils", "cadaveric-arum-mk04-with-nanofibrils", "cadaveric-arum-1-msa", "cadaveric-arum-2-msa", "cadaveric-arum-3-msa", "cadaveric-arum-4-msa",
    "fine-powdered-biomass-irragration", "compost-plant-mk01-with-pump", "compost-plant-mk02-with-pump", "compost-plant-mk03-with-pump", "compost-plant-mk04-with-pump", "cheap-retrovirus", "biomass-destruction", "worm", "worm-stone", "worm-wood", "worm-coarse", "worm-manure",
    "cottongut-science-red-seeds-80-20", "cottongut-science-green-seeds-80-20", "cottongut-science-blue-seeds-80-20", "cottongut-science-py-seeds-80-20", "cottongut-science-prod-seeds-80-20", "denatured-seismite-2-80-20", "cottongut-food-03", "caged-cottongut-1-cannibal", "caged-cottongut-2-cannibal", "caged-cottongut-3-cannibal", "caged-cottongut-4-cannibal", "prandium-lab-mk01-ultrasound", "prandium-lab-mk02-ultrasound", "prandium-lab-mk03-ultrasound", "prandium-lab-mk04-ultrasound",
    "fluidflyavan-earth-sample-turd", "caravan-earth-sample-turd", "fluidavan-earth-sample-turd", "flyavan-earth-sample-turd", "nukavan-earth-sample-turd", "ocula-earth-sample-turd", "digosaurus-earth-sample-turd", "thikat-earth-sample-turd", "work-o-dile-earth-sample-turd", "crawdad-earth-sample-turd", "dingrido-earth-sample-turd", "spidertron-earth-sample-turd", "phadaisus-earth-sample-turd", "bioport-earth-sample-turd", "provider-tank-earth-sample-turd", "requester-tank-earth-sample-turd", "vessel-earth-sample-turd", "vessel-to-ground-earth-sample-turd", "gobachov-earth-sample-turd", "huzu-earth-sample-turd", "chorkok-earth-sample-turd",
    "vrauks-earth-sample-turd", "auog-earth-sample-turd", "cottongut-earth-sample-turd", "ulric-earth-sample-turd", "arqad-earth-sample-turd", "korlex-earth-sample-turd", "mukmoux-earth-sample-turd", "phagnot-earth-sample-turd", "arthurian-earth-sample-turd", "scrondrix-earth-sample-turd", "dingrits-earth-sample-turd", "phadai-earth-sample-turd", "simik-earth-sample-turd", "vonix-earth-sample-turd", "zungror-earth-sample-turd", "xeno-earth-sample-turd", "antelope-earth-sample-turd", "zipir1-earth-sample-turd", "trits-earth-sample-turd", "xyhiphoe-earth-sample-turd", "dhilmos-earth-sample-turd", "numal-earth-sample-turd", "sea-sponge-earth-sample-turd",
    "creature-chamber-mk01-arthurian", "creature-chamber-mk02-arthurian", "creature-chamber-mk03-arthurian", "creature-chamber-mk04-arthurian", "digosaurus-turd", "thikat-turd", "work-o-dile-turd", "caravan-turd", "flyavan-turd", "nukavan-turd", "fluidavan-turd", "fluidflyavan-turd", "digosaurus-convert-from-base", "thikat-convert-from-base", "work-o-dile-convert-from-base", "caravan-convert-from-base", "flyavan-convert-from-base", "nukavan-convert-from-base", "fluidavan-convert-from-base", "fluidflyavan-convert-from-base",
    "cridren-sixth-layer-ethylene-chlorohydrin", "cridren-sixth-layer-organic-acid-anhydride", "cridren-1-neural-cranio", "cridren-2-neural-cranio", "cridren-3-neural-cranio", "cridren-4-neural-cranio", "cridren-enclosure-mk01-with-mufflers", "cridren-enclosure-mk02-with-mufflers", "cridren-enclosure-mk03-with-mufflers", "cridren-enclosure-mk04-with-mufflers",
    "earth-generic-sample-duplication", "solar-panel-equipment-cheap", "data-array-with-solar",
    "dhilmos-1-cover", "dhilmos-2-cover", "dhilmos-3-cover", "dhilmos-4-cover", "dhilmos-1-skimmer", "dhilmos-2-skimmer", "dhilmos-3-skimmer", "dhilmos-4-skimmer", "dhilmos-egg-1-skimmer", "dhilmos-egg-2-skimmer", "dhilmos-egg-3-skimmer", "dhilmos-egg-4-skimmer", "dhilmos-1-double-intake", "dhilmos-2-double-intake", "dhilmos-3-double-intake", "dhilmos-4-double-intake",
    "dingrits-alpha", "snarer-heart-mutation", "space-suit-mutation", "space-dingrit-mutation", "dingrits-1-training", "dingrits-2-training", "dingrits-3-training", "dingrits-4-training",
    "fiber-dry-storage", "log-wood-fast", "fwf-mk01-with-furnace", "log3-cheap", "log6-cheap",
    "fawogae-1-nitrogen", "fawogae-2-nitrogen", "fawogae-3-nitrogen", "fawogae-4-nitrogen", "fawogae-5-nitrogen", "acid-gas-fawogae", "fawogae-sample-with-xeno-codex", "fawogae-mk02-with-xeno-codex", "fawogae-mk03-with-xeno-codex", "fawogae-mk04-with-xeno-codex", "coal-fawogae-buffed", "fawogae-plantation-mk01-with-pressure-pump", "fawogae-plantation-mk02-with-pressure-pump", "fawogae-plantation-mk03-with-pressure-pump", "fawogae-plantation-mk04-with-pressure-pump",
    "breed-fish-1-agressive-selection", "breed-fish-2-agressive-selection", "breed-fish-3-agressive-selection", "breed-fish-4-agressive-selection", "fish-hydrolysate-cooling", "cyanic-acid-from-fish-hydrolysate", "breed-fish-egg-1-doused", "breed-fish-egg-2-doused", "breed-fish-egg-3-doused", "breed-fish-egg-4-doused",
    "adam42-gen-laser", "enzyme-pks-nickel-carbonyl", "hmas-pvp",
    "grod-1-pressured", "grod-2-pressured", "grod-3-pressured", "grod-4-pressured", "grod-al-tailings", "grod-pb-tailings", "grod-sn-tailings", "grod-al-2-tailings", "grod-pb-2-tailings", "grod-sn-2-tailings", "grod-al-3-tailings", "grod-pb-3-tailings", "grod-sn-3-tailings", "grod-seeds-heavy-water", "grod-1-dry", "grod-2-dry", "grod-3-dry", "grod-4-dry",
    "alcl3", "fungicide", "guar-1-guarpulse", "guar-2-guarpulse", "guar-3-guarpulse", "guar-4-guarpulse", "guar-1-aquaguar", "guar-2-aquaguar", "guar-3-aquaguar", "guar-4-aquaguar", "guar-gum-plantation-with-bots", "guar-gum-plantation-mk02-with-bots", "guar-gum-plantation-mk03-with-bots", "guar-gum-plantation-mk04-with-bots",
    "manure-bacteria-fish", "zogna-bacteria-darkness", "bio-sample-icd",
    "biomass-kicalk-dry", "kicalk-dry-bedding", "heating-system-cheap", "kicalk-plantation-mk01-with-mesh", "kicalk-plantation-mk02-with-mesh", "kicalk-plantation-mk03-with-mesh", "kicalk-plantation-mk04-with-mesh", "kicalk-1-dry", "kicalk-2-dry", "kicalk-3-dry", "kicalk-4-dry", "kicalk-5-dry", "kicalk-1-saline", "kicalk-2-saline", "kicalk-3-saline", "kicalk-4-saline", "kicalk-5-saline", "kicalk-1-rotation", "kicalk-2-rotation", "kicalk-3-rotation", "kicalk-4-rotation", "kicalk-5-rotation",
    "kmauts-cub-1-ratio", "kmauts-cub-2-ratio", "kmauts-cub-3-ratio", "kmauts-cub-4-ratio", "kmauts-1-ratio", "kmauts-2-ratio", "kmauts-3-ratio", "kmauts-4-ratio", "kmauts-cub-1-eye-out", "kmauts-cub-2-eye-out", "kmauts-cub-3-eye-out", "kmauts-cub-4-eye-out", "kmauts-ration-chitin",
    "korlex-milk-1-doubled", "korlex-milk-2-doubled", "korlex-milk-3-doubled", "korlex-milk-4-doubled", "korlex-1-slowed", "korlex-2-slowed", "korlex-3-slowed", "korlex-4-slowed", "kimberlite-into-lime", "korlex-milk-1-pressured", "korlex-milk-2-pressured", "korlex-milk-3-pressured", "korlex-milk-4-pressured", "ez-ranch-mk01-with-nexelit", "ez-ranch-mk02-with-nexelit", "ez-ranch-mk03-with-nexelit", "ez-ranch-mk04-with-nexelit",
    "moondrop-1-cu", "moondrop-2-cu", "moondrop-3-cu", "moondrop-4-cu", "moondrop-5-cu", "methane-co2-with-lamp", "moondrop-co2",
    "chlorinated-water", "Moss-1-chlorinated", "Moss-2-chlorinated", "Moss-3-chlorinated", "Moss-4-chlorinated", "Moss-1-without-sludge", "Moss-2-without-sludge", "Moss-3-without-sludge", "Moss-4-without-sludge", "unrefine-refsyngas", "unrefine-refined-natural-gas", "moss-farm-mk01-with-bioreactor", "moss-farm-mk02-with-bioreactor", "moss-farm-mk03-with-bioreactor", "moss-farm-mk04-with-bioreactor", "Moss-1-without-sludge-for-real", "Moss-2-without-sludge-for-real", "Moss-3-without-sludge-for-real", "Moss-4-without-sludge-for-real",
    "artifical-insemination", "mukmoux-1-bip", "mukmoux-2-bip", "mukmoux-3-bip", "mukmoux-4-bip", "mukmoux-manure-1-mukmoux-turd", "mukmoux-manure-2-mukmoux-turd", "mukmoux-manure-3-mukmoux-turd", "mukmoux-manure-4-mukmoux-turd", "mukmoux-pasture-mk01-with-electronics", "mukmoux-pasture-mk02-with-electronics", "mukmoux-pasture-mk03-with-electronics", "mukmoux-pasture-mk04-with-electronics", "mukmoux-calf-1-microchip", "mukmoux-calf-2-microchip", "mukmoux-calf-3-microchip", "mukmoux-calf-4-microchip",
    "pre-pesticide-01-navens", "navens-sample-with-vonix-gen", "navens-spore-sterilization", "navens-spore-mk02-sterilization", "navens-spore-mk03-sterilization", "navens-spore-mk04-sterilization", "full-render-navens-abomination", "navens-1-abomination", "navens-2-abomination", "navens-3-abomination", "navens-4-abomination",
    "aeroorgan-ink", "aeroorgan-buffed", "numal-raising-1-deuterium", "numal-neutron", "numal-mk02-neutron", "numal-mk03-neutron", "numal-mk04-neutron", "numal-egg-1-neutron", "numal-egg-2-neutron", "numal-egg-3-neutron", "numal-egg-4-neutron", "numal-egg-5-neutron", "numal-egg-6-neutron", "ex-gut-num-neodymium",
    "energy-drinkb", "Phadai-Dance-Dance-Revolution-1-piezoelectric", "Phadai-Dance-Dance-Revolution-2-piezoelectric",  "Phadai-Dance-Dance-Revolution-3-piezoelectric",  "Phadai-Dance-Dance-Revolution-4-piezoelectric", "Phadai-Dance-Dance-Revolution-1-dubstep", "Phadai-Dance-Dance-Revolution-2-dubstep",  "Phadai-Dance-Dance-Revolution-3-dubstep",  "Phadai-Dance-Dance-Revolution-4-dubstep",
    "gas-bladder-to-deuterium", "gas-bladder-to-dry-gas-stream", "phagnot-cub-1-fast", "phagnot-cub-2-fast", "phagnot-cub-3-fast", "phagnot-cub-4-fast", "phagnot-1-kicalk", "phagnot-2-kicalk", "phagnot-3-kicalk", "phagnot-4-kicalk", "phagnot-cub-1-kicalk", "phagnot-cub-2-kicalk", "phagnot-cub-3-kicalk", "phagnot-cub-4-kicalk", "phagnot-food-01-kicalk", "phagnot-food-02-kicalk",
    "paper-towel", "ralesia-seeds-paper-towel", "ralesia-plantation-mk01-with-ceramic", "ralesia-plantation-mk02-with-ceramic", "ralesia-plantation-mk03-with-ceramic", "ralesia-plantation-mk04-with-ceramic", "ralesia-1-hydrogen-burn", "ralesia-2-hydrogen-burn", "ralesia-3-hydrogen-burn", "ralesia-4-hydrogen-burn",
    "deadhead-recycle", "rennea-1-deadhead", "rennea-2-deadhead", "rennea-3-deadhead", "rennea-4-deadhead", "rennea-1-hydrophile", "rennea-2-hydrophile", "rennea-3-hydrophile", "rennea-4-hydrophile", "rennea-seeds-venom",
    "py-science-pack-1-turd", "py-science-pack-2-turd", "py-science-pack-3-turd", "py-science-pack-4-turd",
    "fts-reactor-with-centrifuge", "fts-reactor-mk02-with-centrifuge", "fts-reactor-mk03-with-centrifuge", "fts-reactor-mk04-with-centrifuge", "nano-cellulose-sap", "sap-tree-mulch-mk01", "sap-tree-mulch-mk02", "sap-tree-mulch-mk03", "sap-tree-mulch-mk04",
    "caged-antelope-1-5th-dimension", "caged-antelope-2-5th-dimension", "caged-antelope-3-5th-dimension", "caged-antelope-4-5th-dimension", "caged-antelope-5-5th-dimension", "caged-antelope-6-5th-dimension", "caged-antelope-7-5th-dimension", "caged-antelope-8-5th-dimension", "full-render-antelope-existential", "quantum-dots-folding-1", "quantum-dots-folding-2", "quantum-dots-folding-3", "quantum-dots-folding-4",
    "Scrondrix-cub-1-boron", "Scrondrix-cub-2-boron", "Scrondrix-cub-3-boron", "Scrondrix-cub-4-boron", "Scrondrix-1-boron", "Scrondrix-2-boron", "Scrondrix-3-boron", "Scrondrix-4-boron", "scrondrix-mk02-boron", "scrondrix-mk03-boron", "scrondrix-mk04-boron", "Scrondrix-cub-1-vegan", "Scrondrix-cub-2-vegan", "Scrondrix-cub-3-vegan", "Scrondrix-cub-4-vegan", "Scrondrix-1-vegan", "Scrondrix-2-vegan", "Scrondrix-3-vegan", "Scrondrix-4-vegan", "scrondrix-mk02-vegan", "scrondrix-mk03-vegan", "scrondrix-mk04-vegan", "scrondrix-brain-slaughterhouse-ex", "scrondrix-experimental-treatment",
    "seaweed-crop-mk01-with-ai", "seaweed-crop-mk02-with-ai", "seaweed-crop-mk03-with-ai", "seaweed-crop-mk04-with-ai", "slacked-lime-seaweed-recycle", "slacked-lime-from-seaweed", "seaweed-1-dry", "seaweed-2-dry", "seaweed-3-dry", "seaweed-4-dry", "seaweed-5-dry",
    "simik-iron", "simik-copper", "simik-quartz", "simik-coal", "simik-tin", "simik-aluminium", "simik-boron", "simik-chromium", "simik-molybdenum", "simik-zinc", "simik-nickel", "simik-lead", "simik-titanium", "simik-niobium", "simik-nexelit", "simik-silver", "simik-gold", "simik-uranium",
    "full-render-dhilmoss-laser", "full-render-xenos-laser", "full-render-kor-laser", "full-render-auogs-laser", "ex-used-auog-laser", "full-render-mukmoux-laser", "full-render-scrondrixs-laser", "full-render-ulrics-laser", "full-render-phagnots-laser", "full-render-simik-laser", "full-render-cottongut-laser", "full-render-arthurian-laser", "full-render-arqads-laser", "full-render-phadais-laser", "ex-used-dingrits-laser", "full-render-dingrits-laser", "full-render-kmauts-laser", "full-render-trit-laser", "full-render-vonix-laser", "full-render-vrauks-laser", "full-render-xyhiphoe-laser", "full-render-fish-laser", "full-render-num-laser", "full-render-zun-laser",
    "full-render-dhilmoss-music", "full-render-xenos-music", "full-render-kor-music", "full-render-auogs-music", "ex-used-auog-music", "full-render-mukmoux-music", "full-render-scrondrixs-music", "full-render-ulrics-music", "full-render-phagnots-music", "full-render-simik-music", "full-render-cottongut-music", "full-render-arthurian-music", "full-render-arqads-music", "full-render-phadais-music", "ex-used-dingrits-music", "full-render-dingrits-music", "full-render-kmauts-music", "full-render-trit-music", "full-render-vonix-music", "full-render-vrauks-music", "full-render-xyhiphoe-music", "full-render-fish-music", "full-render-num-music", "full-render-zun-music",
    "full-render-dhilmoss-lard", "full-render-xenos-lard", "full-render-kor-lard", "full-render-auogs-lard", "ex-used-auog-lard", "full-render-mukmoux-lard", "full-render-scrondrixs-lard", "full-render-ulrics-lard", "full-render-phagnots-lard", "full-render-simik-lard", "full-render-cottongut-lard", "full-render-arthurian-lard", "full-render-arqads-lard", "full-render-phadais-lard", "ex-used-dingrits-lard", "full-render-dingrits-lard", "full-render-kmauts-lard", "full-render-trit-lard", "full-render-vonix-lard", "full-render-vrauks-lard", "full-render-xyhiphoe-lard", "full-render-fish-lard", "full-render-num-lard", "full-render-zun-lard",
    "sponge-pure-sand", "sponge-stone-brick", "sponge-rich-clay", "sea-sponge-sprouts-flagellum", "sea-sponge-sprouts-2-flagellum", "sea-sponge-sprouts-3-flagellum", "sea-sponge-sprouts-4-flagellum", "sea-sponge-1-no-zonga", "sea-sponge-2-no-zonga",
    "trits-cub-1-mgo", "trits-cub-2-mgo", "trits-cub-3-mgo", "trits-cub-4-mgo", "trits-1-dc", "trits-2-dc", "trits-3-dc", "trits-4-dc", "trits-reef-mk01-with-nexelit", "trits-reef-mk02-with-nexelit", "trits-reef-mk03-with-nexelit", "trits-reef-mk04-with-nexelit",
    "tuuphra-seeds-with-water", "tuuphra-1-fungicide", "tuuphra-2-fungicide", "tuuphra-3-fungicide", "tuuphra-4-fungicide", "tuuphra-grease",
    "noooo-dont-turn-that-horse-into-glue", "saddle", "saddle-b", "ulric-cub-1-saddle", "ulric-cub-2-saddle", "ulric-cub-3-saddle", "ulric-cub-4-saddle", "ulric-1-manure", "ulric-2-manure", "ulric-3-manure", "ulric-4-manure",
    "vonix-direct-raising", "vonix-raising-1-cancer", "vonix-raising-2-cancer", "vonix-raising-3-cancer", "vonix-den-mk01-free", "vonix-den-mk02-free", "vonix-den-mk03-free", "vonix-den-mk04-free",
    "vrauks-1-no-water", "vrauks-2-no-water", "vrauks-3-no-water", "vrauks-4-no-water","vrauks-5-no-water", "vrauks-cocoon-1-no-water", "vrauks-cocoon-2-no-water", "vrauks-cocoon-3-no-water", "vrauks-cocoon-4-no-water","vrauks-cocoon-5-no-water", "vrauks-paddock-mk01-with-lamp", "vrauks-paddock-mk02-with-lamp", "vrauks-paddock-mk03-with-lamp", "vrauks-paddock-mk04-with-lamp", "ammonia-from-cyanic",
    "biosynthetic-nylon", "py-sawblade-module-mk01", "py-sawblade-module-mk02", "py-sawblade-module-mk03", "py-sawblade-module-mk04", "wood-seedling-turd", "wood-seedling-mk02-turd", "wood-seedling-mk03-turd", "wood-seedling-mk04-turd", "lacquer-resin", "lacquer-resin-to-formica", "phenolicboard-with-laquer", "high-distillate-to-anthracene-oil",
    "caged-xeno-1-dna-polymerase", "caged-xeno-2-dna-polymerase", "caged-xeno-3-dna-polymerase", "caged-xeno-4-dna-polymerase", "xeno-rc-breeding", "xeno-egg-1-cheap", "xeno-egg-2-cheap", "xeno-egg-3-cheap", "xeno-egg-4-cheap",
    "xyhiphoe-1-hot-cold", "xyhiphoe-2-hot-cold", "xyhiphoe-3-hot-cold", "xyhiphoe-4-hot-cold", "xyhiphoe-single", "xyhiphoe-cub-1-acetone", "xyhiphoe-cub-2-acetone", "xyhiphoe-cub-3-acetone", "xyhiphoe-cub-4-acetone",
    "yaedols-spores-coke-oven-gas", "yaedols-spore-mk02-coke-oven-gas", "yaedols-spore-mk03-coke-oven-gas", "yaedols-spore-mk04-coke-oven-gas", "yaedols-1-hot-air", "yaedols-2-hot-air", "yaedols-3-hot-air", "yaedols-4-hot-air", "yaedols-spore-4",
    "yotoi-seeds-cold", "yotoi-1-free-leaves", "yotoi-2-free-leaves", "yotoi-3-free-leaves", "yotoi-4-free-leaves", "nutrient", "yotoi-aloe-orchard-mk01-with-nutrient", "yotoi-aloe-orchard-mk02-with-nutrient", "yotoi-aloe-orchard-mk03-with-nutrient", "yotoi-aloe-orchard-mk04-with-nutrient", "yotoi-2-nutrient", "yotoi-3-nutrient", "yotoi-4-nutrient", "yotoi-fruit-2-nutrient", "yotoi-fruit-3-nutrient", "yotoi-fruit-4-nutrient",
    "zipir-a-1-suicide", "zipir-a-2-suicide", "zipir-a-3-suicide", "zipir-a-4-suicide", "zipir-a-5-suicide", "zipir-a-6-suicide", "zipir-eggs-1-trits-gen", "zipir-eggs-2-trits-gen", "zipir-eggs-3-trits-gen", "zipir-eggs-4-trits-gen", "zipir-eggs-5-trits-gen", "zipir1-pyvoid-hatchery", "zipir-reef-mk01-with-rc", "zipir-reef-mk02-with-rc", "zipir-reef-mk03-with-rc", "zipir-reef-mk04-with-rc",
    "zungror-with-yaedols-codex", "zungror-cocoon-1-rich-clay", "zungror-cocoon-2-rich-clay", "zungror-cocoon-3-rich-clay", "vsk-duplicated", "pre-fiber-1-buffed", "zungror-raising-1-with-funny-rock", "zungror-raising-2-with-funny-rock", "zungror-raising-3-with-funny-rock",
    "sweet-syrup", "a-molasse", "arthurian-codex", "desulfurizator-unit", "xeno-codex", "heatsink", "carbon-dust",
  }
  local recipe_prototypes = prototypes.recipe
  for _,force in pairs(game.forces) do
    for _,player in pairs(force.players) do
      for _,recipe in pairs(turd_recipes) do
        if recipe_prototypes[recipe] then
          player.clear_recipe_notification(recipe)
        end
      end
    end
  end
end
