function gadget:GetInfo()
  return { name="RA2 Core Rules", desc="RA2 construction, deployment and faction rules.", author="RTSMerge", layer=10, enabled=true }
end
if not gadgetHandler:IsSyncedCode() then return end

local deployDefs = {}
local sideByTeam = {}
local deployCommand = 34567

function gadget:Initialize()
  for id,ud in pairs(UnitDefs) do
    local cp=ud.customParams
    if cp and cp.role=="mcv" then deployDefs[id]=cp.side end
  end
  for _,teamID in ipairs(Spring.GetTeamList()) do
    local _,_,_,_,side = Spring.GetTeamInfo(teamID)
    sideByTeam[teamID]=side
  end
end

function gadget:AllowCommand(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
  if cmdID~=deployCommand or not deployDefs[unitDefID] then return true end
  if Spring.GetUnitIsDead(unitID) then return false end
  if Spring.GetUnitIsTransporting(unitID) then return false end
  return true
end

function gadget:CommandFallback(unitID, unitDefID, teamID, cmdID, cmdParams, cmdOptions)
  if cmdID~=deployCommand or not deployDefs[unitDefID] then return false end
  if Spring.GetUnitIsDead(unitID) then return true end
  local x,y,z=Spring.GetUnitPosition(unitID)
  if not x then return true end
  local side=deployDefs[unitDefID]
  local target = side=="allies" and "allied_conyard" or side=="soviet" and "soviet_conyard" or "yuri_conyard"
  local ud=UnitDefNames[target]
  if not ud then return true end
  local newID=Spring.CreateUnit(target,x,y,z,0,teamID)
  if newID then
    Spring.DestroyUnit(unitID,false,true)
    Spring.GiveOrderToUnit(newID,CMD.STOP,{},0)
  end
  return true
end
