-- ASPECTV4 | ARROWS
-- ID: 26 | Type: Render
-- Shows off-screen enemy indicators

local Core = _G.Aspect

local Arrows = {
    enabled = false,
    color = Color3.new(1, 0, 0),
    drawing = nil
}

local function toggle(state)
    Arrows.enabled = state
    if state then
        Arrows.drawing = Drawing.new("Triangle")
        Arrows.drawing.Color = Arrows.color
        Arrows.drawing.Thickness = 2
        Arrows.drawing.Filled = true
    else
        if Arrows.drawing then
            Arrows.drawing:Destroy()
            Arrows.drawing = nil
        end
    end
end

local function drawArrows()
    if not Arrows.enabled or not Arrows.drawing then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    for _, player in ipairs(Core.GetPlayers()) do
        if player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local screenPos, onScreen = Core.WorldToScreen(root.Position)
                if not onScreen then
                    -- Draw arrow pointing to player
                    local center = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y / 2)
                    local dir = (screenPos - center).Unit * 50
                    
                    Arrows.drawing.PointA = center + dir
                    Arrows.drawing.PointB = center + dir + Vector2.new(10, 10)
                    Arrows.drawing.PointC = center + dir + Vector2.new(-10, 10)
                    Arrows.drawing.Visible = true
                end
            end
        end
    end
end

Core.RegisterExploit(26, "Arrows", toggle, {
    color = { type = "color", default = Color3.new(1, 0, 0) }
})

Core.AddHook("RenderStepped", drawArrows)

print("[ASPECTV4] Arrows loaded (disabled)")
return Arrows
