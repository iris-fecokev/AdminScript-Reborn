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
    FlySpeed = 50,
    ExplosionRadius = 20,
    Language = "ru"
}

-- Локализация
local localization = {
    ru = {
        main_title = "AdminScript by IRIS_FECOKEV",
        tab_main = "Основные",
        tab_players = "Игроки",
        tab_visual = "Визуал",
        tab_debug = "Дебаг",
        tab_settings = "Настройки",
        refresh_players = "Обновить список игроков",
        kill_selected = "Убить выбранных",
        kill_all = "Убить всех игроков",
        teleport_to_player = "Телепорт к игроку",
        heal_selected = "Исцелить выбранных",
        heal_all = "Исцелить всех",
        freeze_selected = "Заблокировать выбранных",
        freeze_all = "Заморозить всех",
        unfreeze_selected = "Разблокировать выбранных",
        unfreeze_all = "Разморозить всех",
        freeze_map = "Заморозить карту",
        unfreeze_map = "Разморозить карту",
        create_explosion = "Создать взрыв",
        teleport_spawn = "Телепорт на спавн",
        flying = "Летание",
        noclip = "Ноклип",
        godmode = "Бессмертие",
        infinite_jump = "Беск. прыжок",
        speed_x2 = "Скорость x2",
        speed_x5 = "Скорость x5",
        day = "День",
        night = "Ночь",
        moon_gravity = "Лунная гравитация",
        rainbow_char = "Радужный персонаж",
        black_hole = "Создать черную дыру",
        esp = "Показать ESP",
        auto_open = "Авто-открытие при запуске",
        fly_speed = "Скорость полёта",
        explosion_radius = "Радиус взрыва",
        language = "Язык",
        on = "ВКЛ",
        off = "ВЫКЛ",
        selected = "✓ ВЫБРАН",
        select = "Выбрать",
        notification = "Уведомление",
        tooltip = "Подсказка"
    },
    en = {
        main_title = "AdminScript by IRIS_FECOKEV",
        tab_main = "Main",
        tab_players = "Players",
        tab_visual = "Visual",
        tab_debug = "Debug",
        tab_settings = "Settings",
        refresh_players = "Refresh player list",
        kill_selected = "Kill selected",
        kill_all = "Kill all players",
        teleport_to_player = "Teleport to player",
        heal_selected = "Heal selected",
        heal_all = "Heal all",
        freeze_selected = "Freeze selected",
        freeze_all = "Freeze all",
        unfreeze_selected = "Unfreeze selected",
        unfreeze_all = "Unfreeze all",
        freeze_map = "Freeze map",
        unfreeze_map = "Unfreeze map",
        create_explosion = "Create explosion",
        teleport_spawn = "Teleport to spawn",
        flying = "Flying",
        noclip = "Noclip",
        godmode = "God mode",
        infinite_jump = "Inf. jump",
        speed_x2 = "Speed x2",
        speed_x5 = "Speed x5",
        day = "Day",
        night = "Night",
        moon_gravity = "Moon gravity",
        rainbow_char = "Rainbow character",
        black_hole = "Create black hole",
        esp = "Show ESP",
        auto_open = "Auto-open on start",
        fly_speed = "Fly speed",
        explosion_radius = "Explosion radius",
        language = "Language",
        on = "ON",
        off = "OFF",
        selected = "✓ SELECTED",
        select = "Select",
        notification = "Notification",
        tooltip = "Tooltip"
    },
    es = {
        main_title = "AdminScript by IRIS_FECOKEV",
        tab_main = "Principal",
        tab_players = "Jugadores",
        tab_visual = "Visual",
        tab_debug = "Depuración",
        tab_settings = "Configuración",
        refresh_players = "Actualizar lista",
        kill_selected = "Matar seleccionados",
        kill_all = "Matar a todos",
        teleport_to_player = "Teletransportarse al jugador",
        heal_selected = "Curar seleccionados",
        heal_all = "Curar a todos",
        freeze_selected = "Congelar seleccionados",
        freeze_all = "Congelar a todos",
        unfreeze_selected = "Descongelar seleccionados",
        unfreeze_all = "Descongelar a todos",
        freeze_map = "Congelar mapa",
        unfreeze_map = "Descongelar mapa",
        create_explosion = "Crear explosión",
        teleport_spawn = "Teletransportarse al spawn",
        flying = "Volar",
        noclip = "Noclip",
        godmode = "Modo dios",
        infinite_jump = "Salto inf.",
        speed_x2 = "Velocidad x2",
        speed_x5 = "Velocidad x5",
        day = "Día",
        night = "Noche",
        moon_gravity = "Gravedad lunar",
        rainbow_char = "Personaje arcoíris",
        black_hole = "Crear agujero negro",
        esp = "Mostrar ESP",
        auto_open = "Abrir automáticamente",
        fly_speed = "Velocidad de vuelo",
        explosion_radius = "Radio de explosión",
        language = "Idioma",
        on = "ACTIVADO",
        off = "DESACTIVADO",
        selected = "✓ SELECCIONADO",
        select = "Seleccionar",
        notification = "Notificación",
        tooltip = "Información"
    },
    fr = {
        main_title = "AdminScript by IRIS_FECOKEV",
        tab_main = "Principal",
        tab_players = "Joueurs",
        tab_visual = "Visuel",
        tab_debug = "Débogage",
        tab_settings = "Paramètres",
        refresh_players = "Actualiser liste",
        kill_selected = "Tuer sélectionnés",
        kill_all = "Tuer tous",
        teleport_to_player = "Téléportation au joueur",
        heal_selected = "Soigner sélectionnés",
        heal_all = "Soigner tous",
        freeze_selected = "Geler sélectionnés",
        freeze_all = "Geler tous",
        unfreeze_selected = "Dégeler sélectionnés",
        unfreeze_all = "Dégeler tous",
        freeze_map = "Geler carte",
        unfreeze_map = "Dégeler carte",
        create_explosion = "Créer explosion",
        teleport_spawn = "Téléportation au spawn",
        flying = "Voler",
        noclip = "Noclip",
        godmode = "Mode dieu",
        infinite_jump = "Saut infini",
        speed_x2 = "Vitesse x2",
        speed_x5 = "Vitesse x5",
        day = "Jour",
        night = "Nuit",
        moon_gravity = "Gravité lunaire",
        rainbow_char = "Personnage arc-en-ciel",
        black_hole = "Créer trou noir",
        esp = "Afficher ESP",
        auto_open = "Ouvrir auto.",
        fly_speed = "Vitesse vol",
        explosion_radius = "Rayon explosion",
        language = "Langue",
        on = "ACTIVÉ",
        off = "DÉSACTIVÉ",
        selected = "✓ SÉLECTIONNÉ",
        select = "Sélectionner",
        notification = "Notification",
        tooltip = "Info-bulle"
    },
    de = {
        main_title = "AdminScript by IRIS_FECOKEV",
        tab_main = "Haupt",
        tab_players = "Spieler",
        tab_visual = "Visuell",
        tab_debug = "Debug",
        tab_settings = "Einstellungen",
        refresh_players = "Spielerliste aktualisieren",
        kill_selected = "Ausgewählte töten",
        kill_all = "Alle töten",
        teleport_to_player = "Zu Spieler teleportieren",
        heal_selected = "Ausgewählte heilen",
        heal_all = "Alle heilen",
        freeze_selected = "Ausgewählte einfrieren",
        freeze_all = "Alle einfrieren",
        unfreeze_selected = "Ausgewählte auftauen",
        unfreeze_all = "Alle auftauen",
        freeze_map = "Karte einfrieren",
        unfreeze_map = "Karte auftauen",
        create_explosion = "Explosion erstellen",
        teleport_spawn = "Zum Spawn teleportieren",
        flying = "Fliegen",
        noclip = "Noclip",
        godmode = "Gottmodus",
        infinite_jump = "Unendl. Sprung",
        speed_x2 = "Geschwindigkeit x2",
        speed_x5 = "Geschwindigkeit x5",
        day = "Tag",
        night = "Nacht",
        moon_gravity = "Mondgravitation",
        rainbow_char = "Regenbogencharakter",
        black_hole = "Schwarzes Loch erstellen",
        esp = "ESP anzeigen",
        auto_open = "Auto-Öffnen",
        fly_speed = "Fluggeschwindigkeit",
        explosion_radius = "Explosionsradius",
        language = "Sprache",
        on = "EIN",
        off = "AUS",
        selected = "✓ AUSGEWÄHLT",
        select = "Auswählen",
        notification = "Benachrichtigung",
        tooltip = "Tooltip"
    }
}

