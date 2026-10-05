function gadget:GetInfo()
  return {
    name = "Tiberium Economy",
    desc = "Prototype resource income and storage hooks",
    author = "RTSMerge",
    layer = 0,
    enabled = true,
  }
end

if not gadgetHandler:IsSyncedCode() then return end

local income = {}
local storage = {}
local MAX_STORAGE = 10000

function gadget:Initialize()
  for _, teamID in ipairs(Spring.GetTeamList()) do
    income[teamID] = 0
    storage[teamID] = 0
  end
end

function gadget:GameFrame(frame)
  if frame % 30 ~= 0 then return end
  for _, teamID in ipairs(Spring.GetTeamList()) do
    local amount = income[teamID] or 0
    if amount > 0 then
      storage[teamID] = math.min(MAX_STORAGE, (storage[teamID] or 0) + amount)
      Spring.SetTeamResource(teamID, "m", storage[teamID])
    end
  end
end

function gadget:AddTiberiumIncome(teamID, amount)
  income[teamID] = (income[teamID] or 0) + amount
end
