function gadget:GetInfo()
  return {name="RA2 Special Mechanics",desc="MCV deploy and undeploy mechanics.",author="RTSMerge",layer=25,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end

local DEPLOY=34567
local mcv={allied_mcv="allied_conyard",soviet_mcv="soviet_conyard",yuri_mcv="yuri_conyard"}
local conyardToMCV={allied_conyard="allied_mcv",soviet_conyard="soviet_mcv",yuri_conyard="yuri_mcv"}
local defNameByID={}
for name,ud in pairs(UnitDefNames) do defNameByID[ud.id]=name end

local function isValidPair(unitDefID)
  local name=defNameByID[unitDefID]
  return name and (mcv[name] or conyardToMCV[name])
end

function gadget:Initialize()
  gadgetHandler:RegisterAllowCommand(DEPLOY)
end

function gadget:AllowCommand(unitID,unitDefID,teamID,cmdID,params,opts)
  if cmdID~=DEPLOY then return true end
  return isValidPair(unitDefID) and Spring.GetUnitTeam(unitID)==teamID
end

function gadget:CommandFallback(unitID,unitDefID,teamID,cmdID,params,opts)
  if cmdID~=DEPLOY then return false end
  local name=defNameByID[unitDefID]
  local target=mcv[name] or conyardToMCV[name]
  if not target or not UnitDefNames[target] then return true end
  local x,y,z=Spring.GetUnitPosition(unitID)
  if not x then return true end
  local facing=Spring.GetUnitBuildFacing(unitID) or 0
  local newID=Spring.CreateUnit(target,x,y,z,facing,teamID)
  if newID then
    Spring.DestroyUnit(unitID,false,true)
    Spring.SetUnitRulesParam(newID,"ra2_deployed",mcv[name] and 1 or 0,{allied=true})
  end
  return true
end