local t = function(key)
    return localization[settings.Language][key] or key
end

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
titleLabel.Text = t("main_title")
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

local mainTab = createTabButton(t("tab_main"), 8)
local playerTab = createTabButton(t("tab_players"), 93)
local visualTab = createTabButton(t("tab_visual"), 178)
local debugTab = createTabButton(t("tab_debug"), 263)
local settingsTab = createTabButton(t("tab_settings"), 348)

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
notificationTitle.Text = t("notification")
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
            stateIndicator.Text = isActive and t("on") or ""
        end
    end
end

-- Система полёта
local flying = false
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
            moveVector = moveVector.Unit * settings.FlySpeed
        end

        if flyBV and flyBV.Parent then
            flyBV.Velocity = moveVector
        end
    end)
    
    showNotification(t("flying"), t("tooltip_flying"), 5)
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
    
    showNotification(t("flying"), t("notification_flying_off"), 3)
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
        selectBtn.Text = selectedPlayers[plr] and t("selected") or t("select")
        selectBtn.BackgroundColor3 = selectedPlayers[plr] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 200, 200)
        selectBtn.TextColor3 = Color3.new(0, 0, 0)
        selectBtn.Font = Enum.Font.SourceSansBold
        selectBtn.TextSize = 14
        selectBtn.Parent = playerFrame
        
        selectBtn.MouseButton1Click:Connect(function()
            selectedPlayers[plr] = not selectedPlayers[plr]
            selectBtn.Text = selectedPlayers[plr] and t("selected") or t("select")
            selectBtn.BackgroundColor3 = selectedPlayers[plr] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 200, 200)
        end)
        
        playerFrame.Parent = playerListFrame
    end
