function gadget:GetInfo() return {name="RA2 Repair Action",desc="Repair command for repair-capable units.",author="RTSMerge",layer=23,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_REPAIR=CMD.CUSTOM_BASE+202
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_REPAIR) end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_REPAIR then return false end
 if Spring.GetUnitRulesParam(id,"ra2_repair_capable")~=1 then return true end
 local target=params and params[1]
 if target and Spring.ValidUnitID(target) and Spring.GetUnitTeam(target)==team then Spring.SetUnitRulesParam(target,"ra2_repairing",1,{allied=true}) end
 return true
end
