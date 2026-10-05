function gadget:GetInfo() return {name="RA2 Game State",desc="Authoritative match state counters.",author="RTSMerge",layer=60,enabled=true} end
if not gadgetHandler:IsSyncedCode() then return end
function gadget:Initialize()
 Spring.SetGameRulesParam("ra2_frame",0,{allied=true})
 Spring.SetGameRulesParam("ra2_version",2,{allied=true})
end
function gadget:GameFrame(f) if f%30==0 then Spring.SetGameRulesParam("ra2_frame",f,{allied=true}) end end
