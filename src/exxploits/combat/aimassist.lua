-- ASPECTV4 | AIM ASSIST
-- ID: 1 | Type: Combat
-- Smoothly aims at nearest enemy

local Core = _G.Aspect

local AimAssist = {
    enabled = false,
    smoothness = 5,
    fov = 90,
    range = 100,
    target = nil
}

-- Toggle function
local function toggle(state)
    AimAssist.enabled = state
    if not state then
        AimAssist.target = nil
    end
end

-- Aim function
local function aim()
    if not AimAssist.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local mouse = lp:GetMouse()
    local target = Core.GetNearestPlayer()
    
    if target and target.Character then
        local head = target.Character:FindFirstChild("Head")
        if head then
            local screenPos, onScreen = Core.WorldToScreen(head.Position)
            if onScreen then
                -- Calculate aim vector
                local deltaX = screenPos.X - mouse.X
                local deltaY = screenPos.Y - mouse.Y
                local distance = math.sqrt(deltaX^2 + deltaY^2)
                
                if distance > 5 then
                    -- Smooth aim
                    local stepX = deltaX / AimAssist.smoothness
                    local stepY = deltaY / AimAssist.smoothness
                    
                    mouse.Move(mouse.X + stepX, mouse.Y + stepY)
                end
            end
        end
    end
end

-- Register exploit
Core.RegisterExploit(1, "AimAssist", toggle, {
    smoothness = { type = "slider", min = 1, max = 20, default = 5 },
    fov = { type = "slider", min = 10, max = 180, default = 90 },
    range = { type = "slider", min = 10, max = 500, default = 100 }
})

-- Add hook
Core.AddHook("RenderStepped", aim)

print("[ASPECTV4] AimAssist loaded (disabled)")
return AimAssist
