-- ASPECTV4 | FAST INTERACTION
-- ID: 46 | Type: World
-- Speeds up ProximityPrompt interactions

local Core = _G.Aspect

local FastInteraction = {
    enabled = false,
    speed = 5
}

local function toggle(state)
    FastInteraction.enabled = state
end

local function fastInteract()
    if not FastInteraction.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if lp then
        for _, prompt in ipairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                prompt.HoldDuration = 0.1
            end
        end    end
end

Core.RegisterExploit(46, "FastInteraction", toggle, {
    speed = { type = "slider", min = 1, max = 10, default = 5 }
})

Core.AddHook("Heartbeat", fastInteract)

print("[ASPECTV4] FastInteraction loaded (disabled)")
return FastInteraction
