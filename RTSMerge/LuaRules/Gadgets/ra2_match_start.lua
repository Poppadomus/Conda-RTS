function gadget:GetInfo() return {name="RA2 Match Bootstrap",desc="Creates an asset-free playable starting state.",author="RTSMerge",layer=1,enabled=true} end
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
function gadget:GameStart()
  local teams=Spring.GetTeamList()
  for teamIndex,teamID in ipairs(teams) do
    local side=sideForTeam(teamID)
    aiTeams[teamID]=(side=="soviet" and #Spring.GetPlayerList(teamID,true)==0)
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
  if frame%90~=0 then return end
  for teamID in pairs(aiTeams) do
    local cy
    for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
      local ud=UnitDefs[Spring.GetUnitDefID(id)]
      if ud and ud.customParams and ud.customParams.role=="conyard" then cy=id break end
    end
    if cy then
      local x,y,z=Spring.GetUnitPosition(cy)
      local function has(role)
        for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
          local ud=UnitDefs[Spring.GetUnitDefID(id)]
          if ud and ud.customParams and ud.customParams.role==role then return true end
        end
        return false
      end
      local build
      if not has("power") then build="soviet_power"
      elseif not has("refinery") then build="soviet_refinery"
      elseif not has("barracks") then build="soviet_barracks"
      elseif not has("warfactory") then build="soviet_warfactory" end
      if build and UnitDefNames[build] then
        Spring.GiveOrderToUnit(cy,-UnitDefNames[build].id,{x+160,y,z+160,0},{})
      end
    end
  end
end
