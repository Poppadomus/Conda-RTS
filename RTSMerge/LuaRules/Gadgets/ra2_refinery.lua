function gadget:GetInfo() return {name="RA2 Refinery Delivery",desc="Harvester cargo delivery to nearby refineries.",author="RTSMerge",layer=3,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local ref,harv={}
function gadget:Initialize()
 ref,harv={},{}
 for id,ud in pairs(UnitDefs) do local cp=ud.customParams or {}; ref[id]=cp.ra2_refinery=="1"; harv[id]=cp.ra2_harvester=="1" end
end
function gadget:GameFrame(frame)
 if frame%15~=0 then return end
 for _,team in ipairs(Spring.GetTeamList()) do
  local metal,_,storage=Spring.GetTeamResources(team,"metal")
  for _,hid in ipairs(Spring.GetTeamUnits(team)) do
   if harv[Spring.GetUnitDefID(hid)] then
    local load=Spring.GetUnitRulesParam(hid,"ra2_cargo") or 0; local x,_,z=Spring.GetUnitPosition(hid)
    if load>0 and x then
     for _,rid in ipairs(Spring.GetTeamUnits(team)) do
      if ref[Spring.GetUnitDefID(rid)] then local rx,_,rz=Spring.GetUnitPosition(rid)
       if rx and (x-rx)^2+(z-rz)^2<10000 then
        local amount=math.min(load,math.max(0,(storage or 0)-(metal or 0)))
        if amount>0 then Spring.AddTeamResource(team,"metal",amount); Spring.SetUnitRulesParam(hid,"ra2_cargo",load-amount,{allied=true}) end
        break
       end
      end
     end
    end
   end
  end
 end
end
