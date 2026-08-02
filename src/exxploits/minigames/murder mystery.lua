-- ASPECTV4 | MURDER MYSTERY
-- ID: 57 | Type: Minigames
-- Auto-detects murderer/sheriff

local Core = _G.Aspect

local MurderMystery = {
    enabled = false,
    detection = true
}

local function toggle(state)
    MurderMystery.enabled = state
end

local function detectRoles()
    if not MurderMystery.enabled then return end
    
    local roles = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        -- Check for knife (murderer)
        if player.Character then
            local knife = player.Character:FindFirstChild("Knife")
            if knife then
                roles[player.Name] = "Murderer"
                warn("[MURDERER] " .. player.Name)
            end
            
            -- Check for gun (sheriff)
            local gun = player.Character:FindFirstChild("Gun")
            if gun then
                roles[player.Name] = "Sheriff"
                warn("[SHERIFF] " .. player.Name)
            end
        end
    end
end

Core.RegisterExploit(57, "MurderMystery", toggle, {
    detection = { type = "toggle", default = true }
})

Core.AddHook("Heartbeat", detectRoles)

print("[ASPECTV4] MurderMystery loaded (disabled)")
return MurderMystery
