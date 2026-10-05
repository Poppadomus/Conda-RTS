function gadget:GetInfo()
  return {name="RA2 Special Mechanics",desc="Deployable and faction-special synced mechanics.",author="RTSMerge",layer=25,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end

local DEPLOY=34567
local mcv={allied_mcv="allied_conyard",soviet_mcv="soviet_conyard",yuri_mcv="yuri_conyard"}
local conyardToMCV={allied_conyard="allied_mcv",soviet_conyard="soviet_mcv",yuri_conyard="yuri_mcv"}

function gadget:AllowCommand(unitID,unitDefID,teamID,cmdID,params,opts)
  if cmdID~=DEPLOY then return true end
  local name=UnitDefs[unitDefID].name
  return mcv[name]~=nil or conyardToMCV[name]~=nil
end

function gadget:CommandFallback(unitID,unitDefID,teamID,cmdID,params,opts)
  if cmdID~=DEPLOY then return false end
  local name=UnitDefs[unitDefID].name
  local target=mcv[name] or conyardToMCV[name]
  if not target or not UnitDefNames[target] then return true end
  local x,y,z=Spring.GetUnitPosition(unitID)
  if not x then return true end
  local facing=Spring.GetUnitBuildFacing(unitID)
  local newID=Spring.CreateUnit(target,x,y,z,facing,teamID)
  if newID then
    Spring.DestroyUnit(unitID,false,true)
    Spring.SetUnitRulesParam(newID,"ra2_deployed",mcv[name] and 1 or 0,{allied=true})
  end
  return true
end
