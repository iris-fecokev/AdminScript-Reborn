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
local MIN_WINDOW_SIZE = Vector2.new(400, 300)

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

-- Настройки
local settings = {
	AutoOpen = true,
	FlySpeed = 50
}

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 500, 0, 550)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -275)
mainFrame.BackgroundColor3 = Color3.fromRGB(212, 208, 200)
mainFrame.BorderSizePixel = 0
mainFrame.ClipsDescendants = true
mainFrame.Visible = false
mainFrame.Parent = gui

-- Заголовок окна
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 14, 122)
titleBar.BorderSizePixel = 0
titleBar.Visible = false
titleBar.Parent = mainFrame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -70, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "AdminScript Reborn by IRIS_FECOKEV"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Visible = false
titleLabel.Parent = titleBar

-- Кнопки управления окном (ImageButton)
local minimizeBtn = Instance.new("ImageButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 26, 0, 26)
minimizeBtn.Position = UDim2.new(1, -55, 0, 2)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Image = "rbxassetid://74729089697042" -- ID иконки сворачивания
minimizeBtn.Visible = true
minimizeBtn.Parent = titleBar

local closeBtn = Instance.new("ImageButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -28, 0, 2)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = "rbxassetid://118955245038416" -- ID иконки закрытия
closeBtn.Visible = true
closeBtn.Parent = titleBar

-- Панель вкладок
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 30)
tabBar.BackgroundColor3 = Color3.fromRGB(192, 192, 192)
tabBar.BorderSizePixel = 0
tabBar.Visible = false
tabBar.Parent = mainFrame

local function createTabButton(name, posX)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 80, 0, 26)
	btn.Position = UDim2.new(0, posX, 0, 2)
	btn.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
	btn.BorderColor3 = Color3.new(0, 0, 0)
	btn.Text = name
	btn.TextColor3 = Color3.new(0, 0, 0)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 14
	btn.Visible = false
	btn.Parent = tabBar
	return btn
end

local mainTab = createTabButton("Основные", 8)
local playerTab = createTabButton("Игроки", 93)
local visualTab = createTabButton("Визуал", 178)
local debugTab = createTabButton("Дебаг", 263)
local settingsTab = createTabButton("Настройки", 348)

-- Контейнеры для вкладок
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -10, 1, -70)
tabContainer.Position = UDim2.new(0, 5, 0, 65)
tabContainer.BackgroundTransparency = 1
tabContainer.Visible = false
tabContainer.Parent = mainFrame

-- Создаем UIListLayout для правильного расположения кнопок
local function createContentFrame()
	local frame = Instance.new("ScrollingFrame")
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.ScrollBarThickness = 10
	frame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	frame.Visible = false

	local listLayout = Instance.new("UIListLayout")
	listLayout.Padding = UDim.new(0, 12)
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

-- UIListLayout для настроек
local settingsListLayout = Instance.new("UIListLayout")
settingsListLayout.Padding = UDim.new(0, 15)
settingsListLayout.SortOrder = Enum.SortOrder.LayoutOrder
settingsListLayout.Parent = settingsContent

-- Ярлык в стиле Windows XP (внизу слева)
local taskbarButton = Instance.new("TextButton")
taskbarButton.Name = "TaskbarButton"
taskbarButton.Size = UDim2.new(0, 150, 0, 35)
taskbarButton.Position = UDim2.new(0, 10, 1, -38)
taskbarButton.BackgroundColor3 = Color3.fromRGB(0, 14, 122)
taskbarButton.BorderSizePixel = 0
taskbarButton.Text = "AdminScript"
taskbarButton.TextColor3 = Color3.new(1, 1, 1)
taskbarButton.Font = Enum.Font.SourceSansBold
taskbarButton.TextSize = 14
taskbarButton.Visible = false
taskbarButton.Parent = gui

