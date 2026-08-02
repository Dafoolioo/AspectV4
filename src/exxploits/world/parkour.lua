-- ASPECTV4 | PARKOUR
-- ID: 50 | Type: World
-- Auto-jumps at edge of platform

local Core = _G.Aspect

local Parkour = {
    enabled = false,
    detection = 0.5
}

local function toggle(state)
    Parkour.enabled = state
end

local function parkour()
    if not Parkour.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = lp.Character:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    
    -- Check for edge
    local ray = Ray.new(root.Position, Vector3.new(0, -5, 0))
    local hit = workspace:FindPartOnRay(ray)
    
    if not hit then
        -- No ground detected, jump
        humanoid.Jump = true
    end
end

Core.RegisterExploit(50, "Parkour", toggle, {
    detection = { type = "slider", min = 0.1, max = 2, default = 0.5 }
})

Core.AddHook("Heartbeat", parkour)

print("[ASPECTV4] Parkour loaded (disabled)")
return Parkour
