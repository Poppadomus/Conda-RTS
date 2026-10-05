function gadget:GetInfo()
  return { name = "RA2 Ore Economy", desc = "Maps Spring metal/energy to RA2-style credits/power.", author = "RTSMerge", layer = 0, enabled = true }
end
if not gadgetHandler:IsSyncedCode() then return end

local CREDIT_CAP = 10000
local ORE_TICK = 30
local ORE_PER_TICK = 25
local harvesterDefs = {}

function gadget:Initialize()
  for unitDefID, unitDef in pairs(UnitDefs) do
    local cp = unitDef.customParams
    if cp and cp.ra2_harvester == "1" then harvesterDefs[unitDefID] = true end
  end
  for _, teamID in ipairs(Spring.GetTeamList()) do
    Spring.SetTeamResource(teamID, "metalStorage", CREDIT_CAP)
    Spring.SetTeamResource(teamID, "metal", 0)
  end
end

function gadget:GameFrame(frame)
  if frame % ORE_TICK ~= 0 then return end
  local harvesters = {}
  for _, unitID in ipairs(Spring.GetAllUnits()) do
    local unitDefID = Spring.GetUnitDefID(unitID)
    if harvesterDefs[unitDefID] then
      local teamID = Spring.GetUnitTeam(unitID)
      harvesters[teamID] = (harvesters[teamID] or 0) + 1
    end
  end
  for teamID, count in pairs(harvesters) do
    local metal, storage = Spring.GetTeamResources(teamID, "metal")
    if metal and storage then
      local gain = math.min(count * ORE_PER_TICK, math.max(0, storage - metal))
      if gain > 0 then Spring.AddTeamResource(teamID, "metal", gain) end
    end
  end
end
