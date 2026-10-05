local function building(name,description,cost,time,hp,x,z,custom,options)
 custom=custom or {}; custom.ra2_armor=custom.ra2_armor or "BUILDING"; custom.ra2_procedural=custom.ra2_procedural or "1"; custom.ra2_visual=custom.ra2_visual or "building"
 return {name=name,description=description,buildCostMetal=cost,buildTime=time,maxDamage=hp,footprintX=x,footprintZ=z,canMove=false,canAttack=false,category="BUILDING",builder=true,buildDistance=180,buildSpeed=250,customParams=custom,buildOptions=options}
end
local function vehicle(name,description,cost,time,hp,speed,custom,weapon)
 custom=custom or {}; custom.ra2_armor=custom.ra2_armor or "MEDIUM"
 local d={name=name,description=description,buildCostMetal=cost,buildTime=time,maxDamage=hp,maxVelocity=speed,acceleration=0.12,brakeRate=0.2,canMove=true,canGuard=true,canPatrol=true,canStop=true,category="VEHICLE",customParams=custom}
 if weapon then d.weapons={weapon} end; return d
end
local function infantry(name,description,cost,time,hp,custom,weapon)
 custom=custom or {}; custom.ra2_armor=custom.ra2_armor or "INFANTRY"
 local d={name=name,description=description,buildCostMetal=cost,buildTime=time,maxDamage=hp,maxVelocity=1.5,acceleration=0.4,brakeRate=0.5,canMove=true,canGuard=true,canPatrol=true,canStop=true,category="INFANTRY",customParams=custom}
 if weapon then d.weapons={weapon} end; return d
end
return {
 allied_mcv=vehicle("Allied MCV","Mobile construction vehicle. Build the Allied Construction Yard.",3000,1800,1000,1.5,{side="allies",role="mcv",ra2_armor="HEAVY"}),
 allied_conyard=building("Allied Construction Yard","Primary Allied construction structure.",2500,1500,1500,4,4,{side="allies",role="conyard",ra2_conyard="1",ra2_armor="BUILDING"},{"allied_power","allied_refinery","allied_barracks","allied_warfactory"}),
 allied_power=building("Power Plant","Generates electrical power.",800,600,750,2,2,{side="allies",role="power",power="100",power_drain="0"}),
 allied_refinery=building("Ore Refinery","Processes ore into credits.",2000,1200,1000,4,3,{side="allies",role="refinery"}),
 allied_barracks=building("Allied Barracks","Produces Allied infantry.",500,500,500,2,2,{side="allies",role="barracks"},{"gi"}),
 allied_warfactory=building("War Factory","Produces Allied vehicles.",2000,1200,1000,4,3,{side="allies",role="warfactory"},{"grizzly_tank","allied_harvester"}),
 grizzly_tank=vehicle("Grizzly Battle Tank","Allied main battle tank.",700,700,600,2.4,{side="allies",role="tank",ra2_armor="MEDIUM"},{def="ra2_grizzly_cannon",onlyTargetCategory="LAND"}),
 gi=infantry("GI","Standard Allied infantry.",100,100,125,{side="allies",role="infantry",ra2_armor="INFANTRY"},{def="ra2_rifle",onlyTargetCategory="LAND"}),
 allied_harvester=vehicle("Chrono Miner","Allied ore harvester.",1400,1000,1000,1.1,{side="allies",role="harvester",ra2_harvester="1",ra2_armor="HEAVY"}),
 soviet_mcv=vehicle("Soviet MCV","Mobile construction vehicle. Build the Soviet Construction Yard.",3000,1800,1100,1.4,{side="soviet",role="mcv",ra2_armor="HEAVY"}),
 soviet_conyard=building("Soviet Construction Yard","Primary Soviet Construction Yard.",2500,1500,1600,4,4,{side="soviet",role="conyard",ra2_conyard="1"},{"soviet_power","soviet_refinery","soviet_barracks","soviet_warfactory"}),
 soviet_power=building("Tesla Reactor","Generates electrical power.",800,600,800,2,2,{side="soviet",role="power",power="150",power_drain="0"}),
 soviet_refinery=building("Ore Refinery","Processes ore into credits.",2000,1200,1100,4,3,{side="soviet",role="refinery"}),
 soviet_barracks=building("Soviet Barracks","Produces Soviet infantry.",500,500,550,2,2,{side="soviet",role="barracks"},{"conscript"}),
 soviet_warfactory=building("Soviet War Factory","Produces Soviet vehicles.",2000,1200,1100,4,3,{side="soviet",role="warfactory"},{"rhino_tank","soviet_harvester"}),
 rhino_tank=vehicle("Rhino Heavy Tank","Soviet main battle tank.",900,800,750,2.2,{side="soviet",role="tank",ra2_armor="HEAVY"},{def="ra2_rhino_cannon",onlyTargetCategory="LAND"}),
 conscript=infantry("Conscript","Standard Soviet infantry.",100,100,140,{side="soviet",role="infantry",ra2_armor="INFANTRY"},{def="ra2_ak47",onlyTargetCategory="LAND"}),
 soviet_harvester=vehicle("War Miner","Soviet ore harvester.",1400,1000,1100,1.0,{side="soviet",role="harvester",ra2_harvester="1",ra2_armor="HEAVY"}),
 yuri_mcv=vehicle("Yuri MCV","Mobile construction vehicle. Build the Yuri Construction Yard.",3000,1800,1000,1.5,{side="yuri",role="mcv",ra2_armor="HEAVY"}),
 yuri_conyard=building("Yuri Construction Yard","Primary Yuri Construction Yard.",2500,1500,1500,4,4,{side="yuri",role="conyard",ra2_conyard="1"},{"yuri_power","yuri_refinery","yuri_barracks","yuri_warfactory"}),
 yuri_power=building("Bio Reactor","Yuri power generation.",800,600,700,2,2,{side="yuri",role="power",power="150",power_drain="0"}),
 yuri_refinery=building("Slave Miner","Yuri ore collection and processing.",2000,1200,1000,4,3,{side="yuri",role="refinery"}),
 yuri_barracks=building("Yuri Barracks","Produces Yuri infantry.",500,500,500,2,2,{side="yuri",role="barracks"},{"initiates"}),
 yuri_warfactory=building("Yuri War Factory","Produces Yuri vehicles.",2000,1200,1000,4,3,{side="yuri",role="warfactory"},{"lasher_tank","yuri_slave_miner"}),
 lasher_tank=vehicle("Lasher Light Tank","Yuri main battle tank.",700,700,600,2.5,{side="yuri",role="tank",ra2_armor="MEDIUM"},{def="ra2_grizzly_cannon",onlyTargetCategory="LAND"}),
 initiates=infantry("Initiate","Yuri basic infantry.",100,100,110,{side="yuri",role="infantry",ra2_armor="INFANTRY"},{def="ra2_rifle",onlyTargetCategory="LAND"}),
 yuri_slave_miner=vehicle("Slave Miner","Yuri mobile ore processor.",1400,1000,950,0.9,{side="yuri",role="harvester",ra2_harvester="1",ra2_armor="HEAVY"})
}
