function gadget:GetInfo() return {name="RA2 Production Queue",desc="Authoritative deterministic infantry/vehicle production queue.",author="RTSMerge",layer=23,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end

local CMD_QUEUE=CMD.CUSTOM_BASE+200
local names={}
local queues={}

for n,ud in pairs(UnitDefNames) do names[ud.id]=n end

local function canBuild(factoryID,targetID)
  local ud=UnitDefs[Spring.GetUnitDefID(factoryID)]
  if not ud then return false end
  for _,opt in ipairs(ud.buildOptions or {}) do
    if UnitDefNames[opt] and UnitDefNames[opt].id==targetID then return true end
  end
  return false
end

local function costOf(targetID)
  local ud=UnitDefs[targetID]
  if not ud then return 0 end
  local cp=ud.customParams or {}
  return tonumber(cp.ra2_cost) or tonumber(ud.buildCostMetal) or 0
end

local function timeOf(targetID)
  local ud=UnitDefs[targetID]
  if not ud then return 1 end
  return math.max(30,tonumber(ud.buildTime) or 30)
end

function gadget:Initialize()
  gadgetHandler:RegisterAllowCommand(CMD_QUEUE)
end

function gadget:UnitCreated(id)
  queues[id]={}
  Spring.SetUnitRulesParam(id,"ra2_queue_length",0,{allied=true})
  Spring.SetUnitRulesParam(id,"ra2_queue_progress",0,{allied=true})
end

function gadget:UnitDestroyed(id)
  queues[id]=nil
end

function gadget:AllowCommand(id,def,team,cmd,params)
  if cmd~=CMD_QUEUE then return true end
  local target=math.abs(tonumber(params and params[1] or 0))
  local cp=UnitDefs[def] and UnitDefs[def].customParams or {}
  if not target or not names[target] or (cp.role~="barracks" and cp.role~="warfactory") then return false end
  if not canBuild(id,target) then return false end
  local metal=Spring.GetTeamResources(team,"metal")
  return (metal or 0)>=costOf(target)
end

function gadget:CommandFallback(id,def,team,cmd,params)
  if cmd~=CMD_QUEUE then return false end
  local target=math.abs(tonumber(params and params[1] or 0))
  if not target or not canBuild(id,target) then return true end
  local cost=costOf(target)
  if not Spring.UseTeamResource(team,"metal",cost) then return true end
  queues[id]=queues[id] or {}
  queues[id][#queues[id]+1]={target=target,progress=0}
  Spring.SetUnitRulesParam(id,"ra2_queue_length",#queues[id],{allied=true})
  return true
end

function gadget:GameFrame(frame)
  if frame%3~=0 then return end
  for producer,q in pairs(queues) do
    if Spring.ValidUnitID(producer) and #q>0 then
      local item=q[1]
      item.progress=math.min(1,item.progress+3/timeOf(item.target))
      Spring.SetUnitRulesParam(producer,"ra2_queue_progress",item.progress,{allied=true})
      if item.progress>=1 then
        local x,y,z=Spring.GetUnitPosition(producer)
        local spawned=false
        if x and UnitDefs[item.target] then
          local team=Spring.GetUnitTeam(producer)
          local offsets={{64,64},{-64,64},{64,-64},{-64,-64},{0,96},{0,-96},{96,0},{-96,0}}
          for _,o in ipairs(offsets) do
            local sx,sz=x+o[1],z+o[2]
            if sx>=0 and sz>=0 and sx<=Game.mapSizeX and sz<=Game.mapSizeZ then
              local created=Spring.CreateUnit(item.target,sx,Spring.GetGroundHeight(sx,sz),sz,0,team)
              if created then spawned=true; break end
            end
          end
        end
        if spawned then table.remove(q,1) else item.progress=math.max(0,item.progress-0.05) end
        Spring.SetUnitRulesParam(producer,"ra2_queue_length",#q,{allied=true})
        Spring.SetUnitRulesParam(producer,"ra2_queue_progress",#q>0 and 0 or 0,{allied=true})
      end
    end
  end
end
