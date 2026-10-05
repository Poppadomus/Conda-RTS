function gadget:GetInfo() return {name="RA2 Veterancy",desc="Deterministic veteran/elite promotion.",author="RTSMerge",layer=30,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local xp={}; local thresholds={100,250,500}; local mult={1,1.1,1.25,1.5}
local function level(v) if v>=thresholds[3] then return 3 elseif v>=thresholds[2] then return 2 elseif v>=thresholds[1] then return 1 end return 0 end
local function apply(id)
 local e=xp[id]; if not e then return end
 local l=level(e.value)
 e.level=l
 Spring.SetUnitRulesParam(id,"ra2_veterancy",l,{allied=true})
 Spring.SetUnitRulesParam(id,"ra2_combat_multiplier",mult[l+1],{allied=true})
end
function gadget:Initialize() for _,id in ipairs(Spring.GetAllUnits()) do xp[id]={value=0,level=0} end end
function gadget:UnitCreated(id) xp[id]={value=0,level=0} end
function gadget:UnitDestroyed(id,def,team,attacker)
 if attacker and xp[attacker] then xp[attacker].value=xp[attacker].value+50; apply(attacker) end
 xp[id]=nil
end
function gadget:UnitDamaged(id,def,team,damage,paralyzer,weapon,attacker)
 if attacker and attacker~=id and xp[attacker] then xp[attacker].value=xp[attacker].value+math.max(1,math.floor(damage)); apply(attacker) end
end