end

-- Система заморозки
local frozenPlayers = {}
local originalColors = {} -- Для сохранения оригинальных цветов
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
    showNotification(t("freeze_selected"), t("notification_freeze_selected"), 3)
end

local function freezeAllPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            
            if rootPart and humanoid and not frozenPlayers[plr] then
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
    showNotification(t("freeze_all"), t("notification_freeze_all"), 3)
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
    showNotification(t("unfreeze_selected"), t("notification_unfreeze_selected"), 3)
end

local function unfreezeAllPlayers()
    for plr, _ in pairs(frozenPlayers) do
        local data = frozenPlayers[plr]
        if data.humanoid and data.humanoid.Parent then
            data.humanoid.WalkSpeed = data.originalWalkSpeed
        end
        frozenPlayers[plr] = nil
    end
    showNotification(t("unfreeze_all"), t("notification_unfreeze_all"), 3)
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
    showNotification(t("moon_gravity"), t("notification_gravity") .. value, 3)
end

local function setTimeOfDay(hour)
    Lighting.ClockTime = hour
    logDebug("Время суток установлено: " .. hour)
    showNotification(t(hour == 12 and "day" or "night"), t("notification_time") .. hour .. ":00", 3)
end

local function speedHack(speed)
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
            logDebug("Скорость установлена: " .. speed)
            showNotification(t("speed_x" .. (speed == 32 and "2" or "5")), t("notification_speed") .. speed, 3)
        end
    end
end

local function espPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local highlight = plr.Character:FindFirstChild("AdminESP")
            if highlight then highlight:Destroy() end
            
            highlight = Instance.new("Highlight")
            highlight.Name = "AdminESP"
            highlight.FillColor = Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.Parent = plr.Character
        end
    end
    logDebug("ESP включен")
    showNotification(t("esp"), t("notification_esp_on"), 3)
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
    showNotification(t("esp"), t("notification_esp_off"), 3)
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
    showNotification(t("ghost_mode"), t("notification_ghost_mode"), 3)
