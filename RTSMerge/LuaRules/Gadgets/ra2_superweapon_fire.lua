function gadget:GetInfo() return {name="RA2 Superweapon Fire",desc="Authoritative superweapon firing command.",author="RTSMerge",layer=41,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_SW=CMD.CUSTOM_BASE+205
local names={"chronosphere","iron_curtain","weather_control","nuclear_missile","psychic_dominator","genetic_mutator","force_shield"}
local costs={chronosphere=1800,iron_curtain=1500,weather_control=1800,nuclear_missile=2100,psychic_dominator=2100,genetic_mutator=1500,force_shield=1800}
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_SW) end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_SW then return false end
 local idx=params and tonumber(params[1]); local name=idx and names[idx]
 if not name then return true end
 local charge=Spring.GetTeamRulesParam(team,"ra2_sw_"..name) or 0
 if charge < (costs[name] or 999999) then return true end
 Spring.SetTeamRulesParam(team,"ra2_sw_"..name,0,{allied=true})
 Spring.SetTeamRulesParam(team,"ra2_last_superweapon",idx,{allied=true})
 return true
end
