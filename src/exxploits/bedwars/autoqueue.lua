-- ASPECTV4 | AUTO QUEUE
-- ID: 54 | Type: Bedwars
-- Auto-queues for games

local Core = _G.Aspect

local AutoQueue = {
    enabled = false
}

local function toggle(state)
    AutoQueue.enabled = state
end

local function queue()
    if not AutoQueue.enabled then return end
    
    -- Find queue button
    local button = nil
    for _, obj in ipairs(game:GetDescendants()) do
        if obj:IsA("TextButton") and obj.Name:find("Queue") then
            button = obj
            break
        end
    end
    
    if button then
        button:Click()
    end
end

Core.RegisterExploit(54, "AutoQueue", toggle, {})

Core.AddHook("Heartbeat", queue)

print("[ASPECTV4] AutoQueue loaded (disabled)")
return AutoQueue
