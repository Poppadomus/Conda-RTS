function gadget:GetInfo() return {name="RA2 Queue Completion",desc="Publishes queue activity; production spawning is handled separately.",author="RTSMerge",layer=24,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do for _,id in ipairs(Spring.GetTeamUnits(team)) do
  local q=Spring.GetUnitRulesParam(id,"ra2_queue_length") or 0
  Spring.SetUnitRulesParam(id,"ra2_queue_active",q>0 and 1 or 0,{allied=true})
 end end
end
