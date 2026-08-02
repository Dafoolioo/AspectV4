-- ASPECTV4 | GRAVITY
-- ID: 48 | Type: World
-- Adjusts gravity

local Core = _G.Aspect

local Gravity = {
    enabled = false,
    value = -50,
    mode = "Workspace"
}

local function toggle(state)
    Gravity.enabled = state
    if state then
        if Gravity.mode == "Workspace" then
            workspace.Gravity = Gravity.value
        end
    else
        workspace.Gravity = 196.2
    end
end

local function gravity()
    if not Gravity.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if Gravity.mode == "Velocity" then
        root.Velocity = Vector3.new(root.Velocity.X, Gravity.value / 10, root.Velocity.Z)
    elseif Gravity.mode == "Impulse" then
        root.Velocity = root.Velocity + Vector3.new(0, Gravity.value / 100, 0)
    end
end

Core.RegisterExploit(48, "Gravity", toggle, {
    value = { type = "slider", min = -200, max = 200, default = -50 },
    mode = { type = "dropdown", options = {"Workspace", "Velocity", "Impulse"}, default = "Workspace" }
})

Core.AddHook("Heartbeat", gravity)

print("[ASPECTV4] Gravity loaded (disabled)")
return Gravity
