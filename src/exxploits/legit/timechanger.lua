-- ASPECTV4 | TIME CHANGER
-- ID: 73 | Type: Legit
-- Changes in-game time

local Core = _G.Aspect

local TimeChanger = {
    enabled = false,
    time = 12
}

local function toggle(state)
    TimeChanger.enabled = state
    if state then
        game:GetService("Lighting").TimeOfDay = TimeChanger.time * 60
    else
        game:GetService("Lighting").TimeOfDay = 12 * 60
    end
end

Core.RegisterExploit(73, "TimeChanger", toggle, {
    time = { type = "slider", min = 0, max = 24, default = 12 }
})

print("[ASPECTV4] TimeChanger loaded (disabled)")
return TimeChanger
