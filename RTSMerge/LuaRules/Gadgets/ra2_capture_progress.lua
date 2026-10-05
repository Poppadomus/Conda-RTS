function gadget:GetInfo() return {name="RA2 Capture Progress",desc="Deterministic capture progress.",author="RTSMerge",layer=24,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local p=Spring.GetUnitRulesParam(id,"ra2_capture_progress")
   if p then
    p=math.min(1,p+0.02)
    Spring.SetUnitRulesParam(id,"ra2_capture_progress",p,{allied=true})
   end
  end
 end
end
