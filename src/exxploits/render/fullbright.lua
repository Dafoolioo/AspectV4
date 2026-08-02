-- ASPECTV4 | FULLBRIGHT
-- ID: 29 | Type: Render
-- Max brightness

local Core = _G.Aspect

local Fullbright = {
    enabled = false,
    mode = "Lighting"
}

local function toggle(state)
    Fullbright.enabled = state
    
    if state then
        if Fullbright.mode == "Lighting" then
            game:GetService("Lighting").Brightness = 1
            game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
        elseif Fullbright.mode == "PointLight" then
            -- Create point light at player
        end
    else
        game:GetService("Lighting").Brightness = 0.3
        game:GetService("Lighting").Ambient = Color3.new(0.3, 0.3, 0.3)
    end
end

Core.RegisterExploit(29, "Fullbright", toggle, {
    mode = { type = "dropdown", options = {"Lighting", "PointLight"}, default = "Lighting" }
})

print("[ASPECTV4] Fullbright loaded (disabled)")
return Fullbright
