-- ASPECTV4 | INFINITE REWARDS
-- ID: 56 | Type: Bedwars
-- Auto-claims all rewards

local Core = _G.Aspect

local InfiniteRewards = {
    enabled = false
}

local function toggle(state)
    InfiniteRewards.enabled = state
end

local function claimRewards()
    if not InfiniteRewards.enabled then return end
    
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Name:find("Claim") then
            obj:Click()
        end
    end
end

Core.RegisterExploit(56, "InfiniteRewards", toggle, {})

Core.AddHook("Heartbeat", claimRewards)

print("[ASPECTV4] InfiniteRewards loaded (disabled)")
return InfiniteRewards
