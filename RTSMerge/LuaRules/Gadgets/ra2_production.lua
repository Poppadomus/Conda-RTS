function gadget:GetInfo() return {name="RA2 Production and Prerequisites",desc="Authoritative RA2 construction gates.",author="RTSMerge",layer=20,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
local rules=VFS.Include("gamedata/ra2_rules.lua")
local units,buildings={},{}
for _,v in ipairs(rules.units) do units[v.id]=v end
for _,v in ipairs(rules.buildings) do buildings[v.id]=v end
local names={}
for n,ud in pairs(UnitDefNames) do names[ud.id]=n end
local producers={allies={barracks="allied_barracks",warfactory="allied_warfactory"},soviet={barracks="soviet_barracks",warfactory="soviet_warfactory"},yuri={barracks="yuri_barracks",warfactory="yuri_warfactory"}}
local sideNames={"allies","soviet","yuri"}
local function side(team)
 local s=select(5,Spring.GetTeamInfo(team,false))
 if type(s)=="string" then
  s=s:lower()
  if s=="allies" or s=="soviet" or s=="yuri" then return s end
 end
 s=tonumber(s) or 0
 return s==1 and "soviet" or s==2 and "yuri" or "allies"
end
local function owns(team,name)
 local ud=UnitDefNames[name]
 return ud and Spring.GetTeamUnitDefCount(team,ud.id)>0
end
local function can(team,name)
 local b=buildings[name]
 if b then if b.side~=side(team) then return false end; for _,r in ipairs(b.requires) do if not owns(team,r) then return false end end; return true end
 local u=units[name]
 if not u or u.side~=side(team) then return false end
 local p=producers[u.side] and producers[u.side][u.production]
 return p and owns(team,p) or false
end
function gadget:Initialize() gadgetHandler:RegisterAllowCommand(CMD.BUILD) end
function gadget:AllowCommand(unitID,unitDefID,teamID,cmdID,params)
 if cmdID~=CMD.BUILD then return true end
 local builder=UnitDefs[unitDefID]
 local role=builder and builder.customParams and builder.customParams.role
 -- Factories use the authoritative custom production queue; Construction Yards use native building.
 if (role=="barracks" or role=="warfactory") and params and tonumber(params[1]) and tonumber(params[1])<0 then return false end
 local raw=params and params[1]; if not raw then return true end
 local name=names[math.abs(raw)]
 if not name then return false end
 return can(teamID,name)
end
