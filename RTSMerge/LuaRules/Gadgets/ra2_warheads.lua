function gadget:GetInfo() return {name="RA2 Warhead Matrix",desc="Centralized RA2 armor/warhead damage resolution.",author="RTSMerge",layer=12,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local matrix={
 SA={NONE=1,LIGHT=0.75,MEDIUM=0.5,HEAVY=0.25,INFANTRY=1,BUILDING=0.5},
 AP={NONE=1,LIGHT=1,MEDIUM=1,HEAVY=0.75,INFANTRY=0.5,BUILDING=0.75},
 HE={NONE=1,LIGHT=0.75,MEDIUM=0.5,HEAVY=0.25,INFANTRY=1,BUILDING=0.5},
}
function gadget:UnitPreDamaged(id,def,team,damage,paralyzer,weapon,attacker)
 if paralyzer or not weapon then return damage end
 local w=WeaponDefs[weapon]; local wc=w and w.customParams or {}; local warhead=wc and wc.ra2_warhead
 local uc=UnitDefs[def] and UnitDefs[def].customParams or {}; local armor=uc.ra2_armor or "NONE"
 local mult=matrix[warhead] and matrix[warhead][armor] or 1
 local veterancy=attacker and (Spring.GetUnitRulesParam(attacker,"ra2_combat_multiplier") or 1) or 1
 return damage*mult*veterancy
end
