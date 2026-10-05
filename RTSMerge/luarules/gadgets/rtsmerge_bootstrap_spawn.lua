function gadget:GetInfo()
  return {name="RTSMerge Bootstrap Spawn",desc="Hard bootstrap that guarantees a visible MCV test unit.",author="RTSMerge",layer=-1000,enabled=true}
end

if not gadgetHandler:IsSyncedCode() then return end

local sides={allies="allied_mcv",soviet="soviet_mcv",yuri="yuri_mcv"}

local function sideForTeam(teamID)
  local _,_,_,_,side=Spring.GetTeamInfo(teamID,false)
  if type(side)=="string" and sides[side:lower()] then return side:lower() end
  return "allies"
end

local function getMCV(teamID)
  for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
    local ud=UnitDefs[Spring.GetUnitDefID(id)]
    if ud and ud.customParams and ud.customParams.role=="mcv" then return id end
  end
end

local function spawn(teamID)
  if getMCV(teamID) then return true end
  local side=sideForTeam(teamID)
  local def=UnitDefNames[sides[side]]
  if not def then
    Spring.Echo("RTSMERGE BOOT FAIL: missing UnitDef",sides[side])
    return false
  end
  local x,z
  x,z=Spring.GetTeamStartPosition(teamID)
  if not x or x<0 then
    local teams=Spring.GetTeamList()
    local index=1
    for i,t in ipairs(teams) do if t==teamID then index=i end end
    x=(index%2==1) and 256 or (Game.mapSizeX-256)
    z=Game.mapSizeZ*0.5
  end
  local y=Spring.GetGroundHeight(x,z)
  local id=Spring.CreateUnit(def.id,x,y,z,0,teamID)
  if id then
    Spring.SetUnitRulesParam(id,"ra2_bootstrap",1,{allied=true})
    Spring.SetUnitRulesParam(id,"ra2_scale",2.5,{allied=true})
    Spring.Echo("RTSMERGE SPAWNED MCV",id,side,x,z)
    return true
  end
  Spring.Echo("RTSMERGE BOOT FAIL: CreateUnit returned nil",side,x,z)
  return false
end

function gadget:GameStart()
  for _,teamID in ipairs(Spring.GetTeamList()) do
    spawn(teamID)
  end
end

function gadget:GameFrame(frame)
  if frame%60==0 then
    for _,teamID in ipairs(Spring.GetTeamList()) do spawn(teamID) end
  end
end
