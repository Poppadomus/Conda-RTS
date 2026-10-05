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
      if type(name) == "string" and type(def) == "table" then
        unitDefs[name] = def
      end
    end
  else
    Spring.Log("RA2S/unitdefs", LOG.ERROR, "Failed to parse "..filename..": "..tostring(defs))
  end
end

for name, def in pairs(unitDefs) do
  if type(def.objectname) ~= "string" or not VFS.FileExists("objects3d/"..def.objectname) then
    Spring.Log("RA2S/unitdefs", LOG.ERROR, "Removing "..name.." because its converted Spring model is missing: "..tostring(def.objectname))
    unitDefs[name] = nil
  end
end

return unitDefs
