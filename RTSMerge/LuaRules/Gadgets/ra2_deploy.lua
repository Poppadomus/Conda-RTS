function gadget:GetInfo() return {name="RA2 Deployables",desc="Deployable-unit capability state.",author="RTSMerge",layer=28,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_deployable=="1" then Spring.SetUnitRulesParam(id,"ra2_deployable",1,{allied=true}) end end
