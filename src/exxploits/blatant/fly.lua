-- ASPECTV4 | FLY
-- ID: 11 | Type: Blatant
-- Noclip flight with WASD controls

local Core = _G.Aspect

local Fly = {
    enabled = false,
    speed = 50,
    mode = "WASD",
    velocity = Vector3.new(0, 0, 0)
}

local function toggle(state)
    Fly.enabled = state
    
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local humanoid = lp.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = state
            if not state then
                Fly.velocity = Vector3.new(0, 0, 0)
            end
        end
    end
end

local function fly()
    if not Fly.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = lp.Character:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    
    -- Get user input
    local speed = Fly.speed
    local keys = {
        W = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W),
        A = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A),
        S = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S),
        D = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D),
        Space = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space),
        Control = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl)
    }
    
    local moveVector = Vector3.new(0, 0, 0)
    if keys.W then moveVector = moveVector + root.CFrame.LookVector * speed end
    if keys.S then moveVector = moveVector - root.CFrame.LookVector * speed end
    if keys.A then moveVector = moveVector - root.CFrame.RightVector * speed end
    if keys.D then moveVector = moveVector + root.CFrame.RightVector * speed end
    if keys.Space then moveVector = moveVector + Vector3.new(0, speed, 0) end
    if keys.Control then moveVector = moveVector - Vector3.new(0, speed, 0) end
    
    -- Apply movement
    if Fly.mode == "WASD" then
        root.Velocity = moveVector
        humanoid.AutoRotate = true
    elseif Fly.mode == "CFrame" then
        root.CFrame = root.CFrame + moveVector
    end
end

Core.RegisterExploit(11, "Fly", toggle, {
    speed = { type = "slider", min = 10, max = 200, default = 50 },
    mode = { type = "dropdown", options = {"WASD", "CFrame"}, default = "WASD" }
})

Core.AddHook("Heartbeat", fly)

print("[ASPECTV4] Fly loaded (disabled)")
return Fly
