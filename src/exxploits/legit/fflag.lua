-- ASPECTV4 | FFLAG
-- ID: 65 | Type: Legit
-- FFlag editor

local Core = _G.Aspect

local FFlag = {
    enabled = false,
    settings = {}
}

local function toggle(state)
    FFlag.enabled = state
    if state then
        -- Set FFlags
        for k, v in pairs(FFlag.settings) do
            game:GetService("FFlag"):Set(k, v)
        end
    end
end

Core.RegisterExploit(65, "FFlag", toggle, {
    settings = { type = "list", default = {} }
})

print("[ASPECTV4] FFlag loaded (disabled)")
return FFlag
