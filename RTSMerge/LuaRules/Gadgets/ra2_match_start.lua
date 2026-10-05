function gadget:GetInfo() return {name="RA2 Match Bootstrap",desc="Creates an asset-free playable starting state and deterministic demo opponent.",author="RTSMerge",layer=1,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end

local mcvBySide={allies="allied_mcv",soviet="soviet_mcv",yuri="yuri_mcv"}
local harvesterBySide={allies="allied_harvester",soviet="soviet_harvester",yuri="yuri_slave_miner"}
local rules=VFS.Include("gamedata/ra2_rules.lua")
local aiTeams={}
local function sideForTeam(teamID)
  local _,_,_,_,side=Spring.GetTeamInfo(teamID,false)
  if type(side)=="string" then return side:lower() end
  side=tonumber(side) or 0
  return side==1 and "soviet" or side==2 and "yuri" or "allies"
end
local function roleUnit(teamID,role)
  for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
    local ud=UnitDefs[Spring.GetUnitDefID(id)]
    if ud and ud.customParams and ud.customParams.role==role then return id end
  end
end
local function hasOrders(id)
  local cmds=Spring.GetUnitCommands(id,1)
  return cmds and #cmds>0
end
local function enemyStart(teamID)
  local myAlly=select(6,Spring.GetTeamInfo(teamID,false))
  for _,other in ipairs(Spring.GetTeamList()) do
    if other~=teamID and select(6,Spring.GetTeamInfo(other,false))~=myAlly then
      local x,y,z=Spring.GetTeamStartPosition(other)
      if x and x>=0 then return x,y,z end
    end
  end
end

function gadget:GameStart()
  for teamIndex,teamID in ipairs(Spring.GetTeamList()) do
    local side=sideForTeam(teamID)
    aiTeams[teamID]=(side=="soviet" and Spring.GetTeamLuaAI(teamID)=="RA2DemoAI")
    local units=Spring.GetTeamUnits(teamID)
    if #units==0 then
      local mcv=UnitDefNames[mcvBySide[side] or mcvBySide.allies]
      local x,y,z=Spring.GetTeamStartPosition(teamID)
      if not x or x<0 then
        local sideIndex=(teamIndex-1)%2
        x=sideIndex==0 and 1024 or (Game.mapSizeX-1024)
        z=Game.mapSizeZ*0.5
        y=Spring.GetGroundHeight(x,z)
      end
      if mcv and x and x>=0 then
        local mcvID=Spring.CreateUnit(mcv.id,x,y,z,0,teamID)
        local harv=UnitDefNames[harvesterBySide[side] or harvesterBySide.allies]
        if mcvID and harv then
          local hx,hz=x+96,z+96
          Spring.CreateUnit(harv.id,hx,Spring.GetGroundHeight(hx,hz),hz,0,teamID)
        end
      end
    end
    Spring.SetTeamResource(teamID,"metalStorage",rules.credits.capacity)
    Spring.SetTeamResource(teamID,"metal",rules.credits.starting)
    Spring.SetTeamRulesParam(teamID,"ra2_credits",rules.credits.starting,{allied=true})
  end
end

function gadget:GameFrame(frame)
  for teamID in pairs(aiTeams) do
    local cy=roleUnit(teamID,"conyard")
    if frame%90==0 and cy then
      local x,y,z=Spring.GetUnitPosition(cy)
      local build
      if not roleUnit(teamID,"power") then build="soviet_power"
      elseif not roleUnit(teamID,"refinery") then build="soviet_refinery"
      elseif not roleUnit(teamID,"barracks") then build="soviet_barracks"
      elseif not roleUnit(teamID,"warfactory") then build="soviet_warfactory" end
      local offsets={
        soviet_power={160,160},
        soviet_refinery={-160,160},
        soviet_barracks={160,-160},
        soviet_warfactory={-160,-160},
      }
      if build and UnitDefNames[build] then
        local o=offsets[build]
        Spring.GiveOrderToUnit(cy,-UnitDefNames[build].id,{x+o[1],y,z+o[2],0},{})
      end
    end
    if frame%180==0 then
      local wf=roleUnit(teamID,"warfactory")
      local tank=UnitDefNames.rhino_tank
      if wf and tank and Spring.GetTeamResources(teamID,"metal")>=900 then
        Spring.GiveOrderToUnit(wf,CMD.CUSTOM_BASE+200,{tank.id},{})
      end
    end
    if frame%30==0 then
      local ex,ey,ez=enemyStart(teamID)
      if ex then
        for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
          local ud=UnitDefs[Spring.GetUnitDefID(id)]
          if ud and ud.customParams and ud.customParams.role=="tank" and not hasOrders(id) then
            Spring.GiveOrderToUnit(id,CMD.MOVE,{ex,ey,ez},{})
          end
        end
      end
    end
  end
end
