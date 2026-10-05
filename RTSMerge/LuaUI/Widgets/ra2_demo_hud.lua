function widget:GetInfo() return {name="RA2 Demo HUD",desc="Procedural demo status and controls.",author="RTSMerge",layer=2,enabled=true} end
local function selected() local s=Spring.GetSelectedUnits(); return s and s[1] end
function widget:DrawScreen()
  local vsx,vsy=Spring.GetViewGeometry()
  local id=selected()
  local team=Spring.GetMyTeamID()
  local metal=Spring.GetTeamResources(team,"metal")
  local power=Spring.GetTeamRulesParam(team,"ra2_power_ratio") or 1
  local low=Spring.GetTeamRulesParam(team,"ra2_low_power") or 0
  gl.Color(0,0,0,0.72); gl.Rect(12,vsy-92,350,vsy-12)
  gl.Color(1,1,1,1)
  gl.Text("RA2 SPRING DEMO",24,vsy-34,18,"o")
  gl.Text("Credits: "..math.floor(metal or 0).."   Power: "..math.floor(power*100).."%",24,vsy-56,13,"o")
  gl.Text("MCV: deploy  |  CY: build  |  Barracks/Factory: click sidebar",24,vsy-76,11,"o")
  if low>0 then gl.Text("LOW POWER",vsx/2-45,vsy-34,16,"o") end
end