end

local function infiniteJump()
    local connection
    connection = UserInputService.JumpRequest:Connect(function()
        if player.Character then
            local humanoid = player.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end
    end)
    
    logDebug("Бесконечный прыжок включен")
    showNotification(t("infinite_jump"), t("notification_infinite_jump"), 3)
    
    return connection
end

local noclipConnection
local function noclip(state)
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            if player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
        showNotification(t("noclip"), t("notification_noclip_on"), 3)
    else
        if player.Character then
            for _, part in ipairs(player.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
        showNotification(t("noclip"), t("notification_noclip_off"), 3)
    end
    return state
end

local function godMode(state)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if state then
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                showNotification(t("godmode"), t("notification_godmode_on"), 3)
            else
                humanoid.MaxHealth = 100
                humanoid.Health = 100
                showNotification(t("godmode"), t("notification_godmode_off"), 3)
            end
        end
    end
    return state
end

local function teleportToPosition(position)
    if player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = position
            logDebug("Телепортирован на позицию: " .. tostring(position))
            showNotification(t("teleport_spawn"), t("notification_teleport"), 3)
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
    showNotification(t("create_explosion"), t("notification_explosion") .. radius, 3)
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
    showNotification(t("rainbow_char"), t("notification_rainbow"), 3)
end

local function freezeMap()
    originalColors = {}
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored == false then
            originalColors[part] = part.Color
            part.Anchored = true
            part.Color = Color3.new(0.5, 0.5, 1)
        end
    end
    logDebug("Карта заморожена")
    showNotification(t("freeze_map"), t("notification_freeze_map"), 3)
end

local function unfreezeMap()
    for part, originalColor in pairs(originalColors) do
        if part:IsA("BasePart") then
            part.Anchored = false
            part.Color = originalColor
        end
    end
    originalColors = {}
    logDebug("Карта разморожена")
    showNotification(t("unfreeze_map"), t("notification_unfreeze_map"), 3)
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
    showNotification(t("black_hole"), t("notification_black_hole"), 3)
end

local function killAllPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
            end
        end
    end
    showNotification(t("kill_all"), t("notification_kill_all"), 3)
end

local function healAllPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end
    end
    showNotification(t("heal_all"), t("notification_heal_all"), 3)
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
        activeStates[stateKey] = not activeStates[stateKey]
        func(activeStates[stateKey])
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

-- Обновление интерфейса при смене языка
local function updateUIForLanguage()
    titleLabel.Text = t("main_title")
    mainTab.Text = t("tab_main")
    playerTab.Text = t("tab_players")
    visualTab.Text = t("tab_visual")
    debugTab.Text = t("tab_debug")
    settingsTab.Text = t("tab_settings")
    
    -- Очищаем вкладки
    for _, content in pairs({mainContent, playerContent, visualContent, debugContent, settingsContent}) do
        content:ClearAllChildren()
    end
    
    -- Пересоздаем кнопки с новыми переводами
    createButtons()
end

-- Создание кнопок
local function createButtons()
    -- Основные функции
    addButton(mainContent, t("refresh_players"), updatePlayerList, t("tooltip_refresh"))
    addButton(mainContent, t("kill_selected"), function()
        for plr, _ in pairs(selectedPlayers) do
            if plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
        showNotification(t("kill_selected"), t("notification_kill_selected"), 3)
    end, t("tooltip_kill_selected"))
    
    addButton(mainContent, t("kill_all"), killAllPlayers, t("tooltip_kill_all"))
    
    addButton(mainContent, t("teleport_to_player"), function()
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
                showNotification(t("teleport_to_player"), t("notification_teleport_to_player") .. target.Name, 3)
            end
        end
    end, t("tooltip_teleport_to_player"))
    
    addButton(mainContent, t("heal_selected"), function()
        for plr, _ in pairs(selectedPlayers) do
            if plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end
        showNotification(t("heal_selected"), t("notification_heal_selected"), 3)
    end, t("tooltip_heal_selected"))
    
    addButton(mainContent, t("heal_all"), healAllPlayers, t("tooltip_heal_all"))
    addButton(mainContent, t("freeze_selected"), freezeSelectedPlayers, t("tooltip_freeze_selected"))
    addButton(mainContent, t("freeze_all"), freezeAllPlayers, t("tooltip_freeze_all"))
    addButton(mainContent, t("unfreeze_selected"), unfreezeSelectedPlayers, t("tooltip_unfreeze_selected"))
    addButton(mainContent, t("unfreeze_all"), unfreezeAllPlayers, t("tooltip_unfreeze_all"))
    
    -- Дополнительные функции
    addButton(mainContent, t("create_explosion"), function()
        if player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                createExplosion(rootPart.Position, settings.ExplosionRadius)
            end
        end
    end, t("tooltip_create_explosion"))
    
    addButton(mainContent, t("teleport_spawn"), function()
        teleportToPosition(CFrame.new(0, 100, 0))
    end, t("tooltip_teleport_spawn"))
    
    addButton(mainContent, t("freeze_map"), freezeMap, t("tooltip_freeze_map"))
    addButton(mainContent, t("unfreeze_map"), unfreezeMap, t("tooltip_unfreeze_map"))
    
    -- Кнопки с состоянием
    createStateButton(mainContent, t("flying"), function(state)
        if state then
            startFlying()
        else
            stopFlying()
        end
    end, "Fly", t("tooltip_flying"))
    
    createStateButton(mainContent, t("noclip"), noclip, "Noclip", t("tooltip_noclip"))
    createStateButton(mainContent, t("godmode"), godMode, "GodMode", t("tooltip_godmode"))
    
    createStateButton(mainContent, t("infinite_jump"), function(state)
        if state then
            infiniteJump()
        end
    end, "InfiniteJump", t("tooltip_infinite_jump"))
    
    -- Визуальные функции
    addButton(visualContent, t("speed_x2"), function()
        speedHack(32)
    end, t("tooltip_speed_x2"))
    
    addButton(visualContent, t("speed_x5"), function()
        speedHack(80)
    end, t("tooltip_speed_x5"))
    
    addButton(visualContent, t("day"), function()
        setTimeOfDay(12)
    end, t("tooltip_day"))
    
    addButton(visualContent, t("night"), function()
        setTimeOfDay(0)
    end, t("tooltip_night"))
    
    addButton(visualContent, t("moon_gravity"), function()
        changeGravity(10)
    end, t("tooltip_moon_gravity"))
    
    addButton(visualContent, t("rainbow_char"), rainbowCharacter, t("tooltip_rainbow_char"))
    addButton(visualContent, t("black_hole"), function()
        if player.Character then
            local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                createBlackHole(rootPart.Position + rootPart.CFrame.LookVector * 10)
            end
        end
    end, t("tooltip_black_hole"))
    
    createStateButton(visualContent, t("esp"), function(state)
        if state then
            espPlayers()
        else
            removeESP()
        end
    end, "ESP", t("tooltip_esp"))
end

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
local autoOpenSetting = createSettingFrame(t("auto_open"))
autoOpenSetting.Parent = settingsContent

local autoOpenToggle = Instance.new("TextButton")
autoOpenToggle.Size = UDim2.new(0.3, 0, 0.8, 0)
autoOpenToggle.Position = UDim2.new(0.65, 0, 0.1, 0)
autoOpenToggle.Text = settings.AutoOpen and t("on") or t("off")
autoOpenToggle.TextColor3 = settings.AutoOpen and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
autoOpenToggle.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
autoOpenToggle.BorderColor3 = Color3.new(0, 0, 0)
autoOpenToggle.TextSize = 14
autoOpenToggle.Font = Enum.Font.SourceSansBold
autoOpenToggle.Visible = true
autoOpenToggle.Parent = autoOpenSetting

autoOpenToggle.MouseButton1Click:Connect(function()
    settings.AutoOpen = not settings.AutoOpen
    autoOpenToggle.Text = settings.AutoOpen and t("on") or t("off")
    autoOpenToggle.TextColor3 = settings.AutoOpen and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
    showNotification(t("settings"), t("notification_auto_open") .. (settings.AutoOpen and t("on") or t("off")), 3)
end)

local flySpeedSetting = createSettingFrame(t("fly_speed") .. ": " .. settings.FlySpeed)
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
        flySpeedSetting:FindFirstChild("TextLabel").Text = t("fly_speed") .. ": " .. newSpeed
        showNotification(t("settings"), t("notification_fly_speed") .. newSpeed, 3)
    else
        flySpeedInput.Text = tostring(settings.FlySpeed)
    end
end)

