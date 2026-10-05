function gadget:GetInfo() return {name="RA2 Vision and Radar",desc="RA2-style radar and spy satellite state.",author="RTSMerge",layer=2,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(frame)
 if frame%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local radar,sat=0,0
  for _,id in ipairs(Spring.GetTeamUnits(team)) do local cp=UnitDefs[Spring.GetUnitDefID(id)].customParams or {}; radar=math.max(radar,tonumber(cp.ra2_radar) or 0); sat=math.max(sat,tonumber(cp.ra2_spy_satellite) or 0) end
  Spring.SetTeamRulesParam(team,"ra2_radar",radar,{allied=true}); Spring.SetTeamRulesParam(team,"ra2_spy_satellite",sat,{allied=true})
 end
end
