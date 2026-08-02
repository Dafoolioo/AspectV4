-- ASPECTV4 | KEYSTROKES
-- ID: 68 | Type: Legit
-- Shows WASD keys

local Core = _G.Aspect

local Keystrokes = {
    enabled = false,
    style = "Keyboard",
    color = Color3.new(1, 1, 1),
    drawings = {}
}

local function toggle(state)
    Keystrokes.enabled = state
    if not state then
        for _, drawing in ipairs(Keystrokes.drawings) do
            drawing:Destroy()
        end
        Keystrokes.drawings = {}
    end
end

local function drawKeystrokes()
    if not Keystrokes.enabled then return end
    
    local keys = {
        W = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W),
        A = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A),
        S = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S),
        D = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D)
    }
    
    local startPos = Vector2.new(10, workspace.CurrentCamera.ViewportSize.Y - 100)
    local spacing = 30
    
    local i = 0
    for key, pressed in pairs(keys) do
        local text = Drawing.new("Text")
        text.Text = key
        text.Size = 20
        text.Color = pressed and Color3.new(0, 1, 0) or Keystrokes.color
        text.Position = startPos + Vector2.new(i * spacing, 0)
        text.Center = true
        text.Visible = true
        table.insert(Keystrokes.drawings, text)
        i = i + 1
    end
end

Core.RegisterExploit(68, "Keystrokes", toggle, {
    style = { type = "dropdown", options = {"Keyboard", "Arrow"}, default = "Keyboard" },
    color = { type = "color", default = Color3.new(1, 1, 1) }
})

Core.AddHook("RenderStepped", drawKeystrokes)

print("[ASPECTV4] Keystrokes loaded (disabled)")
return Keystrokes
