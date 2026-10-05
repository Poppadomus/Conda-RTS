function gadget:GetInfo() return {name="RA2 Country Selection",desc="Initializes country capability state.",author="RTSMerge",layer=16,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local factions={allies="America",soviet="Russia",yuri="Yuri"}
function gadget:Initialize()
 for _,team in ipairs(Spring.GetTeamList()) do
  local side=select(5,Spring.GetTeamInfo(team,false))
  local country=factions[side==1 and "soviet" or side==2 and "yuri" or "allies"]
  Spring.SetTeamRulesParam(team,"ra2_country",country,{allied=true})
 end
end
