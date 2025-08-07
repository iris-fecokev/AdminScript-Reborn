local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local ContextActionService = game:GetService("ContextActionService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "IRIS_FECOKEV_WinXP_GUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Конфигурация
local ANIMATION_STEPS = 8
local ANIMATION_STEP_DELAY = 0.01
local BUNDLE_ID = 198755078324875
local FLY_ANIMATION_ID = 93954221593805

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 500)
mainFrame.Position = UDim2.new(0.5, -200, 0.5, -250)
mainFrame.BackgroundColor3 = Color3.fromRGB(212, 208, 200)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = gui

-- Заголовок окна
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 24)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 14, 122)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -60, 1, 0)
titleLabel.Position = UDim2.new(0, 5, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "AdminScript Reborn by IRIS_FECOKEV"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 14
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Кнопки управления окном
local minimizeBtn = Instance.new("ImageButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 22, 0, 22)
minimizeBtn.Position = UDim2.new(1, -50, 0, 1)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Image = "rbxassetid://100060328280272"
minimizeBtn.Parent = titleBar

local closeBtn = Instance.new("ImageButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -25, 0, 1)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = "rbxassetid://111156260096414"
closeBtn.Parent = titleBar

-- Панель вкладок
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 24)
tabBar.Position = UDim2.new(0, 0, 0, 24)
tabBar.BackgroundColor3 = Color3.fromRGB(192, 192, 192)
tabBar.BorderSizePixel = 0
tabBar.Parent = mainFrame

local function createTabButton(name, posX)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 80, 0, 22)
    btn.Position = UDim2.new(0, posX, 0, 0)
    btn.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
    btn.BorderColor3 = Color3.new(0, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 14
    btn.Parent = tabBar
    return btn
end

local mainTab = createTabButton("Основные", 5)
local playerTab = createTabButton("Игроки", 90)
local settingsTab = createTabButton("Настройки", 175)

-- Контейнеры для вкладок
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -10, 1, -58)
tabContainer.Position = UDim2.new(0, 5, 0, 53)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

local mainContent = Instance.new("ScrollingFrame")
mainContent.Size = UDim2.new(1, 0, 1, 0)
mainContent.BackgroundTransparency = 1
mainContent.ScrollBarThickness = 8
mainContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
mainContent.Visible = true
mainContent.Parent = tabContainer

local playerContent = Instance.new("ScrollingFrame")
playerContent.Size = UDim2.new(1, 0, 1, 0)
playerContent.BackgroundTransparency = 1
playerContent.ScrollBarThickness = 8
playerContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
playerContent.Visible = false
playerContent.Parent = tabContainer

local settingsContent = Instance.new("ScrollingFrame")
settingsContent.Size = UDim2.new(1, 0, 1, 0)
settingsContent.BackgroundTransparency = 1
settingsContent.ScrollBarThickness = 8
settingsContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
settingsContent.Visible = false
settingsContent.Parent = tabContainer

-- Вкладка восстановления
local restoreTab = Instance.new("Frame")
restoreTab.Size = UDim2.new(0, 120, 0, 25)
restoreTab.Position = UDim2.new(0.5, -60, 1, -30)
restoreTab.BackgroundColor3 = Color3.fromRGB(0, 14, 122)
restoreTab.BorderSizePixel = 0
restoreTab.Visible = false
restoreTab.Parent = gui

local tabLabel = Instance.new("TextLabel")
tabLabel.Size = UDim2.new(1, 0, 1, 0)
tabLabel.Text = "Открыть панель"
tabLabel.BackgroundTransparency = 1
tabLabel.TextColor3 = Color3.new(1, 1, 1)
tabLabel.Font = Enum.Font.SourceSansBold
tabLabel.TextSize = 14
tabLabel.Parent = restoreTab

-- Стилизация кнопок
local function createButton(name, sizeY)
    local btnFrame = Instance.new("Frame")
    btnFrame.Size = UDim2.new(1, 0, 0, sizeY or 40)
    btnFrame.BackgroundTransparency = 1
    
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0.8, 0)
    btn.Position = UDim2.new(0, 5, 0.1, 0)
    btn.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
    btn.BorderColor3 = Color3.new(0, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.AutoButtonColor = false
    
    local highlight = Instance.new("Frame")
    highlight.Size = UDim2.new(1, 0, 1, 0)
    highlight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    highlight.BackgroundTransparency = 0.8
    highlight.BorderSizePixel = 0
    highlight.Visible = false
    highlight.Parent = btn
    
    btn.MouseEnter:Connect(function()
        highlight.Visible = true
    end)
    
    btn.MouseLeave:Connect(function()
        highlight.Visible = false
    end)
    
    btn.Parent = btnFrame
    return btnFrame, btn
end

-- Система полёта
local flying = false
local flySpeed = 50
local flyAnimation = nil
local flyAnimTrack = nil

local function startFlying()
    if flying then return end
    local character = player.Character
    if not character then return end
    
    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end
    
    -- Загрузка анимации полёта
    if not flyAnimation then
        flyAnimation = Instance.new("Animation")
        flyAnimation.AnimationId = "rbxassetid://" .. FLY_ANIMATION_ID
    end
    
    -- Воспроизведение анимации
    flyAnimTrack = humanoid:LoadAnimation(flyAnimation)
    flyAnimTrack:Play()
    
    flying = true
    
    -- Отключение гравитации и коллизий
    rootPart.Gravity = 0
    for _, part in ipairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.CanCollide = false
        end
    end
    
    local camera = workspace.CurrentCamera
    local keys = {
        [Enum.KeyCode.W] = false,
        [Enum.KeyCode.A] = false,
        [Enum.KeyCode.S] = false,
        [Enum.KeyCode.D] = false,
        [Enum.KeyCode.Space] = false,
        [Enum.KeyCode.LeftShift] = false
    }
    
    -- Обработка ввода
    local function handleInput(action, state, input)
        if keys[input.KeyCode] ~= nil then
            keys[input.KeyCode] = state == Enum.UserInputState.Begin
        end
        return Enum.ContextActionResult.Sink
    end
    
    ContextActionService:BindAction("FlyControl", handleInput, false,
        Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
        Enum.KeyCode.Space, Enum.KeyCode.LeftShift)
    
    -- Основной цикл полёта
    local flyConnection
    flyConnection = RunService.Heartbeat:Connect(function(dt)
        if not flying or not character:FindFirstChild("HumanoidRootPart") then
            flyConnection:Disconnect()
            return
        end
        
        -- Рассчитываем направление движения
        local moveVector = Vector3.new()
        if keys[Enum.KeyCode.W] then moveVector += camera.CFrame.LookVector end
        if keys[Enum.KeyCode.S] then moveVector -= camera.CFrame.LookVector end
        if keys[Enum.KeyCode.D] then moveVector += camera.CFrame.RightVector end
        if keys[Enum.KeyCode.A] then moveVector -= camera.CFrame.RightVector end
        if keys[Enum.KeyCode.Space] then moveVector += Vector3.new(0, 1, 0) end
        if keys[Enum.KeyCode.LeftShift] then moveVector -= Vector3.new(0, 1, 0) end
        
        -- Нормализуем вектор и применяем скорость
        if moveVector.Magnitude > 0 then
            moveVector = moveVector.Unit * flySpeed
        end
        
        -- Обновляем позицию через CFrame
        rootPart.CFrame = rootPart.CFrame + moveVector * dt
    end)
end

local function stopFlying()
    if not flying then return end
    flying = false
    
    ContextActionService:UnbindAction("FlyControl")
    
    local character = player.Character
    if character then
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.Gravity = 1
        end
        
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end
    end
    
    if flyAnimTrack then
        flyAnimTrack:Stop()
        flyAnimTrack = nil
    end
end

-- Функции админ-панели
local functions = {
    ["Убить всех игроков"] = function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
    end,
    
    ["Показать оповещение"] = function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local head = plr.Character:FindFirstChild("Head")
                if head then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Adornee = head
                    billboard.Size = UDim2.new(0, 200, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 3, 0)
                    billboard.AlwaysOnTop = true
                    
                    local label = Instance.new("TextLabel")
                    label.Size = UDim2.new(1, 0, 1, 0)
                    label.Text = "Admin is here!"
                    label.Font = Enum.Font.SourceSansBold
                    label.TextSize = 24
                    label.TextColor3 = Color3.new(1, 0, 0)
                    label.BackgroundTransparency = 1
                    label.Parent = billboard
                    
                    billboard.Parent = head
                    game:GetService("Debris"):AddItem(billboard, 10)
                end
            end
        end
    end,
    
    ["Заменить тела"] = function()
        local asset = InsertService:LoadAsset(BUNDLE_ID)
        local bodyParts = asset:GetChildren()[1]:GetChildren()
        
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                for _, part in ipairs(bodyParts) do
                    if part:IsA("MeshPart") then
                        local char = plr.Character
                        local existing = char:FindFirstChild(part.Name)
                        if existing then
                            local clone = part:Clone()
                            clone.Parent = char
                            clone.CFrame = existing.CFrame
                            
                            for _, weld in ipairs(char:GetDescendants()) do
                                if weld:IsA("Motor6D") and weld.Part1 == existing then
                                    weld.Part1 = clone
                                end
                            end
                            existing:Destroy()
                        end
                    end
                end
            end
        end
    end,
    
    ["Телепортировать всех ко мне"] = function()
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr ~= player and plr.Character then
                    local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
                    if targetRoot then
                        targetRoot.CFrame = root.CFrame * CFrame.new(0, 0, -5)
                    end
                end
            end
        end
    end,
    
    ["Заблокировать всех"] = function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 0
                end
            end
        end
    end,
    
    ["Разблокировать всех"] = function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = 16
                end
            end
        end
    end,
    
    ["Удалить все инструменты"] = function()
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr:FindFirstChild("Backpack") then
                for _, item in ipairs(plr.Backpack:GetChildren()) do
                    if item:IsA("Tool") then
                        item:Destroy()
                    end
                end
            end
        end
    end,
    
    ["Создать копии"] = function()
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then
            for _, plr in ipairs(Players:GetPlayers()) do
                if plr.Character then
                    local char = plr.Character
                    local clone = char:Clone()
                    clone.Parent = workspace
                    clone:SetPrimaryPartCFrame(root.CFrame * CFrame.new(0, 0, -10))
                end
            end
        end
    end,
    
    ["Включить летание"] = startFlying,
    
    ["Выключить летание"] = stopFlying,
    
    ["Бессмертие"] = function()
        local character = player.Character
        if character then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            end
        end
    end,
    
    ["Ноклип"] = function()
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end,
    
    ["Увеличить скорость полёта"] = function()
        flySpeed = math.min(flySpeed + 10, 100)
    end,
    
    ["Уменьшить скорость полёта"] = function()
        flySpeed = math.max(flySpeed - 10, 10)
    end
}

-- Создаем кнопки для основных функций
for name, func in pairs(functions) do
    local btnFrame, btn = createButton(name)
    btnFrame.Parent = mainContent
    btn.MouseButton1Click:Connect(func)
end

-- Настройки
local settings = {
    AutoOpen = true,
    AnimationSpeed = 0.01,
    ThemeColor = Color3.fromRGB(0, 14, 122)
}

local function createSetting(name, default)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 30)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.6, 0, 1, 0)
    label.Text = name
    label.TextColor3 = Color3.new(0, 0, 0)
    label.Font = Enum.Font.SourceSans
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.BackgroundTransparency = 1
    label.Parent = frame
    
    return frame
