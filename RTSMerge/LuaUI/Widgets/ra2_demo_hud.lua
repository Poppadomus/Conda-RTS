function widget:GetInfo() return {name="RA2 Demo HUD",desc="Procedural demo status and controls.",author="RTSMerge",layer=2,enabled=true} end
local function selected() local s=Spring.GetSelectedUnits(); return s and s[1] end
function widget:DrawWorld()
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
\nfunction widget:DrawScreen()\n  local _,_,shift,ctrl=Spring.GetModKeyState()\n  local sel=Spring.GetSelectedUnits()\n  if #sel==0 then return end\n  local y=180\n  for i=1,math.min(#sel,8) do\n    local id=sel[i]\n    local name=UnitDefs[Spring.GetUnitDefID(id)].name or "Unit"\n    local hp,maxhp=Spring.GetUnitHealth(id)\n    local p=(maxhp and maxhp>0) and math.max(0,math.min(1,hp/maxhp)) or 0\n    gl.Color(0,0,0,0.72); gl.Rect(18,y-3,218,y+20)\n    gl.Color(0.15,0.15,0.15,1); gl.Rect(26,y,190,y+6)\n    gl.Color(0.2,0.85,0.25,1); gl.Rect(26,y,26+164*p,y+6)\n    gl.Color(1,1,1,1); gl.Text(name,26,y+17,11,"o")\n    y=y+28\n  end\nend\n