function widget:GetInfo() return {name="RA2 Objective Status",desc="Mission objective status panel.",author="RTSMerge",layer=10,enabled=true} end
function widget:DrawScreen()
 local team=Spring.GetMyTeamID(); local state=Spring.GetTeamRulesParam(team,"ra2_objective_state") or 0
 local vsx,vsy=Spring.GetViewGeometry()
 gl.Color(0,0,0,0.72); gl.Rect(vsx-225,18,vsx-18,52); gl.Color(1,1,1,1)
 gl.Text("OBJECTIVE: "..tostring(state),vsx-210,40,12,"o")
end
