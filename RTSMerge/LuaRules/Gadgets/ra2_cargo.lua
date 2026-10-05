function gadget:GetInfo() return {name="RA2 Cargo",desc="Harvester cargo lifecycle.",author="RTSMerge",layer=9,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local harvester={}
function gadget:Initialize() for id,ud in pairs(UnitDefs) do harvester[id]=(ud.customParams or {}).ra2_harvester=="1" end end
function gadget:UnitCreated(id,def) if harvester[def] then Spring.SetUnitRulesParam(id,"ra2_cargo",0,{allied=true}); Spring.SetUnitRulesParam(id,"ra2_cargo_capacity",100,{allied=true}) end end
function gadget:GameFrame(f)
 if f%30~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do for _,id in ipairs(Spring.GetTeamUnits(team)) do if harvester[Spring.GetUnitDefID(id)] then local c=Spring.GetUnitRulesParam(id,"ra2_cargo") or 0; local cap=Spring.GetUnitRulesParam(id,"ra2_cargo_capacity") or 100; if c==0 then Spring.SetUnitRulesParam(id,"ra2_cargo",cap,{allied=true}) end end end end
end
