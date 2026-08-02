-- ASPECTV4 | MAIN UI
-- Press INSERT to toggle

local Core = _G.Aspect
local Theme = _G.AspectTheme

local UI = {
    ScreenGui = nil,
    MainFrame = nil,
    Enabled = false,
    Tabs = {},
    CurrentTab = 1
}

-- Create UI
local function createUI()
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    screenGui.Name = "AspectV4"
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 500, 0, 600)
    mainFrame.Position = UDim2.new(0.5, -250, 0.5, -300)
    mainFrame.BackgroundColor3 = Theme.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    mainFrame.Visible = false
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundColor3 = Theme.BackgroundDark
    title.BorderSizePixel = 0
    title.Text = "ASPECTV4 | 74 Exploits"
    title.TextColor3 = Theme.Primary
    title.TextSize = 20
    title.Font = Enum.Font.GothamBold
    title.Parent = mainFrame
    
    -- Tab buttons
    local tabs = {"Combat", "Blatant", "Render", "Utility", "World", "Bedwars", "Minigames", "Legit"}
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(1, 0, 0, 30)
    tabContainer.Position = UDim2.new(0, 0, 0, 40)
    tabContainer.BackgroundColor3 = Theme.BackgroundDark
    tabContainer.BorderSizePixel = 0
    tabContainer.Parent = mainFrame
    
    local tabButtons = {}
    for i, name in ipairs(tabs) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 60, 1, 0)
        btn.Position = UDim2.new(0, (i-1) * 62, 0, 0)
        btn.BackgroundColor3 = Theme.Background
        btn.BorderSizePixel = 0
        btn.Text = name
        btn.TextColor3 = Theme.Text
        btn.TextSize = 12
        btn.Font = Enum.Font.GothamMedium
        btn.Parent = tabContainer
        btn.Name = "Tab" .. i
        
        btn.MouseButton1Click:Connect(function()
            UI.CurrentTab = i
            for _, b in ipairs(tabButtons) do
                b.BackgroundColor3 = Theme.Background
            end
            btn.BackgroundColor3 = Theme.Primary
            -- Update content
            updateContent(i)
        end)
        
        table.insert(tabButtons, btn)
    end
    
    -- Content frame
    local content = Instance.new("ScrollingFrame")
    content.Size = UDim2.new(1, -20, 1, -80)
    content.Position = UDim2.new(0, 10, 0, 75)
    content.BackgroundColor3 = Theme.BackgroundDark
    content.BorderSizePixel = 0
    content.Parent = mainFrame
    content.CanvasSize = UDim2.new(0, 0, 0, 0)
    content.ScrollBarThickness = 8
    
    -- Close button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 0, 30)
    closeBtn.Position = UDim2.new(1, -35, 0, 5)
    closeBtn.BackgroundColor3 = Theme.Error
    closeBtn.BorderSizePixel = 0
    closeBtn.Text = "X"
    closeBtn.TextColor3 = Theme.Text
    closeBtn.TextSize = 16
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.Parent = mainFrame
    
    closeBtn.MouseButton1Click:Connect(function()
        UI.Enabled = false
        mainFrame.Visible = false
    end)
    
    -- Panic button
    local panicBtn = Instance.new("TextButton")
    panicBtn.Size = UDim2.new(0, 80, 0, 30)
    panicBtn.Position = UDim2.new(0, 10, 0, 5)
    panicBtn.BackgroundColor3 = Theme.Error
    panicBtn.BorderSizePixel = 0
    panicBtn.Text = "PANIC"
    panicBtn.TextColor3 = Theme.Text
    panicBtn.TextSize = 14
    panicBtn.Font = Enum.Font.GothamBold
    panicBtn.Parent = mainFrame
    
    panicBtn.MouseButton1Click:Connect(function()
        Core.Panic()
        -- Update UI
        updateContent(UI.CurrentTab)
    end)
    
    UI.ScreenGui = screenGui
    UI.MainFrame = mainFrame
    UI.Content = content
    
    -- Populate content
    local function populateContent(tabIndex)
        -- Clear content
        for _, child in ipairs(content:GetChildren()) do
            child:Destroy()
        end
        
        local exploits = {}
        if tabIndex == 1 then
            exploits = {1,2,3,4,5,6,7,8}
        elseif tabIndex == 2 then
            exploits = {9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25}
        elseif tabIndex == 3 then
            exploits = {26,27,28,29,30,31,32,33}
        elseif tabIndex == 4 then
            exploits = {34,35,36,37,38,39,40,41,42,43,44}
        elseif tabIndex == 5 then
            exploits = {45,46,47,48,49,50,51,52}
        elseif tabIndex == 6 then
            exploits = {53,54,55,56}
        elseif tabIndex == 7 then
            exploits = {57}
        elseif tabIndex == 8 then
            exploits = {58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74}
        end
        
        local y = 0
        for _, id in ipairs(exploits) do
            local exploit = Core.Exploits[id]
            if exploit then
                -- Exploit row
                local row = Instance.new("Frame")
                row.Size = UDim2.new(1, 0, 0, 35)
                row.Position = UDim2.new(0, 0, 0, y)
                row.BackgroundColor3 = Theme.Background
                row.BorderSizePixel = 0
                row.Parent = content
                
                -- Toggle button
                local toggle = Instance.new("TextButton")
                toggle.Size = UDim2.new(0, 60, 1, -4)
                toggle.Position = UDim2.new(1, -65, 0, 2)
                toggle.BackgroundColor3 = Core.Enabled[id] and Theme.Success or Theme.Error
                toggle.BorderSizePixel = 0
                toggle.Text = Core.Enabled[id] and "ON" or "OFF"
                toggle.TextColor3 = Theme.Text
                toggle.TextSize = 12
                toggle.Font = Enum.Font.GothamBold
                toggle.Parent = row
                
                toggle.MouseButton1Click:Connect(function()
                    Core.ToggleExploit(id)
                    toggle.BackgroundColor3 = Core.Enabled[id] and Theme.Success or Theme.Error
                    toggle.Text = Core.Enabled[id] and "ON" or "OFF"
                end)
                
                -- Name
                local name = Instance.new("TextLabel")
                name.Size = UDim2.new(1, -70, 1, 0)
                name.Position = UDim2.new(0, 5, 0, 0)
                name.BackgroundTransparency = 1
                name.Text = id .. ". " .. exploit.name
                name.TextColor3 = Theme.Text
                name.TextSize = 13
                name.TextXAlignment = Enum.TextXAlignment.Left
                name.Font = Enum.Font.Gotham
                name.Parent = row
                
                y = y + 40
            end
        end
        
        content.CanvasSize = UDim2.new(0, 0, 0, y + 10)
    end
    
    updateContent = populateContent
    
    -- Default to combat tab
    tabButtons[1].BackgroundColor3 = Theme.Primary
    populateContent(1)
    
    return screenGui, mainFrame
end

-- Toggle UI
local function toggleUI()
    if not UI.ScreenGui then
        createUI()
    end
    
    UI.Enabled = not UI.Enabled
    UI.MainFrame.Visible = UI.Enabled
end

-- Keybind: INSERT
game:GetService("UserInputService").InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        toggleUI()
    end
    if input.KeyCode == Enum.KeyCode.End then
        Core.Panic()
    end
end)

print("[ASPECTV4] UI loaded. Press INSERT to open menu.")
print("[ASPECTV4] Press END for panic.")

return UI
