function gadget:GetInfo() return {name="RA2 Repair",desc="Repair capability state.",author="RTSMerge",layer=23,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_repair=="1" then Spring.SetUnitRulesParam(id,"ra2_repair_capable",1,{allied=true}) end end
