function gadget:GetInfo() return {name="RA2 Stealth",desc="Stealth capability state.",author="RTSMerge",layer=26,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_stealth=="1" then Spring.SetUnitRulesParam(id,"ra2_stealth",1,{allied=true}) end end
