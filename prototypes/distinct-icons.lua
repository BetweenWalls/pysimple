--- distinct-icons.lua

local debug_errors = false

local recipes = {
    {artificial=true, names={"art-vrauks", "art-auog", "art-cottongut", "art-ulric", "art-arqad", "art-korlex", "art-mukmoux", "art-phagnot", "art-arthurian", "art-scrondrix", "art-dingrits", "art-phadai", "art-kmauts", "art-phadai", "art-simik", "art-vonix", "art-xenos", "art-zipir", "art-trits", "art-xyhiphoe", "art-dhilmos"}},
    {cage=true, names={"uncaged-vrauks", "uncaged-auog", "uncaged-ulric", "uncaged-korlex", "uncaged-mukmoux", "uncaged-phagnot", "uncaged-arthurian", "uncaged-scrondrix", "uncaged-dingrits", "uncaged-kmauts", "uncaged-phadai", "uncaged-simik", "uncaged-zungror", "uncaged-xeno"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-bioreserve.png", numbered=true, names={"bioreserve-super-1", "bioreserve-super-2", "bioreserve-super-3", "bioreserve-super-4", "bioreserve-super-5", "bioreserve-super-6", "bioreserve-super-7"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-ralesia.png", numbered=true, names={"ralesia-super-1", "ralesia-super-2", "ralesia-super-3", "ralesia-super-4", "ralesia-super-5", "ralesia-super-6", "ralesia-super-7", "ralesia-super-8", "ralesia-super-9", "ralesia-super-10"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-tuuphra.png", numbered=true, names={"tuuphra-super-1", "tuuphra-super-2", "tuuphra-super-3", "tuuphra-super-4", "tuuphra-super-5", "tuuphra-super-6", "tuuphra-super-7", "tuuphra-super-8", "tuuphra-super-9", "tuuphra-super-10"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-kicalk.png", numbered=true, names={"kicalk-super-1", "kicalk-super-2", "kicalk-super-3", "kicalk-super-4", "kicalk-super-5", "kicalk-super-6", "kicalk-super-7", "kicalk-super-8", "kicalk-super-9", "kicalk-super-10"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-rennea.png", numbered=true, names={"rennea-super-1", "rennea-super-2", "rennea-super-3", "rennea-super-4", "rennea-super-5", "rennea-super-6", "rennea-super-7", "rennea-super-8", "rennea-super-9", "rennea-super-10"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-yotoi.png", numbered=true, names={"yotoi-super-1", "yotoi-super-2", "yotoi-super-3", "yotoi-super-4", "yotoi-super-5", "yotoi-super-6", "yotoi-super-7", "yotoi-super-8", "yotoi-super-9", "yotoi-super-10"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-yotoi-fruit.png", numbered=true, names={"yotoi-fruit-super-1", "yotoi-fruit-super-2", "yotoi-fruit-super-3", "yotoi-fruit-super-4", "yotoi-fruit-super-5", "yotoi-fruit-super-6", "yotoi-fruit-super-7", "yotoi-fruit-super-8", "yotoi-fruit-super-9", "yotoi-fruit-super-10"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-grod.png", numbered=true, names={"grod-super-1", "grod-super-2", "grod-super-3", "grod-super-4", "grod-super-5", "grod-super-6", "grod-super-7", "grod-super-8", "grod-super-9", "grod-super-10"}},
    {icon="__pyalienlifegraphics__/graphics/icons/replicator-cadaveric-arum.png", numbered=true, names={"arum-super-1", "arum-super-2", "arum-super-3", "arum-super-4", "arum-super-5", "arum-super-6", "arum-super-7", "arum-super-8", "arum-super-9", "arum-super-10"}},
    {icon="__pyalternativeenergygraphics__/graphics/icons/replicator-mova.png", numbered=true, names={"mova-super-1", "mova-super-2", "mova-super-3", "mova-super-4", "mova-super-5", "mova-super-6", "mova-super-7", "mova-super-8", "mova-super-9", "mova-super-10"}},
}

local kinds = {"item", "module"}

if settings.startup["pysimple-recipe-menu"].value or settings.startup["pysimple-descriptions"].value then
    for _,info in pairs(recipes) do
        local skip = info.skip or 0
        for i,name in pairs(info.names) do
            local recipe = data.raw.recipe[name]
            if recipe then
                if info.icon then
                    recipe.icons = {{icon=info.icon}}
                elseif recipe.icon then
                    recipe.icons = {{icon=recipe.icon, icon_size=recipe.icon_size}}
                elseif not recipe.icons then
                    if recipe.results and #recipe.results > 0 then
                        local thing
                        for _,result in pairs (recipe.results) do
                            if not thing then thing = result.name end
                            if recipe.main_product and recipe.main_product == result.name then
                                thing = result.name
                            end
                        end
                        if thing then
                            local prod
                            for _,kind in pairs(kinds) do
                                if data.raw[kind][thing] then
                                    prod = data.raw[kind][thing]
                                    break
                                end
                            end
                            if prod and prod.icons then
                                recipe.icons = {{icon=prod.icons[1].icon, icon_size=prod.icons[1].icon_size}}
                            elseif prod and prod.icon then
                                recipe.icons = {{icon=prod.icon, icon_size=prod.icon_size}}
                            end
                        end
                    end
                end
                if recipe.icons then
                    if info.turd then -- seems unnecessary as long as the turd recipes are positioned consistently - always adjacent to the recipes they replace
                        table.insert(recipe.icons, {icon = "__pycoalprocessinggraphics__/graphics/icons/gui/turd.png", scale = 0.34, shift = {12,12}})
                    end
                    if info.sample then -- some recipes are merged with their corresponding item and some aren't, so these don't show up consistently which makes them unreliable and questionable for inclusion
                        table.insert(recipe.icons, {icon = "__pyalienlifegraphics__/graphics/icons/earth-generic-sample.png", scale = 0.16, shift = {8,8}})
                    end
                    if info.cage then
                        table.insert(recipe.icons, {icon = "__pyalienlifegraphics__/graphics/icons/cage.png", scale = 0.2, shift = {8,8}})
                    end
                    if info.artificial then
                        table.insert(recipe.icons, {icon = "__pyalienlifegraphics__/graphics/icons/laboratory-grown-brain.png", scale = 0.16, shift = {8,8}})
                    end
                    if info.numbered then
                        if i+skip < 10 then
                            table.insert(recipe.icons, {icon = "__pyalienlifegraphics__/graphics/icons/"..tostring(i+skip)..".png", scale = 0.25, shift = {8,8}})
                        elseif i+skip == 10 then
                            table.insert(recipe.icons, {icon = "__pyalienlifegraphics__/graphics/icons/1.png", scale = 0.25, shift = {1,8}})
                            table.insert(recipe.icons, {icon = "__pyalienlifegraphics__/graphics/icons/0.png", scale = 0.25, shift = {8,8}})
                        end
                    end
                elseif debug_errors then
                    error("missing icon list: "..name)
                end
            elseif debug_errors then
                error("invalid recipe name: "..name)
            end
        end
    end
end
