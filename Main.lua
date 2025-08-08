local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ContextActionService = game:GetService("ContextActionService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")
local Workspace = game:GetService("Workspace")
local Debris = game:GetService("Debris")
local PhysicsService = game:GetService("PhysicsService")
local CollectionService = game:GetService("CollectionService")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "IRIS_FECOKEV_WinXP_GUI_" .. HttpService:GenerateGUID(false)
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- Конфигурация
local ANIMATION_STEPS = 8
local ANIMATION_STEP_DELAY = 0.03
local FLY_ANIMATION_ID = 93954221593805
local DEBUG_MODE = true
local DEBUG_LOG_MAX = 50

-- Глобальные переменные
local debugLogs = {}
local debugPanel
local debugLogFrame
local debugConnection
local performanceStats = {
    FPS = 0,
    Ping = 0,
    Memory = 0
}

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 700)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -350)
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
titleBar.Visible = false
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
titleLabel.Visible = false
titleLabel.Parent = titleBar

-- Кнопки управления окном
local minimizeBtn = Instance.new("ImageButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 22, 0, 22)
minimizeBtn.Position = UDim2.new(1, -50, 0, 1)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Image = "rbxassetid://100060328280272"
minimizeBtn.Visible = false
minimizeBtn.Parent = titleBar

local closeBtn = Instance.new("ImageButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 22, 0, 22)
closeBtn.Position = UDim2.new(1, -25, 0, 1)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = "rbxassetid://111156260096414"
closeBtn.Visible = false
closeBtn.Parent = titleBar

-- Панель вкладок
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 24)
tabBar.Position = UDim2.new(0, 0, 0, 24)
tabBar.BackgroundColor3 = Color3.fromRGB(192, 192, 192)
tabBar.BorderSizePixel = 0
tabBar.Visible = false
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
    btn.Visible = false
    btn.Parent = tabBar
    return btn
end

local mainTab = createTabButton("Основные", 5)
local playerTab = createTabButton("Игроки", 90)
local visualTab = createTabButton("Визуал", 175)
local debugTab = createTabButton("Дебаг", 260)
local settingsTab = createTabButton("Настройки", 345)

-- Контейнеры для вкладок
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -10, 1, -58)
tabContainer.Position = UDim2.new(0, 5, 0, 53)
tabContainer.BackgroundTransparency = 1
tabContainer.Visible = false
tabContainer.Parent = mainFrame

-- Создаем UIListLayout для правильного расположения кнопок
local function createContentFrame()
    local frame = Instance.new("ScrollingFrame")
    frame.Size = UDim2.new(1, 0, 1, 0)
    frame.BackgroundTransparency = 1
    frame.ScrollBarThickness = 8
    frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
    frame.Visible = false

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.SortOrder = Enum.SortOrder.LayoutOrder
    listLayout.Parent = frame

    return frame
end

local mainContent = createContentFrame()
mainContent.Parent = tabContainer

local playerContent = createContentFrame()
playerContent.Parent = tabContainer

local visualContent = createContentFrame()
visualContent.Parent = tabContainer

local debugContent = createContentFrame()
debugContent.Parent = tabContainer

local settingsContent = createContentFrame()
settingsContent.Parent = tabContainer

-- Ярлык в стиле Windows XP (внизу слева)
local taskbarButton = Instance.new("TextButton")
taskbarButton.Name = "TaskbarButton"
taskbarButton.Size = UDim2.new(0, 150, 0, 30)
taskbarButton.Position = UDim2.new(0, 10, 1, -35)
taskbarButton.BackgroundColor3 = Color3.fromRGB(0, 14, 122)
taskbarButton.BorderSizePixel = 0
taskbarButton.Text = "AdminScript"
taskbarButton.TextColor3 = Color3.new(1, 1, 1)
taskbarButton.Font = Enum.Font.SourceSansBold
taskbarButton.TextSize = 14
taskbarButton.Visible = false
taskbarButton.Parent = gui

