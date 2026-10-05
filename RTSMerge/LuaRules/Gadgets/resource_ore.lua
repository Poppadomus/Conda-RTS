function gadget:GetInfo()
  return {name="RA2 Ore Economy",desc="RA2 credit storage and harvester ledger.",author="RTSMerge",layer=0,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end

local CREDIT_CAP=10000
local TICK=30
local HARVEST_PER_TICK=25
local harvesterDefs={}

function gadget:Initialize()
  for id,ud in pairs(UnitDefs) do
    if ud.customParams and ud.customParams.ra2_harvester=="1" then harvesterDefs[id]=true end
  end
  for _,teamID in ipairs(Spring.GetTeamList()) do
    Spring.SetTeamResource(teamID,"ms",CREDIT_CAP)
    Spring.SetTeamResource(teamID,"metal",0)
    Spring.SetTeamRulesParam(teamID,"ra2_credits",0)
  end
end

function gadget:GameFrame(frame)
  if frame%TICK~=0 then return end
  for _,teamID in ipairs(Spring.GetTeamList()) do
    local count=0
    for _,unitID in ipairs(Spring.GetTeamUnits(teamID)) do
      if harvesterDefs[Spring.GetUnitDefID(unitID)] then count=count+1 end
    end
    if count>0 then
      local metal,storage=Spring.GetTeamResources(teamID,"metal")
      local gain=math.min(count*HARVEST_PER_TICK,math.max(0,(storage or CREDIT_CAP)-(metal or 0)))
      if gain>0 then
        Spring.AddTeamResource(teamID,"metal",gain)
        Spring.SetTeamRulesParam(teamID,"ra2_credits",(metal or 0)+gain)
      end
    end
  end
end
