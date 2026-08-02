-- ASPECTV4 | INTERACT EXTENDER
-- ID: 49 | Type: World
-- Extends interaction range

local Core = _G.Aspect

local InteractExtender = {
    enabled = false,
    distance = 50
}

local function toggle(state)
    InteractExtender.enabled = state
end

local function extendInteraction()
    if not InteractExtender.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if lp then
        for _, prompt in ipairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") then
                prompt.MaxActivationDistance = InteractExtender.distance
            end
        end
    end
end

Core.RegisterExploit(49, "InteractExtender", toggle, {
    distance = { type = "slider", min = 10, max = 200, default = 50 }
})

Core.AddHook("Heartbeat", extendInteraction)

print("[ASPECTV4] InteractExtender loaded (disabled)")
return InteractExtender
