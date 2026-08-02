-- ASPECTV4 | TRACERS
-- ID: 31 | Type: Render
-- Lines from screen to enemies

local Core = _G.Aspect

local Tracers = {
    enabled = false,
    color = Color3.new(1, 0, 0),
    drawings = {}
}

local function toggle(state)
    Tracers.enabled = state
    if not state then
        for _, drawing in ipairs(Tracers.drawings) do
            drawing:Destroy()
        end
        Tracers.drawings = {}
    end
end

local function drawTracers()
    if not Tracers.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local center = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, workspace.CurrentCamera.ViewportSize.Y)
    
    for _, player in ipairs(Core.GetPlayers()) do
        if player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                local screenPos, onScreen = Core.WorldToScreen(root.Position)
                if onScreen then
                    local line = Drawing.new("Line")
                    line.From = center
                    line.To = screenPos
                    line.Color = Tracers.color
                    line.Thickness = 1
                    line.Visible = true
                    table.insert(Tracers.drawings, line)
                end
            end
        end
    end
end

Core.RegisterExploit(31, "Tracers", toggle, {
    color = { type = "color", default = Color3.new(1, 0, 0) }
})

Core.AddHook("RenderStepped", drawTracers)

print("[ASPECTV4] Tracers loaded (disabled)")
return Tracers
