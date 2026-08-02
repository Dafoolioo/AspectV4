-- ASPECTV4 | HITBOX EXPANDER
-- ID: 3 | Type: Combat
-- Increases local hitbox size via memory patch at 0x1A4

local Core = _G.Aspect
local Memory = _G.Memory

local HitboxExpander = {
    enabled = false,
    multiplier = 1.5,
    addresses = {
        [0x1A4] = { size = 4, default = 0x3F800000 }  -- Float 1.0
    }
}

local function toggle(state)
    HitboxExpander.enabled = state
    local lp = game.Players.LocalPlayer
    
    if lp and lp.Character then
        for _, part in ipairs(lp.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                if state then
                    -- Expand hitbox
                    part.Size = part.Size * HitboxExpander.multiplier
                else
                    -- Restore default
                    part.Size = part.Size / HitboxExpander.multiplier
                end
            end
        end
    end
end

-- Hook character added to apply effect
local function onCharacterAdded(char)
    if HitboxExpander.enabled then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * HitboxExpander.multiplier
            end
        end
    end
end

Core.RegisterExploit(3, "HitboxExpander", toggle, {
    multiplier = { type = "slider", min = 1.0, max = 3.0, default = 1.5 }
})

-- Character added hook
game.Players.LocalPlayer.CharacterAdded:Connect(onCharacterAdded)

print("[ASPECTV4] HitboxExpander loaded (disabled)")
return HitboxExpander
