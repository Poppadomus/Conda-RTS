function gadget:GetInfo() return {name="RA2 Construction Yard",desc="Construction-yard capability state.",author="RTSMerge",layer=18,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_conyard=="1" then Spring.SetUnitRulesParam(id,"ra2_conyard",1,{allied=true}) end end
