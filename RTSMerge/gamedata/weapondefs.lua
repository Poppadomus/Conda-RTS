local weaponDefs = {}
local shared = {}
local system = VFS.Include("gamedata/system.lua")

for _, filename in ipairs(VFS.DirList("weapons/", "*.lua", nil, true)) do
  local env = {}
  env._G = env
  env.Shared = shared
  env.GetFilename = function() return filename end
  setmetatable(env, { __index = system })
  local ok, defs = pcall(VFS.Include, filename, env, VFS_MODES)
  if ok and type(defs) == "table" then
    for name, def in pairs(defs) do
      if type(name) == "string" and type(def) == "table" then
        weaponDefs[name] = def
      end
    end
  else
    Spring.Log("RA2S/weapondefs", LOG.ERROR, "Failed to parse "..filename..": "..tostring(defs))
  end
end

return weaponDefs
