function widget:GetInfo() return {name="RA2 Construction Sidebar",desc="Clickable procedural construction controls.",author="RTSMerge",layer=1,enabled=true} end
local panelW=300
local function selectedCY()
  local s=Spring.GetSelectedUnits()
  for _,id in ipairs(s) do
    local ud=UnitDefs[Spring.GetUnitDefID(id)]
    local cp=ud and ud.customParams or {}
    if cp.role=="conyard" then return id,ud end
  end
end
local function options(ud)
  local out={}
  for _,name in ipairs(ud.buildOptions or {}) do
    local d=UnitDefNames[name]
    if d then out[#out+1]={name=name,id=d.id,def=UnitDefs[d.id]} end
  end
  return out
end
function widget:DrawScreen()
  local vsx,vsy=Spring.GetViewGeometry()
  local id,ud=selectedCY()
  if not id then return end
  local x=vsx-panelW-16
  gl.Color(0,0,0,0.78); gl.Rect(x,45,vsx-10,vsy-45)
  gl.Color(1,1,1,1); gl.Text("CONSTRUCTION",x+14,vsy-70,20,"o")
  local y=vsy-110
  for _,item in ipairs(options(ud)) do
    gl.Color(0.12,0.12,0.12,0.95); gl.Rect(x+10,y-8,vsx-20,y+25)
    gl.Color(1,1,1,1); gl.Text(item.def.name or item.name,x+20,y+10,13,"o")
    gl.Text(tostring(math.floor(item.def.buildCostMetal or 0)),vsx-75,y+10,12,"o")
    y=y-34
  end
end
function widget:MousePress(mx,my,button)
  if button~=1 then return false end
  local vsx,vsy=Spring.GetViewGeometry()
  local x=vsx-panelW-16
  if mx<x+10 or mx>vsx-20 then return false end
  local id,ud=selectedCY()
  if not id then return false end
  local y=vsy-110
  for _,item in ipairs(options(ud)) do
    if my>=y-8 and my<=y+25 then
      local hitX,hitZ=Spring.TraceScreenRay(mx,my,true)
      if hitX and hitX=="ground" then
        local pos=hitZ
        Spring.GiveOrderToUnit(id,-item.id,{pos[1],pos[2],pos[3],0},{})
      end
      return true
    end
    y=y-34
  end
  return false
end