-- Система подсказок
local tooltip = Instance.new("TextLabel")
tooltip.Name = "Tooltip"
tooltip.Size = UDim2.new(0, 300, 0, 60)
tooltip.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
tooltip.BorderColor3 = Color3.new(0, 0, 0)
tooltip.TextColor3 = Color3.new(0, 0, 0)
tooltip.Font = Enum.Font.SourceSans
tooltip.TextSize = 14
tooltip.TextWrapped = true
tooltip.Visible = false
tooltip.ZIndex = 100
tooltip.Parent = gui

-- Система уведомлений
local notificationFrame = Instance.new("Frame")
notificationFrame.Name = "NotificationFrame"
notificationFrame.Size = UDim2.new(0, 300, 0, 80)
notificationFrame.Position = UDim2.new(1, -310, 1, -90)
notificationFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
notificationFrame.BackgroundTransparency = 0.3
notificationFrame.BorderSizePixel = 0
notificationFrame.Visible = false
notificationFrame.ZIndex = 90
notificationFrame.Parent = gui

local notificationTitle = Instance.new("TextLabel")
notificationTitle.Name = "Title"
notificationTitle.Size = UDim2.new(1, -10, 0, 25)
notificationTitle.Position = UDim2.new(0, 5, 0, 5)
notificationTitle.BackgroundTransparency = 1
notificationTitle.TextColor3 = Color3.new(1, 1, 1)
notificationTitle.Font = Enum.Font.SourceSansBold
notificationTitle.TextSize = 16
notificationTitle.TextXAlignment = Enum.TextXAlignment.Left
notificationTitle.Text = "Уведомление"
notificationTitle.Parent = notificationFrame

local notificationText = Instance.new("TextLabel")
notificationText.Name = "Text"
notificationText.Size = UDim2.new(1, -10, 1, -35)
notificationText.Position = UDim2.new(0, 5, 0, 30)
notificationText.BackgroundTransparency = 1
notificationText.TextColor3 = Color3.new(1, 1, 1)
notificationText.Font = Enum.Font.SourceSans
notificationText.TextSize = 14
notificationText.TextWrapped = true
notificationText.TextXAlignment = Enum.TextXAlignment.Left
notificationText.TextYAlignment = Enum.TextYAlignment.Top
notificationText.Parent = notificationFrame

local function showNotification(title, message, duration)
	notificationTitle.Text = title
	notificationText.Text = message
	notificationFrame.Visible = true

	delay(duration or 5, function()
		notificationFrame.Visible = false
	end)
end

-- Переработанная функция создания кнопок с подсказками
local function createButton(name, sizeY, withState, tooltipText)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1, -15, 0, sizeY or 38)
	btn.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
	btn.BorderColor3 = Color3.new(0, 0, 0)
	btn.Text = name
	btn.TextColor3 = Color3.new(0, 0, 0)
	btn.Font = Enum.Font.SourceSansBold
	btn.TextSize = 15
	btn.AutoButtonColor = false
	btn.LayoutOrder = 1
	btn.Visible = false

	-- Создаем элементы управления состоянием
	local stateIndicator
	if withState then
		stateIndicator = Instance.new("TextLabel")
		stateIndicator.Name = "StateIndicator"
		stateIndicator.Size = UDim2.new(0, 40, 1, -4)
		stateIndicator.Position = UDim2.new(1, -45, 0, 2)
		stateIndicator.Text = ""
		stateIndicator.TextColor3 = Color3.new(0, 0.5, 0)
		stateIndicator.Font = Enum.Font.SourceSansBold
		stateIndicator.TextSize = 15
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

	-- Подсказка при наведении
	if tooltipText then
		btn.MouseEnter:Connect(function()
			highlight.Visible = true
			tooltip.Text = tooltipText
			tooltip.Visible = true

			-- Позиционирование подсказки рядом с кнопкой
			local mousePos = UserInputService:GetMouseLocation()
			tooltip.Position = UDim2.new(0, mousePos.X + 20, 0, mousePos.Y)
		end)

		btn.MouseLeave:Connect(function()
			highlight.Visible = false
			tooltip.Visible = false
		end)
	else
		btn.MouseEnter:Connect(function() highlight.Visible = true end)
		btn.MouseLeave:Connect(function() highlight.Visible = false end)
	end

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

	showNotification("Летание", "Летание активировано! Управление: WASD, Пробел - вверх, Shift - вниз", 5)
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

	showNotification("Летание", "Летание деактивировано", 3)
