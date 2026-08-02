-- ASPECTV4 | AUTO REJOIN
-- ID: 36 | Type: Utility
-- Auto rejoins on disconnect

local Core = _G.Aspect

local AutoRejoin = {
    enabled = false,
    delay = 5
}

local function toggle(state)
    AutoRejoin.enabled = state
end

local function checkDisconnect()
    if not AutoRejoin.enabled then return end
    
    local success, _ = pcall(function()
        return game.Players.LocalPlayer
    end)
    
    if not success then
        task.wait(AutoRejoin.delay)
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
    end
end

Core.RegisterExploit(36, "AutoRejoin", toggle, {
    delay = { type = "slider", min = 1, max = 30, default = 5 }
})

Core.AddHook("Heartbeat", checkDisconnect)

print("[ASPECTV4] AutoRejoin loaded (disabled)")
return AutoRejoin
