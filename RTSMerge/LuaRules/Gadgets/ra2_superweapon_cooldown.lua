function gadget:GetInfo() return {name="RA2 Superweapon Cooldown",desc="Tracks firing cooldowns.",author="RTSMerge",layer=44,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local c=Spring.GetTeamRulesParam(team,"ra2_superweapon_active") or 0
  if c>0 then Spring.SetTeamRulesParam(team,"ra2_superweapon_cooldown",math.max(0,(Spring.GetTeamRulesParam(team,"ra2_superweapon_cooldown") or 30)-1),{allied=true}) end
 end
end
