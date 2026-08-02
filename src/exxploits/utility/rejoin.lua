-- ASPECTV4 | REJOIN
-- ID: 41 | Type: Utility
-- Rejoins current server

local Core = _G.Aspect

local Rejoin = {
    enabled = false
}

local function toggle(state)
    Rejoin.enabled = state
    if state then
        game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)
        Rejoin.enabled = false
    end
end

Core.RegisterExploit(41, "Rejoin", toggle, {})

print("[ASPECTV4] Rejoin loaded (disabled)")
return Rejoin
