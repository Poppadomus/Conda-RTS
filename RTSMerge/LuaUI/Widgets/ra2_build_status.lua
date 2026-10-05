function widget:GetInfo() return {name="RA2 Build Status",desc="Selected construction status display.",author="RTSMerge",layer=6,enabled=true} end
function widget:DrawScreen()
 local ids=Spring.GetSelectedUnits(); if #ids==0 then return end
 local id=ids[1]; local p=Spring.GetUnitRulesParam(id,"ra2_power_efficiency") or 1
 local q=Spring.GetUnitRulesParam(id,"ra2_queue_length") or 0
 local vsx,vsy=Spring.GetViewGeometry(); gl.Color(1,1,1,1); gl.Text("Build queue: "..q,25,vsy-135,12,"o"); gl.Text("Power efficiency: "..math.floor(p*100).."%",25,vsy-151,12,"o")
end
