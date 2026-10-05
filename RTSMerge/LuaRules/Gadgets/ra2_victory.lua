function gadget:GetInfo() return {name="RA2 Victory Conditions",desc="Ends the match when one allyteam remains after combat begins.",author="RTSMerge",layer=90,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local started=false
function gadget:GameFrame(frame)
  if frame%90~=0 then return end
  local alive={}
  for _,teamID in ipairs(Spring.GetTeamList()) do
    local dead=select(2,Spring.GetTeamInfo(teamID,false))
    if not dead and #Spring.GetTeamUnits(teamID)>0 then
      alive[Spring.GetTeamAllyTeamID(teamID)]=true
    end
  end
  local count,winner=0,nil
  for ally in pairs(alive) do count=count+1; winner=ally end
  if count>=2 then started=true end
  if started and count==1 then Spring.GameOver({winner}) end
end
