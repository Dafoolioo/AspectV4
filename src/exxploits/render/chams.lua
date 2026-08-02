-- ASPECTV4 | CHAMS
-- ID: 27 | Type: Render
-- Highlights players through walls

local Core = _G.Aspect

local Chams = {
    enabled = false,
    color = Color3.new(0, 1, 0),
    mode = "Highlight"
}

local function toggle(state)
    Chams.enabled = state
    -- In real implementation, would use Highlight or BoxHandles
end

local function chams()
    if not Chams.enabled then return end
    
    for _, player in ipairs(Core.GetPlayers()) do
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    if Chams.mode == "Highlight" then
                        part.Color = Chams.color
                        part.Transparency = 0.3
                    elseif Chams.mode == "BoxHandles" then
                        -- Use SelectionBox
                        local box = Instance.new("SelectionBox")
                        box.Adornee = part
                        box.Color3 = Chams.color
                        box.LineThickness = 0.1
                        box.Parent = part
                    end
                end
            end
        end
    end
end

Core.RegisterExploit(27, "Chams", toggle, {
    color = { type = "color", default = Color3.new(0, 1, 0) },
    mode = { type = "dropdown", options = {"Highlight", "BoxHandles"}, default = "Highlight" }
})

Core.AddHook("RenderStepped", chams)

print("[ASPECTV4] Chams loaded (disabled)")
return Chams
