function gadget:GetInfo() return {name="RA2 Gem Ore",desc="Gem cargo multiplier.",author="RTSMerge",layer=5,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do Spring.SetTeamRulesParam(team,"ra2_gem_bonus",2,{allied=true}) end
end
