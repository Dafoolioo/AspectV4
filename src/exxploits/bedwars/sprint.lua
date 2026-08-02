-- ASPECTV4 | SPRINT
-- ID: 53 | Type: Bedwars
-- Forces sprinting on

local Core = _G.Aspect

local Sprint = {
    enabled = false
}

local function toggle(state)
    Sprint.enabled = state
    local lp = game.Players.LocalPlayer
    
    if lp and lp.Character then
        local humanoid = lp.Character:FindFirstChild("Humanoid")
        if humanoid then
            if state then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Sprinting, true)
            end
        end
    end
end

local function forceSprint()
    if not Sprint.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local humanoid = lp.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid:ChangeState(Enum.HumanoidStateType.Sprinting)
        end
    end
end

Core.RegisterExploit(53, "Sprint", toggle, {})

Core.AddHook("Heartbeat", forceSprint)

print("[ASPECTV4] Sprint loaded (disabled)")
return Sprint
