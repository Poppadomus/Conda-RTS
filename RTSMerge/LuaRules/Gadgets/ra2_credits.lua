function gadget:GetInfo() return {name="RA2 Credits",desc="Credit storage and cap state.",author="RTSMerge",layer=6,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:Initialize()
 for _,team in ipairs(Spring.GetTeamList()) do
  Spring.SetTeamRulesParam(team,"ra2_credit_cap",10000,{allied=true})
  Spring.SetTeamRulesParam(team,"ra2_credits",0,{allied=true})
 end
end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local metal,storage=Spring.GetTeamResources(team,"metal")
  Spring.SetTeamRulesParam(team,"ra2_credits",math.min(metal or 0,storage or 10000),{allied=true})
 end
end
