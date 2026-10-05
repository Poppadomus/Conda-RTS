function gadget:GetInfo() return {name="RA2 Queue Commands",desc="Queues explicit RA2 production requests.",author="RTSMerge",layer=21,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_RA2_QUEUE=CMD.CUSTOM_BASE+200
local queues={}
local names={}
for n,ud in pairs(UnitDefNames) do names[ud.id]=n end
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_RA2_QUEUE) end
function gadget:AllowCommand(id,def,team,cmd,params)
 if cmd~=CMD_RA2_QUEUE then return true end
 return params and params[1] and names[math.abs(params[1])]~=nil
end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_RA2_QUEUE then return false end
 queues[id]=queues[id] or {}
 local target=params and params[1]
 if target then queues[id][#queues[id]+1]=math.abs(target) end
 Spring.SetUnitRulesParam(id,"ra2_queue_length",#queues[id],{allied=true})
 return true
end
