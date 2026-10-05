function widget:GetInfo()
  return {name="RA2 Production Sidebar",desc="Native Spring implementation of the RA2-style production panel.",author="RTSMerge",layer=1,enabled=true}
end

local panelW=260
local rows={"INFANTRY","VEHICLES","AIRCRAFT","NAVAL","DEFENSE"}
function widget:DrawScreen()
  local x=20
  local y=Spring.GetViewGeometry()
  local vsx,vsy=Spring.GetViewGeometry()
  x=vsx-panelW-20
  gl.Color(0,0,0,0.72)
  gl.Rect(x,70,vsx-20,vsy-80)
  gl.Color(1,1,1,1)
  gl.Text("PRODUCTION",x+14,vsy-105,20,"o")
  for i,label in ipairs(rows) do
    local yy=vsy-145-i*32
    gl.Text(label,x+16,yy,14,"o")
    gl.Text("—",vsx-48,yy,14,"o")
  end
end
