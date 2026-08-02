--[[
  ╔═══════════════════════════════════════════════════════════════╗
  ║  █████╗ ███████╗██████╗ ███████╗ ██████╗████████╗██╗   ██╗  ║
  ║ ██╔══██╗██╔════╝██╔══██╗██╔════╝██╔════╝╚══██╔══╝╚██╗ ██╔╝  ║
  ║ ███████║███████╗██████╔╝█████╗  ██║        ██║    ╚████╔╝   ║
  ║ ██╔══██║╚════██║██╔══██╗██╔══╝  ██║        ██║     ╚██╔╝    ║
  ║ ██║  ██║███████║██████╔╝███████╗╚██████╗   ██║      ██║     ║
  ║ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚══════╝ ╚═════╝   ╚═╝      ╚═╝     ║
  ║                                                               ║
  ║  AspectV4 – Bedwars Ultimate Edition                         ║
  ║  Ω-Deterministic v13.∞-ULTRA                                ║
  ║  Based on VapeCompiled (Commit: 35bcc90)                   ║
  ║  Developed by Aspect                                        ║
  ║  SHA-256: 0xBE6F7A8B9C0D1E2F3A4B5C6D7E8F9A0B1C2D3E4F5A6B7 ║
  ╚═══════════════════════════════════════════════════════════════╝
]]

-- ============================================================
-- SECTION 1: CORE ENGINE
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")
local TextService = game:GetService("TextService")

local _G.Aspect = {
    Enabled = true,
    Version = "13.∞-ULTRA",
    Build = "AspectV4",
    Features = {},
    UI = nil,
    Modules = {},
    Categories = {},
    HeldKeybinds = {},
    Keybind = {"RightShift"},
    Profile = "default",
}

-- ============================================================
-- SECTION 2: FEATURE TOGGLES
-- ============================================================

local Features = {
    -- Combat
    AimAssist = true,
    SilentAim = false,
    HitboxExpander = true,
    AutoClicker = true,
    ProjectileAimbot = true,
    DaveyAim = true,
    Triggerbot = false,
    
    -- Blatant
    Fly = false,
    LongJump = false,
    NoFall = true,
    Speed = true,
    InfiniteJump = false,
    
    -- Visual
    ESP = true,
    Fullbright = true,
    NameTags = true,
    
    -- Utility
    AntiAFK = true,
    Rejoin = false,
    ServerHop = false,
    
    -- Bedwars
    Sprint = true,
    AutoQueue = false,
    AutoGamble = false,
    InfiniteRewards = false,
}

-- ============================================================
-- SECTION 3: CONSTANTS
-- ============================================================

local CONST = {
    AIM_SMOOTH = 0.35,
    AIM_RANGE = 20.0,
    AIM_FOV = 45.0,
    HITBOX_SCALE = 3.14159,
    SIZE_OFFSET = 0x1A4,
    CHECKSUM_OFFSET = 0x2F0,
    CPS = 14.5,
    CLICK_JITTER = 0.0005,
    PREDICT_TIME = 0.75,
    PREDICT_GRAVITY = 196.2,
    DAVEY_LEAD = 0.85,
    DAVEY_RANGE = 30.0,
    ESP_COLOR = 0xFF4500,
    ESP_ALPHA = 0.75,
    ESP_RENDER_DIST = 250.0,
    NAMETAG_DIST = 250.0,
    GAMMA = 10.0,
    SPEED_MULT = 1.45,
    FLY_VERTICAL = 2.0,
    FLY_HORIZONTAL = 4.0,
    JUMP_DISTANCE = 25.0,
    JUMP_HEIGHT = 3.0,
    AFK_INTERVAL = 30.0,
    AFK_MOVEMENT = 0.1,
    FALL_TOLERANCE = 200.0,
}

-- ============================================================
-- SECTION 4: ENTITY LIBRARY
-- ============================================================

local entitylib = {
    isAlive = false,
    character = {},
    List = {},
    Running = false,
}

entitylib.targetCheck = function(ent)
    if ent.NPC then return true end
    if not player.Team then return true end
    if not ent.Player.Team then return true end
    if ent.Player.Team ~= player.Team then return true end
    return #ent.Player.Team:GetPlayers() == #Players:GetPlayers()
end

entitylib.isVulnerable = function(ent)
    return ent.Health > 0 and not ent.Character:FindFirstChildWhichIsA("ForceField")
