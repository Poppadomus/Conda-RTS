function gadget:GetInfo() return {name="RA2 Power Fire Control",desc="Tracks powered firing efficiency.",author="RTSMerge",layer=13,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:AllowCommand(id,def,team,cmd,params)
 if cmd~=CMD.ATTACK then return true end
 local cp=UnitDefs[def].customParams or {}
 if cp.ra2_powered=="1" then return (Spring.GetUnitRulesParam(id,"ra2_power_efficiency") or 1)>0 end
 return true
end
