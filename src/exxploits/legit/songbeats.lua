-- ASPECTV4 | SONG BEATS
-- ID: 71 | Type: Legit
-- MP3 player with beat effects

local Core = _G.Aspect

local SongBeats = {
    enabled = false,
    volume = 50,
    player = nil
}

local function toggle(state)
    SongBeats.enabled = state
    if state then
        -- Load MP3 player
        local player = Instance.new("Sound")
        player.SoundId = "rbxassetid://1234567890"
        player.Volume = SongBeats.volume / 100
        player.Parent = game.Players.LocalPlayer
        player:Play()
        SongBeats.player = player
    else
        if SongBeats.player then
            SongBeats.player:Stop()
            SongBeats.player:Destroy()
            SongBeats.player = nil
        end
    end
end

Core.RegisterExploit(71, "SongBeats", toggle, {
    volume = { type = "slider", min = 0, max = 100, default = 50 }
})

print("[ASPECTV4] SongBeats loaded (disabled)")
return SongBeats
