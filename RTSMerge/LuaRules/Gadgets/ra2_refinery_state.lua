function gadget:GetInfo() return {name="RA2 Refinery State",desc="Refinery capacity and delivery state.",author="RTSMerge",layer=8,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_refinery=="1" then Spring.SetUnitRulesParam(id,"ra2_refinery",1,{allied=true}); Spring.SetUnitRulesParam(id,"ra2_refinery_capacity",100,{allied=true}) end end
