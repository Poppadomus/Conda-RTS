function gadget:GetInfo() return {name="RA2 Damage State",desc="Tracks damage and destruction state.",author="RTSMerge",layer=12,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitDamaged(id,def,team,damage) Spring.SetUnitRulesParam(id,"ra2_last_damage",damage,{allied=true}) end
function gadget:UnitDestroyed(id,def,team) Spring.SetUnitRulesParam(id,"ra2_destroyed",1,{allied=true}) end
