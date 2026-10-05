function gadget:GetInfo() return {name="RA2 Faction Visuals",desc="Publishes faction visual metadata.",author="RTSMerge",layer=3,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local palette={allies=1,soviet=2,yuri=3}
function gadget:UnitCreated(id,def,team)
 local cp=UnitDefs[def].customParams or {}
 local side=cp.side
 if side and palette[side] then Spring.SetUnitRulesParam(id,"ra2_faction_palette",palette[side],{allied=true}) end
end