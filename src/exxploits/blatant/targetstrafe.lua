-- ASPECTV4 | TARGET STRAFE
-- ID: 24 | Type: Blatant
-- Automatically strafes around opponents

local Core = _G.Aspect

local TargetStrafe = {
    enabled = false,
    radius = 5,
    speed = 10,
    angle = 0
}

local function toggle(state)
    TargetStrafe.enabled = state
end

local function strafe()
    if not TargetStrafe.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local target = Core.GetNearestPlayer()
    if not target or not target.Character then return end
    
    local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    
    TargetStrafe.angle = TargetStrafe.angle + TargetStrafe.speed * 0.05
    
    -- Calculate orbit position
    local radius = TargetStrafe.radius
    local x = math.cos(TargetStrafe.angle) * radius
    local z = math.sin(TargetStrafe.angle) * radius
    
    local newPos = targetRoot.Position + Vector3.new(x, 0, z)
    root.CFrame = CFrame.new(newPos, targetRoot.Position)
end

Core.RegisterExploit(24, "TargetStrafe", toggle, {
    radius = { type = "slider", min = 2, max = 15, default = 5 },
    speed = { type = "slider", min = 1, max = 20, default = 10 }
})

Core.AddHook("Heartbeat", strafe)

print("[ASPECTV4] TargetStrafe loaded (disabled)")
return TargetStrafe
