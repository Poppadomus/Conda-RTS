function gadget:GetInfo() return {name="RA2 Match Bootstrap",desc="Creates an asset-free playable starting state.",author="RTSMerge",layer=1,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local mcvBySide={allies="allied_mcv",soviet="soviet_mcv",yuri="yuri_mcv"}
local harvesterBySide={allies="allied_harvester",soviet="soviet_harvester",yuri="yuri_slave_miner"}
local rules=VFS.Include("gamedata/ra2_rules.lua")
local function sideForTeam(teamID)
  local _,_,_,_,side=Spring.GetTeamInfo(teamID,false)
  if type(side)=="string" then return side:lower() end
  side=tonumber(side) or 0
  return side==1 and "soviet" or side==2 and "yuri" or "allies"
end
function gadget:GameStart()
  for _,teamID in ipairs(Spring.GetTeamList()) do
    local side=sideForTeam(teamID)
    local units=Spring.GetTeamUnits(teamID)
    if #units==0 then
      local mcv=UnitDefNames[mcvBySide[side] or mcvBySide.allies]
      local x,y,z=Spring.GetTeamStartPosition(teamID)
      if mcv and x and x>=0 then
        local mcvID=Spring.CreateUnit(mcv.id,x,y,z,0,teamID)
        local harv=UnitDefNames[harvesterBySide[side] or harvesterBySide.allies]
        if mcvID and harv then
          local hx,hz=x+96,z+96
          Spring.CreateUnit(harv.id,hx,Spring.GetGroundHeight(hx,hz),hz,0,teamID)
        end
      end
    end
    Spring.SetTeamResource(teamID,"metal",rules.credits.starting)
    Spring.SetTeamRulesParam(teamID,"ra2_credits",rules.credits.starting,{allied=true})
  end
end