-- Переработанная функция создания кнопок
local function createButton(name, sizeY, withState)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, sizeY or 35)
    btn.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
    btn.BorderColor3 = Color3.new(0, 0, 0)
    btn.Text = name
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.SourceSans
    btn.TextSize = 16
    btn.AutoButtonColor = false
    btn.LayoutOrder = 1
    btn.Visible = false

    -- Создаем элементы управления состоянием только если это кнопка с состоянием
    local stateIndicator
    if withState then
        stateIndicator = Instance.new("TextLabel")
        stateIndicator.Name = "StateIndicator"
        stateIndicator.Size = UDim2.new(0, 40, 1, -4)
        stateIndicator.Position = UDim2.new(1, -45, 0, 2)
        stateIndicator.Text = ""
        stateIndicator.TextColor3 = Color3.new(0, 0.5, 0)
        stateIndicator.Font = Enum.Font.SourceSansBold
        stateIndicator.TextSize = 14
        stateIndicator.BackgroundTransparency = 1
        stateIndicator.Visible = false
        stateIndicator.Parent = btn
    end

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
    
    -- Возвращаем кнопку и функцию для обновления состояния
    return btn, function(isActive)
        if withState and stateIndicator then
            stateIndicator.Visible = isActive
            stateIndicator.Text = isActive and "ON" or ""
        end
    end
end

-- Система полёта
local flying = false
local flySpeed = 50
local flyAnimation = nil
local flyAnimTrack = nil
local flyBV = nil

local function startFlying()
    if flying then return end
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end

    if not flyAnimation then
        flyAnimation = Instance.new("Animation")
        flyAnimation.AnimationId = "rbxassetid://" .. FLY_ANIMATION_ID
    end

    flyAnimTrack = humanoid:LoadAnimation(flyAnimation)
    flyAnimTrack:Play()

    flyBV = Instance.new("BodyVelocity")
    flyBV.Velocity = Vector3.new(0, 0, 0)
    flyBV.MaxForce = Vector3.new(100000, 100000, 100000)
    flyBV.P = 10000
    flyBV.Parent = rootPart

    flying = true

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

    local function handleInput(action, state, input)
        if keys[input.KeyCode] ~= nil then
            keys[input.KeyCode] = state == Enum.UserInputState.Begin
        end
        return Enum.ContextActionResult.Sink
    end

    ContextActionService:BindAction("FlyControl", handleInput, false,
        Enum.KeyCode.W, Enum.KeyCode.A, Enum.KeyCode.S, Enum.KeyCode.D,
        Enum.KeyCode.Space, Enum.KeyCode.LeftShift)

    local flyConnection
    flyConnection = RunService.Heartbeat:Connect(function(dt)
        if not flying or not rootPart or not rootPart.Parent then
            flyConnection:Disconnect()
            return
        end

        local moveVector = Vector3.new()
        if keys[Enum.KeyCode.W] then moveVector += camera.CFrame.LookVector end
        if keys[Enum.KeyCode.S] then moveVector -= camera.CFrame.LookVector end
        if keys[Enum.KeyCode.D] then moveVector += camera.CFrame.RightVector end
        if keys[Enum.KeyCode.A] then moveVector -= camera.CFrame.RightVector end
        if keys[Enum.KeyCode.Space] then moveVector += Vector3.new(0, 1, 0) end
        if keys[Enum.KeyCode.LeftShift] then moveVector -= Vector3.new(0, 1, 0) end

        if moveVector.Magnitude > 0 then
            moveVector = moveVector.Unit * flySpeed
        end

        if flyBV and flyBV.Parent then
            flyBV.Velocity = moveVector
        end
    end)
end

local function stopFlying()
    if not flying then return end
    flying = false

    ContextActionService:UnbindAction("FlyControl")

    local character = player.Character
    if character then
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = true
            end
        end

        if flyBV then
            flyBV:Destroy()
            flyBV = nil
        end
    end

    if flyAnimTrack then
        flyAnimTrack:Stop()
        flyAnimTrack = nil
    end
end

-- Система выбора игроков
local selectedPlayers = {}
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(1, -10, 0.7, 0)
playerListFrame.Position = UDim2.new(0, 5, 0, 5)
playerListFrame.BackgroundTransparency = 1
playerListFrame.ScrollBarThickness = 8
playerListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
playerListFrame.Visible = false
playerListFrame.Parent = playerContent

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Padding = UDim.new(0, 5)
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerListLayout.Parent = playerListFrame

