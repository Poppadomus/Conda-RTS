function gadget:GetInfo() return {name="RA2 Harvester Logic",desc="Automatic refinery return and cargo state.",author="RTSMerge",layer=4,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local h,r={}
function gadget:Initialize() h={}; r={}; for id,ud in pairs(UnitDefs) do local cp=ud.customParams or {}; h[id]=cp.ra2_harvester=="1"; r[id]=cp.ra2_refinery=="1" end end
function gadget:UnitCreated(id,def) if h[def] then Spring.SetUnitRulesParam(id,"ra2_harvester_state",0,{allied=true}) end end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local refID
  for _,id in ipairs(Spring.GetTeamUnits(team)) do if r[Spring.GetUnitDefID(id)] then refID=id; break end end
  if refID then
   local rx,_,rz=Spring.GetUnitPosition(refID)
   for _,id in ipairs(Spring.GetTeamUnits(team)) do if h[Spring.GetUnitDefID(id)] then local load=Spring.GetUnitRulesParam(id,"ra2_cargo") or 0; if load>0 and rx then local x,_,z=Spring.GetUnitPosition(id); if x and (x-rx)^2+(z-rz)^2>14400 then Spring.GiveOrderToUnit(id,CMD.MOVE,{rx,0,rz},{}) else Spring.SetUnitRulesParam(id,"ra2_harvester_state",1,{allied=true}) end end end end
  end
 end
end
