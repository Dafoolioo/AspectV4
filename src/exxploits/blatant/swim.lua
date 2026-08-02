-- ASPECTV4 | SWIM
-- ID: 23 | Type: Blatant
-- Creates water under you to swim in midair

local Core = _G.Aspect

local Swim = {
    enabled = false,
    mode = "Water"
}

local function toggle(state)
    Swim.enabled = state
end

local function swim()
    if not Swim.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if Swim.mode == "Water" then
        -- Create water block under feet
        local water = Instance.new("Part")
        water.Size = Vector3.new(10, 0.1, 10)
        water.Position = root.Position - Vector3.new(