local function updatePlayerList()
    playerListFrame:ClearAllChildren()
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local playerFrame = Instance.new("Frame")
            playerFrame.Size = UDim2.new(1, -10, 0, 30)
            playerFrame.BackgroundTransparency = 1
            
            local playerName = Instance.new("TextLabel")
            playerName.Size = UDim2.new(0.7, 0, 1, 0)
            playerName.Text = plr.Name
            playerName.TextColor3 = Color3.new(0, 0, 0)
            playerName.Font = Enum.Font.SourceSans
            playerName.TextSize = 14
            playerName.TextXAlignment = Enum.TextXAlignment.Left
            playerName.BackgroundTransparency = 1
            playerName.Parent = playerFrame
            
            local selectBtn = Instance.new("TextButton")
            selectBtn.Size = UDim2.new(0.25, 0, 0.8, 0)
            selectBtn.Position = UDim2.new(0.75, 0, 0.1, 0)
            selectBtn.Text = selectedPlayers[plr] and "✓" or ""
            selectBtn.BackgroundColor3 = selectedPlayers[plr] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 200, 200)
            selectBtn.TextColor3 = Color3.new(0, 0, 0)
            selectBtn.Font = Enum.Font.SourceSansBold
            selectBtn.TextSize = 14
            selectBtn.Parent = playerFrame
            
            selectBtn.MouseButton1Click:Connect(function()
                selectedPlayers[plr] = not selectedPlayers[plr]
                selectBtn.Text = selectedPlayers[plr] and "✓" or ""
                selectBtn.BackgroundColor3 = selectedPlayers[plr] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 200, 200)
            end)
            
            playerFrame.Parent = playerListFrame
        end
    end
end

-- Система заморозки с сохранением позиции
local frozenPlayers = {}
local freezeLoop = RunService.Heartbeat:Connect(function()
    for plr, data in pairs(frozenPlayers) do
        if plr.Character and data.rootPart and data.rootPart.Parent then
            data.rootPart.CFrame = data.originalCFrame
        end
    end
end)

local function freezeSelectedPlayers()
    for plr, _ in pairs(selectedPlayers) do
        if plr.Character and not frozenPlayers[plr] then
            local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid then
                frozenPlayers[plr] = {
                    rootPart = rootPart,
                    originalCFrame = rootPart.CFrame,
                    humanoid = humanoid,
                    originalWalkSpeed = humanoid.WalkSpeed
                }
                humanoid.WalkSpeed = 0
            end
        end
    end
end

local function unfreezeSelectedPlayers()
    for plr, _ in pairs(selectedPlayers) do
        if frozenPlayers[plr] then
            local data = frozenPlayers[plr]
            if data.humanoid and data.humanoid.Parent then
                data.humanoid.WalkSpeed = data.originalWalkSpeed
            end
            frozenPlayers[plr] = nil
        end
    end
end

-- Система хитбоксов
local hitboxes = {}
local hitboxMode = 0 -- 0: выкл, 1: весь хитбокс, 2: части тела

local function createHitbox(part)
    local hitbox = Instance.new("BoxHandleAdornment")
    hitbox.Name = "AdminHitbox"
    hitbox.Adornee = part
    hitbox.AlwaysOnTop = true
    hitbox.ZIndex = 10
    hitbox.Size = part.Size
    hitbox.Transparency = 0.7
    
    if hitboxMode == 1 then
        hitbox.Color3 = Color3.new(1, 0, 0) -- Красный для всего хитбокса
    elseif hitboxMode == 2 then
        hitbox.Color3 = Color3.new(1, 1, 1) -- Белый для частей тела
    end
    
    hitbox.Parent = part
    return hitbox
end

local function updateHitboxes()
    -- Удаляем старые хитбоксы
    for _, hitbox in ipairs(hitboxes) do
        if hitbox then
            hitbox:Destroy()
        end
    end
    hitboxes = {}
    
    if hitboxMode == 0 then return end
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            if hitboxMode == 1 then -- Весь хитбокс
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    local hitboxPart = Instance.new("Part")
                    hitboxPart.Name = "HitboxPart"
                    hitboxPart.Size = Vector3.new(3, 5, 3)
                    hitboxPart.Transparency = 1
                    hitboxPart.CanCollide = false
                    hitboxPart.Anchored = true
                    hitboxPart.Parent = plr.Character
                    
                    local weld = Instance.new("Weld")
                    weld.Part0 = plr.Character.HumanoidRootPart
                    weld.Part1 = hitboxPart
                    weld.Parent = hitboxPart
                    
                    local hitbox = createHitbox(hitboxPart)
                    table.insert(hitboxes, hitbox)
                end
            elseif hitboxMode == 2 then -- Части тела
                for _, part in ipairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        local hitbox = createHitbox(part)
                        table.insert(hitboxes, hitbox)
                    end
                end
            end
        end
    end
end

local function setHitboxMode(mode)
    hitboxMode = mode
    updateHitboxes()
end

