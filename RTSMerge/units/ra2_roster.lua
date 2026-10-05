local function v(name,desc,cost,time,hp,speed,side,visual,weapon,armor)
  local d={name=name,description=desc,buildCostMetal=cost,buildTime=time,maxDamage=hp,maxVelocity=speed,acceleration=.12,brakeRate=.2,canMove=true,canGuard=true,canPatrol=true,canStop=true,category="VEHICLE",customParams={side=side,role="unit",ra2_armor=armor or "MEDIUM",ra2_procedural="1",ra2_visual=visual}}
  if weapon then d.weapons={{def=weapon,onlyTargetCategory="LAND"}} end
  return d
end
local function i(name,desc,cost,side,visual,weapon)
  return v(name,desc,cost,math.max(100,cost*2),100,1.5,side,visual,weapon,"INFANTRY")
end
return {
guardian_gi=i("Guardian GI","Allied anti-tank infantry.",200,"allies","infantry","ra2_grizzly_cannon"),
rocketeer=i("Rocketeer","Allied airborne infantry.",600,"allies","infantry","ra2_rifle"),
engineer=i("Engineer","Combat engineer.",500,"allies","engineer"),
navy_seal=i("Navy SEAL","Allied elite commando.",1000,"allies","hero","ra2_rifle"),
spy=i("Spy","Allied infiltrator.",1000,"allies","spy"),
tanya=i("Tanya","Allied commando.",1000,"allies","hero","ra2_rifle"),
chrono_legionnaire=i("Chrono Legionnaire","Allied chronal infantry.",1500,"allies","hero","ra2_rifle"),
mirage_tank=v("Mirage Tank","Allied stealth battle tank.",1000,900,600,2.3,"allies","mirage","ra2_grizzly_cannon"),
prism_tank=v("Prism Tank","Allied long-range tank.",1200,1000,700,1.9,"allies","prism","ra2_grizzly_cannon"),
ifv=v("IFV","Allied infantry fighting vehicle.",600,650,500,2.7,"allies","ifv","ra2_grizzly_cannon"),
flak_trooper=i("Flak Trooper","Soviet anti-air infantry.",300,"soviet","infantry","ra2_ak47"),
tesla_trooper=i("Tesla Trooper","Soviet electromagnetic infantry.",500,"soviet","hero","ra2_ak47"),
soviet_engineer=i("Soviet Engineer","Soviet combat engineer.",500,"soviet","engineer"),
boris=i("Boris","Soviet hero infantry.",1500,"soviet","hero","ra2_ak47"),
flak_track=v("Flak Track","Soviet anti-air transport.",500,600,400,2.8,"soviet","ifv","ra2_ak47"),
terror_drone=v("Terror Drone","Soviet parasitic drone.",500,500,150,3.5,"soviet","infantry","ra2_ak47","LIGHT"),
v3_rocket=v("V3 Rocket Launcher","Soviet long-range artillery.",800,850,300,1.5,"soviet","tesla","ra2_rhino_cannon"),
apocalypse_tank=v("Apocalypse Tank","Soviet super-heavy tank.",1750,1400,1000,1.7,"soviet","apocalypse","ra2_rhino_cannon","HEAVY"),
tesla_tank=v("Tesla Tank","Soviet Tesla battle tank.",1200,1000,700,2.0,"soviet","tesla","ra2_rhino_cannon"),
kirov=v("Kirov Airship","Soviet heavy bomber.",2000,1800,1200,1.2,"soviet","aircraft","ra2_rhino_cannon","HEAVY"),
siege_chopper=v("Siege Chopper","Soviet artillery helicopter.",1200,1200,500,2.2,"soviet","helicopter","ra2_rhino_cannon"),
brute=i("Brute","Yuri heavy infantry.",500,"yuri","infantry","ra2_rifle"),
virus=i("Virus","Yuri toxin sniper.",700,"yuri","hero","ra2_rifle"),
mastermind=v("Mastermind","Yuri psychic battle vehicle.",1750,1500,800,1.6,"yuri","magnetron","ra2_grizzly_cannon","HEAVY"),
yuri_prime=i("Yuri Prime","Yuri psychic hero.",1500,"yuri","hero","ra2_rifle"),
gatling_tank=v("Gattling Tank","Yuri anti-air/anti-infantry tank.",900,850,650,2.3,"yuri","gatling","ra2_grizzly_cannon"),
magnetron=v("Magnetron","Yuri magnetic support vehicle.",1000,900,500,2.0,"yuri","magnetron","ra2_grizzly_cannon"),
chaos_drone=v("Chaos Drone","Yuri chaos vehicle.",500,550,250,3.0,"yuri","lasher","ra2_grizzly_cannon","LIGHT"),
grinder=v("Grinder","Yuri crushing vehicle.",1000,900,800,1.8,"yuri","lasher","ra2_grizzly_cannon"),
boomer=v("Boomer Submarine","Yuri missile submarine.",1500,1300,800,1.7,"yuri","naval","ra2_rhino_cannon","HEAVY"),
};
