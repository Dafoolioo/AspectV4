-- ASPECTV4 | ANTI AFK
-- ID: 45 | Type: World
-- Prevents idle kick

local Core = _G.Aspect

local AntiAFK = {
    enabled = false,
    mode = "Movement"
}

local function toggle(state)
    AntiAFK.enabled = state
end

local function antiAFK()
    if not AntiAFK.enabled then return end
    
    if AntiAFK.mode == "Movement" then
        -- Simulate movement
        local lp = game.Players.LocalPlayer
        if lp and lp.Character then
            local root = lp.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame + Vector3.new(0, 0.001, 0)
                task.wait(0.01)
                root.CFrame = root.CFrame - Vector3.new(0, 0.001, 0)
            end
        end
    end
end

Core.RegisterExploit(45, "AntiAFK", toggle, {
    mode = { type = "dropdown", options = {"Movement"}, default = "Movement" }
})

Core.AddHook("Heartbeat", antiAFK)

print("[ASPECTV4] AntiAFK loaded (disabled)")
return AntiAFK
