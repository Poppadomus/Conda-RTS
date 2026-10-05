function gadget:GetInfo() return {name="RA2 MCV State",desc="Mobile construction vehicle state.",author="RTSMerge",layer=25,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_mcv=="1" then Spring.SetUnitRulesParam(id,"ra2_mcv",1,{allied=true}) end end
