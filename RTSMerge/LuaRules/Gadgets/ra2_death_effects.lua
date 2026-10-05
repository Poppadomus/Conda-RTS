function gadget:GetInfo() return {name="RA2 Death Effects",desc="Publishes deterministic destruction effects.",author="RTSMerge",layer=45,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitDestroyed(id,def,team) Spring.SetTeamRulesParam(team,"ra2_last_destroyed_unit",def,{allied=true}) end
