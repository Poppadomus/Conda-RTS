function gadget:GetInfo() return {name="RA2 Unit Limits",desc="Country and unit-limit bookkeeping.",author="RTSMerge",layer=17,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local counts={}
function gadget:UnitCreated(id,def,team) counts[team]=counts[team] or {}; counts[team][def]=(counts[team][def] or 0)+1 end
function gadget:UnitDestroyed(id,def,team) if counts[team] then counts[team][def]=math.max(0,(counts[team][def] or 1)-1) end end
function gadget:GameFrame(f) if f%30~=0 then return end; for team,t in pairs(counts) do local total=0; for _,n in pairs(t) do total=total+n end; Spring.SetTeamRulesParam(team,"ra2_unit_count",total,{allied=true}) end end
