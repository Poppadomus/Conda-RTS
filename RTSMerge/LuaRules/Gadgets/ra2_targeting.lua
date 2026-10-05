function gadget:GetInfo() return {name="RA2 Target Classes",desc="Target class metadata.",author="RTSMerge",layer=11,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_armor then Spring.SetUnitRulesParam(id,"ra2_armor_class",cp.ra2_armor,{allied=true}) end end
