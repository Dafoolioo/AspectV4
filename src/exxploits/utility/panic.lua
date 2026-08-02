-- ASPECTV4 | PANIC
-- ID: 40 | Type: Utility
-- Disables all modules at once

local Core = _G.Aspect

local Panic = {
    enabled = false
}

local function toggle(state)
    Panic.enabled = state
    if state then
        Core.Panic()
        Panic.enabled = false  -- Auto-disable after panic
    end
end

Core.RegisterExploit(40, "Panic", toggle, {})

print("[ASPECTV4] Panic loaded (disabled)")
return Panic
