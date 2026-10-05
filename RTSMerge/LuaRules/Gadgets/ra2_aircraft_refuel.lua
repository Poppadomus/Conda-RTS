function gadget:GetInfo() return {name="RA2 Aircraft Refuel",desc="Aircraft return/refuel state.",author="RTSMerge",layer=39,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do for _,id in ipairs(Spring.GetTeamUnits(team)) do
  local cp=UnitDefs[Spring.GetUnitDefID(id)].customParams or {}
  if cp.ra2_aircraft=="1" then Spring.SetUnitRulesParam(id,"ra2_refuel",1,{allied=true}) end
 end end
end