local explosionRadiusSetting = createSettingFrame(t("explosion_radius") .. ": " .. settings.ExplosionRadius)
explosionRadiusSetting.Parent = settingsContent

local explosionRadiusInput = Instance.new("TextBox")
explosionRadiusInput.Size = UDim2.new(0.3, 0, 0.8, 0)
explosionRadiusInput.Position = UDim2.new(0.65, 0, 0.1, 0)
explosionRadiusInput.Text = tostring(settings.ExplosionRadius)
explosionRadiusInput.TextColor3 = Color3.new(0, 0, 0)
explosionRadiusInput.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
explosionRadiusInput.BorderColor3 = Color3.new(0, 0, 0)
explosionRadiusInput.TextSize = 14
explosionRadiusInput.Font = Enum.Font.SourceSansBold
explosionRadiusInput.Visible = true
explosionRadiusInput.Parent = explosionRadiusSetting

explosionRadiusInput.FocusLost:Connect(function()
    local newRadius = tonumber(explosionRadiusInput.Text)
    if newRadius and newRadius > 0 then
        settings.ExplosionRadius = newRadius
        explosionRadiusSetting:FindFirstChild("TextLabel").Text = t("explosion_radius") .. ": " .. newRadius
        showNotification(t("settings"), t("notification_explosion_radius") .. newRadius, 3)
    else
        explosionRadiusInput.Text = tostring(settings.ExplosionRadius)
    end
end)