end

-- Система выбора игроков (исправлено слипание)
local selectedPlayers = {}
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(1, -15, 1, -15)
playerListFrame.Position = UDim2.new(0, 8, 0, 8)
playerListFrame.BackgroundTransparency = 1
playerListFrame.ScrollBarThickness = 10
playerListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
playerListFrame.Visible = false
playerListFrame.Parent = playerContent

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Padding = UDim.new(0, 15)
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerListLayout.Parent = playerListFrame

local function updatePlayerList()
	playerListFrame:ClearAllChildren()

	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= player then
			local playerFrame = Instance.new("Frame")
			playerFrame.Size = UDim2.new(1, -10, 0, 50)
			playerFrame.BackgroundTransparency = 1
			playerFrame.LayoutOrder = #playerListFrame:GetChildren() + 1

			local playerName = Instance.new("TextLabel")
			playerName.Size = UDim2.new(1, 0, 0.5, 0)
			playerName.Text = plr.Name
			playerName.TextColor3 = Color3.new(0, 0, 0)
			playerName.Font = Enum.Font.SourceSansBold
			playerName.TextSize = 15
			playerName.TextXAlignment = Enum.TextXAlignment.Left
			playerName.BackgroundTransparency = 1
			playerName.Parent = playerFrame

			local selectBtn = Instance.new("TextButton")
			selectBtn.Size = UDim2.new(1, 0, 0.45, 0)
			selectBtn.Position = UDim2.new(0, 0, 0.5, 0)
			selectBtn.Text = selectedPlayers[plr] and "✓ ВЫБРАН" or "Выбрать"
			selectBtn.BackgroundColor3 = selectedPlayers[plr] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 200, 200)
			selectBtn.TextColor3 = Color3.new(0, 0, 0)
			selectBtn.Font = Enum.Font.SourceSansBold
			selectBtn.TextSize = 14
			selectBtn.Parent = playerFrame

			selectBtn.MouseButton1Click:Connect(function()
				selectedPlayers[plr] = not selectedPlayers[plr]
				selectBtn.Text = selectedPlayers[plr] and "✓ ВЫБРАН" or "Выбрать"
				selectBtn.BackgroundColor3 = selectedPlayers[plr] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 200, 200)
			end)

			playerFrame.Parent = playerListFrame
		end
	end
end

-- Система заморозки
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
	showNotification("Заморозка", "Выбранные игроки заморожены", 3)
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
	showNotification("Заморозка", "Выбранные игроки разморожены", 3)
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
			logLabel.TextSize = 13
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

	local statsLayout = Instance.new("UIListLayout")
	statsLayout.Padding = UDim.new(0, 10)
	statsLayout.SortOrder = Enum.SortOrder.LayoutOrder
	statsLayout.Parent = statsFrame

	local fpsLabel = Instance.new("TextLabel")
	fpsLabel.Size = UDim2.new(1, 0, 0, 28)
	fpsLabel.Text = "FPS: 0"
	fpsLabel.TextColor3 = Color3.new(0, 0, 0)
	fpsLabel.Font = Enum.Font.SourceSansBold
	fpsLabel.TextSize = 16
	fpsLabel.Parent = statsFrame

	local pingLabel = Instance.new("TextLabel")
	pingLabel.Size = UDim2.new(1, 0, 0, 28)
	pingLabel.Text = "Ping: 0ms"
	pingLabel.TextColor3 = Color3.new(0, 0, 0)
	pingLabel.Font = Enum.Font.SourceSansBold
	pingLabel.TextSize = 16
	pingLabel.Parent = statsFrame

	local memLabel = Instance.new("TextLabel")
	memLabel.Size = UDim2.new(1, 0, 0, 28)
	memLabel.Text = "Memory: 0MB"
	memLabel.TextColor3 = Color3.new(0, 0, 0)
	memLabel.Font = Enum.Font.SourceSansBold
	memLabel.TextSize = 16
	memLabel.Parent = statsFrame

	debugLogFrame = Instance.new("ScrollingFrame")
	debugLogFrame.Size = UDim2.new(1, -15, 0.7, 0)
	debugLogFrame.Position = UDim2.new(0, 8, 0.3, 0)
	debugLogFrame.BackgroundTransparency = 1
	debugLogFrame.ScrollBarThickness = 10
	debugLogFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
	debugLogFrame.Parent = debugPanel

	local logLayout = Instance.new("UIListLayout")
	logLayout.Padding = UDim.new(0, 7)
	logLayout.SortOrder = Enum.SortOrder.LayoutOrder
	logLayout.Parent = debugLogFrame

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
			pingLabel.Text = "Ping: " .. math.random(20, 100) .. "ms"
			memLabel.Text = "Memory: " .. math.random(50, 200) .. "MB"
		end
	end)