-- Дебаг-система
local function logDebug(message)
    if not DEBUG_MODE then return end
    
    table.insert(debugLogs, 1, os.date("%H:%M:%S") .. " - " .. message)
    
    if #debugLogs > DEBUG_LOG_MAX then
        table.remove(debugLogs)
    end
    
    if debugLogFrame then
        debugLogFrame:ClearAllChildren()
        
        for i, log in ipairs(debugLogs) do
            local logLabel = Instance.new("TextLabel")
            logLabel.Size = UDim2.new(1, 0, 0, 20)
            logLabel.Position = UDim2.new(0, 0, 0, (i-1)*20)
            logLabel.Text = log
            logLabel.TextColor3 = Color3.new(0, 0, 0)
            logLabel.Font = Enum.Font.SourceSans
            logLabel.TextSize = 14
            logLabel.TextXAlignment = Enum.TextXAlignment.Left
            logLabel.BackgroundTransparency = 1
            logLabel.Parent = debugLogFrame
        end
    end
end

local function initDebugPanel()
    debugPanel = Instance.new("Frame")
    debugPanel.Size = UDim2.new(1, 0, 0.4, 0)
    debugPanel.Position = UDim2.new(0, 0, 0.6, 0)
    debugPanel.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    debugPanel.BorderSizePixel = 0
    debugPanel.Visible = true
    debugPanel.Parent = debugContent
    
    local statsFrame = Instance.new("Frame")
    statsFrame.Size = UDim2.new(0.5, 0, 0.3, 0)
    statsFrame.BackgroundTransparency = 1
    statsFrame.Parent = debugPanel
    
    local fpsLabel = Instance.new("TextLabel")
    fpsLabel.Size = UDim2.new(1, 0, 0.33, 0)
    fpsLabel.Text = "FPS: 0"
    fpsLabel.TextColor3 = Color3.new(0, 0, 0)
    fpsLabel.Font = Enum.Font.SourceSansBold
    fpsLabel.TextSize = 16
    fpsLabel.Parent = statsFrame
    
    local pingLabel = Instance.new("TextLabel")
    pingLabel.Size = UDim2.new(1, 0, 0.33, 0)
    pingLabel.Position = UDim2.new(0, 0, 0.33, 0)
    pingLabel.Text = "Ping: 0ms"
    pingLabel.TextColor3 = Color3.new(0, 0, 0)
    pingLabel.Font = Enum.Font.SourceSansBold
    pingLabel.TextSize = 16
    pingLabel.Parent = statsFrame
    
    local memLabel = Instance.new("TextLabel")
    memLabel.Size = UDim2.new(1, 0, 0.33, 0)
    memLabel.Position = UDim2.new(0, 0, 0.66, 0)
    memLabel.Text = "Memory: 0MB"
    memLabel.TextColor3 = Color3.new(0, 0, 0)
    memLabel.Font = Enum.Font.SourceSansBold
    memLabel.TextSize = 16
    memLabel.Parent = statsFrame
    
    debugLogFrame = Instance.new("Frame")
    debugLogFrame.Size = UDim2.new(1, -10, 0.7, 0)
    debugLogFrame.Position = UDim2.new(0, 5, 0.3, 0)
    debugLogFrame.BackgroundTransparency = 1
    debugLogFrame.ClipsDescendants = true
    debugLogFrame.Parent = debugPanel
    
    -- Обновление статистики
    local lastTime = tick()
    local frames = 0
    
    debugConnection = RunService.Heartbeat:Connect(function(dt)
        frames = frames + 1
        
        if tick() - lastTime >= 1 then
            performanceStats.FPS = frames
            frames = 0
            lastTime = tick()
            
            -- Обновление статистики
            fpsLabel.Text = "FPS: " .. performanceStats.FPS
            pingLabel.Text = "Ping: " .. math.random(20, 100) .. "ms" -- Заглушка
            memLabel.Text = "Memory: " .. math.random(50, 200) .. "MB" -- Заглушка
        end
    end)
end

-- Расширенные функции дебага
local function showCollisionGeometry()
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = part
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Size = part.Size
            box.Transparency = 0.8
            box.Color3 = Color3.new(0, 1, 0)
            box.Parent = part
            Debris:AddItem(box, 10)
        end
    end
    logDebug("Показана геометрия коллизий")
end

local function showNetworkOwners()
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            local owner = part:GetNetworkOwner()
            if owner then
                local billboard = Instance.new("BillboardGui")
                billboard.Adornee = part
                billboard.Size = UDim2.new(0, 100, 0, 40)
                billboard.AlwaysOnTop = true
                
                local label = Instance.new("TextLabel")
                label.Size = UDim2.new(1, 0, 1, 0)
                label.Text = owner.Name
                label.TextColor3 = Color3.new(1, 0, 0)
                label.BackgroundTransparency = 1
                label.Parent = billboard
                
                billboard.Parent = part
                Debris:AddItem(billboard, 10)
            end
        end
    end
    logDebug("Показаны владельцы сетевых объектов")
