function gadget:GetInfo() return {name="RA2 Fog State",desc="Fog-of-war capability metadata.",author="RTSMerge",layer=1,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:Initialize() for _,team in ipairs(Spring.GetTeamList()) do Spring.SetTeamRulesParam(team,"ra2_fog_mode",1,{allied=true}) end end
