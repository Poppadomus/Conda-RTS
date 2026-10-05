function gadget:GetInfo() return {name="RA2 MCV Command",desc="Dedicated MCV deploy command.",author="RTSMerge",layer=25,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_DEPLOY=CMD.CUSTOM_BASE+201
local map={allied_mcv="allied_conyard",soviet_mcv="soviet_conyard",yuri_mcv="yuri_conyard"}
local names={}
for n,ud in pairs(UnitDefNames) do names[ud.id]=n end
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_DEPLOY) end
function gadget:AllowCommand(id,def,team,cmd)
 if cmd~=CMD_DEPLOY then return true end
 return map[names[def]]~=nil
end
function gadget:CommandFallback(id,def,team,cmd)
 if cmd~=CMD_DEPLOY then return false end
 local target=map[names[def]]
 local x,y,z=Spring.GetUnitPosition(id)
 if target and x and UnitDefNames[target] then
  local blocked=false
  for _,other in ipairs(Spring.GetUnitsInCylinder(x,z,90)) do
   if other~=id and Spring.GetUnitTeam(other)==team and UnitDefs[Spring.GetUnitDefID(other)] and not UnitDefs[Spring.GetUnitDefID(other)].canMove then blocked=true; break end
  end
  if not blocked then
   local gy=Spring.GetGroundHeight(x,z)
   local conyard=Spring.CreateUnit(target,x,gy,z,0,team)
   if conyard then Spring.DestroyUnit(id,false,true) end
  end
 end
 return true
end
