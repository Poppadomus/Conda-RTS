function widget:GetInfo() return {name="RA2 Construction Sidebar",desc="Clickable RA2-style construction controls with placement mode.",author="RTSMerge",layer=1,enabled=true} end
local panelW=300
local activeBuild=nil

local function selectedCY()
  for _,id in ipairs(Spring.GetSelectedUnits()) do
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

local function panelBounds()
  local vsx,vsy=Spring.GetViewGeometry()
  local x=vsx-panelW-16
  return x,45,vsx-10,vsy-45
end

function widget:DrawScreen()
  local id,ud=selectedCY()
  if not id then activeBuild=nil; return end
  local vsx,vsy=Spring.GetViewGeometry()
  local x=vsx-panelW-16
  gl.Color(0,0,0,0.82); gl.Rect(x,45,vsx-10,vsy-45)
  gl.Color(1,1,1,1); gl.Text("CONSTRUCTION",x+14,vsy-70,20,"o")
  if activeBuild then
    gl.Text("Place: "..(UnitDefs[activeBuild].name or "building").."  (RMB cancel)",x+14,vsy-92,12,"o")
  else
    gl.Text("Select a building, then click terrain",x+14,vsy-92,12,"o")
  end
  local y=vsy-120
  for _,item in ipairs(options(ud)) do
    local affordable=(Spring.GetTeamResources(Spring.GetMyTeamID(),"metal") or 0)>=(item.def.buildCostMetal or 0)
    if item.id==activeBuild then
      gl.Color(0.30,0.45,0.18,0.98)
    elseif affordable then
      gl.Color(0.12,0.12,0.12,0.95)
    else
      gl.Color(0.06,0.06,0.06,0.92)
    end
    gl.Rect(x+10,y-8,vsx-20,y+25)
    gl.Color(1,1,1,affordable and 1 or 0.45)
    gl.Text(item.def.name or item.name,x+20,y+10,13,"o")
    gl.Text(tostring(math.floor(item.def.buildCostMetal or 0)),vsx-75,y+10,12,"o")
    y=y-34
  end
end

function widget:MousePress(mx,my,button)
  local id,ud=selectedCY()
  if not id then return false end
  local x,y1,x2,y2=panelBounds()
  if button==3 then
    activeBuild=nil
    return false
  end
  if button~=1 then return false end

  if mx>=x+10 and mx<=x2-10 and my>=y1 and my<=y2 then
    local vsx,vsy=Spring.GetViewGeometry()
    local y=vsy-120
    for _,item in ipairs(options(ud)) do
      if my>=y-8 and my<=y+25 then
        local metal=Spring.GetTeamResources(Spring.GetMyTeamID(),"metal") or 0
        if metal >= (item.def.buildCostMetal or 0) then
          activeBuild=item.id
        end
        return true
      end
      y=y-34
    end
    return true
  end

  if activeBuild then
    local kind,pos=Spring.TraceScreenRay(mx,my,true)
    if kind=="ground" and pos then
      Spring.GiveOrderToUnit(id,-activeBuild,{pos[1],pos[2],pos[3],0},{})
      activeBuild=nil
      return true
    end
  end
  return false
end
