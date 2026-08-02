-- ASPECTV4 | REACH
-- ID: 8 | Type: Combat
-- Extends tool attack range

local Core = _G.Aspect
local Memory = _G.Memory

local Reach = {
    enabled = false,
    distance = 4.5
}

-- Toggle function
local function toggle(state)
    Reach.enabled = state
    -- In real implementation, patch memory at TouchInterest or Resize
    if state then
        Memory.Patch(0x7ffe1000, 0x3F800000, Reach.distance)
    else
        Memory.Patch(0x7ffe1000, Reach.distance, 0x3F800000)
    end
end

-- Hook tool attack
local function hookToolAttack()
    if not Reach.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if lp.Character then
        local tool = lp.Character:FindFirstChildOfClass("Tool")
        if tool then
            -- Modify tool range
            tool.Handle.Size = tool.Handle.Size + Vector3.new(Reach.distance - 3, 0, 0)
        end
    end
end

Core.RegisterExploit(8, "Reach", toggle, {
    distance = { type = "slider", min = 3.0, max = 8.0, default = 4.5 }
})

Core.AddHook("Heartbeat", hookToolAttack)

print("[ASPECTV4] Reach loaded (disabled)")
return Reach
