function widget:GetInfo() return {name="RA2 Action Bar",desc="Clickable RA2 special-action controls.",author="RTSMerge",layer=7,enabled=true} end
local actions={{"DEPLOY",201},{"REPAIR",202},{"CAPTURE",203},{"STEALTH",204}}
function widget:DrawScreen()
 local vsx,vsy=Spring.GetViewGeometry(); local x=250; local y=vsy-55
 for i,a in ipairs(actions) do gl.Color(0,0,0,0.75); gl.Rect(x+(i-1)*88,y,x+i*88-4,y+32); gl.Color(1,1,1,1); gl.Text(a[1],x+8+(i-1)*88,y+11,11,"o") end
end
function widget:MousePress(mx,my,b)
 if b~=1 then return false end
 local vsx,vsy=Spring.GetViewGeometry(); local x=250; local y=vsy-55
 if my<y or my>y+32 then return false end
 local i=math.floor((mx-x)/88)+1; if not actions[i] then return false end
 local ids=Spring.GetSelectedUnits(); for _,id in ipairs(ids) do Spring.GiveOrderToUnit(id,CMD.CUSTOM_BASE+actions[i][2],{},0) end
 return true
end
