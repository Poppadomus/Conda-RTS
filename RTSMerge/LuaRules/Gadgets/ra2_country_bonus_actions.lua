function gadget:GetInfo() return {name="RA2 Country Bonus Actions",desc="Country special capability actions.",author="RTSMerge",layer=37,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_BONUS=CMD.CUSTOM_BASE+208
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_BONUS) end
function gadget:CommandFallback(id,def,team,cmd,params)
 if cmd~=CMD_BONUS then return false end
 local bonus=Spring.GetTeamRulesParam(team,"ra2_country_bonus") or ""
 Spring.SetTeamRulesParam(team,"ra2_bonus_active",bonus,{allied=true})
 return true
end
