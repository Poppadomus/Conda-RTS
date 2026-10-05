function gadget:GetInfo() return {name="RA2 Capture Target",desc="Stores engineer capture targets.",author="RTSMerge",layer=25,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_CAPTURE=CMD.CUSTOM_BASE+203
function gadget:AllowCommand(id,def,team,cmd,params) if cmd~=CMD_CAPTURE then return true end; return Spring.GetUnitRulesParam(id,"ra2_capture")==1 and params and params[1]~=nil end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_CAPTURE then return false end
 local target=params and params[1]
 if target and Spring.ValidUnitID(target) and Spring.GetUnitTeam(target)~=team then Spring.SetUnitRulesParam(id,"ra2_capture_target",target,{allied=true}); Spring.SetUnitRulesParam(id,"ra2_capture_progress",0,{allied=true}) end
 return true
end