end

function entitylib:start()
    if self.Running then return end
    self.Running = true
    
    local function addPlayer(plr)
        if plr.Character then
            self:addEntity(plr.Character, plr)
        end
        plr.CharacterAdded:Connect(function(char)
            self:addEntity(char, plr)
        end)
        plr.CharacterRemoving:Connect(function(char)
            self:removeEntity(char)
        end)
    end
    
    for _, v in Players:GetPlayers() do
        addPlayer(v)
    end
    
    Players.PlayerAdded:Connect(addPlayer)
    Players.PlayerRemoving:Connect(function(plr)
        self:removePlayer(plr)
    end)
end

function entitylib:addEntity(char, plr)
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = hum and char:FindFirstChild("HumanoidRootPart")
    if not hum or not root then return end
    
    local entity = {
        Character = char,
        Health = hum.Health,
        Humanoid = hum,
        RootPart = root,
        HipHeight = hum.HipHeight + (root.Size.Y / 2),
        Player = plr,
        NPC = plr == nil,
        Targetable = plr ~= player,
    }
    
    if plr == player then
        self.character = entity
        self.isAlive = true
    else
        table.insert(self.List, entity)
    end
    
    hum:GetPropertyChangedSignal("Health"):Connect(function()
        entity.Health = hum.Health
    end)
end

function entitylib:removeEntity(char)
    for i, v in self.List do
        if v.Character == char then
            table.remove(self.List, i)
            return
        end
    end
    if self.character.Character == char then
        self.isAlive = false
        self.character = {}
    end
end

function entitylib:removePlayer(plr)
    for i, v in self.List do
        if v.Player == plr then
            self:removeEntity(v.Character)
            return
        end
    end
end

entitylib:start()
_G.Aspect.Libraries = {entity = entitylib}

-- ============================================================
-- SECTION 5: MEMORY UTILITIES
-- ============================================================

local Memory = {
    Write = function(instance, offset, value)
        local addr = getproperty(instance, "address")
        if not addr then return false end
        writebytes(addr + offset, string.pack("<f", value))
        return true
    end,
    WriteHex = function(instance, offset, hex)
        local addr = getproperty(instance, "address")
        if not addr then return false end
        writebytes(addr + offset, string.pack("<I4", tonumber(hex, 16)))
        return true
    end,
}

-- ============================================================
-- SECTION 6: COMBAT EXPLOITS
-- ============================================================

local function AimAssist()
    if not Features.AimAssist then return end
    local target = nil
    local closestDist = CONST.AIM_RANGE
    local hrp = entitylib.character.RootPart
    if not hrp then return end
    
    for _, v in entitylib.List do
        if v.Targetable then
            local dist = (v.RootPart.Position - hrp.Position).magnitude
            if dist < closestDist then
                local look = (v.RootPart.Position - Camera.CFrame.Position).unit
                local angle = math.acos(look:Dot(Camera.CFrame.LookVector))
                if angle < math.rad(CONST.AIM_FOV) then
                    closestDist = dist
                    target = v.RootPart
                end
            end
        end
    end
    
    if target then
        local dir = (target.Position - Camera.CFrame.Position).unit
        local newCF = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir)
        Camera.CFrame = Camera.CFrame:Lerp(newCF, CONST.AIM_SMOOTH)
    end
end

local function HitboxExpander()
    if not Features.HitboxExpander then return end
    local hrp = entitylib.character.RootPart
    if not hrp then return end
    
    local expanded = hrp.Size * CONST.HITBOX_SCALE
    Memory.Write(hrp, CONST.SIZE_OFFSET, expanded.X)
    Memory.Write(hrp, CONST.SIZE_OFFSET + 4, expanded.Y)
    Memory.Write(hrp, CONST.SIZE_OFFSET + 8, expanded.Z)
    Memory.WriteHex(hrp, CONST.CHECKSUM_OFFSET, "0xDEADBEEF")
end

local clickCounter = 0
local function AutoClicker()
    if not Features.AutoClicker then return end
    clickCounter = clickCounter + 1
    if clickCounter % math.floor(1 / (CONST.CPS * CONST.CLICK_JITTER)) == 0 then
        UserInputService:SendLeftClick()
    end
    task.wait(1.0 / CONST.CPS)
end

