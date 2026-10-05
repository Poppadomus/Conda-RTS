function gadget:GetInfo() return {name="RA2 Capture Action",desc="Engineer capture command.",author="RTSMerge",layer=24,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_CAPTURE=CMD.CUSTOM_BASE+203
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_CAPTURE) end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_CAPTURE then return false end
 if Spring.GetUnitRulesParam(id,"ra2_capture")~=1 then return true end
 local target=params and params[1]
 if target and Spring.ValidUnitID(target) and Spring.GetUnitTeam(target)~=team then Spring.SetUnitRulesParam(target,"ra2_capture_progress",0,{allied=true}) end
 return true
end
