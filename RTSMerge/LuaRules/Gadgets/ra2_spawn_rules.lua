function gadget:GetInfo() return {name="RA2 Spawn Rules",desc="Initializes faction starting-unit state.",author="RTSMerge",layer=5,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:GameStart()
 for _,team in ipairs(Spring.GetTeamList()) do
  local side=select(5,Spring.GetTeamInfo(team,false))
  Spring.SetTeamRulesParam(team,"ra2_start_side",side or "unknown",{allied=true})
 end
end
function gadget:UnitCreated(id,def,team)
 local cp=UnitDefs[def].customParams or {}
 if cp.role=="mcv" then Spring.SetUnitRulesParam(id,"ra2_starting_mcv",1,{allied=true}) end
end
