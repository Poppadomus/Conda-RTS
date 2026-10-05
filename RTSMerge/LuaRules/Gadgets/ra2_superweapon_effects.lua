function gadget:GetInfo() return {name="RA2 Superweapon Effects",desc="Executes deterministic superweapon effect hooks.",author="RTSMerge",layer=43,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local fired=Spring.GetTeamRulesParam(team,"ra2_last_superweapon")
  if fired and fired>0 then
   local x=Spring.GetTeamRulesParam(team,"ra2_sw_target_x")
   local z=Spring.GetTeamRulesParam(team,"ra2_sw_target_z")
   if x and z then Spring.SetTeamRulesParam(team,"ra2_superweapon_active",fired,{allied=true}) end
   Spring.SetTeamRulesParam(team,"ra2_last_superweapon",0,{allied=true})
  end
 end
end