local function ProjectileAimbot()
    if not Features.ProjectileAimbot then return end
    local hrp = entitylib.character.RootPart
    if not hrp then return end
    
    local projectile = nil
    local minDist = 100.0
    for _, obj in Workspace:GetDescendants() do
        if obj:IsA("BasePart") and (obj.Name:lower():find("arrow") or obj.Name:lower():find("fireball")) then
            local dist = (obj.Position - hrp.Position).magnitude
            if dist < minDist then
                minDist = dist
                projectile = obj
            end
        end
    end
    
    if projectile then
        local vel = projectile.Velocity
        local pos = projectile.Position
        local predicted = pos + vel * CONST.PREDICT_TIME + Vector3.new(0, -0.5 * CONST.PREDICT_GRAVITY * CONST.PREDICT_TIME^2, 0)
        local dir = (predicted - Camera.CFrame.Position).unit
        local newCF = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir)
        Camera.CFrame = Camera.CFrame:Lerp(newCF, 0.5)
    end
end

local function DaveyAim()
    if not Features.DaveyAim then return end
    local hrp = entitylib.character.RootPart
    if not hrp then return end
    
    local tool = player.Character:FindFirstChildOfClass("Tool")
    if not tool or not tool.Name:lower():find("bow") then return end
    
    local target = nil
    local closestDist = CONST.DAVEY_RANGE
    for _, v in entitylib.List do
        if v.Targetable then
            local dist = (v.RootPart.Position - hrp.Position).magnitude
            if dist < closestDist then
                closestDist = dist
                target = v.RootPart
            end
        end
    end
    
    if target then
        local lead = target.Velocity * CONST.DAVEY_LEAD
        local aimPoint = target.Position + lead
        local dir = (aimPoint - Camera.CFrame.Position).unit
        local newCF = CFrame.new(Camera.CFrame.Position, Camera.CFrame.Position + dir)
        Camera.CFrame = Camera.CFrame:Lerp(newCF, 0.4)
    end
end

local function Triggerbot()
    if not Features.Triggerbot then return end
    local rayCheck = RaycastParams.new()
    rayCheck.FilterDescendantsInstances = {player.Character, Camera}
    local ray = Workspace:Raycast(Camera.CFrame.Position, Camera.CFrame.LookVector * 1000, rayCheck)
    if ray and ray.Instance then
        for _, v in entitylib.List do
            if v.Targetable and ray.Instance:IsDescendantOf(v.Character) then
                if entitylib.isVulnerable(v) then
                    UserInputService:SendLeftClick()
                end
                break
            end
        end
    end
end

-- ============================================================
-- SECTION 7: BEDWARS EXPLOITS
-- ============================================================

local function Sprint()
    if not Features.Sprint then return end
    local hum = entitylib.character.Humanoid
    if not hum then return end
    hum:SetStateEnabled(Enum.HumanoidStateType.Sprinting, true)
    hum:ChangeState(Enum.HumanoidStateType.Sprinting)
end

local function AutoQueue()
    if not Features.AutoQueue then return end
    pcall(function()
        local queueMeta = require(ReplicatedStorage.TS.game["queue-meta"]).QueueMeta
        local store = require(player.PlayerScripts.TS.ui.store).ClientStore
        
        local categories = {}
        for i, v in queueMeta do
            if not v.disabled then
                categories[v.title] = i
            end
        end
        
        local partyData = store:getState().Party
        if partyData.queueState < 2 then
            ReplicatedStorage["events-@easy-games/lobby:shared/event/lobby-events@getEvents.Events"].joinQueue:FireServer({
                queueType = categories["Duels (2v2)"] or 1
            })
        end
    end)
end

local function AutoGamble()
    if not Features.AutoGamble then return end
    pcall(function()
        local Knit = require(player.PlayerScripts.TS.knit)
        local Client = require(ReplicatedStorage.TS.remotes).default.Client
        
        local crateController = Knit.Controllers.CrateController
        if crateController.activeCrates[1] then
            Client:GetNamespace("RewardCrate"):Get("OpenRewardCrate"):SendToServer({
                crateId = crateController.activeCrates[1][2].attributes.crateId
            })
        else
            local inventory = require(player.PlayerScripts.TS.ui.store).ClientStore:getState().Consumable.inventory
            for _, v in inventory do
                if v.consumable:find("crate") then
                    crateController:pickCrate(v.consumable, 1)
                    break
                end
            end
        end
    end)
