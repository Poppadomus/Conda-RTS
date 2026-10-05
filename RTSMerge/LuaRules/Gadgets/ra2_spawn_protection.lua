function gadget:GetInfo() return {name="RA2 Spawn Protection",desc="Short initial deployment protection state.",author="RTSMerge",layer=38,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:UnitCreated(id) Spring.SetUnitRulesParam(id,"ra2_spawn_frame",Spring.GetGameFrame(),{allied=true}) end
