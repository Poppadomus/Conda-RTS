function gadget:GetInfo() return {name="RA2 Objective Actions",desc="Objective completion state.",author="RTSMerge",layer=51,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_OBJECTIVE=CMD.CUSTOM_BASE+207
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_OBJECTIVE) end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_OBJECTIVE then return false end
 local value=params and tonumber(params[1]) or 1
 Spring.SetTeamRulesParam(team,"ra2_objective_state",value,{allied=true})
 return true
end
