-- ASPECTV4 | ANTI RAGDOLL
-- ID: 35 | Type: Utility
-- Prevents ragdoll state

local Core = _G.Aspect

local AntiRagdoll = {
    enabled = false
}

local function toggle(state)
    AntiRagdoll.enabled = state
end

local function preventRagdoll()
    if not AntiRagdoll.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if lp and lp.Character then
        local humanoid = lp.Character:FindFirstChild("Humanoid")
        if humanoid then
            if humanoid:GetState() == Enum.HumanoidStateType.Physics then
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
                task.wait(0.1)
                humanoid:SetStateEnabled(Enum.HumanoidStateType.Physics, true)
                humanoid:ChangeState(Enum.HumanoidStateType.Running)
            end
        end
    end
end

Core.RegisterExploit(35, "AntiRagdoll", toggle, {})

Core.AddHook("Heartbeat", preventRagdoll)

print("[ASPECTV4] AntiRagdoll loaded (disabled)")
return AntiRagdoll
