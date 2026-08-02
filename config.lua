-- ASPECTV4 CONFIGURATION

local Config = {
    Version = "4.0.0",
    Author = "AspectV4 Team",
    
    -- Keybinds
    Keys = {
        MenuToggle = "Insert",
        Panic = "End",
        KillauraToggle = "F",
        FlyToggle = "G",
        ESPToggle = "H"
    },
    
    -- Default settings (all disabled)
    Defaults = {
        Enabled = false,
        -- Combat
        AimAssist = { enabled = false, smoothness = 5, fov = 90, range = 100 },
        SilentAim = { enabled = false, fov = 180, range = 200 },
        HitboxExpander = { enabled = false, multiplier = 1.5 },
        AutoClicker = { enabled = false, cps = 12, jitter = true },
        ProjectileAimbot = { enabled = false, velocity = 100 },
        DaveyAim = { enabled = false, prediction = 0.5 },
        Triggerbot = { enabled = false, delay = 50 },
        Reach = { enabled = false, distance = 4.5 },
        
        -- Blatant
        AntiFall = { enabled = false, mode = "Part" },
        Desync = { enabled = false, mode = "Raknet" },
        Fly = { enabled = false, speed = 50, mode = "WASD" },
        HighJump = { enabled = false, height = 50, mode = "Velocity" },
        HitBoxes = { enabled = false, size = 3 },
        InfiniteJump = { enabled = false, mode = "Velocity" },
        Invisible = { enabled = false, mode = "Animation" },
        Killaura = { enabled = false, range = 20, speed = 10 },
        LongJump = { enabled = false, distance = 30, mode = "Velocity" },
        MouseTP = { enabled = false, range = 100 },
        Phase = { enabled = false, mode = "Part" },
        Speed = { enabled = false, amount = 50, mode = "Velocity" },
        Spider = { enabled = false, speed = 20, mode = "Velocity" },
        SpinBot = { enabled = false, speed = 5, mode = "CFrame" },
        Swim = { enabled = false, mode = "Water" },
        TargetStrafe = { enabled = false, radius = 5, speed = 10 },
        Timer = { enabled = false, speed = 1.5 },
        
        -- Render
        Arrows = { enabled = false, color = Color3.new(1, 0, 0) },
        Chams = { enabled = false, color = Color3.new(0, 1, 0), mode = "Highlight" },
        ESP = { enabled = false, box = true, skeleton = true, health = true, name = true },
        Fullbright = { enabled = false, mode = "Lighting" },
        NameTags = { enabled = false, health = true, distance = true },
        Tracers = { enabled = false, color = Color3.new(1, 0, 0) },
        Waypoints = { enabled = false, color = Color3.new(0, 0, 1) },
        ZoomUnlocker = { enabled = false, distance = 500 },
        
        -- Utility
        AnimationPlayer = { enabled = false, speed = 1, animation = "Run" },
        AntiRagdoll = { enabled = false },
        AutoRejoin = { enabled = false, delay = 5 },
        Blink = { enabled = false, mode = "Movement Only" },
        ChatSpammer = { enabled = false, messages = {"AspectV4 >"}, delay = 2, mode = "Order" },
        Disabler = { enabled = false },
        Panic = { enabled = false },
        Rejoin = { enabled = false },
        ServerHop = { enabled = false, mode = "Teleport" },
        StaffDetector = { enabled = false },
        StateSpoofer = { enabled = false, mode = "Raknet" },
        
        -- World
        AntiAFK = { enabled = false, mode = "Movement" },
        FastInteraction = { enabled = false, speed = 5 },
        Freecam = { enabled = false, speed = 50 },
        Gravity = { enabled = false, value = -50, mode = "Workspace" },
        InteractExtender = { enabled = false, distance = 50 },
        Parkour = { enabled = false, detection = 0.5 },
        SafeWalk = { enabled = false },
        Xray = { enabled = false, whitelist = {"Diamond", "Iron", "Gold"} },
        
        -- Bedwars
        Sprint = { enabled = false },
        AutoQueue = { enabled = false },
        AutoGamble = { enabled = false },
        InfiniteRewards = { enabled = false },
        
        -- Minigames
        MurderMystery = { enabled = false, detection = true },
        
        -- Legit
        Atmosphere = { enabled = false, effect = "Sky", color = Color3.new(0.5, 0.5, 1) },
        Breadcrumbs = { enabled = false, max = 100, color = Color3.new(1, 1, 0) },
        Cape = { enabled = false, color = Color3.new(1, 0, 0) },
        ChinaHat = { enabled = false, color = Color3.new(1, 1, 0) },
        Clock = { enabled = false, format = "24h" },
        Coords = { enabled = false, position = "TopLeft" },
        Disguise = { enabled = false, target = "" },
        FFlag = { enabled = false, settings = {} },
        FOV = { enabled = false, value = 120 },
        FPS = { enabled = false, position = "TopRight" },
        Keystrokes = { enabled = false, style = "Keyboard", color = Color3.new(1, 1, 1) },
        Memory = { enabled = false, position = "BottomRight" },
        Ping = { enabled = false, position = "BottomLeft" },
        SongBeats = { enabled = false, volume = 50 },
        Speedmeter = { enabled = false, position = "TopCenter" },
        TimeChanger = { enabled = false, time = 12 }
    }
}

-- Store globally
_G.AspectConfig = Config
return Config
