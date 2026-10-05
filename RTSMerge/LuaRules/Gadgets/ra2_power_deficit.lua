function gadget:GetInfo() return {name="RA2 Power Deficit",desc="Applies RA2-style power deficit to production and defenses.",author="RTSMerge",layer=6,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(frame)
 if frame%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local ratio=Spring.GetTeamRulesParam(team,"ra2_power_ratio") or 1
  Spring.SetTeamRulesParam(team,"ra2_power_deficit",ratio<1 and 1 or 0,{allied=true})
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local cp=UnitDefs[Spring.GetUnitDefID(id)].customParams or {}
   if cp.power_drain then
    Spring.SetUnitRulesParam(id,"ra2_power_efficiency",ratio,{allied=true})
   end
  end
 end
end
