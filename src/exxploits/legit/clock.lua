-- ASPECTV4 | CLOCK
-- ID: 62 | Type: Legit
-- Shows local time

local Core = _G.Aspect

local Clock = {
    enabled = false,
    format = "24h",
    drawing = nil
}

local function toggle(state)
    Clock.enabled = state
    if state then
        Clock.drawing = Drawing.new("Text")
        Clock.drawing.Size = 16
        Clock.drawing.Color = Color3.new(1, 1, 1)
        Clock.drawing.Position = Vector2.new(10, 10)
        Clock.drawing.Center = false
    else
        if Clock.drawing then
            Clock.drawing:Destroy()
            Clock.drawing = nil
        end
    end
end

local function updateClock()
    if not Clock.enabled or not Clock.drawing then return end
    
    local time = os.date("*t")
    local timeStr = ""
    
    if Clock.format == "24h" then
        timeStr = string.format("%02d:%02d:%02d", time.hour, time.min, time.sec)
    else
        local hour = time.hour % 12
        if hour == 0 then hour = 12 end
        timeStr = string.format("%02d:%02d:%02d %s", hour, time.min, time.sec, time.hour >= 12 and "PM" or "AM")
    end
    
    Clock.drawing.Text = "🕐 " .. timeStr
    Clock.drawing.Visible = true
end

Core.RegisterExploit(62, "Clock", toggle, {
    format = { type = "dropdown", options = {"24h", "12h"}, default = "24h" }
})

Core.AddHook("RenderStepped", updateClock)

print("[ASPECTV4] Clock loaded (disabled)")
return Clock
