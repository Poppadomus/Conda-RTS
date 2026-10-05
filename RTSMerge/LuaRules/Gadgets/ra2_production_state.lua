function gadget:GetInfo() return {name="RA2 Production State",desc="Publishes active producer and production capability.",author="RTSMerge",layer=20,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def)
 local cp=UnitDefs[def].customParams or {}
 local role=cp.role
 if role=="barracks" or role=="warfactory" then
  Spring.SetUnitRulesParam(id,"ra2_producer",role,{allied=true})
  Spring.SetUnitRulesParam(id,"ra2_production_enabled",1,{allied=true})
 end
end
function gadget:UnitDestroyed(id) end
