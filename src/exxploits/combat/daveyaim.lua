-- ASPECTV4 | DAVEY AIM
-- ID: 6 | Type: Combat
-- Archer lead prediction for bow shots

local Core = _G.Aspect

local DaveyAim = {
    enabled = false,
    prediction = 0.5,
    target = nil
}

local function toggle(state)
    DaveyAim.enabled = state
end

-- Lead prediction
local function predictLead()
    if not DaveyAim.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local target = Core.GetNearestPlayer()
    if target and target.Character then
        local head = target.Character:FindFirstChild("Head")
        local root = target.Character:FindFirstChild("HumanoidRootPart")
        local origin = lp.Character:FindFirstChild("Head")
        
        if head and root and origin then
            -- Calculate velocity of target
            local velocity = (root.Position - head.Position) * DaveyAim.prediction
            
            -- Predict future position
            local predictedPos = head.Position + velocity
            
            -- Aim at predicted position
            local screenPos, _ = Core.WorldToScreen(predictedPos)
            if screenPos then
                local mouse = lp:GetMouse()
                mouse.Move(screenPos.X, screenPos.Y)
            end
        end
    end
end

Core.RegisterExploit(6, "DaveyAim", toggle, {
    prediction = { type = "slider", min = 0.1, max = 1.0, default = 0.5 }
})

Core.AddHook("RenderStepped", predictLead)

print("[ASPECTV4] DaveyAim loaded (disabled)")
return DaveyAim