end

local function showPhysicsGroups()
    for groupName, _ in pairs(PhysicsService:GetRegisteredCollisionGroups()) do
        local parts = PhysicsService:GetCollisionGroupParts(groupName)
        for _, part in ipairs(parts) do
            local box = Instance.new("BoxHandleAdornment")
            box.Adornee = part
            box.AlwaysOnTop = true
            box.ZIndex = 5
            box.Size = part.Size
            box.Transparency = 0.7
            box.Color3 = Color3.new(math.random(), math.random(), math.random())
            box.Parent = part
            Debris:AddItem(box, 10)
        end
    end
    logDebug("Показаны группы физики")
end

local function dumpInstanceTree(object, depth)
    depth = depth or 0
    local prefix = string.rep("  ", depth)
    logDebug(prefix .. object:GetFullName() .. " (" .. object.ClassName .. ")")
    
    for _, child in ipairs(object:GetChildren()) do
        dumpInstanceTree(child, depth + 1)
    end
end

local function testNetworkLatency()
    local start = os.clock()
    -- Имитация сетевого запроса
    wait(0.1)
    local latency = (os.clock() - start) * 1000
    logDebug("Сетевая задержка: " .. string.format("%.2f", latency) .. "ms")
end

local function stressTestPerformance()
    logDebug("Начало стресс-теста производительности...")
    local startTime = os.clock()
    
    local parts = {}
    for i = 1, 100 do
        local part = Instance.new("Part")
        part.Position = Vector3.new(math.random(-50, 50), 10, math.random(-50, 50))
        part.Parent = Workspace
        table.insert(parts, part)
    end
    
    for i = 1, 100 do
        for _, part in ipairs(parts) do
            part.Position += Vector3.new(0.1, 0, 0.1)
        end
        RunService.Heartbeat:Wait()
    end
    
    for _, part in ipairs(parts) do
        part:Destroy()
    end
    
    local duration = os.clock() - startTime
    logDebug("Стресс-тест завершен за " .. string.format("%.2f", duration) .. " секунд")
end

-- Новые функции
local function infiniteJump()
    player.Character:WaitForChild("Humanoid").UseJumpPower = true
    UserInputService.JumpRequest:Connect(function()
        player.Character.Humanoid:ChangeState("Jumping")
    end)
    logDebug("Бесконечный прыжок активирован")
end

local function changeGravity(value)
    Workspace.Gravity = value
    logDebug("Гравитация изменена на: " .. value)
end

local function setTimeOfDay(time)
    Lighting.ClockTime = time
    logDebug("Время суток установлено: " .. time)
end

local function ghostMode()
    if player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = 0.7
                part.CanCollide = false
            end
        end
    end
    logDebug("Режим призрака активирован")
end

local function espPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "ESP"
                billboard.Adornee = head
                billboard.Size = UDim2.new(0, 100, 0, 40)
                billboard.StudsOffset = Vector3.new(0, 2, 0)
                billboard.AlwaysOnTop = true
                
                local nameLabel = Instance.new("TextLabel")
                nameLabel.Size = UDim2.new(1, 0, 0.5, 0)
                nameLabel.Text = plr.Name
                nameLabel.TextColor3 = Color3.new(1, 1, 0)
                nameLabel.BackgroundTransparency = 1
                nameLabel.Parent = billboard
                
                local healthLabel = Instance.new("TextLabel")
                healthLabel.Size = UDim2.new(1, 0, 0.5, 0)
                healthLabel.Position = UDim2.new(0, 0, 0.5, 0)
                healthLabel.Text = "HP: 100"
                healthLabel.TextColor3 = Color3.new(0, 1, 0)
                healthLabel.BackgroundTransparency = 1
                healthLabel.Parent = billboard
                
                billboard.Parent = head
                
                -- Обновление здоровья
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:GetPropertyChangedSignal("Health"):Connect(function()
                        healthLabel.Text = "HP: " .. math.floor(humanoid.Health)
                    end)
                end
            end
        end
    end
    logDebug("ESP игроков активировано")
end

local function removeESP()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local head = plr.Character:FindFirstChild("Head")
            if head then
                for _, child in ipairs(head:GetChildren()) do
                    if child.Name == "ESP" then
                        child:Destroy()
                    end
                end
            end
        end
    end
    logDebug("ESP удалено")
end

local function speedHack(speed)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
        end
    end
    logDebug("Скорость изменена на: " .. speed)
end

