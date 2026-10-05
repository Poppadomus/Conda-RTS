function gadget:GetInfo()
 return {name="RA2 Ore Fields",desc="Deterministic ore/gem fields and harvester cargo.",author="RTSMerge",layer=1,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end
local CELL=128
local RADIUS=512
local HARVEST=5
local fields={}
local harvesters={}
local function key(x,z) return math.floor(x/CELL)..":"..math.floor(z/CELL) end
local function nearest(x,z)
 local best,dist
 for k,f in pairs(fields) do
  local dx,dz=x-f.x,z-f.z
  local d=dx*dx+dz*dz
  if d<=RADIUS*RADIUS and (not dist or d<dist) then best,dist=k,d end
 end
 return best
end
function gadget:Initialize()
 if GG.ra2_ore_fields then
  for _,f in ipairs(GG.ra2_ore_fields) do fields[key(f.x,f.z)]={x=f.x,z=f.z,ore=f.ore or 10000,gems=f.gems or 0} end
 end
end
function gadget:UnitCreated(id,def,team)
 local cp=UnitDefs[def].customParams or {}
 if cp.ra2_harvester=="1" then harvesters[id]={load=0} end
end
function gadget:UnitDestroyed(id) harvesters[id]=nil end
function gadget:GameFrame(frame)
 if frame%15~=0 then return end
 for id,h in pairs(harvesters) do
  local x,_,z=Spring.GetUnitPosition(id)
  if x then
   local k=nearest(x,z)
   if k then
    local f=fields[k]
    local amount=math.min(HARVEST,100-h.load,f.ore)
    if amount>0 then h.load=h.load+amount; f.ore=f.ore-amount end
    Spring.SetUnitRulesParam(id,"ra2_cargo",h.load,{allied=true})
   end
  end
 end
end
