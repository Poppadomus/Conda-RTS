function gadget:GetInfo() return {name="RA2 Repair Tick",desc="Applies repair action over time.",author="RTSMerge",layer=24,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   if Spring.GetUnitRulesParam(id,"ra2_repairing")==1 then
    local target=Spring.GetUnitRulesParam(id,"ra2_repair_target")
    if target and Spring.ValidUnitID(target) and Spring.GetUnitTeam(target)==team then
     local hp,maxhp=Spring.GetUnitHealth(target)
     if hp and maxhp then Spring.SetUnitHealth(target,{health=math.min(maxhp,hp+10)}) end
    end
   end
  end
 end
end
