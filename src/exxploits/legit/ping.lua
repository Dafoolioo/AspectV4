-- ASPECTV4 | PING
-- ID: 70 | Type: Legit
-- Shows ping

local Core = _G.Aspect

local Ping = {
    enabled = false,
    position = "BottomLeft",
    drawing = nil
}

local function toggle(state)
    Ping.enabled = state
    if state then
        Ping.drawing = Drawing.new("Text")
        Ping.drawing.Size = 14
        Ping.drawing.Color = Color3.new(0, 1, 0)
        Ping.drawing.Position = Vector2.new(10, workspace.CurrentCamera.ViewportSize.Y - 30)
        Ping.drawing.Center = false
    else
        if Ping.drawing then
            Ping.drawing:Destroy()
            Ping.drawing = nil
        end
    end
end

local function updatePing()
    if not Ping.enabled or not Ping.drawing then return end
    
    local ping = game:GetService("Stats"):FindFirstChild("Network"):FindFirstChild("Ping")
    if ping then
        local pingVal = ping.Value
        local color = Color3.new(0, 1, 0)
        if pingVal > 100 then color = Color3.new(1, 1, 0) end
        if pingVal > 200 then color = Color3.new(1, 0, 0) end
        
        Ping.drawing.Color = color
        Ping.drawing.Text = "Ping: " .. math.floor(pingVal) .. "ms"
        Ping.drawing.Visible = true
    end
end

Core.RegisterExploit(70, "Ping", toggle, {
    position = {