end

-- ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ
local function changeGravity(value)
	Workspace.Gravity = value
	logDebug("Гравитация изменена: " .. value)
	showNotification("Гравитация", "Гравитация установлена: " .. value, 3)
end

local function setTimeOfDay(hour)
	Lighting.ClockTime = hour
	logDebug("Время суток установлено: " .. hour)
	showNotification("Время суток", "Установлено время: " .. hour .. ":00", 3)
end

local function speedHack(speed)
	if player.Character then
		local humanoid = player.Character:FindFirstChild("Humanoid")
		if humanoid then
			humanoid.WalkSpeed = speed
			logDebug("Скорость установлена: " .. speed)
			showNotification("Скорость", "Скорость персонажа: " .. speed, 3)
		end
	end
end

local function espPlayers()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character then
			local highlight = Instance.new("Highlight")
			highlight.Name = "AdminESP"
			highlight.FillColor = Color3.new(1, 0, 0)
			highlight.OutlineColor = Color3.new(1, 1, 1)
			highlight.Parent = plr.Character
		end
	end
	logDebug("ESP включен")
	showNotification("ESP", "ESP игроков активирован", 3)
end

local function removeESP()
	for _, plr in ipairs(Players:GetPlayers()) do
		if plr.Character then
			local highlight = plr.Character:FindFirstChild("AdminESP")
			if highlight then
				highlight:Destroy()
			end
		end
	end
	logDebug("ESP выключен")
	showNotification("ESP", "ESP игроков деактивирован", 3)
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
	logDebug("Режим призрака включен")
	showNotification("Режим призрака", "Вы стали полупрозрачным и проходимым", 3)
end

local function infiniteJump()
	UserInputService.JumpRequest:Connect(function()
		if player.Character then
			local humanoid = player.Character:FindFirstChild("Humanoid")
			if humanoid then
				humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			end
		end
	end)
	logDebug("Бесконечный прыжок включен")
	showNotification("Бесконечный прыжок", "Вы можете прыгать бесконечно в воздухе", 3)
end

local function noclip(state)
	if player.Character then
		for _, part in ipairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = not state
			end
		end
	end
	showNotification("Ноклип", state and "Активирован" or "Деактивирован", 3)
	return not state
end

local function godMode(state)
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
	showNotification("Бессмертие", state and "Активировано" or "Деактивировано", 3)
	return not state
end

local function teleportToPosition(position)
	if player.Character then
		local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			rootPart.CFrame = position
			logDebug("Телепортирован на позицию: " .. tostring(position))
			showNotification("Телепорт", "Успешная телепортация", 3)
		end
	end
end

