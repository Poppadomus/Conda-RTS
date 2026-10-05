function gadget:GetInfo() return {name="RA2 Base Power",desc="Base power production state.",author="RTSMerge",layer=6,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local prod=0
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local cp=UnitDefs[Spring.GetUnitDefID(id)].customParams or {}
   prod=prod+(tonumber(cp.power) or 0)
  end
  Spring.SetTeamRulesParam(team,"ra2_power_production",prod,{allied=true})
 end
end
