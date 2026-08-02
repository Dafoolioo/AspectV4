-- ASPECTV4 | TIMER
-- ID: 25 | Type: Blatant
-- Changes game speed using StepPhysics

local Core = _G.Aspect

local Timer = {
    enabled = false,
    speed = 1.5
}

local function toggle(state)
    Timer.enabled = state
    if state then
        game:GetService("RunService").Stepped:Connect(function(dt)
            if Timer.enabled then
                -- Multiply time
                game:GetService("RunService").Stepped:Wait(Timer.speed - 1)
            end
        end)
    end
end

Core.RegisterExploit(25, "Timer", toggle, {
    speed = { type = "slider", min = 0.1, max = 5.0, default = 1.5 }
})

print("[ASPECTV4] Timer loaded (disabled)")
return Timer