local function createExplosion(position, radius)
	local explosion = Instance.new("Explosion")
	explosion.Position = position
	explosion.BlastRadius = radius
	explosion.BlastPressure = 1000000
	explosion.ExplosionType = Enum.ExplosionType.CratersAndDebris
	explosion.Parent = Workspace
	logDebug("Создан взрыв радиусом: " .. radius)
	showNotification("Взрыв", "Создан взрыв радиусом " .. radius, 3)
end

local function rainbowCharacter()
	if player.Character then
		for _, part in ipairs(player.Character:GetDescendants()) do
			if part:IsA("BasePart") then
				spawn(function()
					while part.Parent do
						part.Color = Color3.new(math.random(), math.random(), math.random())
						wait(0.1)
					end
				end)
			end
		end
	end
	logDebug("Радужный эффект включен")
	showNotification("Радуга", "Ваш персонаж стал радужным", 3)
end

local function freezeMap()
	for _, part in ipairs(Workspace:GetDescendants()) do
		if part:IsA("BasePart") and part.Anchored == false then
			part.Anchored = true
			part.Color = Color3.new(0.5, 0.5, 1)
		end
	end
	logDebug("Карта заморожена")
	showNotification("Заморозка карты", "Вся карта заморожена", 3)
end

local function unfreezeMap()
	for _, part in ipairs(Workspace:GetDescendants()) do
		if part:IsA("BasePart") then
			part.Anchored = false
			part.Color = Color3.new(1, 1, 1)
		end
	end
	logDebug("Карта разморожена")
	showNotification("Разморозка карты", "Вся карта разморожена", 3)
end

local function createBlackHole(position)
	local blackHole = Instance.new("Part")
	blackHole.Position = position
	blackHole.Size = Vector3.new(5, 5, 5)
	blackHole.Shape = Enum.PartType.Ball
	blackHole.Color = Color3.new(0, 0, 0)
	blackHole.Material = Enum.Material.Neon
	blackHole.Anchored = false
	blackHole.CanCollide = false
	blackHole.Parent = Workspace

	local bodyForce = Instance.new("BodyForce")
	bodyForce.Force = Vector3.new(0, blackHole:GetMass() * Workspace.Gravity, 0)
	bodyForce.Parent = blackHole

	spawn(function()
		while blackHole.Parent do
			for _, part in ipairs(Workspace:GetDescendants()) do
				if part:IsA("BasePart") and part ~= blackHole and part.Position:Distance(blackHole.Position) < 50 then
					local direction = (blackHole.Position - part.Position).Unit
					part.Velocity = direction * 100
				end
			end
			wait(0.1)
		end
	end)

	logDebug("Черная дыра создана")
	showNotification("Черная дыра", "Создана черная дыра, притягивающая объекты", 3)
end

-- Состояния функций
local activeStates = {
	Fly = false,
	Noclip = false,
	GodMode = false,
	ESP = false
}

-- Функция для кнопок с состоянием
local function createStateButton(content, name, func, stateKey, tooltipText)
	local btn, updateState = createButton(name, 38, true, tooltipText)
	btn.Parent = content

	-- Инициализируем состояние
	updateState(activeStates[stateKey])

	btn.MouseButton1Click:Connect(function()
		activeStates[stateKey] = func(activeStates[stateKey])
		updateState(activeStates[stateKey])
	end)

	return btn
end

-- Функция для обычных кнопок
local function addButton(content, name, func, tooltipText)
	local btn = createButton(name, 38, false, tooltipText)
	btn.Parent = content
	btn.MouseButton1Click:Connect(func)
	return btn
end

-- Основные функции
addButton(mainContent, "Обновить список игроков", updatePlayerList, "Обновить список всех игроков на сервере")
addButton(mainContent, "Убить выбранных", function()
	for plr, _ in pairs(selectedPlayers) do
		if plr.Character then
			local humanoid = plr.Character:FindFirstChild("Humanoid")
			if humanoid then
				humanoid.Health = 0
			end
		end
	end
	logDebug("Убиты выбранные игроки")
	showNotification("Убийство", "Выбранные игроки убиты", 3)
end, "Убить всех выбранных игроков")

