-- ASPECTV4 | FREECAM
-- ID: 47 | Type: World
-- Noclip camera

local Core = _G.Aspect

local Freecam = {
    enabled = false,
    speed = 50,
    camera = workspace.CurrentCamera,
    originalCFrame = nil
}

local function toggle(state)
    Freecam.enabled = state
    if state then
        Freecam.originalCFrame = Freecam.camera.CFrame
    else
        if Freecam.originalCFrame then
            Freecam.camera.CFrame = Freecam.originalCFrame
        end
    end
end

local function freecam()
    if not Freecam.enabled then return end
    
    local speed = Freecam.speed
    local keys = {
        W = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W),
        A = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A),
        S = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S),
        D = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D),
        Space = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.Space),
        Control = game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl)
    }
    
    local cam = Freecam.camera
    local move = Vector3.new(0, 0, 0)
    
    if keys.W then move = move + cam.CFrame.LookVector * speed end
    if keys.S then move = move - cam.CFrame.LookVector * speed end
    if keys.A then move = move - cam.CFrame.RightVector * speed end
    if keys.D then move = move + cam.CFrame.RightVector * speed end
    if keys.Space then move = move + Vector3.new(0, speed, 0) end
    if keys.Control then move = move - Vector3.new(0, speed, 0) end
    
    cam.CFrame = cam.CFrame + move
end

Core.RegisterExploit(47, "Freecam", toggle, {
    speed = { type = "slider", min = 10, max = 200, default = 50 }
})

Core.AddHook("Heartbeat", freecam)

print("[ASPECTV4] Freecam loaded (disabled)")
return Freecam
