function gadget:GetInfo() return {name="RA2 Runtime Self Test",desc="Validates the asset-free playable core at game start.",author="RTSMerge",layer=0,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end

local requiredUnits={"allied_mcv","soviet_mcv","yuri_mcv","allied_conyard","soviet_conyard","yuri_conyard","allied_refinery","soviet_refinery","yuri_refinery","allied_barracks","soviet_barracks","yuri_barracks","allied_warfactory","soviet_warfactory","yuri_warfactory","grizzly_tank","rhino_tank","lasher_tank","gi","conscript","initiates","allied_harvester","soviet_harvester","yuri_slave_miner"}
local requiredWeapons={"ra2_grizzly_cannon","ra2_rifle","ra2_rhino_cannon","ra2_ak47"}

function gadget:GameStart()
  local failures=0
  for _,name in ipairs(requiredUnits) do
    if not UnitDefNames[name] then failures=failures+1; Spring.Log("RA2S/selftest",LOG.ERROR,"Missing unit: "..name) end
  end
  for _,name in ipairs(requiredWeapons) do
    if not WeaponDefNames[name] then failures=failures+1; Spring.Log("RA2S/selftest",LOG.ERROR,"Missing weapon: "..name) end
  end
  local procedural=VFS.FileExists("objects3d/ra2_procedural.3do")
  if not procedural then failures=failures+1; Spring.Log("RA2S/selftest",LOG.ERROR,"Missing procedural model") end
  if failures==0 then
    Spring.Log("RA2S/selftest",LOG.INFO,"PASS: asset-free RTS core definitions loaded")
  else
    Spring.Log("RA2S/selftest",LOG.ERROR,"FAIL: "..failures.." required runtime definitions missing")
  end
  Spring.SetGameRulesParam("ra2_selftest_failures",failures)
end
