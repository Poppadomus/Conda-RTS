function gadget:GetInfo() return {name="RA2 Veterancy State",desc="Publishes deterministic veterancy thresholds.",author="RTSMerge",layer=32,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id) Spring.SetUnitRulesParam(id,"ra2_xp",0,{allied=true}) end
function gadget:UnitDestroyed(id,def,team,attacker)
 if attacker and Spring.ValidUnitID(attacker) then
  local xp=Spring.GetUnitRulesParam(attacker,"ra2_xp") or 0
  Spring.SetUnitRulesParam(attacker,"ra2_xp",xp+50,{allied=true})
 end
end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do for _,id in ipairs(Spring.GetTeamUnits(team)) do
  local xp=Spring.GetUnitRulesParam(id,"ra2_xp") or 0
  local level=xp>=500 and 3 or xp>=250 and 2 or xp>=100 and 1 or 0
  Spring.SetUnitRulesParam(id,"ra2_veterancy",level,{allied=true})
 end end
end
