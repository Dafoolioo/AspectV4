-- ASPECTV4 | WAYPOINTS
-- ID: 32 | Type: Render
-- Visual markers at custom positions

local Core = _G.Aspect

local Waypoints = {
    enabled = false,
    color = Color3.new(0, 0, 1),
    points = {},
    drawings = {}
}

local function toggle(state)
    Waypoints.enabled = state
    if not state then
        for _, drawing in ipairs(Waypoints.drawings) do
            drawing:Destroy()
        end
        Waypoints.drawings = {}
    end
end

local function drawWaypoints()
    if not Waypoints.enabled then return end
    
    for _, point in ipairs(Waypoints.points) do
        local screenPos, onScreen = Core.WorldToScreen(point)
        if onScreen then
            local marker = Drawing.new("Circle")
            marker.Radius = 8
            marker.Position = screenPos
            marker.Color = Waypoints.color
            marker.Filled = true
            marker.Visible = true
            table.insert(Waypoints.drawings, marker)
            
            -- Distance text
            local lp = game.Players.LocalPlayer
            if lp.Character then
                local root = lp.Character:FindFirstChild("HumanoidRootPart")
                if root then
                    local dist = (root.Position - point).Magnitude
                    local text = Drawing.new("Text")
                    text.Text = math.floor(dist) .. "m"
                    text.Position = screenPos + Vector2.new(0, -20)
                    text.Size = 12
                    text.Color = Color3.new(1, 1, 1)
                    text.Center = true
                    text.Visible = true
                    table.insert(Waypoints.drawings, text)
                end
            end
        end
    end
end

Core.RegisterExploit(32, "Waypoints", toggle, {
    color = { type = "color", default = Color3.new(0, 0, 1) }
})

Core.AddHook("RenderStepped", drawWaypoints)

print("[ASPECTV4] Waypoints loaded (disabled)")
return Waypoints
