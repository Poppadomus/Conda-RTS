function widget:GetInfo() return {name="RA2 Superweapon Controls",desc="Target and fire superweapon controls.",author="RTSMerge",layer=8,enabled=true} end
local x0,y0,w=20,120,210
function widget:DrawScreen()
 local vsx,vsy=Spring.GetViewGeometry(); local team=Spring.GetMyTeamID(); local last=Spring.GetTeamRulesParam(team,"ra2_last_superweapon") or 0
 gl.Color(0,0,0,0.75); gl.Rect(x0,y0,x0+w,y0+42); gl.Color(1,1,1,1); gl.Text("SW TARGET / FIRE",x0+10,y0+25,13,"o")
 if last>0 then gl.Text("ACTIVE: "..last,x0+10,y0+39,10,"o") end
end
