local unitDefs = {}
local shared = {}
local system = VFS.Include("gamedata/system.lua")

for _, filename in ipairs(VFS.DirList("units/", "*.lua", nil, true)) do
  local env = {}
  env._G = env
  env.Shared = shared
  env.GetFilename = function() return filename end
  setmetatable(env, { __index = system })
  local ok, defs = pcall(VFS.Include, filename, env, VFS_MODES)
  if ok and type(defs) == "table" then
    for name, def in pairs(defs) do
      if type(name) == "string" and type(def) == "table" then unitDefs[name] = def end
    end
  else
    Spring.Log("RA2S/unitdefs", LOG.ERROR, "Failed to parse "..filename..": "..tostring(defs))
  end
end

for _, def in pairs(unitDefs) do
  def.objectname = def.objectname or "ra2_procedural.3do"
  def.customParams = def.customParams or {}
  def.customParams.ra2_procedural = def.customParams.ra2_procedural or "1"
  def.customParams.ra2_visual = def.customParams.ra2_visual or
    (def.customParams.role == "mcv" and "mcv" or
     def.customParams.role == "harvester" and "harvester" or
     def.customParams.role == "infantry" and "infantry" or "tank")
end

local production = {
  alliesInfantry = {"gi","guardian_gi","rocketeer","engineer","navy_seal","spy","tanya","chrono_legionnaire"},
  alliesVehicles = {"grizzly_tank","ifv","mirage_tank","prism_tank","allied_harvester"},
  sovietInfantry = {"conscript","flak_trooper","tesla_trooper","soviet_engineer","boris"},
  sovietVehicles = {"rhino_tank","flak_track","terror_drone","v3_rocket","apocalypse_tank","tesla_tank","soviet_harvester"},
  yuriInfantry = {"initiates","brute","virus","yuri_prime"},
  yuriVehicles = {"lasher_tank","gatling_tank","magnetron","mastermind","chaos_drone","grinder","yuri_slave_miner"},
}
local function appendOptions(factory, list)
  if not unitDefs[factory] then return end
  unitDefs[factory].buildOptions = unitDefs[factory].buildOptions or {}
  for _, name in ipairs(list) do
    if unitDefs[name] then
      local found=false
      for _, existing in ipairs(unitDefs[factory].buildOptions) do if existing==name then found=true end end
      if not found then unitDefs[factory].buildOptions[#unitDefs[factory].buildOptions+1]=name end
    end
  end
end
appendOptions("allied_barracks", production.alliesInfantry)
appendOptions("allied_warfactory", production.alliesVehicles)
appendOptions("soviet_barracks", production.sovietInfantry)
appendOptions("soviet_warfactory", production.sovietVehicles)
appendOptions("yuri_barracks", production.yuriInfantry)
appendOptions("yuri_warfactory", production.yuriVehicles)

return unitDefs
