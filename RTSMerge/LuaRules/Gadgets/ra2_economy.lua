function gadget:GetInfo() return {name="RA2 Authoritative Economy",desc="Deterministic logical ore, harvester cargo and refinery delivery.",author="RTSMerge",layer=2,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end

local harvester,refinery,state={}, {}, {}
local CAPACITY=1000
local LOAD_PER_TICK=25
local ORE_RADIUS=140
local ORE_POINTS={}

local function orePointFor(teamID)
  if not ORE_POINTS[teamID] then
    local mx,mz=Game.mapSizeX*0.5,Game.mapSizeZ*0.5
    local slot=(teamID%4)-1.5
    ORE_POINTS[teamID]={math.max(80,math.min(Game.mapSizeX-80,mx+slot*260)),math.max(80,math.min(Game.mapSizeZ-80,mz+((teamID%2)*2-1)*180))}
  end
  return ORE_POINTS[teamID][1],ORE_POINTS[teamID][2]
end
local function nearestRefinery(teamID,x,z)
  local best,bestDist=nil,nil
  for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
    if refinery[Spring.GetUnitDefID(id)] then
      local rx,_,rz=Spring.GetUnitPosition(id)
      if rx then
        local d=(x-rx)^2+(z-rz)^2
        if not bestDist or d<bestDist then best,bestDist=id,d end
      end
    end
  end
  return best
end
function gadget:Initialize()
  for id,ud in pairs(UnitDefs) do
    local cp=ud.customParams or {}
    harvester[id]=cp.ra2_harvester=="1"
    refinery[id]=cp.ra2_refinery=="1" or cp.role=="refinery"
  end
end
function gadget:UnitCreated(id,def,team)
  if harvester[def] then
    state[id]={cargo=0,mode="ore",lastOrder=-1000}
    Spring.SetUnitRulesParam(id,"ra2_cargo",0,{allied=true})
  end
end
function gadget:UnitDestroyed(id) state[id]=nil end
function gadget:GameFrame(frame)
  if frame%15~=0 then return end
  for id,s in pairs(state) do
    if Spring.ValidUnitID(id) then
      local team=Spring.GetUnitTeam(id)
      local x,_,z=Spring.GetUnitPosition(id)
      if x then
        local ox,oz=orePointFor(team)
        local refineryID=nearestRefinery(team,x,z)
        local rx,rz
        if refineryID then rx,_,rz=Spring.GetUnitPosition(refineryID) end
        if s.mode=="ore" then
          if s.cargo<CAPACITY then
            if frame-s.lastOrder>=90 then
              Spring.GiveOrderToUnit(id,CMD.MOVE,{ox,Spring.GetGroundHeight(ox,oz),oz},{})
              s.lastOrder=frame
            end
            if (x-ox)^2+(z-oz)^2<=ORE_RADIUS^2 then
              s.cargo=math.min(CAPACITY,s.cargo+LOAD_PER_TICK)
              Spring.SetUnitRulesParam(id,"ra2_cargo",s.cargo,{allied=true})
              if s.cargo>=CAPACITY then s.mode="refinery" end
            end
          else s.mode="refinery" end
        elseif s.mode=="refinery" and refineryID and rx then
          if frame-s.lastOrder>=90 then
            Spring.GiveOrderToUnit(id,CMD.MOVE,{rx,Spring.GetGroundHeight(rx,rz),rz},{})
            s.lastOrder=frame
          end
          if (x-rx)^2+(z-rz)^2<=120^2 then
            local amount=s.cargo
            local current,storage=Spring.GetTeamResources(team,"metal")
            local room=math.max(0,(storage or 10000)-(current or 0))
            amount=math.min(amount,room)
            if amount>0 then
              Spring.AddTeamResource(team,"metal",amount)
              current=(current or 0)+amount
              Spring.SetTeamRulesParam(team,"ra2_credits",current,{allied=true})
              s.cargo=s.cargo-amount
              Spring.SetUnitRulesParam(id,"ra2_cargo",s.cargo,{allied=true})
            end
            if s.cargo<=0 then s.mode="ore" end
          end
        end
      end
    end
  end
end
