-- ASPECTV4 | INVISIBLE
-- ID: 15 | Type: Blatant
-- Makes character invisible using animation trickery

local Core = _G.Aspect

local Invisible = {
    enabled = false,
    mode = "Animation"
}

local function toggle(state)
    Invisible.enabled = state
    
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        if state then
            -- Make invisible using transparency
            for _, part in ipairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
                if part:IsA("Decal") then
                    part.Transparency = 1
                end
            end
        else
            -- Restore visibility
            for _, part in ipairs(lp.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                end
                if part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
        end
    end
end

Core.RegisterExploit(15, "Invisible", toggle, {
    mode = { type = "dropdown", options = {"Animation"}, default = "Animation" }
})

print("[ASPECTV4] Invisible loaded (disabled)")
return Invisible