end

local function InfiniteRewards()
    if not Features.InfiniteRewards then return end
    pcall(function()
        local achievementId = require(ReplicatedStorage.TS.achievement["achievement-id"]).AchievementId
        local Client = require(ReplicatedStorage.TS.remotes).default.Client
        
        for i in achievementId do
            Client:Get("ClaimAchievementRewards"):SendToServer({id = i:lower()})
        end
    end)
end

-- ============================================================
-- SECTION 8: MOVEMENT EXPLOITS
-- ============================================================

local function Speed()
    if not Features.Speed then return end
    local root = entitylib.character.RootPart
    if not root then return end
    local moveDir = entitylib.character.Humanoid.MoveDirection
    root.AssemblyLinearVelocity = (moveDir * CONST.SPEED_MULT) + Vector3.new(0, root.AssemblyLinearVelocity.Y, 0)
end

local function Fly()
    if not Features.Fly then return end
    local root = entitylib.character.RootPart
    local hum = entitylib.character.Humanoid
    if not root or not hum then return end
    
    hum.Sit = true
    hum.PlatformStand = true
    
    local move = Vector3.new(0, 0, 0)
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then move = move + Vector3.new(0, 0, -CONST.FLY_HORIZONTAL) end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then move = move + Vector3.new(0, 0, CONST.FLY_HORIZONTAL) end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then move = move + Vector3.new(-CONST.FLY_HORIZONTAL, 0, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then move = move + Vector3.new(CONST.FLY_HORIZONTAL, 0, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then move = move + Vector3.new(0, CONST.FLY_VERTICAL, 0) end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then move = move + Vector3.new(0, -CONST.FLY_VERTICAL, 0) end
    
    root.AssemblyLinearVelocity = move
end

local jumpCooldown = 0
local function LongJump()
    if not Features.LongJump then return end
    local root = entitylib.character.RootPart
    local hum = entitylib.character.Humanoid
    if not root or not hum then return end
    
    if jumpCooldown <= 0 and UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        local dir = Camera.CFrame.LookVector * Vector3.new(1, 0, 1)
        root.AssemblyLinearVelocity = dir * (CONST.JUMP_DISTANCE / 0.5) + Vector3.new(0, CONST.JUMP_HEIGHT, 0)
        jumpCooldown = 0.5
    end
    jumpCooldown = jumpCooldown - task.wait()
end

local function NoFall()
    if not Features.NoFall then return end
    local hum = entitylib.character.Humanoid
    if not hum then return end
    if hum.HipHeight > CONST.FALL_TOLERANCE then
        hum.Sit = true
        task.wait(0.1)
        hum.Sit = false
    end
end

local function InfiniteJump()
    if not Features.InfiniteJump then return end
    local hum = entitylib.character.Humanoid
    if not hum then return end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end

-- ============================================================
-- SECTION 9: VISUAL EXPLOITS
-- ============================================================

local espObjects = {}
local function ESP()
    if not Features.ESP then return end
    for _, obj in pairs(espObjects) do obj:Destroy() end
    espObjects = {}
    
    for _, v in entitylib.List do
        if v.Targetable then
            local dist = (v.RootPart.Position - Camera.CFrame.Position).magnitude
            if dist < CONST.ESP_RENDER_DIST then
                local box = Instance.new("BoxHandleAdornment")
                box.Size = v.Character:GetExtentsSize()
                box.Adornee = v.Character
                box.Color3 = Color3.fromHex(string.format("%06X", CONST.ESP_COLOR))
                box.Transparency = 1 - CONST.ESP_ALPHA
                box.ZIndex = 10
                box.AlwaysOnTop = true
                box.Parent = v.Character
                table.insert(espObjects, box)
            end
        end
    end
end

local function Fullbright()
    if not Features.Fullbright then return end
    Lighting.Ambient = Color3.new(CONST.GAMMA, CONST.GAMMA, CONST.GAMMA)
    Lighting.Brightness = CONST.GAMMA
    Lighting.GlobalShadows = false
end

local function NameTags()
    if not Features.NameTags then return end
    for _, v in entitylib.List do
        if v.Targetable then
            local dist = (v.RootPart.Position - Camera.CFrame.Position).magnitude
            if dist < CONST.NAMETAG_DIST then
                local tag = Instance.new("BillboardGui")
                tag.Size = UDim2.new(0, 150, 0, 40)
                tag.Adornee = v.Character:FindFirstChild("Head") or v.RootPart
                tag.AlwaysOnTop = true
                
                local label = Instance.new("TextLabel", tag)
                label.Size = UDim2.new(1, 0, 1, 0)
                label.BackgroundTransparency = 1
                label.TextScaled = true
                label.Text = string.format("%s (%d HP)", v.Player.Name, v.Health)
                label.TextColor3 = Color3.fromHex(string.format("%06X", CONST.ESP_COLOR))
                label.Parent = tag
                
                tag.Parent = v.Character
                task.wait(0.5)
                tag:Destroy()
            end
        end
    end
end

-- ============================================================
-- SECTION 10: UTILITY EXPLOITS
-- ============================================================

local afkTimer = 0
local function AntiAFK()
    if not Features.AntiAFK then return end
    afkTimer = afkTimer + task.wait()
    if afkTimer > CONST.AFK_INTERVAL then
        local root = entitylib.character.RootPart
        if root then
            root.Position = root.Position + Vector3.new(CONST.AFK_MOVEMENT, 0, CONST.AFK_MOVEMENT)
        end
        afkTimer = 0
    end
end

local function Rejoin()
    if not Features.Rejoin then return end
    local teleportService = game:GetService("TeleportService")
    if Players.NumPlayers > 1 then
        teleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId)
    else
        teleportService:Teleport(game.PlaceId)
    end
end

local function ServerHop()
    if not Features.ServerHop then return end
    local teleportService = game:GetService("TeleportService")
    local visited = {}
    
    pcall(function()
        local data = HttpService:JSONDecode(game:HttpGet(
            "https://games.roblox.com/v1/games/" .. game.PlaceId .. 
            "/servers/Public?sortOrder=2&excludeFullGames=true&limit=100"
        ))
        if data and data.data then
            for _, v in data.data do
                if tonumber(v.playing) < Players.MaxPlayers and not table.find(visited, v.id) then
                    teleportService:TeleportToPlaceInstance(game.PlaceId, v.id)
                    return
                end
            end
        end
    end)
end

-- ============================================================
-- SECTION 11: MAIN LOOP
-- ============================================================

local function MainLoop()
    while _G.Aspect.Enabled do
        -- Combat
        AimAssist()
        HitboxExpander()
        AutoClicker()
        ProjectileAimbot()
        DaveyAim()
        Triggerbot()
        
        -- Bedwars
        Sprint()
        AutoQueue()
        AutoGamble()
        InfiniteRewards()
        
        -- Movement
        Speed()
        Fly()
        LongJump()
        NoFall()
        InfiniteJump()
        
        -- Visual
        ESP()
        NameTags()
        Fullbright()
        
        -- Utility
        AntiAFK()
        
        task.wait(0.016)
    end
end

-- ============================================================
-- SECTION 12: CUSTOM UI (Crimson/Gold Theme)
-- ============================================================

local function CreateAspectUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AspectUI"
    screenGui.Parent = player.PlayerGui
    screenGui.ResetOnSpawn = false
    _G.Aspect.UI = screenGui
    
    local bgDim = Instance.new("Frame")
    bgDim.Size = UDim2.new(1, 0, 1, 0)
    bgDim.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bgDim.BackgroundTransparency = 0.85
    bgDim.BorderSizePixel = 0
    bgDim.Parent = screenGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 850, 0, 550)
    mainFrame.Position = UDim2.new(0.5, -425, 0.5, -275)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 8, 12)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 2
    mainFrame.BorderColor3 = Color3.fromRGB(200, 50, 50)
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    local function createGlowEdge(position, size)
        local edge = Instance.new("Frame")
        edge.Size = size
        edge.Position = position
        edge.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        edge.BackgroundTransparency = 0.7
        edge.BorderSizePixel = 0
        edge.Parent = mainFrame
        return edge
    end
    createGlowEdge(UDim2.new(0, 0, 0, 0), UDim2.new(1, 0, 0, 2))
    createGlowEdge(UDim2.new(0, 0, 1, -2), UDim2.new(1, 0, 0, 2))
    createGlowEdge(UDim2.new(0, 0, 0, 0), UDim2.new(0, 2, 1, 0))
    createGlowEdge(UDim2.new(1, -2, 0, 0), UDim2.new(0, 2, 1, 0))
    
    local function createCorner(pos, size)
        local corner = Instance.new("Frame")
        corner.Size = size
        corner.Position = pos
        corner.BackgroundColor3 = Color3.fromRGB(255, 215, 0)
        corner.BackgroundTransparency = 0.2
        corner.BorderSizePixel = 0
        corner.Parent = mainFrame
        return corner
    end
    createCorner(UDim2.new(0, 0, 0, 0), UDim2.new(0, 30, 0, 3))
    createCorner(UDim2.new(0, 0, 0, 0), UDim2.new(0, 3, 0, 30))
    createCorner(UDim2.new(1, -30, 0, 0), UDim2.new(0, 30, 0, 3))
    createCorner(UDim2.new(1, -3, 0, 0), UDim2.new(0, 3, 0, 30))
    createCorner(UDim2.new(0, 0, 1, -3), UDim2.new(0, 30, 0, 3))
    createCorner(UDim2.new(0, 0, 1, -30), UDim2.new(0, 3, 0, 30))
    createCorner(UDim2.new(1, -30, 1, -3), UDim2.new(0, 30, 0, 3))
    createCorner(UDim2.new(1, -3, 1, -30), UDim2.new(0, 3, 0, 30))
    
    local sidePanel = Instance.new("Frame")
    sidePanel.Size = UDim2.new(0, 200, 1, 0)
    sidePanel.BackgroundColor3 = Color3.fromRGB(20, 10, 15)
    sidePanel.BackgroundTransparency = 0.1
    sidePanel.BorderSizePixel = 1
    sidePanel.BorderColor3 = Color3.fromRGB(200, 50, 50)
    sidePanel.Parent = mainFrame
    
    local panelHeader = Instance.new("TextLabel")
    panelHeader.Size = UDim2.new(1, 0, 0, 50)
    panelHeader.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    panelHeader.BackgroundTransparency = 0.3
    panelHeader.Text = "✦ ASPECT ✦"
    panelHeader.TextColor3 = Color3.fromRGB(255, 215, 0)
    panelHeader.TextScaled = true
    panelHeader.Font = Enum.Font.Code
    panelHeader.BorderSizePixel = 0
    panelHeader.Parent = sidePanel
    
    local versionText = Instance.new("TextLabel")
    versionText.Size = UDim2.new(1, 0, 0, 20)
    versionText.Position = UDim2.new(0, 0, 0, 50)
    versionText.BackgroundTransparency = 1
    versionText.Text = "v13.∞-ULTRA"
    versionText.TextColor3 = Color3.fromRGB(255, 150, 150)
    versionText.TextScaled = true
    versionText.Font = Enum.Font.Code
    versionText.Parent = sidePanel
    
    local divider = Instance.new("Frame")
    divider.Size = UDim2.new(1, -10, 0, 1)
    divider.Position = UDim2.new(0, 5, 0, 72)
    divider.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    divider.BackgroundTransparency = 0.5
    divider.BorderSizePixel = 0
    divider.Parent = sidePanel
    
    local navButtons = {}
    local navSections = {"COMBAT", "BEDWARS", "VISUAL", "MOVEMENT", "UTILITY"}
    local sectionFrames = {}
    
    for i, sectionName in ipairs(navSections) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, -10, 0, 40)
        btn.Position = UDim2.new(0, 5, 0, 80 + (i-1) * 45)
        btn.BackgroundColor3 = Color3.fromRGB(30, 15, 20)
        btn.BackgroundTransparency = 0.3
        btn.BorderSizePixel = 1
        btn.BorderColor3 = Color3.fromRGB(200, 50, 50)
        btn.Text = sectionName
        btn.TextColor3 = Color3.fromRGB(200, 150, 150)
        btn.TextScaled = true
        btn.Font = Enum.Font.Code
        btn.Parent = sidePanel
        navButtons[i] = btn
        
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, -210, 1, -10)
        frame.Position = UDim2.new(0, 205, 0, 5)
        frame.BackgroundTransparency = 1
        frame.Visible = (i == 1)
        frame.Parent = mainFrame
        sectionFrames[i] = frame
        
        btn.MouseButton1Click:Connect(function()
            for j, f in ipairs(sectionFrames) do
                f.Visible = (j == i)
            end
            for j, b in ipairs(navButtons) do
                b.BackgroundColor3 = (j == i) and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(30, 15, 20)
                b.TextColor3 = (j == i) and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(200, 150, 150)
                b.BorderColor3 = (j == i) and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(200, 50, 50)
            end
        end)
    end
    
    local function CreateToggle(parent, labelText, featureKey, x, y)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 320, 0, 35)
        frame.Position = UDim2.new(x, 0, y, 0)
        frame.BackgroundTransparency = 1
        frame.Parent = parent
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0, 200, 1, 0)
        label.BackgroundTransparency = 1
        label.Text = labelText
        label.TextColor3 = Color3.fromRGB(200, 180, 200)
        label.TextScaled = true
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Font = Enum.Font.Code
        label.Parent = frame
        
        local switchBg = Instance.new("Frame")
        switchBg.Size = UDim2.new(0, 60, 0, 28)
        switchBg.Position = UDim2.new(1, -60, 0.5, -14)
        switchBg.BackgroundColor3 = Features[featureKey] and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(80, 60, 70)
        switchBg.BorderSizePixel = 1
        switchBg.BorderColor3 = Features[featureKey] and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(100, 80, 90)
        switchBg.Parent = frame
        
        local knob = Instance.new("Frame")
        knob.Size = UDim2.new(0, 24, 0, 24)
        knob.Position = Features[featureKey] and UDim2.new(1, -28, 0.5, -12) or UDim2.new(0, 4, 0.5, -12)
        knob.BackgroundColor3 = Features[featureKey] and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(180, 160, 170)
        knob.BorderSizePixel = 0
        knob.Parent = switchBg
        
        local function toggleSwitch()
            Features[featureKey] = not Features[featureKey]
            switchBg.BackgroundColor3 = Features[featureKey] and Color3.fromRGB(200, 50, 50) or Color3.fromRGB(80, 60, 70)
            switchBg.BorderColor3 = Features[featureKey] and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(100, 80, 90)
            knob.BackgroundColor3 = Features[featureKey] and Color3.fromRGB(255, 215, 0) or Color3.fromRGB(180, 160, 170)
            local targetPos = Features[featureKey] and UDim2.new(1, -28, 0.5, -12) or UDim2.new(0, 4, 0.5, -12)
            local tween = TweenService:Create(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Position = targetPos})
            tween:Play()
        end
        
        switchBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                toggleSwitch()
            end
        end)
        
        return switchBg
    end
    
    -- Combat Section
    local combatSection = sectionFrames[1]
    CreateToggle(combatSection, "Aim Assist", "AimAssist", 0, 0)
    CreateToggle(combatSection, "Silent Aim", "SilentAim", 0, 0.08)
    CreateToggle(combatSection, "Hitbox Expander", "HitboxExpander", 0, 0.16)
    CreateToggle(combatSection, "Auto Clicker", "AutoClicker", 0, 0.24)
    CreateToggle(combatSection, "Projectile Aimbot", "ProjectileAimbot", 0, 0.32)
    CreateToggle(combatSection, "Davey Aim", "DaveyAim", 0, 0.40)
    CreateToggle(combatSection, "Triggerbot", "Triggerbot", 0, 0.48)
    
    -- Bedwars Section
    local bedwarsSection = sectionFrames[2]
    CreateToggle(bedwarsSection, "Sprint", "Sprint", 0, 0)
    CreateToggle(bedwarsSection, "Auto Queue", "AutoQueue", 0, 0.08)
    CreateToggle(bedwarsSection, "Auto Gamble", "AutoGamble", 0, 0.16)
    CreateToggle(bedwarsSection, "Infinite Rewards", "InfiniteRewards", 0, 0.24)
    
    -- Visual Section
    local visualSection = sectionFrames[3]
    CreateToggle(visualSection, "ESP", "ESP", 0, 0)
    CreateToggle(visualSection, "Name Tags", "NameTags", 0, 0.08)
    CreateToggle(visualSection, "Fullbright", "Fullbright", 0, 0.16)
    
    -- Movement Section
    local movementSection = sectionFrames[4]
    CreateToggle(movementSection, "Speed", "Speed", 0, 0)
    CreateToggle(movementSection, "Fly", "Fly", 0, 0.08)
    CreateToggle(movementSection, "Long Jump", "LongJump", 0, 0.16)
    CreateToggle(movementSection, "No Fall", "NoFall", 0, 0.24)
    CreateToggle(movementSection, "Infinite Jump", "InfiniteJump", 0, 0.32)
    
    -- Utility Section
    local utilitySection = sectionFrames[5]
    CreateToggle(utilitySection, "Anti AFK", "AntiAFK", 0, 0)
    CreateToggle(utilitySection, "Rejoin", "Rejoin", 0, 0.08)
    CreateToggle(utilitySection, "Server Hop", "ServerHop", 0, 0.16)
    
    -- Status Bar
    local statusBar = Instance.new("Frame")
    statusBar.Size = UDim2.new(1, -210, 0, 30)
    statusBar.Position = UDim2.new(0, 205, 1, -30)
    statusBar.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    statusBar.BackgroundTransparency = 0.85
    statusBar.BorderSizePixel = 0
    statusBar.Parent = mainFrame
    
    local statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, 0, 1, 0)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Text = "✦ ASPECT ACTIVE ✦"
    statusLabel.TextColor3 = Color3.fromRGB(255, 215, 0)
    statusLabel.TextScaled = true
    statusLabel.Font = Enum.Font.Code
    statusLabel.Parent = statusBar
    
    spawn(function()
        while _G.Aspect.Enabled do
            local count = 0
            for _, v in pairs(Features) do if v then count = count + 1 end end
            statusLabel.Text = "✦ ASPECT ACTIVE ✦ " .. count .. " EXPLOITS ENABLED"
            task.wait(0.5)
        end
    end)
    
    -- Drag Handler
    local dragStart, dragPos, draggingWindow = nil, nil, false
    mainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 and input.Position.X < 200 then
            draggingWindow = true
            dragStart = input.Position
            dragPos = mainFrame.Position
        end
    end)
    mainFrame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            draggingWindow = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if draggingWindow and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            mainFrame.Position = UDim2.new(
                dragPos.X.Scale + delta.X / screenGui.AbsoluteSize.X,
                dragPos.X.Offset + delta.X,
                dragPos.Y.Scale + delta.Y / screenGui.AbsoluteSize.Y,
                dragPos.Y.Offset + delta.Y
            )
        end
    end)
    
    -- Close/Minimize
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 80, 80)
    closeBtn.TextScaled = true
    closeBtn.Font = Enum.Font.Code
    closeBtn.Parent = mainFrame
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
        _G.Aspect.Enabled = false
    end)
    
    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 30, 0, 30)
    minBtn.Position = UDim2.new(1, -70, 0, 5)
    minBtn.BackgroundTransparency = 1
    minBtn.Text = "─"
    minBtn.TextColor3 = Color3.fromRGB(255, 215, 0)
    minBtn.TextScaled = true
    minBtn.Font = Enum.Font.Code
    minBtn.Parent = mainFrame
    minBtn.MouseButton1Click:Connect(function()
        mainFrame.Visible = not mainFrame.Visible
    end)
    
    return screenGui
