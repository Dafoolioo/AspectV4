-- ASPECTV4 HOOK MANAGER

local HookManager = {}

-- Hook storage
HookManager.Hooks = {
    RenderStepped = {},
    Heartbeat = {},
    Stepped = {},
    CharacterAdded = {},
    CharacterRemoving = {}
}

-- Add hook
function HookManager.Add(step, func, priority)
    priority = priority or 0
    if not HookManager.Hooks[step] then
        HookManager.Hooks[step] = {}
    end
    table.insert(HookManager.Hooks[step], {func = func, priority = priority})
    table.sort(HookManager.Hooks[step], function(a, b)
        return a.priority > b.priority
    end)
end

-- Remove hook
function HookManager.Remove(step, func)
    if HookManager.Hooks[step] then
        for i, hook in ipairs(HookManager.Hooks[step]) do
            if hook.func == func then
                table.remove(HookManager.Hooks[step], i)
                break
            end
        end
    end
end

-- Run hooks
function HookManager.Run(step, ...)
    if HookManager.Hooks[step] then
        for _, hook in ipairs(HookManager.Hooks[step]) do
            pcall(hook.func, ...)
        end
    end
end

-- Initialize connections
game:GetService("RunService").RenderStepped:Connect(function(dt)
    HookManager.Run("RenderStepped", dt)
end)

game:GetService("RunService").Heartbeat:Connect(function(dt)
    HookManager.Run("Heartbeat", dt)
end)

game:GetService("RunService").Stepped:Connect(function(dt)
    HookManager.Run("Stepped", dt)
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    HookManager.Run("CharacterAdded", char)
end)

game.Players.LocalPlayer.CharacterRemoving:Connect(function(char)
    HookManager.Run("CharacterRemoving", char)
end)

return HookManager
