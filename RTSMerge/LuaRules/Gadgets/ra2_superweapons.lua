function gadget:GetInfo()
 return {name="RA2 Superweapon Charge",desc="Deterministic RA2/YR superweapon charge state.",author="RTSMerge",layer=40,enabled=true}
end
if not gadgetHandler:IsSyncedCode() then return end
local defs={chronosphere=1800,iron_curtain=1500,weather_control=1800,nuclear_missile=2100,psychic_dominator=2100,genetic_mutator=1500,force_shield=1800}
local state={}
function gadget:Initialize()
 for _,team in ipairs(Spring.GetTeamList()) do state[team]={} end
end
function gadget:GameFrame(frame)
 if frame%30~=0 then return end
 for team,s in pairs(state) do
  for name,charge in pairs(defs) do
   s[name]=math.min(charge,(s[name] or 0)+1)
   Spring.SetTeamRulesParam(team,"ra2_sw_"..name,s[name],{allied=true})
  end
 end
end
