function gadget:GetInfo()
  return {name="RA2 Production and Prerequisites",desc="Authoritative construction/production gates.",author="RTSMerge",layer=20,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end

local rules = VFS.Include("gamedata/ra2_rules.lua")
local unitRules, buildingRules = {}, {}
for _,v in ipairs(rules.units) do unitRules[v.id]=v end
for _,v in ipairs(rules.buildings) do buildingRules[v.id]=v end

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

local function canBuild(teamID, defName)
  local r=buildingRules[defName]
  if r then
    if r.side ~= teamSide(teamID) then return false end
    for _,req in ipairs(r.requires) do if not owns(teamID,req) then return false end end
    return true
  end
  local u=unitRules[defName]
  return u and u.side == teamSide(teamID) and owns(teamID,u.production and (u.side=="allies" and (u.production=="barracks" and "allied_barracks" or "allied_warfactory") or u.side=="soviet" and (u.production=="barracks" and "soviet_barracks" or "soviet_warfactory") or (u.production=="barracks" and "yuri_barracks" or "yuri_warfactory")))
end

function gadget:AllowCommand(unitID,unitDefID,teamID,cmdID,cmdParams,cmdOptions)
  if cmdID ~= CMD.BUILD or not cmdParams or not cmdParams[1] then return true end
  local ud=UnitDefs[math.abs(cmdParams[1])]
  if not ud then return true end
  return canBuild(teamID,ud.name)
end
