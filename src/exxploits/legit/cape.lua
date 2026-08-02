-- ASPECTV4 | CAPE
-- ID: 60 | Type: Legit
-- Adds custom cape

local Core = _G.Aspect

local Cape = {
    enabled = false,
    color = Color3.new(1, 0, 0),
    capePart = nil
}

local function toggle(state)
    Cape.enabled = state
    local lp = game.Players.LocalPlayer
    
    if lp and lp.Character then
        if state then
            -- Create cape
            local cape = Instance.new("Part")
            cape.Size = Vector3.new(3, 5, 0.1)
            cape.Position = lp.Character.HumanoidRootPart.Position + Vector3.new(0, 2, -1)
            cape.Color = Cape.color
            cape.Anchored = false
            cape.CanCollide = false
            cape.Parent = lp.Character
            
            -- Weld to character
            local weld = Instance.new("Weld")
            weld.Part0 = lp.Character.HumanoidRootPart
            weld.Part1 = cape
            weld.C0 = CFrame.new(0, 2, -1)
            weld.Parent = cape
            
            Cape.capePart = cape
        else
            if Cape.capePart then
                Cape.capePart:Destroy()
                Cape.capePart = nil
            end
        end
    end
end

Core.RegisterExploit(60, "Cape", toggle, {
    color = { type = "color", default = Color3.new(1, 0, 0) }
})

print("[ASPECTV4] Cape loaded (disabled)")
return Cape