local languageSetting = createSettingFrame(t("language") .. ": " .. settings.Language:upper())
languageSetting.Parent = settingsContent

local languageDropdown = Instance.new("TextButton")
languageDropdown.Size = UDim2.new(0.3, 0, 0.8, 0)
languageDropdown.Position = UDim2.new(0.65, 0, 0.1, 0)
languageDropdown.Text = settings.Language:upper()
languageDropdown.TextColor3 = Color3.new(0, 0, 0)
languageDropdown.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
languageDropdown.BorderColor3 = Color3.new(0, 0, 0)
languageDropdown.TextSize = 14
languageDropdown.Font = Enum.Font.SourceSansBold
languageDropdown.Visible = true
languageDropdown.Parent = languageSetting

languageDropdown.MouseButton1Click:Connect(function()
    local languages = {"ru", "en", "es", "fr", "de"}
    local currentIndex = table.find(languages, settings.Language) or 1
    local nextIndex = (currentIndex % #languages) + 1
    settings.Language = languages[nextIndex]
    languageDropdown.Text = settings.Language:upper()
    languageSetting:FindFirstChild("TextLabel").Text = t("language") .. ": " .. settings.Language:upper()
    updateUIForLanguage()
    showNotification(t("settings"), t("notification_language") .. settings.Language:upper(), 3)
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
            createButtons()
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
closeBtn.MouseButton1Click:Connect(function()
    closeWindow()
    gui:Destroy() -- Полностью удаляем GUI при закрытии
end)

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
playerTab.MouseButton1Click:Connect(function() 
    switchTab(playerContent)
    updatePlayerList()
end)
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
    if noclipConnection then
        noclipConnection:Disconnect()
    end
end)

-- Защита от ошибок
RunService.Heartbeat:Connect(function()
    if flying and not player.Character then
        stopFlying()
    end
end)

-- Инициализация дебаг-лога
logDebug("Админ-панель инициализирована")
logDebug("Версия: Ultimate v4.0")
logDebug("Игрок: " .. player.Name)
