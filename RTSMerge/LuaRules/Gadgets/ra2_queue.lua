function gadget:GetInfo() return {name="RA2 Production Queue",desc="Deterministic production queue metadata.",author="RTSMerge",layer=21,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local queues={}
function gadget:UnitCreated(id) queues[id]={} end
function gadget:UnitDestroyed(id) queues[id]=nil end
function gadget:GameFrame(f) if f%15~=0 then return end; for id,q in pairs(queues) do Spring.SetUnitRulesParam(id,"ra2_queue_length",#q,{allied=true}) end end
