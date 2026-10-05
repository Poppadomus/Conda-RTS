function gadget:GetInfo() return {name="RA2 Production Costs",desc="Exposes RA2 production cost metadata.",author="RTSMerge",layer=19,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:Initialize()
 for id,ud in pairs(UnitDefs) do local cp=ud.customParams or {}; if cp.ra2_cost then Spring.SetUnitRulesParam(id,"ra2_cost",tonumber(cp.ra2_cost) or 0,{allied=true}) end end
end
