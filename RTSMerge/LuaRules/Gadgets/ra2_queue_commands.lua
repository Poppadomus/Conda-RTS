function gadget:GetInfo() return {name="RA2 Queue Commands",desc="Queues explicit RA2 production requests.",author="RTSMerge",layer=21,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_RA2_QUEUE=CMD.CUSTOM_BASE+200
local names={}
for n,ud in pairs(UnitDefNames) do names[ud.id]=n end
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_RA2_QUEUE) end
function gadget:AllowCommand(id,def,team,cmd,params)
 if cmd~=CMD_RA2_QUEUE then return true end
 local target=params and tonumber(params[1]); if not target or not names[math.abs(target)] then return false end
 local cp=UnitDefs[def].customParams or {}
 return cp.role=="barracks" or cp.role=="warfactory"
end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_RA2_QUEUE then return false end
 local target=math.abs(tonumber(params[1] or 0)); if not names[target] then return true end
 local q=Spring.GetUnitRulesParam(id,"ra2_queue_length") or 0
 Spring.SetUnitRulesParam(id,"ra2_queue_length",q+1,{allied=true})
 if q==0 then Spring.SetUnitRulesParam(id,"ra2_queue_next",target,{allied=true}) end
 return true
end
