function gadget:GetInfo() return {name="RA2 Country Bonuses",desc="Country capability flags.",author="RTSMerge",layer=15,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local bonus={America="paratrooper",France="grand_cannon",Germany="tank_destroyer",GreatBritain="sniper",Korea="black_eagle",Cuba="terrorist",Iraq="desolator",Libya="demolition_truck",Russia="tesla_tank",Yuri="psychic"}
function gadget:Initialize()
 for _,team in ipairs(Spring.GetTeamList()) do local country=Spring.GetTeamRulesParam(team,"ra2_country"); if country and bonus[country] then Spring.SetTeamRulesParam(team,"ra2_country_bonus",bonus[country],{allied=true}) end end
end
