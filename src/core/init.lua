-- ASPECTV4 CORE INITIALIZATION
-- Address: 0x7ffe0000
-- Deterministic seed: 0x00000000

local Core = {}
Core.Exploits = {}
Core.Enabled = {}
Core.Modules = {}
Core.Hooks = {}

-- Global access
_G.Aspect = Core

-- Disable all by default
for i = 1, 74 do
    Core.Enabled[i] = false
end

-- Register exploit function
function Core.RegisterExploit(id, name, toggleFunc, settings)
    Core.Exploits[id] = {
        name = name,
        toggle = toggleFunc,
        settings = settings or {},
        enabled = false
    }
    Core.Modules[id] = false
end

-- Toggle function
function Core.ToggleExploit(id)
    if Core.Exploits[id] then
        Core.Enabled[id] = not Core.Enabled[id]
        Core.Exploits[id].enabled = Core.Enabled[id]
        Core.Exploits[id].toggle(Core.Enabled[id])
        return Core.Enabled[id]
    end
    return false
end

-- Get player functions
function Core.GetPlayers()
    local players = {}
    for _, v in ipairs(game.Players:GetPlayers()) do
        if v ~= game.Players.LocalPlayer and v.Character then
            table.insert(players, v)
        end
    end
    return players
end

function Core.GetNearestPlayer()
    local lp = game.Players.LocalPlayer
    if not lp.Character then return nil end
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local nearest, minDist = nil, math.huge
    for _, player in ipairs(Core.GetPlayers()) do
        local pr = player.Character:FindFirstChild("HumanoidRootPart")
        if pr then
            local dist = (root.Position - pr.Position).Magnitude
            if dist < minDist then
                minDist = dist
                nearest = player
            end
        end
    end
    return nearest
end

function Core.GetClosestToCursor()
    local mouse = game.Players.LocalPlayer:GetMouse()
    local ray = Ray.new(mouse.UnitRay.Origin, mouse.UnitRay.Direction * 1000)
    local hit = workspace:FindPartOnRay(ray)
    if hit then
        local parent = hit.Parent
        while parent do
            if parent:IsA("Model") and parent:FindFirstChild("Humanoid") then
                local player = game.Players:GetPlayerFromCharacter(parent)
                if player then return player end
            end
            parent = parent.Parent
        end
    end
    return nil
end

-- World to Screen
function Core.WorldToScreen(pos)
    local cam = workspace.CurrentCamera
    local vec, onScreen = cam:WorldToScreenPoint(pos)
    return Vector2.new(vec.X, vec.Y), onScreen
end

-- Hook system
function Core.AddHook(step, func)
    if not Core.Hooks[step] then Core.Hooks[step] = {} end
    table.insert(Core.Hooks[step], func)
end

function Core.RunHooks(step, ...)
    if Core.Hooks[step] then
        for _, func in ipairs(Core.Hooks[step]) do
            pcall(func, ...)
        end
    end
end

-- Run hook loop
game:GetService("RunService").RenderStepped:Connect(function(dt)
    Core.RunHooks("RenderStepped", dt)
end)

game:GetService("RunService").Heartbeat:Connect(function(dt)
    Core.RunHooks("Heartbeat", dt)
end)

-- Panic function
function Core.Panic()
    for id, exploit in pairs(Core.Exploits) do
        if exploit.enabled then
            exploit.toggle(false)
            exploit.enabled = false
            Core.Enabled[id] = false
        end
    end
    print("[ASPECTV4] PANIC - All exploits disabled")
end

-- Expose
return Core
