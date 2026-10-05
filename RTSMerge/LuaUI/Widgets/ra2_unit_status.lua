function widget:GetInfo() return {name="RA2 Unit Status",desc="Selected-unit veteran and capability status.",author="RTSMerge",layer=5,enabled=true} end
function widget:DrawScreen()
 local vsx,vsy=Spring.GetViewGeometry(); local ids=Spring.GetSelectedUnits(); if #ids==0 then return end
 local id=ids[1]; local v=Spring.GetUnitRulesParam(id,"ra2_veterancy") or 0; local c=Spring.GetUnitRulesParam(id,"ra2_cargo") or 0
 gl.Color(0,0,0,0.7); gl.Rect(18,vsy-105,230,vsy-20); gl.Color(1,1,1,1)
 gl.Text("RA2 UNIT STATUS",30,vsy-42,14,"o"); gl.Text("Veterancy: "..v,30,vsy-64,12,"o"); gl.Text("Cargo: "..c,30,vsy-82,12,"o")
end
