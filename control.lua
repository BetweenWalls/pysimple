--- control.lua

script.on_init(
  function()
    validate_technology_effects()
  end
)
script.on_configuration_changed(
  function()
    validate_technology_effects()
  end
)

--- Enables beacon recipes which should be enabled but aren't due to technology changes
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
    "hot-air-mk01",
  }
  for _,force in pairs(game.forces) do
    for _,tech in pairs(altered_techs) do
      if force.technologies[tech] and force.technologies[tech].researched then
        for _,effect in pairs(force.technologies[tech].prototype.effects) do
          if effect.type == "unlock-recipe" and force.recipes[effect.recipe] and not force.recipes[effect.recipe].enabled then
            force.recipes[effect.recipe].enabled = true
          end
        end
      end
    end
  end
end
