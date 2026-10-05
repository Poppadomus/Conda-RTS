function gadget:GetInfo() return {name="RA2 Placement Rules",desc="Authoritative construction placement validation hook.",author="RTSMerge",layer=22,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:AllowCommand(id,def,team,cmd,params)
 if cmd~=CMD.BUILD then return true end
 return params and params[2]~=nil and params[3]~=nil
end
