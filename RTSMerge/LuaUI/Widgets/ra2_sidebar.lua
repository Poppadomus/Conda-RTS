function widget:GetInfo() return {name="RA2 Production Sidebar",desc="Clickable native Spring production panel.",author="RTSMerge",layer=1,enabled=true} end
local panelW=260; local rows={"INFANTRY","VEHICLES","AIRCRAFT","NAVAL","DEFENSE"}; local selected=1
function widget:DrawScreen()
 local vsx,vsy=Spring.GetViewGeometry(); local x=vsx-panelW-20
 gl.Color(0,0,0,0.72); gl.Rect(x,70,vsx-20,vsy-80); gl.Color(1,1,1,1)
 gl.Text("PRODUCTION",x+14,vsy-105,20,"o")
 for i,label in ipairs(rows) do local y=vsy-145-i*32; if i==selected then gl.Color(0.2,0.7,1,0.3); gl.Rect(x+8,y-8,vsx-28,y+18); gl.Color(1,1,1,1) end; gl.Text(label,x+16,y,14,"o") end
end
function widget:MousePress(mx,my,button)
 local vsx,vsy=Spring.GetViewGeometry(); local x=vsx-panelW-20
 if mx<x+8 or mx>vsx-28 then return false end
 for i=1,#rows do local y=vsy-145-i*32; if my>=y-10 and my<=y+20 then selected=i; return true end end
 return false
end
function widget:GetSelectedCategory() return selected end
