function gadget:GetInfo() return {name="RA2 Power Shutdown",desc="Publishes shutdown state for deficit.",author="RTSMerge",layer=14,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do local ratio=Spring.GetTeamRulesParam(team,"ra2_power_ratio") or 1; local off=ratio<=0 and 1 or 0; Spring.SetTeamRulesParam(team,"ra2_power_shutdown",off,{allied=true}) end
end
