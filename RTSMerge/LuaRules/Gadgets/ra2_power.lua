function gadget:GetInfo() return {name="RA2 Power Grid",desc="RA2 power production and deficit state.",author="RTSMerge",layer=5,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local producers,consumers={},{}
function gadget:Initialize() for id,ud in pairs(UnitDefs) do local cp=ud.customParams or {}; producers[id]=tonumber(cp.power) or 0; consumers[id]=tonumber(cp.power_drain) or 0 end end
function gadget:GameFrame(frame)
 if frame%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local prod,drain=0,0
  for _,id in ipairs(Spring.GetTeamUnits(team)) do local d=Spring.GetUnitDefID(id); prod=prod+(producers[d] or 0); drain=drain+(consumers[d] or 0) end
  local ratio=drain>0 and math.min(1,prod/drain) or 1
  Spring.SetTeamRulesParam(team,"ra2_power_production",prod,{allied=true}); Spring.SetTeamRulesParam(team,"ra2_power_drain",drain,{allied=true}); Spring.SetTeamRulesParam(team,"ra2_power_ratio",ratio,{allied=true})
 end
end
