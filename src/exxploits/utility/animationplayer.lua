-- ASPECTV4 | ANIMATION PLAYER
-- ID: 34 | Type: Utility
-- Plays custom animations

local Core = _G.Aspect

local AnimationPlayer = {
    enabled = false,
    speed = 1,
    animation = "Run",
    animator = nil
}

local function toggle(state)
    AnimationPlayer.enabled = state
    local lp = game.Players.LocalPlayer
    
    if lp and lp.Character then
        local humanoid = lp.Character:FindFirstChild("Humanoid")
        if humanoid then
            if state then
                -- Load animation
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://" .. (AnimationPlayer.animations[AnimationPlayer.animation] or 0)
                AnimationPlayer.animator = humanoid:LoadAnimation(anim)
                AnimationPlayer.animator:Play()
                AnimationPlayer.animator:AdjustSpeed(AnimationPlayer.speed)
            else
                if AnimationPlayer.animator then
                    AnimationPlayer.animator:Stop()
                    AnimationPlayer.animator = nil
                end
            end
        end
    end
end

AnimationPlayer.animations = {
    Run = "123456789",
    Walk = "987654321",
    Idle = "111111111",
    Jump = "222222222"
}

Core.RegisterExploit(34, "AnimationPlayer", toggle, {
    speed = { type = "slider", min = 0.1, max = 5, default = 1 },
    animation = { type = "dropdown", options = {"Run", "Walk", "Idle", "Jump"}, default = "Run" }
})

print("[ASPECTV4] AnimationPlayer loaded (disabled)")
return AnimationPlayer
