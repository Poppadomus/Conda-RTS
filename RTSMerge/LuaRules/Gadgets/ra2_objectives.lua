function gadget:GetInfo() return {name="RA2 Objectives",desc="Mission objective state.",author="RTSMerge",layer=50,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:Initialize() for _,team in ipairs(Spring.GetTeamList()) do Spring.SetTeamRulesParam(team,"ra2_objective_state",0,{allied=true}) end end
