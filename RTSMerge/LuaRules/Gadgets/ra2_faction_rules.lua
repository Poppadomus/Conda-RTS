function gadget:GetInfo() return {name="RA2 Faction Rules",desc="Faction identity state.",author="RTSMerge",layer=16,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local sides={"allies","soviet","yuri"}
function gadget:Initialize()
 for _,team in ipairs(Spring.GetTeamList()) do
  local s=select(5,Spring.GetTeamInfo(team,false)); local side=sides[(s or 0)+1] or sides[s] or "allies"
  Spring.SetTeamRulesParam(team,"ra2_faction",side,{allied=true})
 end
end
