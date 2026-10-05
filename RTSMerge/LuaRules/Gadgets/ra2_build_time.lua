function gadget:GetInfo() return {name="RA2 Build Time",desc="Exposes RA2 build-time metadata.",author="RTSMerge",layer=19,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:Initialize()
 for id,ud in pairs(UnitDefs) do local cp=ud.customParams or {}; if cp.ra2_build_time then Spring.SetUnitRulesParam(id,"ra2_build_time",tonumber(cp.ra2_build_time) or 0,{allied=true}) end end
end
