function gadget:GetInfo() return {name="RA2 Refinery Bonus",desc="Refinery delivery bonus state.",author="RTSMerge",layer=10,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_refinery=="1" then Spring.SetUnitRulesParam(id,"ra2_refinery_bonus",1,{allied=true}) end end
