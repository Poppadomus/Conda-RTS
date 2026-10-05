function gadget:GetInfo() return {name="RA2 Special Mechanics",desc="MCV deploy and undeploy.",author="RTSMerge",layer=25,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local DEPLOY=34567
local mcv={allied_mcv="allied_conyard",soviet_mcv="soviet_conyard",yuri_mcv="yuri_conyard"}
local back={allied_conyard="allied_mcv",soviet_conyard="soviet_mcv",yuri_conyard="yuri_mcv"}
local names={}; for n,ud in pairs(UnitDefNames) do names[ud.id]=n end
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(DEPLOY) end
function gadget:AllowCommand(id,def,team,cmd)
 if cmd~=DEPLOY then return true end
 local n=names[def]; return n and (mcv[n] or back[n]) and Spring.GetUnitTeam(id)==team
end
function gadget:CommandFallback(id,def,team,cmd)
 if cmd~=DEPLOY then return false end
 local n=names[def]; local target=mcv[n] or back[n]
 if not target or not UnitDefNames[target] then return true end
 local x,y,z=Spring.GetUnitPosition(id); if not x then return true end
 local facing=Spring.GetUnitBuildFacing and Spring.GetUnitBuildFacing(id) or 0
 local newID=Spring.CreateUnit(target,x,y,z,facing,team)
 if newID then
  Spring.DestroyUnit(id,false,true)
  Spring.SetUnitRulesParam(newID,"ra2_deployed",mcv[n] and 1 or 0,{allied=true})
 end
 return true
end
