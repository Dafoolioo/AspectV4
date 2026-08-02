-- ASPECTV4 - ULTIMATE BEDWARS SCRIPT
-- Version: 4.0.0
-- Repository: https://github.com/YOUR_USERNAME/AspectV4

local repo = "https://raw.githubusercontent.com/Dafooliooo/AspectV4/main/"

local function loadModule(path)
    return loadstring(game:HttpGet(repo .. path))()
end

-- Load configuration
loadModule("config.lua")

-- Load core
loadModule("src/core/init.lua")
loadModule("src/core/sandbox.lua")
loadModule("src/core/hookmanager.lua")
loadModule("src/core/memory.lua")

-- Load ALL exploits (74 total)
local exploitPaths = {
    -- Combat (8)
    "src/exploits/combat/aimassist.lua",
    "src/exploits/combat/silentaim.lua",
    "src/exploits/combat/hitboxexpander.lua",
    "src/exploits/combat/autoclicker.lua",
    "src/exploits/combat/projectileaimbot.lua",
    "src/exploits/combat/daveyaim.lua",
    "src/exploits/combat/triggerbot.lua",
    "src/exploits/combat/reach.lua",
    
    -- Blatant (17)
    "src/exploits/blatant/antifall.lua",
    "src/exploits/blatant/desync.lua",
    "src/exploits/blatant/fly.lua",
    "src/exploits/blatant/highjump.lua",
    "src/exploits/blatant/hitboxes.lua",
    "src/exploits/blatant/infinitejump.lua",
    "src/exploits/blatant/invisible.lua",
    "src/exploits/blatant/killaura.lua",
    "src/exploits/blatant/longjump.lua",
    "src/exploits/blatant/mousetp.lua",
    "src/exploits/blatant/phase.lua",
    "src/exploits/blatant/speed.lua",
    "src/exploits/blatant/spider.lua",
    "src/exploits/blatant/spinbot.lua",
    "src/exploits/blatant/swim.lua",
    "src/exploits/blatant/targetstrafe.lua",
    "src/exploits/blatant/timer.lua",
    
    -- Render (8)
    "src/exploits/render/arrows.lua",
    "src/exploits/render/chams.lua",
    "src/exploits/render/esp.lua",
    "src/exploits/render/fullbright.lua",
    "src/exploits/render/nametags.lua",
    "src/exploits/render/tracers.lua",
    "src/exploits/render/waypoints.lua",
    "src/exploits/render/zoomunlocker.lua",
    
    -- Utility (11)
    "src/exploits/utility/animationplayer.lua",
    "src/exploits/utility/antiragdoll.lua",
    "src/exploits/utility/autorejoin.lua",
    "src/exploits/utility/blink.lua",
    "src/exploits/utility/chatspammer.lua",
    "src/exploits/utility/disabler.lua",
    "src/exploits/utility/panic.lua",
    "src/exploits/utility/rejoin.lua",
    "src/exploits/utility/serverhop.lua",
    "src/exploits/utility/staffdetector.lua",
    "src/exploits/utility/statespoofer.lua",
    
    -- World (8)
    "src/exploits/world/antiafk.lua",
    "src/exploits/world/fastinteraction.lua",
    "src/exploits/world/freecam.lua",
    "src/exploits/world/gravity.lua",
    "src/exploits/world/interactextender.lua",
    "src/exploits/world/parkour.lua",
    "src/exploits/world/safewalk.lua",
    "src/exploits/world/xray.lua",
    
    -- Bedwars (4)
    "src/exploits/bedwars/sprint.lua",
    "src/exploits/bedwars/autoqueue.lua",
    "src/exploits/bedwars/autogamble.lua",
    "src/exploits/bedwars/infiniterewards.lua",
    
    -- Minigames (1)
    "src/exploits/minigames/murder mystery.lua",
    
    -- Legit (17)
    "src/exploits/legit/atmosphere.lua",
    "src/exploits/legit/breadcrumbs.lua",
    "src/exploits/legit/cape.lua",
    "src/exploits/legit/chinahat.lua",
    "src/exploits/legit/clock.lua",
    "src/exploits/legit/coords.lua",
    "src/exploits/legit/disguise.lua",
    "src/exploits/legit/fflag.lua",
    "src/exploits/legit/fov.lua",
    "src/exploits/legit/fps.lua",
    "src/exploits/legit/keystrokes.lua",
    "src/exploits/legit/memory.lua",
    "src/exploits/legit/ping.lua",
    "src/exploits/legit/songbeats.lua",
    "src/exploits/legit/speedmeter.lua",
    "src/exploits/legit/timechanger.lua"
}

for _, path in ipairs(exploitPaths) do
    loadModule(path)
end

-- Load UI last
loadModule("src/ui/theme.lua")
loadModule("src/ui/mainui.lua")

print("==========================================")
print("ASPECTV4 v4.0.0 LOADED SUCCESSFULLY")
print("All 74 exploits are DISABLED by default")
print("Press INSERT to open the UI menu")
print("==========================================")
