function widget:GetInfo() return {name="RA2 MCV Deploy Control",desc="Procedural MCV deploy control.",author="RTSMerge",layer=2,enabled=true} end
local CMD_DEPLOY=CMD.CUSTOM_BASE+201
local mcvRoles={mcv=true}

local function selectedMCV()
  for _,id in ipairs(Spring.GetSelectedUnits()) do
    local ud=UnitDefs[Spring.GetUnitDefID(id)]
    local cp=ud and ud.customParams or {}
    if mcvRoles[cp.role] then return id end
  end
end

function widget:DrawScreen()
  local id=selectedMCV()
  if not id then return end
  local vsx,vsy=Spring.GetViewGeometry()
  local x=vsx-220
  gl.Color(0,0,0,0.8); gl.Rect(x,vsy-95,vsx-20,vsy-45)
  gl.Color(1,1,1,1); gl.Text("DEPLOY CONSTRUCTION YARD",x+12,vsy-64,13,"o")
end

function widget:MousePress(mx,my,button)
  if button~=1 then return false end
  local id=selectedMCV()
  if not id then return false end
  local vsx,vsy=Spring.GetViewGeometry()
  local x=vsx-220
  if mx>=x and mx<=vsx-20 and my>=vsy-95 and my<=vsy-45 then
    Spring.GiveOrderToUnit(id,CMD_DEPLOY,{},{})
    return true
  end
  return false
end
