function widget:GetInfo() return {name="RA2 Visual Status",desc="Displays lightweight procedural damage and faction indicators.",author="RTSMerge",layer=1,enabled=true} end
local function drawBar(id)
 local hp,maxhp=Spring.GetUnitHealth(id)
 if not hp or not maxhp or maxhp<=0 or hp>=maxhp then return end
 local x,y,z=Spring.GetUnitViewPosition(id)
 if not x then return end
 local p=hp/maxhp
 gl.PushMatrix(); gl.Translate(x,y+18,z); gl.Billboard()
 gl.Color(0.05,0.05,0.05,0.8); gl.Rect(-10,-1,10,1)
 gl.Color(1-p,p,0,1); gl.Rect(-10,-1,-10+20*p,1)
 gl.PopMatrix()
end
function widget:DrawWorld()
 for _,id in ipairs(Spring.GetVisibleUnits(-1,1,false)) do drawBar(id) end
end