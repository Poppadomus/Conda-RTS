function gadget:GetInfo()
  return {name="RA2 Production and Prerequisites",desc="Authoritative construction/production gates.",author="RTSMerge",layer=20,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end

local rules = VFS.Include("gamedata/ra2_rules.lua")
local unitRules, buildingRules, keyByDefID = {}, {}, {}
for _,v in ipairs(rules.units) do unitRules[v.id]=v end
for _,v in ipairs(rules.buildings) do buildingRules[v.id]=v end
for key,ud in pairs(UnitDefNames) do keyByDefID[ud.id]=key end

local function teamSide(teamID)
  local _,_,_,_,side = Spring.GetTeamInfo(teamID)
  return side == 1 and "allies" or side == 2 and "soviet" or "yuri"
end

local function owns(teamID, defName)
  local ud=UnitDefNames[defName]
  if not ud then return false end
  for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
    if Spring.GetUnitDefID(id)==ud.id then return true end
  end
  return false
end

local producer = {
  allies={barracks="allied_barracks",warfactory="allied_warfactory"},
  soviet={barracks="soviet_barracks",warfactory="soviet_warfactory"},
  yuri={barracks="yuri_barracks",warfactory="yuri_warfactory"},
}

local function canBuild(teamID, defName)
  local b=buildingRules[defName]
  if b then
    if b.side ~= teamSide(teamID) then return false end
    for _,req in ipairs(b.requires) do
      if not owns(teamID,req) then return false end
    end
    return true
  end
  local u=unitRules[defName]
  if not u or u.side ~= teamSide(teamID) then return false end
  local p=producer[u.side] and producer[u.side][u.production]
  return p ~= nil and owns(teamID,p)
end

function gadget:AllowCommand(unitID,unitDefID,teamID,cmdID,cmdParams,cmdOptions)
  if cmdID ~= CMD.BUILD or not cmdParams or not cmdParams[1] then return true end
  local defName=keyByDefID[math.abs(cmdParams[1])]
  if not defName then return false end
  return canBuild(teamID,defName)
end