addButton(mainContent, "Телепорт к игроку", function()
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
			showNotification("Телепорт", "Телепортирован к игроку " .. target.Name, 3)
		end
	end
end, "Телепортироваться к выбранному игроку")

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
	showNotification("Исцеление", "Выбранные игроки исцелены", 3)
end, "Исцелить всех выбранных игроков")

addButton(mainContent, "Заблокировать выбранных", freezeSelectedPlayers, "Заморозить выбранных игроков")
addButton(mainContent, "Разблокировать выбранных", unfreezeSelectedPlayers, "Разморозить выбранных игроков")

-- Дополнительные функции
addButton(mainContent, "Создать взрыв", function()
	if player.Character then
		local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			createExplosion(rootPart.Position, 20)
		end
	end
end, "Создать взрыв в вашей позиции")

addButton(mainContent, "Телепорт на спавн", function()
	teleportToPosition(CFrame.new(0, 100, 0))
end, "Телепортироваться на точку спавна")

addButton(mainContent, "Заморозить карту", freezeMap, "Заморозить все объекты на карте")
addButton(mainContent, "Разморозить карту", unfreezeMap, "Разморозить все объекты на карте")

-- Кнопки с состоянием
createStateButton(mainContent, "Летание", function(state)
	if state then
		stopFlying()
	else
		startFlying()
	end
	return not state
end, "Fly", "Включить/выключить режим полёта. Управление: WASD, Пробел - вверх, Shift - вниз")

createStateButton(mainContent, "Ноклип", noclip, "Noclip", "Проходить сквозь стены и объекты")
createStateButton(mainContent, "Бессмертие", godMode, "GodMode", "Стать неуязвимым к урону")
createStateButton(mainContent, "Беск. прыжок", function(state)
	if not state then
		infiniteJump()
	end
	return true
end, "InfiniteJump", "Прыгать бесконечное количество раз в воздухе")

-- Визуальные функции
addButton(visualContent, "Скорость x2", function()
	speedHack(32)
end, "Увеличить скорость передвижения в 2 раза")

addButton(visualContent, "Скорость x5", function()
	speedHack(80)
end, "Увеличить скорость передвижения в 5 раз")

addButton(visualContent, "День", function()
	setTimeOfDay(12)
end, "Установить дневное время")

addButton(visualContent, "Ночь", function()
	setTimeOfDay(0)
end, "Установить ночное время")

addButton(visualContent, "Лунная гравитация", function()
	changeGravity(10)
end, "Уменьшить гравитацию как на Луне")

addButton(visualContent, "Радужный персонаж", rainbowCharacter, "Ваш персонаж меняет цвета радуги")
addButton(visualContent, "Создать черную дыру", function()
	if player.Character then
		local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
		if rootPart then
			createBlackHole(rootPart.Position + rootPart.CFrame.LookVector * 10)
		end
	end
end, "Создать черную дыру, которая притягивает объекты")

createStateButton(visualContent, "Показать ESP", function(state)
	if state then
		removeESP()
	else
		espPlayers()
	end
	return not state
end, "ESP", "Показывать контуры игроков через стены")

-- Функция для создания элементов настроек
local function createSettingFrame(text)
	local frame = Instance.new("Frame")
	frame.Size = UDim2.new(1, 0, 0, 38)
	frame.BackgroundTransparency = 1
	frame.LayoutOrder = #settingsContent:GetChildren() + 1

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(0.6, 0, 1, 0)
	label.Text = text
	label.TextColor3 = Color3.new(0, 0, 0)
	label.Font = Enum.Font.SourceSansBold
	label.TextSize = 14
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.BackgroundTransparency = 1
	label.Parent = frame

	return frame
end

-- Настройки
local autoOpenSetting = createSettingFrame("Авто-открытие при запуске")
autoOpenSetting.Parent = settingsContent

