function gadget:GetInfo() return {name="RA2 Spawn Rules",desc="Validates faction starting-unit compatibility.",author="RTSMerge",layer=17,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local allowed={allied_mcv=true,soviet_mcv=true,yuri_mcv=true}
function gadget:Initialize()
 for _,team in ipairs(Spring.GetTeamList()) do
  local units=Spring.GetTeamUnits(team)
  for _,id in ipairs(units) do
   local n=UnitDefs[Spring.GetUnitDefID(id)].name
   Spring.SetUnitRulesParam(id,"ra2_starting_unit",allowed[n] and 1 or 0,{allied=true})
  end
 end
end
