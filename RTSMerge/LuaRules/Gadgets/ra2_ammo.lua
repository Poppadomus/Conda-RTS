function gadget:GetInfo() return {name="RA2 Ammo State",desc="Ammo/reload bookkeeping.",author="RTSMerge",layer=40,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id) Spring.SetUnitRulesParam(id,"ra2_ammo",100,{allied=true}) end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do for _,id in ipairs(Spring.GetTeamUnits(team)) do local a=Spring.GetUnitRulesParam(id,"ra2_ammo") or 0; Spring.SetUnitRulesParam(id,"ra2_ammo",math.min(100,a+5),{allied=true}) end end
end
