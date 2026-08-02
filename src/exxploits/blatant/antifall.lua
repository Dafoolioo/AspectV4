-- ASPECTV4 | ANTI FALL
-- ID: 9 | Type: Blatant
-- Prevents falling into the void

local Core = _G.Aspect

local AntiFall = {
    enabled = false,
    mode = "Part"  -- Part or Classic
}

local function toggle(state)
    AntiFall.enabled = state
end

local function preventFall()
    if not AntiFall.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Check if falling into void
    if root.Position.Y < -100 then
        -- Teleport back to safe position
        root.Position = Vector3.new(root.Position.X, 100, root.Position.Z)
        
        if AntiFall.mode == "Part" then
            -- Create platform
            local part = Instance.new("Part")
            part.Size = Vector3.new(10, 1, 10)
            part.Position = root.Position - Vector3.new(0, 3, 0)
            part.Anchored = true
            part.Parent = workspace
            part.Transparency = 0.5
            
            task.wait(0.5)
            part:Destroy()
        end
    end
end

Core.RegisterExploit(9, "AntiFall", toggle, {
    mode = { type = "dropdown", options = {"Part", "Classic"}, default = "Part" }
})

Core.AddHook("Heartbeat", preventFall)

print("[ASPECTV4] AntiFall loaded (disabled)")
return AntiFall