local function teleportToPosition()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame = root.CFrame + root.CFrame.LookVector * 50
        logDebug("Телепортирован вперед на 50 юнитов")
    end
end

local function spawnVehicle()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local vehicle = Instance.new("Part")
        vehicle.Name = "AdminVehicle"
        vehicle.Size = Vector3.new(4, 2, 6)
        vehicle.Position = root.Position + root.CFrame.LookVector * 10
        vehicle.Anchored = false
        vehicle.CanCollide = true
        vehicle.Color = Color3.new(0, 0.5, 1)
        vehicle.Parent = Workspace
        
        local seat = Instance.new("Seat")
        seat.Size = Vector3.new(2, 1, 2)
        seat.Position = vehicle.Position + Vector3.new(0, 1.5, 0)
        seat.Parent = vehicle
        
        local weld = Instance.new("Weld")
        weld.Part0 = vehicle
        weld.Part1 = seat
        weld.C0 = CFrame.new(0, 1.5, 0)
        weld.Parent = vehicle
        
        logDebug("Транспорт создан")
    end
end

local function deleteAllObjects()
    for _, obj in ipairs(Workspace:GetChildren()) do
        if not obj:IsA("Terrain") and obj ~= player.Character then
            obj:Destroy()
        end
    end
    logDebug("Все объекты удалены")
end

local function createExplosion()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        local explosion = Instance.new("Explosion")
        explosion.Position = root.Position
        explosion.BlastRadius = 20
        explosion.BlastPressure = 100000
        explosion.Parent = Workspace
        logDebug("Создан взрыв")
    end
end

local function freezeWorld()
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = true
        end
    end
    logDebug("Мир заморожен")
end

local function unfreezeWorld()
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Anchored = false
        end
    end
    logDebug("Мир разморожен")
end

-- Состояния функций
local activeStates = {
    Fly = false,
    Noclip = false,
    GodMode = false,
    Hitbox = false,
    InfiniteJump = false,
    GhostMode = false,
    ESP = false
}

-- Переработанная функция для кнопок с состоянием
local function createStateButton(content, name, func, stateKey)
    local btn, updateState = createButton(name, nil, true) -- true указывает, что это кнопка с состоянием
    btn.Parent = content
    
    -- Инициализируем состояние
    updateState(activeStates[stateKey])
    
    btn.MouseButton1Click:Connect(function()
        activeStates[stateKey] = func(activeStates[stateKey])
        updateState(activeStates[stateKey])
    end)
    
    return btn
end

-- Функция для обычных кнопок (без состояния)
local function addButton(content, name, func)
    local btn = createButton(name, nil, false) -- false указывает, что это обычная кнопка
    btn.Parent = content
    btn.MouseButton1Click:Connect(func)
    return btn
end

-- Функции для переключения состояний
local function toggleNoclip(state)
    if state then
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    else
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
    return not state
end

local function toggleGodMode(state)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if not state then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
            end
        end
    end
    return not state
end

local function toggleFly(state)
    if state then
        stopFlying()
    else
        startFlying()
    end
    return not state
end

local function toggleHitbox(state)
    if state then
        setHitboxMode(0)
    else
        setHitboxMode(1)
    end
    return not state
end

local function toggleInfiniteJump(state)
    if state then
        -- Отключаем бесконечный прыжок
    else
        infiniteJump()
    end
    return not state
end

local function toggleGhostMode(state)
    if state then
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                    part.CanCollide = true
                end
            end
        end
    else
        ghostMode()
    end
    return not state
end

local function toggleESP(state)
    if state then
        removeESP()
    else
        espPlayers()
    end
    return not state
end

-- Основные функции
addButton(mainContent, "Обновить список игроков", updatePlayerList)
addButton(mainContent, "Убить выбранных игроков", function()
    for plr, _ in pairs(selectedPlayers) do
        if plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end
    end
    logDebug("Убиты выбранные игроки")
end)

addButton(mainContent, "Телепортироваться к игроку", function()
    local target
    for plr, _ in pairs(selectedPlayers) do
        target = plr
        break
    end
    
    if target and target.Character then
        local targetRoot = target.Character:FindFirstChild("HumanoidRootPart")
        local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        
        if targetRoot and playerRoot then
            playerRoot.CFrame = targetRoot.CFrame * CFrame.new(0, 3, 0)
            logDebug("Телепортирован к игроку: " .. target.Name)
        end
    end
end)

addButton(mainContent, "Исцелить выбранных", function()
    for plr, _ in pairs(selectedPlayers) do
        if plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end
    end
    logDebug("Исцелены выбранные игроки")
end)

