-- ASPECTV4 | HITBOXES
-- ID: 13 | Type: Blatant
-- Expands enemy hitboxes on client side

local Core = _G.Aspect

local HitBoxes = {
    enabled = false,
    size = 3
}

local function toggle(state)
    HitBoxes.enabled = state
    
    -- Apply to all players
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    if state then
                        part.Size = part.Size * HitBoxes.size
                    else
                        part.Size = part.Size / HitBoxes.size
                    end
                end
            end
        end
    end
end

Core.RegisterExploit(13, "HitBoxes", toggle, {
    size = { type = "slider", min = 1, max = 10, default = 3 }
})

print("[ASPECTV4] HitBoxes loaded (disabled)")
return HitBoxes