end

local autoOpenSetting = createSetting("Авто-открытие при запуске")
local themeColorSetting = createSetting("Цвет темы")
local flySpeedSetting = createSetting("Скорость полёта")

local autoOpenToggle = Instance.new("TextButton")
autoOpenToggle.Size = UDim2.new(0.3, 0, 0.7, 0)
autoOpenToggle.Position = UDim2.new(0.65, 0, 0.15, 0)
autoOpenToggle.Text = settings.AutoOpen and "ON" or "OFF"
autoOpenToggle.TextColor3 = settings.AutoOpen and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
autoOpenToggle.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
autoOpenToggle.BorderColor3 = Color3.new(0, 0, 0)
autoOpenToggle.Parent = autoOpenSetting

autoOpenToggle.MouseButton1Click:Connect(function()
    settings.AutoOpen = not settings.AutoOpen
    autoOpenToggle.Text = settings.AutoOpen and "ON" or "OFF"
    autoOpenToggle.TextColor3 = settings.AutoOpen and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
end)

local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(0.3, 0, 0.7, 0)
flySpeedLabel.Position = UDim2.new(0.65, 0, 0.15, 0)
flySpeedLabel.Text = tostring(flySpeed)
flySpeedLabel.TextColor3 = Color3.new(0, 0, 0)
flySpeedLabel.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
flySpeedLabel.BorderColor3 = Color3.new(0, 0, 0)
flySpeedLabel.Parent = flySpeedSetting