addButton(mainContent, "Заблокировать выбранных", freezeSelectedPlayers)
addButton(mainContent, "Разблокировать выбранных", unfreezeSelectedPlayers)
addButton(mainContent, "Телепорт вперед", teleportToPosition)
addButton(mainContent, "Создать транспорт", spawnVehicle)
addButton(mainContent, "Удалить всё", deleteAllObjects)
addButton(mainContent, "Создать взрыв", createExplosion)
addButton(mainContent, "Заморозить мир", freezeWorld)
addButton(mainContent, "Разморозить мир", unfreezeWorld)

-- Кнопки с состоянием
createStateButton(mainContent, "Летание", toggleFly, "Fly")
createStateButton(mainContent, "Ноклип", toggleNoclip, "Noclip")
createStateButton(mainContent, "Бессмертие", toggleGodMode, "GodMode")
createStateButton(mainContent, "Бесконечный прыжок", toggleInfiniteJump, "InfiniteJump")
createStateButton(mainContent, "Режим призрака", toggleGhostMode, "GhostMode")

-- Визуальные функции
createStateButton(visualContent, "Показать хитбоксы", toggleHitbox, "Hitbox")
createStateButton(visualContent, "Показать ESP", toggleESP, "ESP")

addButton(visualContent, "Режим хитбоксов: Весь", function()
    setHitboxMode(1)
    logDebug("Хитбоксы: весь персонаж")
end)

addButton(visualContent, "Режим хитбоксов: Части", function()
    setHitboxMode(2)
    logDebug("Хитбоксы: части тела")
end)

addButton(visualContent, "Скорость x2", function()
    speedHack(32)
end)

addButton(visualContent, "Скорость x5", function()
    speedHack(80)
end)

addButton(visualContent, "День", function()
    setTimeOfDay(12)
end)

addButton(visualContent, "Ночь", function()
    setTimeOfDay(0)
end)

addButton(visualContent, "Гравитация Луны", function()
    changeGravity(10)
end)

-- Дебаг-функции
addButton(debugContent, "Показать геометрию коллизий", showCollisionGeometry)
addButton(debugContent, "Показать владельцев объектов", showNetworkOwners)
addButton(debugContent, "Показать группы физики", showPhysicsGroups)
addButton(debugContent, "Дамп иерархии Workspace", function()
    logDebug("Начало дампа иерархии Workspace...")
    dumpInstanceTree(Workspace)
    logDebug("Дамп иерархии Workspace завершен")
end)
addButton(debugContent, "Тест сетевой задержки", testNetworkLatency)
addButton(debugContent, "Стресс-тест производительности", stressTestPerformance)
addButton(debugContent, "Создать 100 кубов", function()
    for i = 1, 100 do
        local part = Instance.new("Part")
        part.Position = Vector3.new(math.random(-50, 50), 10, math.random(-50, 50))
        part.Parent = Workspace
    end
    logDebug("Создано 100 кубов")
end)

-- Настройки
local settings = {
    AutoOpen = true,
    ThemeColor = Color3.fromRGB(0, 14, 122)
}

local function createSetting(name)
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
autoOpenSetting.Visible = false
autoOpenSetting.Parent = settingsContent

local flySpeedSetting = createSetting("Скорость полёта: " .. flySpeed)
flySpeedSetting.Visible = false
flySpeedSetting.Parent = settingsContent

local autoOpenToggle = Instance.new("TextButton")
autoOpenToggle.Size = UDim2.new(0.3, 0, 0.7, 0)
autoOpenToggle.Position = UDim2.new(0.65, 0, 0.15, 0)
autoOpenToggle.Text = settings.AutoOpen and "ON" or "OFF"
autoOpenToggle.TextColor3 = settings.AutoOpen and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
autoOpenToggle.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
autoOpenToggle.BorderColor3 = Color3.new(0, 0, 0)
autoOpenToggle.Visible = false
autoOpenToggle.Parent = autoOpenSetting

autoOpenToggle.MouseButton1Click:Connect(function()
    settings.AutoOpen = not settings.AutoOpen
    autoOpenToggle.Text = settings.AutoOpen and "ON" or "OFF"
    autoOpenToggle.TextColor3 = settings.AutoOpen and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
    logDebug("Авто-открытие: " .. (settings.AutoOpen and "включено" or "выключено"))
end)

local flySpeedLabel = Instance.new("TextLabel")
flySpeedLabel.Size = UDim2.new(0.3, 0, 0.7, 0)
flySpeedLabel.Position = UDim2.new(0.65, 0, 0.15, 0)
flySpeedLabel.Text = tostring(flySpeed)
flySpeedLabel.TextColor3 = Color3.new(0, 0, 0)
flySpeedLabel.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
flySpeedLabel.BorderColor3 = Color3.new(0, 0, 0)
flySpeedLabel.Visible = false
flySpeedLabel.Parent = flySpeedSetting

