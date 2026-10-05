function widget:GetInfo() return {name="RA2 Minimap Status",desc="Compact faction and economy status.",author="RTSMerge",layer=9,enabled=true} end
function widget:DrawScreen()
 local team=Spring.GetMyTeamID(); local side=Spring.GetTeamRulesParam(team,"ra2_country") or "Unknown"; local power=Spring.GetTeamRulesParam(team,"ra2_power_ratio") or 1
 local credits=select(1,Spring.GetTeamResources(team,"metal")) or 0
 local vsx,vsy=Spring.GetViewGeometry(); gl.Color(0,0,0,0.7); gl.Rect(18,18,190,62); gl.Color(1,1,1,1)
 gl.Text(side,28,34,12,"o"); gl.Text("C "..math.floor(credits).."  P "..math.floor(power*100).."%",28,52,11,"o")
end
