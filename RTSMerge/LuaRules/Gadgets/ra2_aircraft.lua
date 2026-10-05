function gadget:GetInfo() return {name="RA2 Aircraft Rules",desc="Aircraft role metadata.",author="RTSMerge",layer=35,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_aircraft=="1" then Spring.SetUnitRulesParam(id,"ra2_aircraft",1,{allied=true}) end end
