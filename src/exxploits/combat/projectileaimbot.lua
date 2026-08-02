-- ASPECTV4 | PROJECTILE AIMBOT
-- ID: 5 | Type: Combat
-- Predicts arrow/fireball trajectories using quartic equationslocal Core = _G.Aspect

local ProjectileAimbot = {
    enabled = false,
    velocity = 100,
    gravity = workspace.Gravity,
    target = nil
}

local function toggle(state)
    ProjectileAimbot.enabled = state
end

-- Calculate trajectory
local function calculateTrajectory(origin, target, velocity, gravity)
    local dx = target.X - origin.X
    local dy = target.Y - origin.Y
    local dz = target.Z - origin.Z
    
    local distance = math.sqrt(dx^2 + dz^2)
    local angle = math.atan(dy / distance)
    
    -- Quartic equation for projectile motion
    local g = gravity or workspace.Gravity
    local v = velocity or 100
    
    local a = -(g^2) / (4 * v^4)
    local b = (g * dy) / (v^2)
    local c = -(dx^2 + dz^2)
    
    -- Solve using quadratic formula
    local discriminant = b^2 - 4 * a * c
    if discriminant < 0 then return nil end
    
    local t = (-b + math.sqrt(discriminant)) / (2 * a)
    local x = origin.X + dx * t
    local y = origin.Y + dy * t + 0.5 * g * t^2
    local z = origin.Z + dz * t
    
    return Vector3.new(x, y, z)
end

-- Aim function
local function aim()
    if not ProjectileAimbot.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local target = Core.GetNearestPlayer()
    if target and target.Character then
        local head = target.Character:FindFirstChild("Head")
        if head then
            local origin = lp.Character:FindFirstChild("Head")
            if origin then
                local predicted = calculateTrajectory(
                    origin.Position,
                    head.Position,
                    ProjectileAimbot.velocity,
                    workspace.Gravity
                )
                
                if predicted then
                    -- Aim at predicted position
                    local screenPos, _ = Core.WorldToScreen(predicted)
                    if screenPos then
                        local mouse = lp:GetMouse()
                        mouse.Move(screenPos.X, screenPos.Y)
                    end
                end
            end
        end
    end
end

Core.RegisterExploit(5, "ProjectileAimbot", toggle, {
    velocity = { type = "slider", min = 50, max = 200, default = 100 }
})

Core.AddHook("RenderStepped", aim)

print("[ASPECTV4] ProjectileAimbot loaded (disabled)")
return ProjectileAimbot