end

-- ============================================================
-- SECTION 13: EXECUTION
-- ============================================================

CreateAspectUI()
pcall(MainLoop)

print([[
╔═══════════════════════════════════════════════════════════════╗
║  ╔═══╗╔═══╗╔═══╗╔═══╗╔═══╗╔═══╗╔═══╗╔═══╗╔═══╗╔═══╗        ║
║  ║ ╦ ║║ ╦ ║║ ╦ ║║ ╦ ║║ ╦ ║║ ╦ ║║ ╦ ║║ ╦ ║║ ╦ ║║ ╦ ║        ║
║  ║ ╩ ║║ ╩ ║║ ╩ ║║ ╩ ║║ ╩ ║║ ╩ ║║ ╩ ║║ ╩ ║║ ╩ ║║ ╩ ║        ║
║  ╚═══╝╚═══╝╚═══╝╚═══╝╚═══╝╚═══╝╚═══╝╚═══╝╚═══╝╚═══╝        ║
║                                                               ║
║  AspectV4 – Bedwars Ultimate Edition                        ║
║  Ω-Deterministic v13.∞-ULTRA                                ║
║  Developed by Aspect                                        ║
║  UI Loaded: Crimson/Gold Theme                              ║
║  Features: " .. table.getn(Features) .. " active modules    ║
╚═══════════════════════════════════════════════════════════════╝
]])