autoOpenSetting.Parent = settingsContent
themeColorSetting.Parent = settingsContent
flySpeedSetting.Parent = settingsContent

-- Анимации в стиле старых Windows
local function animateWindow(action)
    local startSize = mainFrame.Size
    local startPos = mainFrame.Position
    local targetSize, targetPos
    
    if action == "open" then
        targetSize = UDim2.new(0, 400, 0, 500)
        targetPos = UDim2.new(0.5, -200, 0.5, -250)
        mainFrame.Visible = true
    elseif action == "close" then
        targetSize = UDim2.new(0, 10, 0, 10)
        targetPos = UDim2.new(0.5, -5, 0.5, -5)
    elseif action == "minimize" then
        targetSize = startSize
        targetPos = UDim2.new(0.5, -200, 1, 5)
    end
    
    local sizeStep = (targetSize - startSize) / ANIMATION_STEPS
    local posStep = (targetPos - startPos) / ANIMATION_STEPS
    
    for i = 1, ANIMATION_STEPS do
        mainFrame.Size = startSize + (sizeStep * i)
        mainFrame.Position = startPos + (posStep * i)
        wait(ANIMATION_STEP_DELAY)
    end
    
    mainFrame.Size = targetSize
    mainFrame.Position = targetPos
    
    if action == "close" then
        mainFrame.Visible = false
    end
