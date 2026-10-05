function widget:GetInfo() return {name="RA2 Superweapon Panel",desc="RA2/YR charge display.",author="RTSMerge",layer=2,enabled=true} end
local names={"chronosphere","iron_curtain","weather_control","nuclear_missile","psychic_dominator","genetic_mutator","force_shield"}
function widget:DrawScreen()
 local vsx,vsy=Spring.GetViewGeometry(); local x=vsx-300; local y=145
 gl.Color(0,0,0,0.72); gl.Rect(x,y-18,vsx-20,y+34); gl.Color(1,1,1,1)
 gl.Text("SUPERWEAPONS",x+10,y+16,14,"o")
 for i,n in ipairs(names) do local c=Spring.GetTeamRulesParam(Spring.GetMyTeamID(),"ra2_sw_"..n) or 0; gl.Text(n:upper().." "..math.floor(c),x+10,y-8-i*18,10,"o") end
end
