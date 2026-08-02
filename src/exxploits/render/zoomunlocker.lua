-- ASPECTV4 | ZOOM UNLOCKER
-- ID: 33 | Type: Render
-- Increases camera zoom distance

local Core = _G.Aspect

local ZoomUnlocker = {
    enabled = false,
    distance = 500
}

local function toggle(state)
    ZoomUnlocker.enabled = state
    if state then
        workspace.CurrentCamera.FieldOfView = 70
    end
end

local function unlockZoom()
    if not ZoomUnlocker.enabled then return end
    
    local cam = workspace.CurrentCamera
    local distance = (cam.CFrame.Position - cam.Focus.Position).Magnitude
    
    if distance < ZoomUnlocker.distance then
        cam.CFrame = CFrame.lookAt(
            cam.Focus.Position + cam.CFrame.LookVector * ZoomUnlocker.distance,
            cam.Focus.Position
        )
    end
end

Core.RegisterExploit(33, "ZoomUnlocker", toggle, {
    distance = { type = "slider", min = 100, max = 1000, default = 500 }
})

Core.AddHook("Heartbeat", unlockZoom)

print("[ASPECTV4] ZoomUnlocker loaded (disabled)")
return ZoomUnlocker
