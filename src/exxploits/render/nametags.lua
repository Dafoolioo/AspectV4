-- ASPECTV4 | NAMETAGS
-- ID: 30 | Type: Render
-- Custom nametags through walls

local Core = _G.Aspect

local NameTags = {
    enabled = false,
    health = true,
    distance = true,
    drawings = {}
}

local function toggle(state)
    NameTags.enabled = state
    if not state then
        for _, drawing in ipairs(NameTags.drawings) do
            drawing:Destroy()
        end
        NameTags.drawings = {}
    end
end

local function drawNametags()
    if not NameTags.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    for _, player in ipairs(Core.GetPlayers()) do
        if player.Character then
            local head = player.Character:FindFirstChild("Head")
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if head and humanoid then
                local screenPos, _ = Core.WorldToScreen(head.Position + Vector3.new(0, 3, 0))
                if screenPos then
                    local text = Drawing.new("Text")
                    local nameStr = player.Name
                    
                    if NameTags.health then
                        nameStr = nameStr .. " | " .. math.floor(humanoid.Health) .. "HP"
                    end
                    
                    if NameTags.distance then
                        local dist = (root.Position - head.Position).Magnitude
                        nameStr = nameStr .. " | " .. math.floor(dist) .. "m"
                    end
                    
                    text.Text = nameStr
                    text.Position = screenPos
                    text.Size = 16
                    text.Color = player.TeamColor or Color3.new(1, 1, 1)
                    text.Center = true
                    text.Visible = true
                    table.insert(NameTags.drawings, text)
                end
            end
        end
    end
end

Core.RegisterExploit(30, "NameTags", toggle, {
    health = { type = "toggle", default = true },
    distance = { type = "toggle", default = true }
})

Core.AddHook("RenderStepped", drawNametags)

print("[ASPECTV4] NameTags loaded (disabled)")
return NameTags
