-- ASPECTV4 | XRAY
-- ID: 52 | Type: World
-- Renders whitelisted parts through walls

local Core = _G.Aspect

local Xray = {
    enabled = false,
    whitelist = {"Diamond", "Iron", "Gold"}
}

local function toggle(state)
    Xray.enabled = state
    
    for _, part in ipairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            if state then
                for _, ore in ipairs(Xray.whitelist) do
                    if part.Name:find(ore) then
                        part.Transparency = 0.3
                        part.LocalTransparencyModifier = 0.3
                    end
                end
            else
                part.Transparency = 0
                part.LocalTransparencyModifier = 0
            end
        end
    end
end

Core.RegisterExploit(52, "Xray", toggle, {
    whitelist = { type = "list", default = {"Diamond", "Iron", "Gold"} }
})

print("[ASPECTV4] Xray loaded (disabled)")
return Xray
