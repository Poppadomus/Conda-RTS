local function building(name, description, cost, time, hp, x, z, custom)
  return {
    name=name, description=description, buildCostMetal=cost, buildTime=time, maxDamage=hp,
    footprintX=x, footprintZ=z, canMove=false, canAttack=false, category="BUILDING",
    customParams=custom or {},
  }
end

local function vehicle(name, description, cost, time, hp, speed, custom, weapon)
  local d = {
    name=name, description=description, buildCostMetal=cost, buildTime=time, maxDamage=hp,
    maxVelocity=speed, acceleration=0.12, brakeRate=0.2,
    canMove=true, canGuard=true, canPatrol=true, canStop=true,
    category="VEHICLE", customParams=custom or {},
  }
  if weapon then d.weapons={weapon} end
  return d
end

local function infantry(name, description, cost, time, hp, custom, weapon)
  local d = {
    name=name, description=description, buildCostMetal=cost, buildTime=time, maxDamage=hp,
    maxVelocity=1.5, acceleration=0.4, brakeRate=0.5,
    canMove=true, canGuard=true, canPatrol=true, canStop=true,
    category="INFANTRY", customParams=custom or {},
  }
  if weapon then d.weapons={weapon} end
  return d
end

return {
  allied_mcv=vehicle("Allied MCV","Deployable Allied Mobile Construction Vehicle.",3000,1800,1000,1.5,{side="allies",role="mcv"}),
  allied_conyard=building("Allied Construction Yard","Primary Allied construction structure.",2500,1500,1500,4,4,{side="allies",role="conyard"}),
  allied_power=building("Power Plant","Generates electrical power.",800,600,750,2,2,{side="allies",role="power",power="100"}),
  allied_refinery=building("Ore Refinery","Processes ore into credits.",2000,1200,1000,4,3,{side="allies",role="refinery"}),
  allied_barracks=building("Allied Barracks","Produces Allied infantry.",500,500,500,2,2,{side="allies",role="barracks"}),
  allied_warfactory=building("War Factory","Produces Allied vehicles.",2000,1200,1000,4,3,{side="allies",role="warfactory"}),
  grizzly_tank=vehicle("Grizzly Battle Tank","Allied main battle tank.",700,700,600,2.4,{side="allies",role="tank"},{def="ra2_grizzly_cannon",onlyTargetCategory="LAND"}),
  gi=infantry("GI","Standard Allied infantry.",100,100,125,{side="allies",role="infantry"},{def="ra2_rifle",onlyTargetCategory="LAND"}),
  allied_harvester=vehicle("Chrono Miner","Allied ore harvester.",1400,1000,1000,1.1,{side="allies",role="harvester",ra2_harvester="1"}),

  soviet_mcv=vehicle("Soviet MCV","Deployable Soviet Mobile Construction Vehicle.",3000,1800,1100,1.4,{side="soviet",role="mcv"}),
  soviet_conyard=building("Soviet Construction Yard","Primary Soviet construction structure.",2500,1500,1600,4,4,{side="soviet",role="conyard"}),
  soviet_power=building("Tesla Reactor","Generates large amounts of electrical power.",800,600,800,2,2,{side="soviet",role="power",power="150"}),
  soviet_refinery=building("Ore Refinery","Processes ore into credits.",2000,1200,1100,4,3,{side="soviet",role="refinery"}),
  soviet_barracks=building("Soviet Barracks","Produces Soviet infantry.",500,500,550,2,2,{side="soviet",role="barracks"}),
  soviet_warfactory=building("Soviet War Factory","Produces Soviet vehicles.",2000,1200,1100,4,3,{side="soviet",role="warfactory"}),
  rhino_tank=vehicle("Rhino Heavy Tank","Soviet main battle tank.",900,800,750,2.2,{side="soviet",role="tank"},{def="ra2_rhino_cannon",onlyTargetCategory="LAND"}),
  conscript=infantry("Conscript","Standard Soviet infantry.",100,100,140,{side="soviet",role="infantry"},{def="ra2_ak47",onlyTargetCategory="LAND"}),
  soviet_harvester=vehicle("War Miner","Soviet ore harvester.",1400,1000,1100,1.0,{side="soviet",role="harvester",ra2_harvester="1"}),

  yuri_mcv=vehicle("Yuri MCV","Deployable Yuri Mobile Construction Vehicle.",3000,1800,1000,1.5,{side="yuri",role="mcv"}),
  yuri_conyard=building("Yuri Construction Yard","Primary Yuri construction structure.",2500,1500,1500,4,4,{side="yuri",role="conyard"}),
  yuri_power=building("Bio Reactor","Yuri power generation.",800,600,700,2,2,{side="yuri",role="power",power="150"}),
  yuri_refinery=building("Slave Miner","Yuri ore collection and processing.",2000,1200,1000,4,3,{side="yuri",role="refinery"}),
  yuri_barracks=building("Yuri Barracks","Produces Yuri infantry.",500,500,500,2,2,{side="yuri",role="barracks"}),
  yuri_warfactory=building("Yuri War Factory","Produces Yuri vehicles.",2000,1200,1000,4,3,{side="yuri",role="warfactory"}),
  lasher_tank=vehicle("Lasher Light Tank","Yuri main battle tank.",700,700,600,2.5,{side="yuri",role="tank"},{def="ra2_grizzly_cannon",onlyTargetCategory="LAND"}),
  initiates=infantry("Initiate","Yuri basic infantry.",100,100,110,{side="yuri",role="infantry"},{def="ra2_rifle",onlyTargetCategory="LAND"}),
  yuri_slave_miner=vehicle("Slave Miner","Yuri mobile ore processor.",1400,1000,950,0.9,{side="yuri",role="harvester",ra2_harvester="1"}),
}
