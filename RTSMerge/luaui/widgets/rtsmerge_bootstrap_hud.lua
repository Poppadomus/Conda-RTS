function widget:GetInfo()
  return {name="RTSMerge Bootstrap HUD",desc="Hard diagnostic HUD for RTSMerge boot visibility.",author="RTSMerge",layer=100000,enabled=true}
end

local function findRole(teamID, role)
  for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
    local ud=UnitDefs[Spring.GetUnitDefID(id)]
    if ud and ud.customParams and ud.customParams.role==role then return id end
  end
end

function widget:DrawScreen()
  local vsx,vsy=Spring.GetViewGeometry()
  local team=Spring.GetMyTeamID()
  local mcv=findRole(team,"mcv")
  gl.Color(0,0,0,0.85)
  gl.Rect(20,20,620,145)
  gl.Color(1,1,0.2,1)
  gl.Text("RTSMERGE BOOT OK",38,112,28,"o")
  gl.Color(1,1,1,1)
  gl.Text("LuaUI is running.  Team "..team.."  MCV="..tostring(mcv or "MISSING"),38,84,18,"o")
  gl.Text("If MCV is MISSING, the simulation bootstrap/UnitDefs are the next problem.",38,58,13,"o")
  gl.Text("Procedural renderer is being forced to use an oversized visible chassis.",38,38,13,"o")
end

function widget:Update()
  local team=Spring.GetMyTeamID()
  local mcv=findRole(team,"mcv")
  if mcv then
    Spring.SelectUnitArray({mcv})
    Spring.SendCommands("viewselection")
  end
end
