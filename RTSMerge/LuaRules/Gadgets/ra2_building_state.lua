function gadget:GetInfo() return {name="RA2 Building State",desc="Building completion and health state.",author="RTSMerge",layer=18,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local ud=UnitDefs[def]; if ud and ud.canMove==false then Spring.SetUnitRulesParam(id,"ra2_building",1,{allied=true}) end end
