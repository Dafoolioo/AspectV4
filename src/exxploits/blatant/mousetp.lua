-- ASPECTV4 | MOUSE TP
-- ID: 18 | Type: Blatant
-- Teleports to mouse cursor position

local Core = _G.Aspect

local MouseTP = {
    enabled = false,
    range = 100
}

local function toggle(state)
    MouseTP.enabled = state
end

local function mouseTP()
    if not MouseTP.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local mouse = lp:GetMouse()
    local targetPos = mouse.Hit.Position
    
    -- Teleport
    if (targetPos - root.Position).Magnitude <= MouseTP.range then
        root.CFrame = CFrame.new(targetPos)
    end
end

Core.RegisterExploit(18, "MouseTP", toggle, {
    range = { type = "slider", min = 10, max = 500, default = 100 }
})

-- Trigger on right click
local mouse = game.Players.LocalPlayer:GetMouse()
mouse.Button2Down:Connect(function()
    if MouseTP.enabled then
        mouseTP()
    end
end)

print("[ASPECTV4] MouseTP loaded (disabled)")
return MouseTP
