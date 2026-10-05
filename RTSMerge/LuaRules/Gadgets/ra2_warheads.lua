function gadget:GetInfo() return {name="RA2 Warhead Matrix",desc="RA2 armor and warhead interaction framework.",author="RTSMerge",layer=12,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local mult={default=1,light=1,medium=1,heavy=1,infantry=1,building=1,air=1,naval=1}
function gadget:UnitPreDamaged(id,def,team,damage,paralyzer,weapon,attacker)
 if paralyzer then return damage end
 local cp=UnitDefs[def] and UnitDefs[def].customParams or {}
 local cls=cp.ra2_armor or "default"
 return damage*(mult[cls] or 1)
end
