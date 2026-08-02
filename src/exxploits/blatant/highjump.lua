-- ASPECTV4 | HIGH JUMP
-- ID: 12 | Type: Blatant
-- Super jump with adjustable height

local Core = _G.Aspect

local HighJump = {
    enabled = false,
    height = 50,
    mode = "Velocity",
    jumpCooldown = 0
}

local function toggle(state)
    HighJump.enabled = state
    HighJump.jumpCooldown = 0
end

local function highJump()
    if not HighJump.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = lp.Character:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    
    HighJump.jumpCooldown = HighJump.jumpCooldown + game:GetService("RunService").Heartbeat:Wait()
    
    local isJumping = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space)
    if isJumping and HighJump.jumpCooldown > 0.5 then
        HighJump.jumpCooldown = 0
        
        if HighJump.mode == "Velocity" then
            root.Velocity = Vector3.new(root.Velocity.X, HighJump.height, root.Velocity.Z)
        elseif HighJump.mode == "Impulse" then
            root.Velocity = root.Velocity + Vector3.new(0, HighJump.height, 0)
        elseif HighJump.mode == "CFrame" then
            root.CFrame = root.CFrame + Vector3.new(0, HighJump.height / 10, 0)
        end
    end
end

Core.RegisterExploit(12, "HighJump", toggle, {
    height = { type = "slider", min = 10, max = 200, default = 50 },
    mode = { type = "dropdown", options = {"Velocity", "Impulse", "CFrame"}, default = "Velocity" }
})

Core.AddHook("Heartbeat", highJump)

print("[ASPECTV4] HighJump loaded (disabled)")
return HighJump
