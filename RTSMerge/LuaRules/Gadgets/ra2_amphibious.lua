function gadget:GetInfo() return {name="RA2 Amphibious",desc="Amphibious capability metadata.",author="RTSMerge",layer=34,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_amphibious=="1" then Spring.SetUnitRulesParam(id,"ra2_amphibious",1,{allied=true}) end end
