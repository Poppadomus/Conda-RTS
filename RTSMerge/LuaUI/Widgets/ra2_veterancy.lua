function widget:GetInfo() return {name="RA2 Veterancy Indicators",desc="Veteran and elite unit markers.",author="RTSMerge",layer=4,enabled=true} end
function widget:DrawWorld()
 for _,id in ipairs(Spring.GetSelectedUnits()) do local v=Spring.GetUnitRulesParam(id,"ra2_veterancy") or 0; if v>0 then local x,y,z=Spring.GetUnitPosition(id); if x then gl.Text(v>=3 and "ELITE" or "VETERAN",x,y+20,z) end end end
end
