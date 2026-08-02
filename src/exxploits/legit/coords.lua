-- ASPECTV4 | COORDS
-- ID: 63 | Type: Legit
-- Shows XYZ coordinates

local Core = _G.Aspect

local Coords = {
    enabled = false,
    position = "TopLeft",
    drawing = nil
}

local function toggle(state)
    Coords.enabled = state
    if state then
        Coords.drawing = Drawing.new("Text")
        Coords.drawing.Size = 14
        Coords.drawing.Color = Color3.new(1, 1, 1)
        Coords.drawing.Position = Vector2.new(10, 40)
        Coords.drawing.Center = false
    else
        if Coords.drawing then
            Coords.drawing:Destroy()
            Coords.drawing = nil
        end
    end
end

local function updateCoords()
    if not Coords.enabled or not Coords.drawing then return end
    
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local root = lp.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local pos = root.Position
            Coords.drawing.Text = string.format("XYZ: %.1f, %.1f, %.1f", pos.X, pos.Y, pos.Z)
            Coords.drawing.Visible = true
        end
    end
end

Core.RegisterExploit(63, "Coords", toggle, {
    position = { type = "dropdown", options = {"TopLeft", "TopRight", "BottomLeft", "BottomRight"}, default = "TopLeft" }
})

Core.AddHook("RenderStepped", updateCoords)

print("[ASPECTV4] Coords loaded (disabled)")
return Coords
