function gadget:GetInfo() return {name="RA2 Veterancy Healing",desc="Veteran and elite regeneration.",author="RTSMerge",layer=31,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do for _,id in ipairs(Spring.GetTeamUnits(team)) do local v=Spring.GetUnitRulesParam(id,"ra2_veterancy") or 0; if v>0 then local hp,maxhp=Spring.GetUnitHealth(id); if hp and maxhp and hp<maxhp then Spring.SetUnitHealth(id,{health=math.min(maxhp,hp+v)}) end end end end
end
