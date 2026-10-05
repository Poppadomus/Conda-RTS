function gadget:GetInfo() return {name="RA2 Radar State",desc="Radar and spy satellite capability state.",author="RTSMerge",layer=2,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id,def) local cp=UnitDefs[def].customParams or {}; if cp.ra2_radar then Spring.SetUnitRulesParam(id,"ra2_radar",tonumber(cp.ra2_radar) or 0,{allied=true}) end; if cp.ra2_spy_satellite=="1" then Spring.SetUnitRulesParam(id,"ra2_spy_satellite",1,{allied=true}) end end
