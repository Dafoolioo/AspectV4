-- ASPECTV4 | DESYNC
-- ID: 10 | Type: Blatant
-- Desyncs position from server using raknet

local Core = _G.Aspect

local Desync = {
    enabled = false,
    mode = "Raknet",
    desyncTimer = 0
}

local function toggle(state)
    Desync.enabled = state
    Desync.desyncTimer = 0
end

local function desync()
    if not Desync.enabled then return end
    
    local lp = game.Players.LocalPlayer
    if not lp.Character then return end
    
    local root = lp.Character:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    Desync.desyncTimer = Desync.desyncTimer + game:GetService("RunService").Heartbeat:Wait()
    
    if Desync.desyncTimer >= 1 then
        Desync.desyncTimer = 0
        
        if Desync.mode == "Raknet" then
            -- Simulate network desync
            root.CFrame = root.CFrame + Vector3.new(0, 0, 5)
            task.wait(0.05)
            root.CFrame = root.CFrame - Vector3.new(0, 0, 5)
        end
    end
end

Core.RegisterExploit(10, "Desync", toggle, {
    mode = { type = "dropdown", options = {"Raknet"}, default = "Raknet" }
})

Core.AddHook("Heartbeat", desync)

print("[ASPECTV4] Desync loaded (disabled)")
return Desync
