function gadget:GetInfo() return {name="RA2 Win Loss",desc="Determines base survival and publishes elimination state.",author="RTSMerge",layer=70,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local alive=false
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local cp=UnitDefs[Spring.GetUnitDefID(id)].customParams or {}
   if cp.role=="conyard" or cp.role=="mcv" then alive=true break end
  end
  Spring.SetTeamRulesParam(team,"ra2_base_alive",alive and 1 or 0,{allied=true})
 end
end
