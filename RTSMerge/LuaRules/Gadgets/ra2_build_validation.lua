function gadget:GetInfo() return {name="RA2 Build Validation",desc="Validates construction placement.",author="RTSMerge",layer=23,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end

local function occupied(x,z,radius,ignoreID)
  for _,u in ipairs(Spring.GetUnitsInCylinder(x,z,radius)) do
    if u~=ignoreID then
      local ud=UnitDefs[Spring.GetUnitDefID(u)]
      if ud and ud.canMove==false then return true end
    end
  end
  return false
end

function gadget:AllowCommand(id,def,team,cmd,params)
  if cmd~=CMD.BUILD then return true end
  if not params or not params[1] or params[2]==nil or params[4]==nil then return false end
  local x,z=params[2],params[4]
  if x<0 or z<0 or x>Game.mapSizeX or z>Game.mapSizeZ then return false end
  local radius=Spring.GetUnitRulesParam(id,"ra2_build_radius") or 900
  local ux,_,uz=Spring.GetUnitPosition(id)
  if not ux then return false end
  if (x-ux)^2+(z-uz)^2>radius*radius then return false end
  if occupied(x,z,80,id) then return false end
  return true
end
