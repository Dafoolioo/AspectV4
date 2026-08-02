-- ASPECTV4 | SPEEDMETER
-- ID: 72 | Type: Legit
-- Shows speed in studs/sec

local Core = _G.Aspect

local Speedmeter = {
    enabled = false,
    position = "TopCenter",
    drawing = nil,
    lastPos = nil,
    lastTime = nil
}

local function toggle(state)
    Speedmeter.enabled = state
    if state then
        Speedmeter.drawing = Drawing.new("Text")
        Speedmeter.drawing.Size = 16
        Speedmeter.drawing.Color = Color3.new(1, 1, 1)
        Speedmeter.drawing.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X / 2, 30)
        Speedmeter.drawing.Center = true
        Speedmeter.lastPos = nil
        Speedmeter.lastTime = nil
    else
        if Speedmeter.drawing then
            Speedmeter.drawing:Destroy()
            Speedmeter.drawing = nil
        end
    end
end

local function updateSpeed()
    if not Speedmeter.enabled or not Speedmeter.drawing then return end
    
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local root = lp.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local currentPos = root.Position
            local currentTime = tick()
            
            if Speedmeter.lastPos and Speedmeter.lastTime then
                local dist = (currentPos - Speedmeter.lastPos).Magnitude
                local dt = currentTime - Speedmeter.lastTime
                local speed = dist / dt
                
                Speedmeter.drawing.Text = string.format("Speed: %.1f studs/s", speed)
                Speedmeter.drawing.Visible = true
            end
            
            Speedmeter.lastPos = currentPos
            Speedmeter.lastTime = currentTime
        end
    end
end

Core.RegisterExploit(72, "Speedmeter", toggle, {
    position = { type = "dropdown", options = {"TopLeft", "TopCenter", "TopRight"}, default = "TopCenter" }
})

Core.AddHook("Heartbeat", updateSpeed)

print("[ASPECTV4] Speedmeter loaded (disabled)")
return Speedmeter
