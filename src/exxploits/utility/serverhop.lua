-- ASPECTV4 | SERVER HOP
-- ID: 42 | Type: Utility
-- Teleports to new server

local Core = _G.Aspect

local ServerHop = {
    enabled = false,
    mode = "Teleport"
}

local function toggle(state)
    ServerHop.enabled = state
    if state then
        -- Get list of servers
        local servers = {}
        -- Find new server
        local success, _ = pcall(function()
            game:GetService("TeleportService"):Teleport(game.PlaceId)
        end)
        ServerHop.enabled = false
    end
end

Core.RegisterExploit(42, "ServerHop", toggle, {
    mode = { type = "dropdown", options = {"Teleport"}, default = "Teleport" }
})

print("[ASPECTV4] ServerHop loaded (disabled)")
return ServerHop
