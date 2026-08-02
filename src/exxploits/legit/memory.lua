-- ASPECTV4 | MEMORY
-- ID: 69 | Type: Legit
-- Shows memory usage

local Core = _G.Aspect

local MemoryDisplay = {
    enabled = false,
    position = "BottomRight",
    drawing = nil
}

local function toggle(state)
    MemoryDisplay.enabled = state
    if state then
        MemoryDisplay.drawing = Drawing.new("Text")
        MemoryDisplay.drawing.Size = 14
        MemoryDisplay.drawing.Color = Color3.new(0, 1, 1)
        MemoryDisplay.drawing.Position = Vector2.new(workspace.CurrentCamera.ViewportSize.X - 150, workspace.CurrentCamera.ViewportSize.Y - 30)
        MemoryDisplay.drawing.Center = false
    else
        if MemoryDisplay.drawing then
            MemoryDisplay.drawing:Destroy()
            MemoryDisplay.drawing = nil
        end
    end
end

local function updateMemory()
    if not MemoryDisplay.enabled or not MemoryDisplay.drawing then return end
    
    local mem = collectgarbage("count") * 1024
    local memMB = mem / 1024 / 1024
    
    MemoryDisplay.drawing.Text = string.format("Mem: %.1f MB", memMB)
    MemoryDisplay.drawing.Visible = true
end

Core.RegisterExploit(69, "Memory", toggle, {
    position = { type = "dropdown", options = {"TopLeft", "TopRight", "BottomLeft", "BottomRight"}, default = "BottomRight" }
})

Core.AddHook("RenderStepped", updateMemory)

print("[ASPECTV4] Memory loaded (disabled)")
return MemoryDisplay
