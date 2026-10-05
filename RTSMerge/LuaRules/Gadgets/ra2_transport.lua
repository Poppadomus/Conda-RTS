function gadget:GetInfo() return {name="RA2 Transport",desc="Transport capability metadata.",author="RTSMerge",layer=29,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_transport=="1" then Spring.SetUnitRulesParam(id,"ra2_transport",1,{allied=true}) end end
