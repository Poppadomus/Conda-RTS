return {
  ra2_grizzly_cannon = {
    name = "105mm Cannon", weaponType = "Cannon",
    damage = { default = 120, vtol = 30 }, range = 420, reloadtime = 1.8,
    weaponVelocity = 500, areaOfEffect = 32, turret = true, tolerance = 4000,
    lineOfSight = true, explosionGenerator = "custom:RA2_CANNON",
  },
  ra2_rifle = {
    name = "GI Rifle", weaponType = "Cannon",
    damage = { default = 25, vtol = 5 }, range = 280, reloadtime = 0.8,
    weaponVelocity = 650, areaOfEffect = 8, turret = true, tolerance = 4000,
    lineOfSight = true, explosionGenerator = "custom:RA2_RIFLE",
  },
  ra2_rhino_cannon = {
    name = "120mm Cannon", weaponType = "Cannon",
    damage = { default = 160, vtol = 35 }, range = 400, reloadtime = 2.2,
    weaponVelocity = 450, areaOfEffect = 36, turret = true, tolerance = 4000,
    lineOfSight = true, explosionGenerator = "custom:RA2_CANNON",
  },
  ra2_ak47 = {
    name = "AKM", weaponType = "Cannon",
    damage = { default = 22, vtol = 4 }, range = 260, reloadtime = 0.9,
    weaponVelocity = 600, areaOfEffect = 8, turret = true, tolerance = 4000,
    lineOfSight = true, explosionGenerator = "custom:RA2_RIFLE",
  },
}
