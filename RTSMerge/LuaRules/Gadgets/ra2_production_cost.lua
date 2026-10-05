function gadget:GetInfo() return {name="RA2 Production Cost",desc="Charges RA2 credits when a production request is accepted.",author="RTSMerge",layer=20,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_QUEUE=CMD.CUSTOM_BASE+200
function gadget:AllowCommand(id,def,team,cmd,params)
 if cmd~=CMD_QUEUE then return true end
 local target=math.abs(tonumber(params and params[1] or 0))
 local ud=target and UnitDefs[target]
 if not ud then return false end
 local cp=ud.customParams or {}
 local cost=tonumber(cp.ra2_cost) or ud.buildCostMetal or 0
 local cur=Spring.GetTeamResources(team,"metal")
 if cur and cur>=cost then
  Spring.UseTeamResource(team,"metal",cost)
  return true
 end
 return false
end