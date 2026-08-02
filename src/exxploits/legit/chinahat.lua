-- ASPECTV4 | CHINA HAT
-- ID: 61 | Type: Legit
-- Puts china hat on character

local Core = _G.Aspect

local ChinaHat = {
    enabled = false,
    color = Color3.new(1, 1, 0),
    hat = nil
}

local function toggle(state)
    ChinaHat.enabled = state
    local lp = game.Players.LocalPlayer
    
    if lp and lp.Character then
        if state then
            -- Create hat
            local hat = Instance.new("Part")
            hat.Size = Vector3.new(2, 1, 2)
            hat.Shape = Enum.PartType.Cylinder
            hat.Position = lp.Character.Head.Position + Vector3.new(0, 1, 0)
            hat.Color = ChinaHat.color
            hat.Anchored = false
            hat.CanCollide = false
            hat.Parent = lp.Character
            
            -- Weld to head
            local weld = Instance.new("Weld")
            weld.Part0 = lp.Character.Head
            weld.Part1 = hat
            weld.C0 = CFrame.new(0, 1, 0)
            weld.Parent = hat
            
            ChinaHat.hat = hat
        else
            if ChinaHat.hat then
                ChinaHat.hat:Destroy()
                ChinaHat.hat = nil
            end
        end
    end
end

Core.RegisterExploit(61, "ChinaHat", toggle, {
    color = { type = "color", default = Color3.new(1, 1, 0) }
})

print("[ASPECTV4] ChinaHat loaded (disabled)")
return ChinaHat
