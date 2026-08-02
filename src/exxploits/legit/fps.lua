-- ASPECTV4 | FPS
-- ID: 67 | Type: Legit
-- Shows FPS counter

local Core = _G.Aspect

local FPS = {
    enabled = false,
    position = "TopRight",
    drawing = nil,
    frames = 0,
    lastTime = 0
}

local function toggle(state)
    FPS.enabled = state
    if state then
        FPS.drawing = Drawing.new("Text")
        FPS.drawing.Size = 14
        FPS.drawing.Color = Color3.new(0, 1, 0)
        FPS.drawing.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X - 100, 10)
        FPS.drawing.Center = false
    else
        if FPS.drawing then
            FPS.drawing:Destroy()
            FPS.drawing = nil
        end
    end
end

local function updateFPS()
    if not FPS.enabled or not FPS.drawing then return end
    
    FPS.frames = FPS.frames + 1
    local currentTime = tick()
    
    if currentTime - FPS.lastTime >= 1 then
        FPS.drawing.Text = "FPS: " .. FPS.frames
        FPS.frames = 0
        FPS.lastTime = currentTime
    end
    
    FPS.drawing.Visible = true
end

Core.RegisterExploit(67, "FPS", toggle, {
    position = { type = "dropdown", options = {"TopLeft", "TopRight", "BottomLeft", "BottomRight"}, default = "TopRight" }
})

Core.AddHook("RenderStepped", updateFPS)

print("[ASPECTV4] FPS loaded (disabled)")
return FPS
