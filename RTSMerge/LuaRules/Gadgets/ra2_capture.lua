function gadget:GetInfo() return {name="RA2 Capture",desc="Engineer capture capability state.",author="RTSMerge",layer=24,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_engineer=="1" then Spring.SetUnitRulesParam(id,"ra2_capture",1,{allied=true}) end end
