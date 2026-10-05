function gadget:GetInfo() return {name="RA2 Terror Units",desc="Demolition and suicide capability state.",author="RTSMerge",layer=32,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_suicide=="1" then Spring.SetUnitRulesParam(id,"ra2_suicide",1,{allied=true}) end end
