function gadget:GetInfo() return {name="RA2 Stealth Action",desc="Stealth state toggle.",author="RTSMerge",layer=26,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local CMD_STEALTH=CMD.CUSTOM_BASE+204
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD_STEALTH) end
function gadget:CommandFallback(id,def,team,cmd)
 if cmd~=CMD_STEALTH then return false end
 if Spring.GetUnitRulesParam(id,"ra2_stealth")==1 then
  local v=Spring.GetUnitRulesParam(id,"ra2_stealthed") or 0
  Spring.SetUnitRulesParam(id,"ra2_stealthed",v==1 and 0 or 1,{allied=true})
 end
 return true
end
