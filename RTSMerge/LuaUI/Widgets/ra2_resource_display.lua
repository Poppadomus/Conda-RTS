function widget:GetInfo()
  return {name="RA2 Credits and Power",desc="RA2-style resource display.",author="RTSMerge",layer=0,enabled=true}
end
local vsx,vsy
function widget:ViewResize(x,y) vsx,vsy=x,y end
function widget:DrawScreen()
  local team=Spring.GetMyTeamID()
  local metal,_,metalStorage,_,energy,_,energyStorage=Spring.GetTeamResources(team,"metal")
  local credits=math.floor(metal or 0)
  local power=math.floor(energy or 0)
  gl.Text("CREDITS  "..credits.." / "..math.floor(metalStorage or 0),vsx-310,vsy-42,18,"o")
  gl.Text("POWER    "..power.." / "..math.floor(energyStorage or 0),vsx-310,vsy-64,16,"o")
end
