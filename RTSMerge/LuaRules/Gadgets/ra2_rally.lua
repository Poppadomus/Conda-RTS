function gadget:GetInfo() return {name="RA2 Rally Points",desc="Stores deterministic factory rally positions.",author="RTSMerge",layer=25,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_RALLY=CMD.CUSTOM_BASE+209
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_RALLY) end
function gadget:AllowCommand(id,def,team,cmd,params)
 if cmd~=CMD_RALLY then return true end
 local cp=UnitDefs[def].customParams or {}
 return cp.role=="barracks" or cp.role=="warfactory"
end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_RALLY then return false end
 local x=tonumber(params and params[1]); local z=tonumber(params and params[2])
 if not x or not z then return true end
 Spring.SetUnitRulesParam(id,"ra2_rally_x",x,{allied=true}); Spring.SetUnitRulesParam(id,"ra2_rally_z",z,{allied=true})
 return true
end