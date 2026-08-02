-- ASPECTV4 | ATMOSPHERE
-- ID: 58 | Type: Legit
-- Custom lighting effects

local Core = _G.Aspect

local Atmosphere = {
    enabled = false,
    effect = "Sky",
    color = Color3.new(0.5, 0.5, 1)
}

local function toggle(state)
    Atmosphere.enabled = state
    local lighting = game:GetService("Lighting")
    
    if state then
        if Atmosphere.effect == "Sky" then
            lighting.SkyColor = Atmosphere.color
            lighting.Ambient = Atmosphere.color
        elseif Atmosphere.effect == "Bloom" then
            lighting.Bloom.Intensity = 1
        elseif Atmosphere.effect == "DepthOfField" then
            lighting.DepthOfField.NearIntensity = 1
        end
    else
        lighting.SkyColor = Color3.new(0, 0, 0)
        lighting.Ambient = Color3.new(0.3, 0.3, 0.3)
    end
end

Core.RegisterExploit(58, "Atmosphere", toggle, {
    effect = { type = "dropdown", options = {"Sky", "Bloom", "DepthOfField"}, default = "Sky" },
    color = { type = "color", default = Color3.new(0.5, 0.5, 1) }
})

print("[ASPECTV4] Atmosphere loaded (disabled)")
return Atmosphere
