-- ASPECTV4 | SPEED
-- ID: 20 | Type: Blatant
-- Velocity boost

local Core = _G.Aspect

local Speed = {
    enabled = false,
    amount = 50,
    mode = "Velocity"
}

local function toggle(state)
    Speed.enabled = state
end

local function speed()
    if not Speed.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    local humanoid = lp.Character:FindFirstChild("Humanoid")
    if not root or not humanoid then return end
    
    if Speed.mode == "Velocity" then
        local vel = root.Velocity
        local speed = vel.Magnitude
        if speed > 0 then
            root.Velocity = vel.Unit * Speed.amount
        end
    elseif Speed.mode == "Impulse" then
        local vel = root.Velocity
        root.Velocity = vel + vel.Unit * Speed.amount
    elseif Speed.mode == "CFrame" then
        local forward = root.CFrame.LookVector
        root.CFrame = root.CFrame + forward * Speed.amount / 20
    elseif Speed.mode == "TP" then
        -- Teleport every frame
        local forward = root.CFrame.LookVector
        root.CFrame = root.CFrame + forward * Speed.amount / 50
    elseif Speed.mode == "Pulse" then
        -- Pulse every 0.5 seconds
        if tick() % 0.5 < 0.1 then
            local forward = root.CFrame.LookVector
            root.Velocity = forward * Speed.amount
        end
    elseif Speed.mode == "WalkSpeed" then
        humanoid.WalkSpeed = Speed.amount
    end
end

Core.RegisterExploit(20, "Speed", toggle, {
    amount = { type = "slider", min = 10, max = 200, default = 50 },
    mode = { type = "dropdown", options = {"Velocity", "Impulse", "CFrame", "TP", "Pulse", "WalkSpeed"}, default = "Velocity" }
})

Core.AddHook("Heartbeat", speed)

print("[ASPECTV4] Speed loaded (disabled)")
return Speed
