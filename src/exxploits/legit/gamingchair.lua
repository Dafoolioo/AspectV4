-- ASPECTV4 | GAMING CHAIR
-- ID: 74 | Type: Legit
-- Renders 3D gaming chair

local Core = _G.Aspect

local GamingChair = {
    enabled = false,
    chair = nil
}

local function toggle(state)
    GamingChair.enabled = state
    local lp = game.Players.LocalPlayer
    
    if lp and lp.Character then
        if state then
            -- Create gaming chair
            local chair = Instance.new("Model")
            chair.Name = "GamingChair"
            
            -- Seat
            local seat = Instance.new("Part")
            seat.Size = Vector3.new(2, 0.5, 2)
            seat.Position = lp.Character.HumanoidRootPart.Position - Vector3.new(0, 1, 0)
            seat.Color = Color3.new(1, 0, 0)
            seat.Material = Enum.Material.Neon
            seat.Anchored = false
            seat.CanCollide = false
            seat.Parent = chair
            
            -- Legs
            for i = 1, 4 do
                local leg = Instance.new("Part")
                leg.Size = Vector3.new(0.1, 0.5, 0.1)
                leg.Position = seat.Position + Vector3.new(
                    (i % 2 == 0 and 0.8 or -0.8),
                    -0.5,
                    (i > 2 and 0.8 or -0.8)
                )
                leg.Color = Color3.new(0.5, 0.5, 0.5)
                leg.Anchored = false
                leg.CanCollide = false
                leg.Parent = chair
                
                local weld = Instance.new("Weld")
                weld.Part0 = seat
                weld.Part1 = leg
                weld.C0 = CFrame.new(leg.Position - seat.Position)
                weld.Parent = leg
            end
            
            -- Back
            local back = Instance.new("Part")
            back.Size = Vector3.new(2, 1.5, 0.1)
            back.Position = seat.Position + Vector3.new(0, 1.5, -1)
            back.Color = Color3.new(1, 0, 0)
            back.Material = Enum.Material.Neon
            back.Anchored = false
            back.CanCollide = false
            back.Parent = chair
            
            -- Weld chair to character
            local weld = Instance.new("Weld")
            weld.Part0 = lp.Character.HumanoidRootPart
            weld.Part1 = seat
            weld.C0 = CFrame.new(0, -1, 0)
            weld.Parent = seat
            
            chair.Parent = workspace
            GamingChair.chair = chair
        else
            if GamingChair.chair then
                GamingChair.chair:Destroy()
                GamingChair.chair = nil
            end
        end
    end
end

Core.RegisterExploit(74, "GamingChair", toggle, {})

print("[ASPECTV4] GamingChair loaded (disabled)")
return GamingChair
