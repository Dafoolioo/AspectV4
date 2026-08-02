-- ASPECTV4 | ESP
-- ID: 28 | Type: Render
-- Box ESP with 2D/3D/Skeleton modes

local Core = _G.Aspect

local ESP = {
    enabled = false,
    box = true,
    skeleton = true,
    health = true,
    name = true,
    drawings = {}
}

local function toggle(state)
    ESP.enabled = state
    if not state then
        for _, drawing in ipairs(ESP.drawings) do
            drawing:Destroy()
        end
        ESP.drawings = {}
    end
end

local function esp()
    if not ESP.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    for _, player in ipairs(Core.GetPlayers()) do
        if player.Character then
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            local head = player.Character:FindFirstChild("Head")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            
            if root and head and humanoid then
                local screenPos, onScreen = Core.WorldToScreen(root.Position)
                local headPos, _ = Core.WorldToScreen(head.Position)
                
                if onScreen then
                    local height = headPos.Y - screenPos.Y
                    local width = height / 2
                    
                    if ESP.box then
                        local box = Drawing.new("Square")
                        box.Size = Vector2.new(width, height)
                        box.Position = Vector2.new(screenPos.X - width/2, screenPos.Y)
                        box.Color = Color3.new(1, 0, 0)
                        box.Thickness = 2
                        box.Filled = false
                        box.Visible = true
                        table.insert(ESP.drawings, box)
                    end
                    
                    if ESP.name then
                        local text = Drawing.new("Text")
                        text.Text = player.Name
                        text.Position = Vector2.new(screenPos.X, screenPos.Y - height - 10)
                        text.Size = 14
                        text.Color = Color3.new(1, 1, 1)
                        text.Center = true
                        text.Visible = true
                        table.insert(ESP.drawings, text)
                    end
                    
                    if ESP.health and humanoid then
                        local healthBar = Drawing.new("Line")
                        healthBar.From = Vector2.new(screenPos.X - width/2 - 10, screenPos.Y)
                        healthBar.To = Vector2.new(screenPos.X - width/2 - 10, screenPos.Y + height * (humanoid.Health / humanoid.MaxHealth))
                        healthBar.Color = Color3.new(0, 1, 0)
                        healthBar.Thickness = 3
                        healthBar.Visible = true
                        table.insert(ESP.drawings, healthBar)
                    end
                    
                    if ESP.skeleton then
                        -- Draw skeleton lines between joints
                        -- Simplified version
                        for _, joint in ipairs(player.Character:GetDescendants()) do
                            if joint:IsA("BasePart") then
                                local pos, _ = Core.WorldToScreen(joint.Position)
                                if pos then
                                    local dot = Drawing.new("Circle")
                                    dot.Radius = 3
                                    dot.Position = pos
                                    dot.Color = Color3.new(0, 0, 1)
                                    dot.Filled = true
                                    dot.Visible = true
                                    table.insert(ESP.drawings, dot)
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

Core.RegisterExploit(28, "ESP", toggle, {
    box = { type = "toggle", default = true },
    skeleton = { type = "toggle", default = true },
    health = { type = "toggle", default = true },
    name = { type = "toggle", default = true }
})

Core.AddHook("RenderStepped", esp)

print("[ASPECTV4] ESP loaded (disabled)")
return ESP
