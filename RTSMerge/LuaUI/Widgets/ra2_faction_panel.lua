function widget:GetInfo() return {name="RA2 Faction Panel",desc="Faction and country display.",author="RTSMerge",layer=11,enabled=true} end
function widget:DrawScreen()
 local team=Spring.GetMyTeamID(); local faction=Spring.GetTeamRulesParam(team,"ra2_faction") or "unknown"; local country=Spring.GetTeamRulesParam(team,"ra2_country") or "unknown"
 local vsx,vsy=Spring.GetViewGeometry(); gl.Color(0,0,0,0.72); gl.Rect(18,70,190,112); gl.Color(1,1,1,1)
 gl.Text(faction:upper(),28,88,12,"o"); gl.Text(country,28,105,11,"o")
end
