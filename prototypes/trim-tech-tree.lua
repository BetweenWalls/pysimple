--- trim-tech-tree.lua

-- The code here is copied from Tech Tree Trimmer by _CodeGreen:
-- TODO: Update for Factorio 2.0 (new trigger technologies seem to cause issues?)

--[[
if settings.startup["pysimple-tech-tree"].value ~= "1" then
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
        if technology.unit then
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
        else
            base_technologies[technology.name] = true
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
              --if data.raw.technology[prerequisite].unit then
                for _, ingredient in pairs(data.raw.technology[prerequisite].unit.ingredients) do
                    local pack = ingredient[1] or ingredient.name
                    requirements[name][pack] = true
                end
              --end
          end
      end
      --if technology.unit then
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
      --end
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
          local prerequisites = technology.prerequisites --[ [@as string[] ] ]
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
end
]]
