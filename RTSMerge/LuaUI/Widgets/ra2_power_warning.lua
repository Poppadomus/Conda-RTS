function widget:GetInfo() return {name="RA2 Power Warning",desc="Power deficit warning overlay.",author="RTSMerge",layer=3,enabled=true} end
function widget:DrawScreen()
 local team=Spring.GetMyTeamID(); local deficit=Spring.GetTeamRulesParam(team,"ra2_power_deficit") or 0
 if deficit>0 then
  local vsx,vsy=Spring.GetViewGeometry(); gl.Color(1,0.15,0.05,0.9); gl.Text("LOW POWER",vsx-210,vsy-118,18,"o")
 end
end
