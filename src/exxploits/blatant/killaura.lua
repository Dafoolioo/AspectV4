-- ASPECTV4 | KILLAURA
-- ID: 16 | Type: Blatant
-- Auto-attacks nearby enemies

local Core = _G.Aspect

local Killaura = {
    enabled = false,
    range = 20,
    speed = 10,
    target = nil,
    attackTimer = 0
}

local function toggle(state)
    Killaura.enabled = state
    Killaura.attackTimer = 0
end

local function killaura()
    if not Killaura.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    Killaura.attackTimer = Killaura.attackTimer + game:GetService("RunService").Heartbeat:Wait()
    
    local attackInterval = 1 / Killaura.speed
    if Killaura.attackTimer < attackInterval then return end
    Killaura.attackTimer = 0
    
    -- Find nearest target
    local target = nil
    local minDist = Killaura.range
    
    for _, player in ipairs(Core.GetPlayers()) do
        if player.Character then
            local pr = player.Character:FindFirstChild("HumanoidRootPart")
            if pr then
                local dist = (root.Position - pr.Position).Magnitude
                if dist < minDist then
                    minDist = dist
                    target = player
                end
            end
        end
    end
    
    if target and target.Character then
        -- Attack
        local mouse = lp:GetMouse()
        mouse.Button1Down:Fire()
        task.wait(0.05)
        mouse.Button1Up:Fire()
        
        -- Face target
        local humanoid = lp.Character:FindFirstChild("Humanoid")
        if humanoid then
            local lookAt = (target.Character.HumanoidRootPart.Position - root.Position)
            humanoid.AutoRotate = true
            root.CFrame = CFrame.lookAt(root.Position, target.Character.HumanoidRootPart.Position)
        end
    end
end

Core.RegisterExploit(16, "Killaura", toggle, {
    range = { type = "slider", min = 5, max = 50, default = 20 },
    speed = { type = "slider", min = 1, max = 20, default = 10 }
})

Core.AddHook("Heartbeat", killaura)

print("[ASPECTV4] Killaura loaded (disabled)")
return Killaura
