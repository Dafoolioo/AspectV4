-- ASPECTV4 | TRIGGERBOT
-- ID: 7 | Type: Combat
-- Automatically shoots when crosshair is on enemy

local Core = _G.Aspect

local Triggerbot = {
    enabled = false,
    delay = 50,
    mouse = game.Players.LocalPlayer:GetMouse()
}

local function toggle(state)
    Triggerbot.enabled = state
end

-- Check if crosshair is on enemy
local function checkCrosshair()
    if not Triggerbot.enabled then return end
    
    local target = Core.GetClosestToCursor()
    if target and target.Character then
        local head = target.Character:FindFirstChild("Head")
        if head then
            -- Simulate click
            Triggerbot.mouse.Button1Down:Fire()
            task.wait(0.01)
            Triggerbot.mouse.Button1Up:Fire()
        end
    end
end

Core.RegisterExploit(7, "Triggerbot", toggle, {
    delay = { type = "slider", min = 0, max = 200, default = 50 }
})

Core.AddHook("Heartbeat", checkCrosshair)

print("[ASPECTV4] Triggerbot loaded (disabled)")
return Triggerbot
