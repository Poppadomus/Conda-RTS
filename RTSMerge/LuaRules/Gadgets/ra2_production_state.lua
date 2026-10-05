function gadget:GetInfo() return {name="RA2 Production State",desc="Publishes active producer state.",author="RTSMerge",layer=20,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def)
 local cp=UnitDefs[def].customParams or {}
 if cp.ra2_producer then Spring.SetUnitRulesParam(id,"ra2_producer",cp.ra2_producer,{allied=true}) end
end
