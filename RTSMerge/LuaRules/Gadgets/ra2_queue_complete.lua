function gadget:GetInfo() return {name="RA2 Queue Completion",desc="Completes queued production entries.",author="RTSMerge",layer=24,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local p=Spring.GetUnitRulesParam(id,"ra2_queue_progress")
   local q=Spring.GetUnitRulesParam(id,"ra2_queue_length") or 0
   if p and q>0 and p>=1 then
    Spring.SetUnitRulesParam(id,"ra2_queue_progress",0,{allied=true})
    Spring.SetUnitRulesParam(id,"ra2_queue_length",q-1,{allied=true})
   end
  end
 end
end
