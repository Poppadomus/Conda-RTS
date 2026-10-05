function gadget:GetInfo() return {name="RA2 Win Loss",desc="Authoritative base-destruction win/loss state.",author="RTSMerge",layer=70,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local alive=false
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local cp=UnitDefs[Spring.GetUnitDefID(id)].customParams or {}
   if cp.ra2_conyard=="1" or cp.ra2_mcv=="1" then alive=true; break end
  end
  Spring.SetTeamRulesParam(team,"ra2_base_alive",alive and 1 or 0,{allied=true})
 end
end
