-- ASPECTV4 | SILENT AIM
-- ID: 2 | Type: Combat
-- Invisible aimbot using raycast hooks

local Core = _G.Aspect

local SilentAim = {
    enabled = false,
    fov = 180,
    range = 200,
    target = nil
}

-- Toggle function
local function toggle(state)
    SilentAim.enabled = state
end

-- Silent aim function
local function silentAim()
    if not SilentAim.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local target = Core.GetClosestToCursor()
    if target and target.Character then
        local head = target.Character:FindFirstChild("Head")
        if head then
            -- Calculate target angle
            local cam = workspace.CurrentCamera
            local dir = (head.Position - cam.CFrame.Position).Unit
            
            -- Hook raycast
            local oldRay = workspace.FindPartOnRay
            workspace.FindPartOnRay = function(self, ray)
                -- Modify ray direction to hit target
                local newRay = Ray.new(ray.Origin, dir * 1000)
                return oldRay(self, newRay)
            end
            
            -- Restore after frame
            task.wait(0)
            workspace.FindPartOnRay = oldRay
        end
    end
end

Core.RegisterExploit(2, "SilentAim", toggle, {
    fov = { type = "slider", min = 10, max = 360, default = 180 },
    range = { type = "slider", min = 10, max = 500, default = 200 }
})

Core.AddHook("RenderStepped", silentAim)

print("[ASPECTV4] SilentAim loaded (disabled)")
return SilentAim
