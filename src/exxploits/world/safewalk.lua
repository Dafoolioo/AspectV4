-- ASPECTV4 | SAFE WALK
-- ID: 51 | Type: World
-- Prevents walking off edges

local Core = _G.Aspect

local SafeWalk = {
    enabled = false
}

local function toggle(state)
    SafeWalk.enabled = state
end

local function safeWalk()
    if not SafeWalk.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Check for edge
    local ray = Ray.new(root.Position + Vector3.new(0, -2, 0), root.CFrame.LookVector * 2)
    local hit = workspace:FindPartOnRay(ray)
    
    if not hit then
        -- Edge detected, stop movement
        root.Velocity = Vector3.new(0, root.Velocity.Y, 0)
    end
end

Core.RegisterExploit(51, "SafeWalk", toggle, {})

Core.AddHook("Heartbeat", safeWalk)

print("[ASPECTV4] SafeWalk loaded (disabled)")
return SafeWalk
