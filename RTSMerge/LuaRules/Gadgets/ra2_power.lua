function gadget:GetInfo()
  return {name="RA2 Power Grid",desc="RA2 power production and deficit handling.",author="RTSMerge",layer=5,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end

local rules=VFS.Include("gamedata/ra2_rules.lua")
local producers, consumers = {}, {}
local function scan()
  producers,consumers={},{}
  for id,ud in pairs(UnitDefs) do
    local cp=ud.customParams or {}
    local p=tonumber(cp.power)
    local c=tonumber(cp.power_drain)
    if p then producers[id]=p end
    if c then consumers[id]=c end
  end
end

function gadget:Initialize() scan() end
function gadget:UnitCreated(unitID,unitDefID,teamID)
  if producers[unitDefID] or consumers[unitDefID] then
    Spring.SetUnitRulesParam(unitID,"ra2_power_role",producers[unitDefID] and "producer" or "consumer",{allied=true})
  end
end

function gadget:GameFrame(frame)
  if frame%30~=0 then return end
  for _,teamID in ipairs(Spring.GetTeamList()) do
    local prod,drain=0,0
    for _,id in ipairs(Spring.GetTeamUnits(teamID)) do
      local def=Spring.GetUnitDefID(id)
      prod=prod+(producers[def] or 0)
      drain=drain+(consumers[def] or 0)
    end
    local _,_,storage=Spring.GetTeamResources(teamID,"energy")
    local ratio=drain>0 and math.min(1,prod/drain) or 1
    Spring.SetTeamResource(teamID,"energyStorage",math.max(100,storage or 100))
    Spring.SetTeamRulesParam(teamID,"ra2_power_production",prod)
    Spring.SetTeamRulesParam(teamID,"ra2_power_drain",drain)
    Spring.SetTeamRulesParam(teamID,"ra2_power_ratio",ratio)
  end
end
