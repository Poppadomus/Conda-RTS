function widget:GetInfo() return {name="RA2 Credits and Power",desc="RA2-style resource display.",author="RTSMerge",layer=0,enabled=true} end
local vsx,vsy
function widget:ViewResize(x,y) vsx,vsy=x,y end
function widget:DrawScreen()
 if not vsx then return end
 local team=Spring.GetMyTeamID(); local metal,_,metalStorage=Spring.GetTeamResources(team,"metal"); local energy,_,energyStorage=Spring.GetTeamResources(team,"energy")
 local prod=Spring.GetTeamRulesParam(team,"ra2_power_production") or 0; local drain=Spring.GetTeamRulesParam(team,"ra2_power_drain") or 0
 gl.Color(0,0,0,0.78); gl.Rect(vsx-330,vsy-92,vsx-18,vsy-18); gl.Color(1,1,1,1)
 gl.Text("CREDITS  "..math.floor(metal or 0).." / "..math.floor(metalStorage or 0),vsx-315,vsy-42,16,"o")
 gl.Text("POWER    "..math.floor(energy or 0).." / "..math.floor(energyStorage or 0),vsx-315,vsy-64,14,"o")
 gl.Text("GRID     "..math.floor(prod).." / "..math.floor(drain),vsx-315,vsy-82,12,"o")
end
