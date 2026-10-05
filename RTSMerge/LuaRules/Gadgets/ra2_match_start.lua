function gadget:GetInfo() return {name="RA2 Match Bootstrap",desc="Creates an asset-free playable starting state.",author="RTSMerge",layer=1,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end

local mcvBySide={allies="allied_mcv",soviet="soviet_mcv",yuri="yuri_mcv"}
local rules=VFS.Include("gamedata/ra2_rules.lua")

local function sideForTeam(teamID)
  local _,_,_,_,side=Spring.GetTeamInfo(teamID,false)
  if type(side)=="string" then return side:lower() end
  side=tonumber(side) or 0
  return side==1 and "soviet" or side==2 and "yuri" or "allies"
end

function gadget:GameStart()
  for _,teamID in ipairs(Spring.GetTeamList()) do
    if #Spring.GetTeamUnits(teamID)==0 then
      local name=mcvBySide[sideForTeam(teamID)] or mcvBySide.allies
      local ud=UnitDefNames[name]
      if ud then
        local x,y,z=Spring.GetTeamStartPosition(teamID)
        if x and x>=0 then Spring.CreateUnit(ud.id,x,y,z,0,teamID) end
      end
    end
    local start=rules.credits.starting
    local cap=rules.credits.capacity
    Spring.SetTeamResource(teamID,"metal",start)
    Spring.SetTeamResource(teamID,"metalStorage",cap)
    Spring.SetTeamRulesParam(teamID,"ra2_credits",start)
  end
end
