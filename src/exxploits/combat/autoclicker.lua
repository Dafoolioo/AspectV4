-- ASPECTV4 | AUTO CLICKER
-- ID: 4 | Type: Combat
-- Automatically clicks at adjustable CPS with jitter

local Core = _G.Aspect

local AutoClicker = {
    enabled = false,
    cps = 12,
    jitter = true,
    clickTimer = 0,
    mouse = game.Players.LocalPlayer:GetMouse()
}

local function toggle(state)
    AutoClicker.enabled = state
    AutoClicker.clickTimer = 0
end

-- Click function
local function click()
    if not AutoClicker.enabled then return end
    
    AutoClicker.clickTimer = AutoClicker.clickTimer + game:GetService("RunService").Heartbeat:Wait()
    local clickInterval = 1 / AutoClicker.cps
    
    if AutoClicker.clickTimer >= clickInterval then
        AutoClicker.clickTimer = 0
        
        -- Left click
        AutoClicker.mouse.Button1Down:Fire()
        task.wait(0.01)
        AutoClicker.mouse.Button1Up:Fire()
        
        -- Jitter (mouse movement)
        if AutoClicker.jitter then
            local jitterX = math.random(-3, 3)
            local jitterY = math.random(-3, 3)
            AutoClicker.mouse.Move(AutoClicker.mouse.X + jitterX, AutoClicker.mouse.Y + jitterY)
        end
    end
end

Core.RegisterExploit(4, "AutoClicker", toggle, {
    cps = { type = "slider", min = 8, max = 20, default = 12 },
    jitter = { type = "toggle", default = true }
})

Core.AddHook("Heartbeat", click)

print("[ASPECTV4] AutoClicker loaded (disabled)")
return AutoClicker
