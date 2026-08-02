-- ASPECTV4 | INFINITE JUMP
-- ID: 14 | Type: Blatant
-- Unlimited jumping

local Core = _G.Aspect

local InfiniteJump = {
    enabled = false,
    mode = "Velocity"
}

local function toggle(state)
    InfiniteJump.enabled = state
end

local function infiniteJump()
    if not InfiniteJump.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = lp.Character:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    
    local isJumping = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space)
    
    if isJumping then
        if InfiniteJump.mode == "Velocity" then
            root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z)
        elseif InfiniteJump.mode == "Jump" then
            humanoid.Jump = true
        end
    end
end

Core.RegisterExploit(14, "InfiniteJump", toggle, {
    mode = { type = "dropdown", options = {"Velocity", "Jump"}, default = "Velocity" }
})

Core.AddHook("Heartbeat", infiniteJump)

print("[ASPECTV4] InfiniteJump loaded (disabled)")
return InfiniteJump
