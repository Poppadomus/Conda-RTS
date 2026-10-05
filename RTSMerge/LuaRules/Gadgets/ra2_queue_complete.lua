function gadget:GetInfo() return {name="RA2 Queue Completion",desc="Advances explicit RA2 production queue state.",author="RTSMerge",layer=24,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do for _,id in ipairs(Spring.GetTeamUnits(team)) do
  local p=Spring.GetUnitRulesParam(id,"ra2_queue_progress") or 0
  local q=Spring.GetUnitRulesParam(id,"ra2_queue_length") or 0
  if q>0 and p>=1 then
   local nextID=Spring.GetUnitRulesParam(id,"ra2_queue_next")
   Spring.SetUnitRulesParam(id,"ra2_queue_progress",0,{allied=true})
   Spring.SetUnitRulesParam(id,"ra2_queue_length",q-1,{allied=true})
   if nextID then Spring.SetUnitRulesParam(id,"ra2_queue_next",nil,{allied=true}) end
  end
 end end
end
