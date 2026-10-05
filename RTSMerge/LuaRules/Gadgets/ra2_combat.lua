function gadget:GetInfo() return {name="RA2 Combat Rules",desc="Deterministic armor and veterancy combat modifiers.",author="RTSMerge",layer=10,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local armor={LIGHT=1,MEDIUM=1,HEAVY=1,BUILDING=1,INFANTRY=1,AIR=1,NAVAL=1}
function gadget:UnitPreDamaged(id,def,team,damage,paralyzer,weapon,attacker)
 if paralyzer then return damage end
 local mult=attacker and (Spring.GetUnitRulesParam(attacker,"ra2_combat_multiplier") or 1) or 1
 local cp=UnitDefs[def] and UnitDefs[def].customParams or {}
 return damage*mult*(armor[cp and cp.ra2_armor] or 1)
end
