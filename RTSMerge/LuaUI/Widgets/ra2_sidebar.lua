function widget:GetInfo() return {name="RA2 Production Sidebar",desc="Procedural RA2 production controls.",author="RTSMerge",layer=1,enabled=true} end

local panelW=300
local CMD_QUEUE=CMD.CUSTOM_BASE+200
local scroll=0

local function selectedFactory()
  local selected=Spring.GetSelectedUnits()
  for _,id in ipairs(selected) do
    local ud=UnitDefs[Spring.GetUnitDefID(id)]
    local cp=ud and ud.customParams or {}
    if cp.role=="barracks" or cp.role=="warfactory" then return id,ud end
  end
end

local function options(factory)
  local out={}
  for _,name in ipairs(factory.buildOptions or {}) do
    local ud=UnitDefNames[name]
    if ud then out[#out+1]={name=name,id=ud.id,def=UnitDefs[ud.id]} end
  end
  return out
end

function widget:DrawScreen()
  local vsx,vsy=Spring.GetViewGeometry()
  local x=vsx-panelW-16
  gl.Color(0,0,0,0.78); gl.Rect(x,45,vsx-10,vsy-45)
  gl.Color(1,1,1,1)
  gl.Text("PRODUCTION",x+14,vsy-70,20,"o")

  local factory=select(2,selectedFactory())
  if not factory then
    gl.Text("Select a Barracks or War Factory",x+14,vsy-105,13,"o")
    return
  end

  local factoryID=select(1,selectedFactory())
  local q=Spring.GetUnitRulesParam(factoryID,"ra2_queue_length") or 0
  local p=Spring.GetUnitRulesParam(factoryID,"ra2_queue_progress") or 0
  gl.Text("Queue: "..q.."  "..math.floor(p*100).."%",x+14,vsy-102,13,"o")

  local list=options(factory)
  local y=vsy-135
  for _,item in ipairs(list) do
    if y<65 then break end
    local d=item.def
    local metal=Spring.GetTeamResources(Spring.GetMyTeamID(),"metal") or 0
    local affordable=metal >= (d.buildCostMetal or 0)
    gl.Color(affordable and 0.12 or 0.06,affordable and 0.12 or 0.06,affordable and 0.12 or 0.06,0.95); gl.Rect(x+10,y-8,vsx-20,y+25)
    gl.Color(1,1,1,affordable and 1 or 0.45)
    gl.Text(d.name or item.name,x+20,y+10,14,"o")
    gl.Text(tostring(math.floor(d.buildCostMetal or 0)),vsx-75,y+10,12,"o")
    y=y-34
  end
end

function widget:MousePress(mx,my,button)
  if button~=1 then return false end
  local vsx,vsy=Spring.GetViewGeometry()
  local x=vsx-panelW-16
  if mx<x+10 or mx>vsx-20 then return false end
  local factoryID,factory=selectedFactory()
  if not factoryID then return false end
  local list=options(factory)
  local y=vsy-135
  for _,item in ipairs(list) do
    if y<65 then break end
    if my>=y-8 and my<=y+25 then
      Spring.GiveOrderToUnit(factoryID,CMD_QUEUE,{item.id},{})
      return true
    end
    y=y-34
  end
  return false
end
