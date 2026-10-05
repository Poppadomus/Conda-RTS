function gadget:GetInfo() return {name="RA2 Deploy State",desc="Tracks MCV deployed state for visuals and rules.",author="RTSMerge",layer=18,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def)
 local cp=UnitDefs[def].customParams or {}
 if cp.role=="mcv" then Spring.SetUnitRulesParam(id,"ra2_deployed",0,{allied=true}) end
end
function gadget:UnitDestroyed(id,def) end