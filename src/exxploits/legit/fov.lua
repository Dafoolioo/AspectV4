-- ASPECTV4 | FOV
-- ID: 66 | Type: Legit
-- Adjusts camera FOV

local Core = _G.Aspect

local FOV = {
    enabled = false,
    value = 120
}

local function toggle(state)
    FOV.enabled = state
    if state then
        workspace.CurrentCamera.FieldOfView = FOV.value
    else
        workspace.CurrentCamera.FieldOfView = 70
    end
end

Core.RegisterExploit(66, "FOV", toggle, {
    value = { type = "slider", min = 60, max = 180, default = 120 }
})

print("[ASPECTV4] FOV loaded (disabled)")
return FOV
