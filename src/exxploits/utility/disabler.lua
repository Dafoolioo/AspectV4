-- ASPECTV4 | DISABLER
-- ID: 39 | Type: Utility
-- Disables GetPropertyChangedSignal detections

local Core = _G.Aspect

local Disabler = {
    enabled = false
}

local function toggle(state)
    Disabler.enabled = state
end

local function disableDetections()
    if not Disabler.enabled then return end
    
    -- Override GetPropertyChangedSignal
    local oldGPC = getmetatable(game).__index.GetPropertyChangedSignal
    getmetatable(game).__index.GetPropertyChangedSignal = function(obj, prop)
        if prop == "Network" or prop == "Character" then
            return function() end
        end
        return oldGPC(obj, prop)
    end
end

Core.RegisterExploit(39, "Disabler", toggle, {})

Core.AddHook("Heartbeat", disableDetections)

print("[ASPECTV4] Disabler loaded (disabled)")
return Disabler
