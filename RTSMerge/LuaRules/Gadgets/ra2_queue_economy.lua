function gadget:GetInfo() return {name="RA2 Queue Economy",desc="Charges production requests from team credits.",author="RTSMerge",layer=23,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local queues={}
function gadget:UnitCreated(id) queues[id]=queues[id] or {} end
function gadget:UnitDestroyed(id) queues[id]=nil end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for id,q in pairs(queues) do
  local team=Spring.GetUnitTeam(id)
  local len=Spring.GetUnitRulesParam(id,"ra2_queue_length") or 0
  if len>0 then
   local metal=Spring.GetTeamResources(team,"metal")
   if metal and metal>=1 then Spring.UseTeamResource(team,"metal",1) end
  end
 end
end
