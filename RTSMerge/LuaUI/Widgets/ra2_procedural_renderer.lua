function widget:GetInfo()
  return {name="RA2 Procedural Renderer",desc="Runtime-generated RA2/YR unit visuals.",author="RTSMerge",layer=-100,enabled=true}
end

local function teamColor(team)
  local r,g,b=Spring.GetTeamColor(team)
  return r,g,b
end

local function box(w,h,d)
  local x,z=w*.5,d*.5
  gl.BeginEnd(GL.QUADS,function()
    gl.Vertex(-x,0,-z);gl.Vertex(x,0,-z);gl.Vertex(x,0,z);gl.Vertex(-x,0,z)
    gl.Vertex(-x,h,-z);gl.Vertex(-x,h,z);gl.Vertex(x,h,z);gl.Vertex(x,h,-z)
    gl.Vertex(-x,0,-z);gl.Vertex(-x,h,-z);gl.Vertex(x,h,-z);gl.Vertex(x,0,-z)
    gl.Vertex(x,0,-z);gl.Vertex(x,h,-z);gl.Vertex(x,h,z);gl.Vertex(x,0,z)
    gl.Vertex(x,0,z);gl.Vertex(x,h,z);gl.Vertex(-x,h,z);gl.Vertex(-x,0,z)
    gl.Vertex(-x,0,z);gl.Vertex(-x,h,z);gl.Vertex(-x,h,-z);gl.Vertex(-x,0,-z)
  end)
end

local function cyl(r,h,n)
  gl.BeginEnd(GL.QUAD_STRIP,function()
    for i=0,n do
      local a=i/n*math.pi*2
      gl.Vertex(math.cos(a)*r,0,math.sin(a)*r)
      gl.Vertex(math.cos(a)*r,h,math.sin(a)*r)
    end
  end)
end

local function tank(arch,team)
  local p=({grizzly={30,8,42,11,25},rhino={34,9,46,12,27},lasher={28,8,40,10,23},ifv={27,8,39,9,20},mirage={31,8,43,10,23},prism={30,8,43,10,29},apocalypse={38,11,50,14,30},gatling={29,8,41,10,22},magnetron={31,8,42,11,25},tesla={30,8,42,10,25}})[arch] or {30,8,40,10,24}
  local r,g,b=teamColor(team)
  gl.Color(r*.55,g*.55,b*.55,1);box(p[1],p[2],p[3])
  gl.Color(r*.9,g*.9,b*.9,1);box(p[1]*.72,p[2]*.65,p[3]*.48)
  gl.Color(r,g,b,1);cyl(p[4],p[2]*.8,12)
  gl.BeginEnd(GL.QUADS,function()
    gl.Vertex(-2,p[2]*1.8,-p[3]*.2);gl.Vertex(2,p[2]*1.8,-p[3]*.2)
    gl.Vertex(2,p[2]*1.8,-p[3]*.2-p[5]);gl.Vertex(-2,p[2]*1.8,-p[3]*.2-p[5])
  end)
end

local function mcv(team)
  local r,g,b=teamColor(team)
  gl.Color(r*.55,g*.55,b*.55,1);box(34,10,48)
  gl.Color(r*.85,g*.85,b*.85,1);box(28,12,31)
  gl.Color(r,g,b,1);box(20,10,18)
end

local function harvester(team)
  local r,g,b=teamColor(team)
  gl.Color(r*.55,g*.55,b*.55,1);box(38,10,48)
  gl.Color(r*.85,g*.85,b*.85,1);box(30,12,27)
  gl.Color(r,g,b,1);box(20,8,14)
end

local function infantry(team)
  local r,g,b=teamColor(team)
  gl.Color(r*.8,g*.8,b*.8,1);cyl(3,7,8)
  gl.Color(r,g,b,1);cyl(3,3,8)
  gl.Color(r*.7,g*.7,b*.7,1);box(5,6,3)
end

local function aircraft(team)
  local r,g,b=teamColor(team)
  gl.Color(r*.7,g*.7,b*.7,1);box(8,5,28)
  gl.Color(r,g,b,1)
  gl.BeginEnd(GL.QUADS,function()
    gl.Vertex(-18,6,0);gl.Vertex(0,6,5);gl.Vertex(18,6,0);gl.Vertex(0,6,-5)
  end)
end

local function naval(team)
  local r,g,b=teamColor(team)
  gl.Color(r*.55,g*.55,b*.55,1);box(16,5,46)
  gl.Color(r,g,b,1);box(11,8,20)
  cyl(6,5,10)
end

local function building(team)
  local r,g,b=teamColor(team)
  gl.Color(r*.55,g*.55,b*.55,1);box(40,14,36)
  gl.Color(r*.9,g*.9,b*.9,1);box(28,8,25)
  gl.Color(r,g,b,1);cyl(6,8,10)
end

function widget:DrawUnit(unitID,drawMode)
  if drawMode~=1 then return false end
  local defID=Spring.GetUnitDefID(unitID)
  local ud=UnitDefs[defID]
  local cp=ud and ud.customParams
  if not cp or cp.ra2_procedural~="1" then return false end
  local hp,maxhp=Spring.GetUnitHealth(unitID)
  if not hp or hp<=0 then return true end
  local team=Spring.GetUnitTeam(unitID)
  local heading=Spring.GetUnitHeading(unitID) or 0
  gl.PushMatrix()
  gl.Rotate(heading*180/32768,0,1,0)
  gl.DepthTest(true)
  gl.Culling(false)
  local a=cp.ra2_visual or "tank"
  if a=="mcv" then mcv(team)
  elseif a=="harvester" then harvester(team)
  elseif a=="infantry" or a=="engineer" or a=="hero" or a=="spy" then infantry(team)
  elseif a=="aircraft" or a=="helicopter" then aircraft(team)
  elseif a=="naval" then naval(team)
  elseif a=="building" then building(team)
  else tank(a,team) end
  gl.PopMatrix()
  return true
end
