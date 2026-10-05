function gadget:GetInfo()
  return {name="RA2 Production and Prerequisites",desc="Authoritative construction and production gates.",author="RTSMerge",layer=20,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end

local rules=VFS.Include("gamedata/ra2_rules.lua")
local unitRules,buildingRules={},{}
for _,v in ipairs(rules.units) do unitRules[v.id]=v end
for _,v in ipairs(rules.buildings) do buildingRules[v.id]=v end

local defNameByID={}
for name,ud in pairs(UnitDefNames) do defNameByID[ud.id]=name end

local function teamSide(teamID)
  local side=select(5,Spring.GetTeamInfo(teamID,false))
  return side==0 and "allies" or side==1 and "soviet" or "yuri"
end

local function owns(teamID,name)
  local ud=UnitDefNames[name]
  return ud and Spring.GetTeamUnitDefCount(teamID,ud.id)>0
end

local function producerFor(side,production)
  local p={
    allies={barracks="allied_barracks",warfactory="allied_warfactory"},
    soviet={barracks="soviet_barracks",warfactory="soviet_warfactory"},
    yuri={barracks="yuri_barracks",warfactory="yuri_warfactory"},
  }
  return p[side] and p[side][production]
end

local function canBuild(teamID,name)
  local side=teamSide(teamID)
  local b=buildingRules[name]
  if b then
    if b.side~=side then return false end
    for _,req in ipairs(b.requires) do if not owns(teamID,req) then return false end end
    return true
  end
  local u=unitRules[name]
  if not u or u.side~=side then return false end
  local producer=producerFor(side,u.production)
  return producer~=nil and owns(teamID,producer)
end

function gadget:AllowCommand(unitID,unitDefID,teamID,cmdID,cmdParams,cmdOptions)
  if cmdID~=CMD.BUILD or not cmdParams or not cmdParams[1] then return true end
  local defName=defNameByID[math.abs(cmdParams[1])]
  if not defName then return false end
  return canBuild(teamID,defName)
end
