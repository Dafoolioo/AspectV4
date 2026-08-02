-- ASPECTV4 | STAFF DETECTOR
-- ID: 43 | Type: Utility
-- Detects staff members in game

local Core = _G.Aspect

local StaffDetector = {
    enabled = false,
    staff = {}
}

local function toggle(state)
    StaffDetector.enabled = state
end

local function detectStaff()
    if not StaffDetector.enabled then return end
    
    for _, player in ipairs(game.Players:GetPlayers()) do
        -- Check for staff indicators
        local isStaff = false
        
        -- Check rank
        if player:IsInGroup(1) or player:IsInGroup(2) then
            isStaff = true
        end
        
        -- Check name tags
        if player.Character and player.Character:FindFirstChild("Head") then
            -- Check for admin accessories
            for _, child in ipairs(player.Character:GetDescendants()) do
                if child:IsA("Accessory") and child.Name:lower():find("admin") then
                    isStaff = true
                end
            end
        end
        
        if isStaff then
            table.insert(StaffDetector.staff, player.Name)
            warn("[STAFF DETECTED] " .. player.Name)
        end
    end
end

Core.RegisterExploit(43, "StaffDetector", toggle, {})

Core.AddHook("Heartbeat", detectStaff)

print("[ASPECTV4] StaffDetector loaded (disabled)")
return StaffDetector
