function gadget:GetInfo()
  return {name="RA2 Veterancy",desc="Synced veteran and elite promotion.",author="RTSMerge",layer=30,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end

local xp, levels = {}, {100, 250, 500}
local healthBonus = {0, 0.10, 0.25, 0.50}
local speedBonus = {0, 0.05, 0.10, 0.15}

local function levelFor(v)
  if v >= levels[3] then return 3 end
  if v >= levels[2] then return 2 end
  if v >= levels[1] then return 1 end
  return 0
end

local function apply(unitID)
  local u=xp[unitID]
  if not u then return end
  local level=levelFor(u.value)
  local max=Spring.GetUnitMaxHealth(unitID)
  if max then Spring.SetUnitMaxHealth(unitID,max/(1+healthBonus[u.applied or 0])*(1+healthBonus[level])) end
  local ud=UnitDefs[Spring.GetUnitDefID(unitID)]
  if ud and Spring.SetUnitMaxSpeed then
    Spring.SetUnitMaxSpeed(unitID,ud.speed*(1+speedBonus[level]))
  end
  u.applied=level
  Spring.SetUnitRulesParam(unitID,"ra2_veterancy",level,{allied=true})
end

function gadget:UnitCreated(unitID,unitDefID,teamID,builderID)
  xp[unitID]={value=0,applied=0}
end

function gadget:UnitDestroyed(unitID,unitDefID,teamID,attackerID)
  if attackerID and xp[attackerID] then
    xp[attackerID].value=xp[attackerID].value+50
    apply(attackerID)
  end
  xp[unitID]=nil
end

function gadget:Initialize()
  for _,id in ipairs(Spring.GetAllUnits()) do xp[id]={value=0,applied=0} end
end
