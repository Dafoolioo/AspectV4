-- ASPECTV4 | SPIN BOT
-- ID: 22 | Type: Blatant
-- Auto-rotates character

local Core = _G.Aspect

local SpinBot = {
    enabled = false,
    speed = 5,
    mode = "CFrame",
    angle = 0
}

local function toggle(state)
    SpinBot.enabled = state
    SpinBot.angle = 0
end

local function spin()
    if not SpinBot.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    SpinBot.angle = SpinBot.angle + SpinBot.speed * 0.1
    
    if SpinBot.mode == "CFrame" then
        root.CFrame = CFrame.new(root.Position) * CFrame.Angles(0, SpinBot.angle, 0)
    elseif SpinBot.mode == "RotVelocity" then
        root.RotVelocity = Vector3.new(0, SpinBot.speed * 5, 0)
    elseif SpinBot.mode == "BodyMover" then
        -- Use BodyAngularVelocity
        local bav = Instance.new("BodyAngularVelocity")
        bav.AngularVelocity = Vector3.new(0, SpinBot.speed * 5, 0)
        bav.MaxTorque = Vector3.new(0, 10000, 0)
        bav.Parent = root
        task.wait(0.1)
        bav:Destroy()
    end
end

Core.RegisterExploit(22, "SpinBot", toggle, {
    speed = { type = "slider", min = 1, max = 20, default = 5 },
    mode = { type = "dropdown", options = {"CFrame", "RotVelocity", "BodyMover"}, default = "CFrame" }
})

Core.AddHook("Heartbeat", spin)

print("[ASPECTV4] SpinBot loaded (disabled)")
return SpinBot
