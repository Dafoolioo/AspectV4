-- ASPECTV4 | LONG JUMP
-- ID: 17 | Type: Blatant
-- Extended horizontal jump

local Core = _G.Aspect

local LongJump = {
    enabled = false,
    distance = 30,
    mode = "Velocity",
    jumpCooldown = 0
}

local function toggle(state)
    LongJump.enabled = state
    LongJump.jumpCooldown = 0
end

local function longJump()
    if not LongJump.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = lp.Character:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    
    LongJump.jumpCooldown = LongJump.jumpCooldown + game:GetService("RunService").Heartbeat:Wait()
    
    local isJumping = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space)
    if isJumping and LongJump.jumpCooldown > 0.3 then
        LongJump.jumpCooldown = 0
        
        local forward = root.CFrame.LookVector
        if LongJump.mode == "Velocity" then
            root.Velocity = Vector3.new(forward.X * LongJump.distance, 50, forward.Z * LongJump.distance)
        elseif LongJump.mode == "Impulse" then
            root.Velocity = root.Velocity + Vector3.new(forward.X * LongJump.distance, 50, forward.Z * LongJump.distance)
        elseif LongJump.mode == "CFrame" then
            root.CFrame = root.CFrame + Vector3.new(forward.X * LongJump.distance / 10, 3, forward.Z * LongJump.distance / 10)
        end
    end
end

Core.RegisterExploit(17, "LongJump", toggle, {
    distance = { type = "slider", min = 10, max = 100, default = 30 },
    mode = { type = "dropdown", options = {"Velocity", "Impulse", "CFrame"}, default = "Velocity" }
})

Core.AddHook("Heartbeat", longJump)

print("[ASPECTV4] LongJump loaded (disabled)")
return LongJump
