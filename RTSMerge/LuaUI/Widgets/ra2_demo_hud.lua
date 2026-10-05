function widget:GetInfo()
  return {
    name="RA2 Demo HUD",
    desc="Procedural demo status and controls.",
    author="RTSMerge",
    layer=2,
    enabled=true,
  }
end

local focused=false

local function selected()
  local s=Spring.GetSelectedUnits()
  return s and s[1]
end

local function findMCV(teamID)
  for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
    local ud=UnitDefs[Spring.GetUnitDefID(id)]
    if ud and ud.customParams and ud.customParams.role=="mcv" then
      return id
    end
  end
end

function widget:Update()
  if focused then return end
  local mcv=findMCV(Spring.GetMyTeamID())
  if mcv then
    Spring.SelectUnitArray({mcv})
    Spring.SendCommands("viewselection")
    focused=true
  end
end

function widget:DrawScreen()
  local vsx,vsy=Spring.GetViewGeometry()
  local team=Spring.GetMyTeamID()
  local metal=Spring.GetTeamResources(team,"metal")
  local power=Spring.GetTeamRulesParam(team,"ra2_power_ratio") or 1
  local low=Spring.GetTeamRulesParam(team,"ra2_low_power") or 0

  gl.Color(0,0,0,0.72)
  gl.Rect(12,vsy-92,350,vsy-12)
  gl.Color(1,1,1,1)
  gl.Text("RA2 SPRING DEMO",24,vsy-34,18,"o")
  gl.Text("Credits: "..math.floor(metal or 0).."   Power: "..math.floor(power*100).."%",24,vsy-56,13,"o")
  gl.Text("MCV: deploy  |  CY: build  |  Barracks/Factory: click sidebar",24,vsy-76,11,"o")
  if low>0 then
    gl.Text("LOW POWER",vsx/2-45,vsy-34,16,"o")
  end

  local sel=Spring.GetSelectedUnits()
  if not sel or #sel==0 then return end

  local y=180
  for i=1,math.min(#sel,8) do
    local id=sel[i]
    local ud=UnitDefs[Spring.GetUnitDefID(id)]
    local name=ud and ud.name or "Unit"
    local hp,maxhp=Spring.GetUnitHealth(id)
    local p=(maxhp and maxhp>0) and math.max(0,math.min(1,hp/maxhp)) or 0

    gl.Color(0,0,0,0.72)
    gl.Rect(18,y-3,218,y+20)
    gl.Color(0.15,0.15,0.15,1)
    gl.Rect(26,y,190,y+6)
    gl.Color(0.2,0.85,0.25,1)
    gl.Rect(26,y,26+164*p,y+6)
    gl.Color(1,1,1,1)
    gl.Text(name,26,y+17,11,"o")
    y=y+28
  end
end
