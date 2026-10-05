function gadget:GetInfo() return {name="RA2 Queue Progress",desc="Tracks deterministic production progress.",author="RTSMerge",layer=22,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local progress={}
function gadget:UnitCreated(id,def) progress[id]=0 end
function gadget:UnitDestroyed(id) progress[id]=nil end
function gadget:GameFrame(f)
 if f%15~=0 then return end
 for id,p in pairs(progress) do
  local q=Spring.GetUnitRulesParam(id,"ra2_queue_length") or 0
  if q>0 then p=math.min(1,p+0.01); progress[id]=p; Spring.SetUnitRulesParam(id,"ra2_queue_progress",p,{allied=true}) end
 end
end
