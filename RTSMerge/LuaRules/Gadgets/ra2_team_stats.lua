function gadget:GetInfo() return {name="RA2 Team Stats",desc="Deterministic team combat statistics.",author="RTSMerge",layer=46,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitDestroyed(id,def,team,attacker)
 if attacker and Spring.ValidUnitID(attacker) then local at=Spring.GetUnitTeam(attacker); Spring.SetTeamRulesParam(at,"ra2_kills",(Spring.GetTeamRulesParam(at,"ra2_kills") or 0)+1,{allied=true}) end
 Spring.SetTeamRulesParam(team,"ra2_losses",(Spring.GetTeamRulesParam(team,"ra2_losses") or 0)+1,{allied=true})
end
