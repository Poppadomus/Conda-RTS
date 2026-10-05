function gadget:GetInfo() return {name="RA2 MCV Command",desc="Dedicated MCV deploy command.",author="RTSMerge",layer=25,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_DEPLOY=CMD.CUSTOM_BASE+201
local map={allied_mcv="allied_conyard",soviet_mcv="soviet_conyard",yuri_mcv="yuri_conyard"}
local names={}
for n,ud in pairs(UnitDefNames) do names[ud.id]=n end
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_DEPLOY) end
function gadget:AllowCommand(id,def,team,cmd) if cmd~=CMD_DEPLOY then return true end; return map[names[def]]~=nil end
function gadget:CommandFallback(id,def,team,cmd)
 if cmd~=CMD_DEPLOY then return false end
 local target=map[names[def]]; local x,y,z=Spring.GetUnitPosition(id)
 if target and x and UnitDefNames[target] then Spring.CreateUnit(target,x,y,z,0,team); Spring.DestroyUnit(id,false,true) end
 return true
end
