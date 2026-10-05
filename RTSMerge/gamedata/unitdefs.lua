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

return unitDefs
