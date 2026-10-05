function gadget:GetInfo() return {name="RA2 Build Radius",desc="Construction-yard build radius state.",author="RTSMerge",layer=17,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_conyard=="1" then Spring.SetUnitRulesParam(id,"ra2_build_radius",900,{allied=true}) end end