-- Анимация открытия окна
local function openWindow()
    taskbarButton.Visible = false
    mainFrame.Visible = true

    for i = 1, ANIMATION_STEPS do
        if i == 1 then
            titleBar.Visible = true
        elseif i == 2 then
            titleLabel.Visible = true
        elseif i == 3 then
            minimizeBtn.Visible = true
            closeBtn.Visible = true
        elseif i == 4 then
            tabBar.Visible = true
        elseif i == 5 then
            mainTab.Visible = true
            playerTab.Visible = true
            visualTab.Visible = true
            debugTab.Visible = true
            settingsTab.Visible = true
        elseif i == 6 then
            tabContainer.Visible = true
        elseif i == 7 then
            mainContent.Visible = true
            playerListFrame.Visible = true
        elseif i == 8 then
            for _, child in ipairs(mainContent:GetChildren()) do
                if child:IsA("TextButton") then
                    child.Visible = true
                end
            end
            updatePlayerList()
            initDebugPanel()
        end

        wait(ANIMATION_STEP_DELAY)
    end
    logDebug("Админ-панель открыта")
end

-- Анимация закрытия окна
local function closeWindow()
    for i = ANIMATION_STEPS, 1, -1 do
        if i == 8 then
            for _, child in ipairs(mainContent:GetChildren()) do
                if child:IsA("TextButton") then
                    child.Visible = false
                end
            end
        elseif i == 7 then
            mainContent.Visible = false
            playerListFrame.Visible = false
        elseif i == 6 then
            tabContainer.Visible = false
        elseif i == 5 then
            mainTab.Visible = false
            playerTab.Visible = false
            visualTab.Visible = false
            debugTab.Visible = false
            settingsTab.Visible = false
        elseif i == 4 then
            tabBar.Visible = false
        elseif i == 3 then
            minimizeBtn.Visible = false
            closeBtn.Visible = false
        elseif i == 2 then
            titleLabel.Visible = false
        elseif i == 1 then
            titleBar.Visible = false
        end

        wait(ANIMATION_STEP_DELAY)
    end

    mainFrame.Visible = false
    taskbarButton.Visible = true
    logDebug("Админ-панель закрыта")
end

-- Обработчики кнопок
closeBtn.MouseButton1Click:Connect(closeWindow)

minimizeBtn.MouseButton1Click:Connect(function()
    closeWindow()
    taskbarButton.Visible = true
end)

taskbarButton.MouseButton1Click:Connect(function()
    taskbarButton.Visible = false
    openWindow()
end)

-- Переключение вкладок
mainTab.MouseButton1Click:Connect(function()
    mainContent.Visible = true
    playerContent.Visible = false
    visualContent.Visible = false
    debugContent.Visible = false
    settingsContent.Visible = false
end)

playerTab.MouseButton1Click:Connect(function()
    mainContent.Visible = false
    playerContent.Visible = true
    visualContent.Visible = false
    debugContent.Visible = false
    settingsContent.Visible = false
end)

visualTab.MouseButton1Click:Connect(function()
    mainContent.Visible = false
    playerContent.Visible = false
    visualContent.Visible = true
    debugContent.Visible = false
    settingsContent.Visible = false
end)

debugTab.MouseButton1Click:Connect(function()
    mainContent.Visible = false
    playerContent.Visible = false
    visualContent.Visible = false
    debugContent.Visible = true
    settingsContent.Visible = false
end)

settingsTab.MouseButton1Click:Connect(function()
    mainContent.Visible = false
    playerContent.Visible = false
    visualContent.Visible = false
    debugContent.Visible = false
    settingsContent.Visible = true
end)

-- Перетаскивание окна
local dragging = false
local dragOffset = Vector2.new(0, 0)
local dragStartPos = UDim2.new(0.5, -300, 0.5, -350)

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = mainFrame.Position
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
    openWindow()
else
    taskbarButton.Visible = true
end

-- Обработка выхода из игры
player.CharacterRemoving:Connect(function()
    stopFlying()
end)

-- Защита от ошибок
RunService.Heartbeat:Connect(function()
    if flying and not player.Character then
        stopFlying()
    end
end)

-- Инициализация дебаг-лога
logDebug("Админ-панель инициализирована")
logDebug("Версия: Reborn v1.5")
logDebug("Игрок: " .. player.Name)