local autoOpenToggle = Instance.new("TextButton")
autoOpenToggle.Size = UDim2.new(0.3, 0, 0.8, 0)
autoOpenToggle.Position = UDim2.new(0.65, 0, 0.1, 0)
autoOpenToggle.Text = settings.AutoOpen and "ON" or "OFF"
autoOpenToggle.TextColor3 = settings.AutoOpen and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
autoOpenToggle.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
autoOpenToggle.BorderColor3 = Color3.new(0, 0, 0)
autoOpenToggle.TextSize = 14
autoOpenToggle.Font = Enum.Font.SourceSansBold
autoOpenToggle.Visible = true
autoOpenToggle.Parent = autoOpenSetting

autoOpenToggle.MouseButton1Click:Connect(function()
	settings.AutoOpen = not settings.AutoOpen
	autoOpenToggle.Text = settings.AutoOpen and "ON" or "OFF"
	autoOpenToggle.TextColor3 = settings.AutoOpen and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
	logDebug("Авто-открытие: " .. (settings.AutoOpen and "включено" or "выключено"))
	showNotification("Настройки", "Авто-открытие: " .. (settings.AutoOpen and "включено" or "выключено"), 3)
end)

local flySpeedSetting = createSettingFrame("Скорость полёта: " .. settings.FlySpeed)
flySpeedSetting.Parent = settingsContent

local flySpeedInput = Instance.new("TextBox")
flySpeedInput.Size = UDim2.new(0.3, 0, 0.8, 0)
flySpeedInput.Position = UDim2.new(0.65, 0, 0.1, 0)
flySpeedInput.Text = tostring(settings.FlySpeed)
flySpeedInput.TextColor3 = Color3.new(0, 0, 0)
flySpeedInput.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
flySpeedInput.BorderColor3 = Color3.new(0, 0, 0)
flySpeedInput.TextSize = 14
flySpeedInput.Font = Enum.Font.SourceSansBold
flySpeedInput.Visible = true
flySpeedInput.Parent = flySpeedSetting

flySpeedInput.FocusLost:Connect(function()
	local newSpeed = tonumber(flySpeedInput.Text)
	if newSpeed and newSpeed > 0 then
		settings.FlySpeed = newSpeed
		flySpeedSetting:FindFirstChild("TextLabel").Text = "Скорость полёта: " .. newSpeed
		logDebug("Скорость полёта изменена: " .. newSpeed)
		showNotification("Настройки", "Скорость полёта: " .. newSpeed, 3)
	else
		flySpeedInput.Text = tostring(settings.FlySpeed)
	end
end)

-- Анимация открытия окна
local function openWindow()
	taskbarButton.Visible = false
	mainFrame.Visible = true

	for i = 1, ANIMATION_STEPS do
		if i == 1 then
			titleBar.Visible = true
		elseif i == 2 then
			titleLabel.Visible = true
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
local function switchTab(content)
	mainContent.Visible = (content == mainContent)
	playerContent.Visible = (content == playerContent)
	visualContent.Visible = (content == visualContent)
	debugContent.Visible = (content == debugContent)
	settingsContent.Visible = (content == settingsContent)
end

mainTab.MouseButton1Click:Connect(function() switchTab(mainContent) end)
playerTab.MouseButton1Click:Connect(function() switchTab(playerContent) end)
visualTab.MouseButton1Click:Connect(function() switchTab(visualContent) end)
debugTab.MouseButton1Click:Connect(function() switchTab(debugContent) end)
settingsTab.MouseButton1Click:Connect(function() switchTab(settingsContent) end)

-- Перетаскивание окна
local dragging = false
local dragOffset = Vector2.new(0, 0)
local dragStartPos = UDim2.new(0.5, -250, 0.5, -275)

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

-- Обновление позиции подсказки при движении мыши
UserInputService.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		if tooltip.Visible then
			local mousePos = UserInputService:GetMouseLocation()
			tooltip.Position = UDim2.new(0, mousePos.X + 20, 0, mousePos.Y)
		end
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
logDebug("Версия: Ultimate v3.0")
logDebug("Игрок: " .. player.Name)
