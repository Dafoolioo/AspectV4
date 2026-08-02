-- ASPECTV4 | DISGUISE
-- ID: 64 | Type: Legit
-- Changes appearance to another user's avatar

local Core = _G.Aspect

local Disguise = {
    enabled = false,
    target = "",
    original = nil
}

local function toggle(state)
    Disguise.enabled = state
    local lp = game.Players.LocalPlayer
    
    if lp and lp.Character then
        if state and Disguise.target ~= "" then
            -- Find target player
            local targetPlayer = game.Players:FindFirstChild(Disguise.target)
            if targetPlayer and targetPlayer.Character then
                -- Copy appearance
                for _, part in ipairs(targetPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        -- Copy properties
                    end
                end
            end
        else
            -- Restore original appearance
        end
    end
end

Core.RegisterExploit(64, "Disguise", toggle, {
    target = { type = "text", default = "" }
})

print("[ASPECTV4] Disguise loaded (disabled)")
return Disguise
