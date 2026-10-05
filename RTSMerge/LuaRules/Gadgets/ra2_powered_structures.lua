function gadget:GetInfo() return {name="RA2 Powered Structures",desc="Marks structures affected by power deficit.",author="RTSMerge",layer=7,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do local ratio=Spring.GetTeamRulesParam(team,"ra2_power_ratio") or 1
  for _,id in ipairs(Spring.GetTeamUnits(team)) do local cp=UnitDefs[Spring.GetUnitDefID(id)].customParams or {}; if cp.ra2_powered=="1" then Spring.SetUnitRulesParam(id,"ra2_power_efficiency",ratio,{allied=true}) end end
 end
end
