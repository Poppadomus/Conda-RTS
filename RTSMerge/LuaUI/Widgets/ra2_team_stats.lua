function widget:GetInfo() return {name="RA2 Team Stats",desc="Team kill/loss display.",author="RTSMerge",layer=12,enabled=true} end
function widget:DrawScreen()
 local t=Spring.GetMyTeamID(); local k=Spring.GetTeamRulesParam(t,"ra2_kills") or 0; local l=Spring.GetTeamRulesParam(t,"ra2_losses") or 0
 local vsx,vsy=Spring.GetViewGeometry(); gl.Color(0,0,0,0.7); gl.Rect(vsx-190,60,vsx-18,92); gl.Color(1,1,1,1); gl.Text("K "..k.." / L "..l,vsx-178,82,12,"o")
end
