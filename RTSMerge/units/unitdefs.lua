local defs = {}

defs.gdi_mcv = {
  name = "Mobile Construction Vehicle",
  description = "Deploys into a Construction Yard.",
  acceleration = 0.04,
  brakeRate = 0.08,
  buildCostMetal = 1200,
  buildTime = 1200,
  maxDamage = 1800,
  maxVelocity = 1.6,
  movementClass = "TANK",
  footprintX = 3,
  footprintZ = 3,
  canMove = true,
  canGuard = true,
  canPatrol = true,
  canStop = true,
  category = "VEHICLE",
}

defs.gdi_conyard = {
  name = "Construction Yard",
  description = "Primary base construction structure.",
  buildCostMetal = 1500,
  buildTime = 1500,
  maxDamage = 2500,
  footprintX = 4,
  footprintZ = 4,
  builder = true,
  buildDistance = 600,
  workerTime = 200,
  canMove = false,
  category = "BUILDING",
}

defs.gdi_refinery = {
  name = "Tiberium Refinery",
  description = "Processes harvested Tiberium into credits.",
  buildCostMetal = 2000,
  buildTime = 1600,
  maxDamage = 1800,
  footprintX = 4,
  footprintZ = 4,
  canMove = false,
  category = "BUILDING",
}

defs.gdi_power = {
  name = "Power Plant",
  description = "Supplies base power.",
  buildCostMetal = 300,
  buildTime = 400,
  maxDamage = 700,
  footprintX = 2,
  footprintZ = 2,
  canMove = false,
  category = "BUILDING",
}

defs.gdi_barracks = {
  name = "Barracks",
  description = "Produces infantry.",
  buildCostMetal = 500,
  buildTime = 600,
  maxDamage = 900,
  footprintX = 2,
  footprintZ = 2,
  canMove = false,
  category = "BUILDING",
}

return defs
