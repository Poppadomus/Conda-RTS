function gadget:GetInfo() return {name="RA2 Build Completion",desc="Publishes construction completion state.",author="RTSMerge",layer=24,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) Spring.SetUnitRulesParam(id,"ra2_build_complete",0,{allied=true}) end
function gadget:UnitFinished(id,def) Spring.SetUnitRulesParam(id,"ra2_build_complete",1,{allied=true}) end
