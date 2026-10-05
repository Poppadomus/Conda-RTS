function gadget:GetInfo() return {name="RA2 Build Validation",desc="Validates RA2 construction ownership and radius.",author="RTSMerge",layer=23,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:AllowCommand(id,def,team,cmd,params)
 if cmd~=CMD.BUILD then return true end
 if not params or not params[2] or not params[3] then return false end
 local x,z=params[2],params[3]
 local radius=Spring.GetUnitRulesParam(id,"ra2_build_radius") or 900
 local ux,_,uz=Spring.GetUnitPosition(id)
 if not ux then return false end
 return (x-ux)^2+(z-uz)^2<=radius*radius
end
