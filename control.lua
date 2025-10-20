--- control.lua

script.on_init(
  function()
    initialize()
    validate_technology_effects()
  end
)
script.on_configuration_changed(
  function()
    initialize()
    validate_technology_effects()
  end
)

--- Saves settings and handles recharting
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
end

--- Updates map colors
function rechart()
  for _,force in pairs(game.forces) do
    for _,surface in pairs(game.surfaces) do
      force.rechart(surface)
    end
  end
end

--- Enables recipes which should be enabled but aren't due to technology changes
function validate_technology_effects()
  local altered_techs = {
    "coal-processing-1",
    "steel-processing",
    "crusher",
    "concrete",
    "mining-with-fluid",
    "tar-processing",
    "acetylene",
    "petri-dish",
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
