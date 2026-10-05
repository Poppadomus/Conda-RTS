local function b(name,desc,cost,hp,side,role)
  return {name=name,description=desc,buildCostMetal=cost,buildTime=math.max(300,cost*1.5),maxDamage=hp,footprintX=3,footprintZ=3,canMove=false,canAttack=false,category="BUILDING",builder=true,buildDistance=180,buildSpeed=250,customParams={side=side,role=role or "support",ra2_armor="BUILDING",ra2_procedural="1",ra2_visual="building"}}
end
return {
allied_airforce=b("Allied Air Force Command","Allied aircraft production.",1000,800,"allies","airfield"),
allied_service_depot=b("Service Depot","Repairs Allied vehicles.",800,800,"allies","repair"),
allied_radar=b("Spy Satellite Uplink","Allied radar and satellite support.",1000,700,"allies","radar"),
allied_tech=b("Battle Lab","Allied advanced technology.",2000,1000,"allies","tech"),
allied_naval=b("Allied Naval Shipyard","Builds Allied naval units.",1000,1000,"allies","naval"),
allied_turret=b("Pillbox","Allied anti-infantry defense.",500,400,"allies","defense"),
allied_aa=b("Patriot Missile System","Allied anti-air defense.",1000,700,"allies","defense"),
soviet_battle_lab=b("Soviet Battle Lab","Soviet advanced technology.",2000,1000,"soviet","tech"),
soviet_airfield=b("Soviet Air Force Command","Soviet aircraft production.",1000,800,"soviet","airfield"),
soviet_radar=b("Radar Tower","Soviet radar.",1000,700,"soviet","radar"),
soviet_naval=b("Soviet Naval Shipyard","Builds Soviet naval units.",1000,1000,"soviet","naval"),
soviet_tesla=b("Tesla Coil","Soviet heavy defense.",1200,800,"soviet","defense"),
soviet_flak=b("Flak Cannon","Soviet anti-air defense.",1000,700,"soviet","defense"),
yuri_battle_lab=b("Psychic Radar","Yuri advanced technology.",1500,900,"yuri","tech"),
yuri_gattling=b("Gatling Turret","Yuri defense.",800,600,"yuri","defense"),
yuri_cloning=b("Cloning Vats","Yuri infantry cloning.",2500,1000,"yuri","barracks"),
yuri_naval=b("Yuri Naval Shipyard","Builds Yuri naval units.",1200,1000,"yuri","naval")
};
