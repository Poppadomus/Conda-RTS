function gadget:GetInfo() return {name="RA2 Capture Complete",desc="Completes engineer captures.",author="RTSMerge",layer=25,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local p=Spring.GetUnitRulesParam(id,"ra2_capture_progress")
   local target=Spring.GetUnitRulesParam(id,"ra2_capture_target")
   if p and target and p>=1 and Spring.ValidUnitID(target) then
    Spring.TransferUnit(target,team,false)
    Spring.SetUnitRulesParam(id,"ra2_capture_progress",nil,{allied=true})
    Spring.SetUnitRulesParam(id,"ra2_capture_target",nil,{allied=true})
   end
  end
 end
end
