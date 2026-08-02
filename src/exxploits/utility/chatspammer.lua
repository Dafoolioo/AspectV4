-- ASPECTV4 | CHAT SPAMMER
-- ID: 38 | Type: Utility
-- Auto-types messages

local Core = _G.Aspect

local ChatSpammer = {
    enabled = false,
    messages = {"AspectV4 >"},
    delay = 2,
    mode = "Order",
    index = 1,
    timer = 0
}

local function toggle(state)
    ChatSpammer.enabled = state
    ChatSpammer.timer = 0
end

local function spam()
    if not ChatSpammer.enabled then return end
    
    ChatSpammer.timer = ChatSpammer.timer + game:GetService("RunService").Heartbeat:Wait()
    
    if ChatSpammer.timer >= ChatSpammer.delay then
        ChatSpammer.timer = 0
        
        local msg = ""
        if ChatSpammer.mode == "Order" then
            msg = ChatSpammer.messages[ChatSpammer.index]
            ChatSpammer.index = ChatSpammer.index % #ChatSpammer.messages + 1
        else
            msg = ChatSpammer.messages[math.random(#ChatSpammer.messages)]
        end
        
        if msg then
            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest"):FireServer(msg, "All")
        end
    end
end

Core.RegisterExploit(38, "ChatSpammer", toggle, {
    messages = { type = "list", default = {"AspectV4 >"} },
    delay = { type = "slider", min = 0.5, max = 10, default = 2 },
    mode = { type = "dropdown", options = {"Order", "Random"}, default = "Order" }
})

Core.AddHook("Heartbeat", spam)

print("[ASPECTV4] ChatSpammer loaded (disabled)")
return ChatSpammer
