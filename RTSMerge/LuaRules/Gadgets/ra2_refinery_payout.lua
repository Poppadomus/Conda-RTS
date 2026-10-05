function gadget:GetInfo() return {name="RA2 Refinery Payout",desc="Pays delivered harvester cargo into the Spring resource ledger.",author="RTSMerge",layer=11,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local cur,_,_,storage=Spring.GetTeamResources(team,"metal")
  for _,id in ipairs(Spring.GetTeamUnits(team)) do
   local cp=UnitDefs[Spring.GetUnitDefID(id)].customParams or {}
   if cp.ra2_harvester=="1" and (Spring.GetUnitRulesParam(id,"ra2_harvester_state") or 0)==1 then
    local load=Spring.GetUnitRulesParam(id,"ra2_cargo") or 0
    local room=math.max(0,(storage or 10000)-(cur or 0))
    local gain=math.min(load,room)
    if gain>0 then Spring.AddTeamResource(team,"metal",gain); Spring.SetUnitRulesParam(id,"ra2_cargo",load-gain,{allied=true}) end
   end
  end
 end
end
