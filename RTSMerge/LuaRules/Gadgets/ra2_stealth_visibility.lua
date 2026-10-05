function gadget:GetInfo() return {name="RA2 Stealth Visibility",desc="Applies stealth state metadata.",author="RTSMerge",layer=27,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local s=Spring.GetUnitRulesParam(id,"ra2_stealthed") or 0
   if s==1 then Spring.SetUnitRulesParam(id,"ra2_hidden",1,{allied=true}) else Spring.SetUnitRulesParam(id,"ra2_hidden",0,{allied=true}) end
  end
 end
end
