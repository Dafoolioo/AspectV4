-- ASPECTV4 | BREADCRUMBS
-- ID: 59 | Type: Legit
-- Leaves trail behind character

local Core = _G.Aspect

local Breadcrumbs = {
    enabled = false,
    max = 100,
    color = Color3.new(1, 1, 0),
    trail = {}
}

local function toggle(state)
    Breadcrumbs.enabled = state
    if not state then
        for _, part in ipairs(Breadcrumbs.trail) do
            part:Destroy()
        end
        Breadcrumbs.trail = {}
    end
end

local function leaveTrail()
    if not Breadcrumbs.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    -- Leave breadcrumb
    local part = Instance.new("Part")
    part.Size = Vector3.new(0.5, 0.1, 0.5)
    part.Position = root.Position
    part.Color = Breadcrumbs.color
    part.Material = Enum.Material.Neon
    part.Anchored = true
    part.CanCollide = false
    part.Parent = workspace
    
    table.insert(Breadcrumbs.trail, part)
    
    -- Limit trail size
    if #Breadcrumbs.trail > Breadcrumbs.max then
        local oldest = table.remove(Breadcrumbs.trail, 1)
        oldest:Destroy()
    end
end

Core.RegisterExploit(59, "Breadcrumbs", toggle, {
    max = { type = "slider", min = 10, max = 500, default = 100 },
    color = { type = "color", default = Color3.new(1, 1, 0) }
})

Core.AddHook("Heartbeat", leaveTrail)

print("[ASPECTV4] Breadcrumbs loaded (disabled)")
return Breadcrumbs
