function gadget:GetInfo() return {name="RA2 Combat Rules",desc="Compatibility hook retained for combat events.",author="RTSMerge",layer=10,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
-- Damage scaling is intentionally centralized in ra2_warheads.lua to avoid double application.
function gadget:UnitDamaged(id,def,team,damage,paralyzer,weapon,attacker)
 if attacker and Spring.ValidUnitID(attacker) then
  local xp=Spring.GetUnitRulesParam(attacker,"ra2_xp") or 0
  Spring.SetUnitRulesParam(attacker,"ra2_last_damage",damage,{allied=true})
  Spring.SetUnitRulesParam(attacker,"ra2_xp",xp+math.max(1,math.floor(damage)),{allied=true})
 end
end
