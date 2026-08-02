-- ASPECTV4 | PHASE
-- ID: 19 | Type: Blatant
-- Clips through walls

local Core = _G.Aspect

local Phase = {
    enabled = false,
    mode = "Part"
}

local function toggle(state)
    Phase.enabled = state
    
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        if state then
            -- Remove collision
            for _, part in ipairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        else
            -- Restore collision
            for _, part in ipairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

Core.RegisterExploit(19, "Phase", toggle, {
    mode = { type = "dropdown", options = {"Part", "Character", "CFrame", "Motor", "FFlag"}, default = "Part" }
})

print("[ASPECTV4] Phase loaded (disabled)")
return Phase
