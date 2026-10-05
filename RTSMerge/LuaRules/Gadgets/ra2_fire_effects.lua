function gadget:GetInfo() return {name="RA2 Fire Effects",desc="Publishes weapon fire state for procedural muzzle effects.",author="RTSMerge",layer=14,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:ProjectileCreated(proID,proData)
 local owner=proData and proData.owner
 if owner and Spring.ValidUnitID(owner) then
  Spring.SetUnitRulesParam(owner,"ra2_last_fire",Spring.GetGameFrame(),{allied=true})
 end
end