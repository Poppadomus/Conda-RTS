function gadget:GetInfo() return {name="RA2 Superweapon Targets",desc="Stores validated superweapon target state.",author="RTSMerge",layer=42,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_TARGET=CMD.CUSTOM_BASE+206
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_TARGET) end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_TARGET then return false end
 local x,y,z=params and params[1],params and params[2],params and params[3]
 if x and y and z then
  Spring.SetTeamRulesParam(team,"ra2_sw_target_x",x,{allied=true})
  Spring.SetTeamRulesParam(team,"ra2_sw_target_y",y,{allied=true})
  Spring.SetTeamRulesParam(team,"ra2_sw_target_z",z,{allied=true})
 end
 return true
end
