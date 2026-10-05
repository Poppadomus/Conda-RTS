function gadget:GetInfo() return {name="RA2 Damage State",desc="Publishes deterministic damaged-unit state for procedural visuals.",author="RTSMerge",layer=13,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitDamaged(id,def,team,damage,paralyzer,weapon,attacker)
 local hp,maxhp=Spring.GetUnitHealth(id)
 if hp and maxhp and maxhp>0 then
  local state=hp/maxhp
  Spring.SetUnitRulesParam(id,"ra2_damage_state",state,{allied=true})
  if state<0.25 then Spring.SetUnitRulesParam(id,"ra2_critical_damage",1,{allied=true}) end
 end
end