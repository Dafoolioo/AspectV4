-- ASPECTV4 | AUTO GAMBLE
-- ID: 55 | Type: Bedwars
-- Auto-opens lucky crates

local Core = _G.Aspect

local AutoGamble = {
    enabled = false
}

local function toggle(state)
    AutoGamble.enabled = state
end

local function gamble()
    if not AutoGamble.enabled then return end
    
    -- Find crate button
    local button = nil
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Name:find("Open") then
            button = obj
            break
        end
    end
    
    if button then
        button:Click()
    end
end

Core.RegisterExploit(55, "AutoGamble", toggle, {})

Core.AddHook("Heartbeat", gamble)

print("[ASPECTV4] AutoGamble loaded (disabled)")
return AutoGamble
