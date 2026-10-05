function gadget:GetInfo() return {name="RA2 Production Spawn",desc="Consumes explicit RA2 queue entries and creates Spring units.",author="RTSMerge",layer=23,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_QUEUE=CMD.CUSTOM_BASE+200
local names={}
local queues={}
for n,ud in pairs(UnitDefNames) do names[ud.id]=n end
local function canBuild(id,target)
 local ud=UnitDefs[Spring.GetUnitDefID(id)]
 for _,opt in ipairs(ud.buildOptions or {}) do if UnitDefNames[opt] and UnitDefNames[opt].id==target then return true end end
 return false
end
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_QUEUE) end
function gadget:AllowCommand(id,def,team,cmd,params)
 if cmd~=CMD_QUEUE then return true end
 local target=math.abs(tonumber(params and params[1] or 0)); local cp=UnitDefs[def].customParams or {}
 return target>0 and names[target]~=nil and (cp.role=="barracks" or cp.role=="warfactory") and canBuild(id,target)
end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_QUEUE then return false end
 local target=math.abs(tonumber(params and params[1] or 0)); if not target or not canBuild(id,target) then return true end
 queues[id]=queues[id] or {}; queues[id][#queues[id]+1]=target
 Spring.SetUnitRulesParam(id,"ra2_queue_length",#queues[id],{allied=true})
 return true
end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for producer,q in pairs(queues) do
  if Spring.ValidUnitID(producer) and #q>0 then
   local p=Spring.GetUnitRulesParam(producer,"ra2_queue_progress") or 0
   if p>=1 then
    local target=q[1]; table.remove(q,1)
    local x,y,z=Spring.GetUnitPosition(producer)
    if x and UnitDefs[target] then Spring.CreateUnit(target,x+32,y,z+32,0,Spring.GetUnitTeam(producer)) end
    Spring.SetUnitRulesParam(producer,"ra2_queue_length",#q,{allied=true})
    Spring.SetUnitRulesParam(producer,"ra2_queue_progress",0,{allied=true})
   end
  end
 end
end