end

-- Обработчики кнопок
closeBtn.MouseButton1Click:Connect(function()
    animateWindow("close")
    restoreTab.Visible = true
end)

minimizeBtn.MouseButton1Click:Connect(function()
    animateWindow("minimize")
    restoreTab.Visible = true
end)

restoreTab.MouseButton1Click:Connect(function()
    restoreTab.Visible = false
    animateWindow("open")
end)

-- Переключение вкладок
mainTab.MouseButton1Click:Connect(function()
    mainContent.Visible = true
    playerContent.Visible = false
    settingsContent.Visible = false
end)

playerTab.MouseButton1Click:Connect(function()
    mainContent.Visible = false
    playerContent.Visible = true
    settingsContent.Visible = false
end)

settingsTab.MouseButton1Click:Connect(function()
    mainContent.Visible = false
    playerContent.Visible = false
    settingsContent.Visible = true
end)

-- Перетаскивание окна
local dragging = false
local dragOffset = Vector2.new(0, 0)

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragOffset = Vector2.new(input.Position.X, input.Position.Y) - Vector2.new(mainFrame.AbsolutePosition.X, mainFrame.AbsolutePosition.Y)
    end
end)

titleBar.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local newPos = UDim2.new(
            0, input.Position.X - dragOffset.X,
            0, input.Position.Y - dragOffset.Y
        )
        mainFrame.Position = newPos
    end
end)

-- Автоматическое открытие при загрузке
if settings.AutoOpen then
    animateWindow("open")
end

-- Обработка выхода из игры
game:GetService("Players").LocalPlayer.CharacterRemoving:Connect(function()
    stopFlying()
end)
