function gadget:GetInfo() return {name="RA2 Repair Target",desc="Stores repair targets.",author="RTSMerge",layer=25,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_REPAIR=CMD.CUSTOM_BASE+202
function gadget:AllowCommand(id,def,team,cmd,params) if cmd~=CMD_REPAIR then return true end; return Spring.GetUnitRulesParam(id,"ra2_repair_capable")==1 and params and params[1]~=nil end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_REPAIR then return false end
 local target=params and params[1]
 if target and Spring.ValidUnitID(target) and Spring.GetUnitTeam(target)==team then Spring.SetUnitRulesParam(id,"ra2_repair_target",target,{allied=true}); Spring.SetUnitRulesParam(id,"ra2_repairing",1,{allied=true}) end
 return true
end
