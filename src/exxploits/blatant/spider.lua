-- ASPECTV4 | SPIDER
-- ID: 21 | Type: Blatant
-- Climbs walls

local Core = _G.Aspect

local Spider = {
    enabled = false,
    speed = 20,
    mode = "Velocity"
}

local function toggle(state)
    Spider.enabled = state
end

local function spider()
    if not Spider.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Check if near wall
    local ray = Ray.new(root.Position, root.CFrame.LookVector * 5)
    local hit = workspace:FindPartOnRay(ray)
    
    if hit then
        local wallNormal = hit.Normal
        if Spider.mode == "Velocity" then
            root.Velocity = Vector3.new(
                wallNormal.X * Spider.speed,
                Spider.speed / 2,
                wallNormal.Z * Spider.speed
            )
        elseif Spider.mode == "Impulse" then
            root.Velocity = root.Velocity + Vector3.new(
                wallNormal.X * Spider.speed,
                0,
                wallNormal.Z * Spider.speed
            )
        elseif Spider.mode == "CFrame" then
            root.CFrame = root.CFrame + Vector3.new(
                wallNormal.X * Spider.speed / 20,
                Spider.speed / 40,
                wallNormal.Z * Spider.speed / 20
            )
        elseif Spider.mode == "Part" then
            -- Create platforms
            local part = Instance.new("Part")
            part.Size = Vector3.new(1, 0.5, 1)
            part.Position = hit.Position + hit.Normal * 0.5
            part.Anchored = true
            part.Parent = workspace
            part.Transparency = 0.5
            task.wait(0.1)
            part:Destroy()
        end
    end
end

Core.RegisterExploit(21, "Spider", toggle, {
    speed = { type = "slider", min = 5, max = 50, default = 20 },
    mode = { type = "dropdown", options = {"Velocity", "Impulse", "CFrame", "Part"}, default = "Velocity" }
})

Core.AddHook("Heartbeat", spider)

print("[ASPECTV4] Spider loaded (disabled)")
return Spider
