function gadget:GetInfo() return {name="RA2 Credits",desc="Initializes RA2 credit capacity state.",author="RTSMerge",layer=6,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameStart()
 for _,team in ipairs(Spring.GetTeamList()) do
  Spring.SetTeamRulesParam(team,"ra2_credits_capacity",10000,{allied=true})
  Spring.SetTeamRulesParam(team,"ra2_credits_initialized",1,{allied=true})
 end
end
