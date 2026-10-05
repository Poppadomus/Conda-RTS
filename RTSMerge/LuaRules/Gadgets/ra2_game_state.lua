function gadget:GetInfo() return {name="RA2 Game State",desc="Publishes conversion version state.",author="RTSMerge",layer=2,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameStart()
 Spring.SetGameRulesParam("ra2_rules_version",2)
 Spring.SetGameRulesParam("ra2_conversion_state",1)
end
