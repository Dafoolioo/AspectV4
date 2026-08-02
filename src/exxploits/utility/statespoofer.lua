-- ASPECTV4 | STATE SPOOFER
-- ID: 44 | Type: Utility
-- Spoofs humanoid states on server

local Core = _G.Aspect

local StateSpoofer = {
    enabled = false,
    mode = "Raknet"
}

local function toggle(state)
    StateSpoofer.enabled = state
end

local function spoofState()
    if not StateSpoofer.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local humanoid = lp.Character:FindFirstChild("Humanoid")
        if humanoid then
            -- Spoof jump state
            if StateSpoofer.mode == "Raknet" then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                task.wait(0.1)
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
        end
    end
end

Core.RegisterExploit(44, "StateSpoofer", toggle, {
    mode = { type = "dropdown", options = {"Raknet"}, default = "Raknet" }
})

Core.AddHook("Heartbeat", spoofState)

print("[ASPECTV4] StateSpoofer loaded (disabled)")
return StateSpoofer
