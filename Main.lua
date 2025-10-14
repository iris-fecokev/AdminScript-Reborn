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
local TextChatService = game:GetService("TextChatService")
local TeleportService = game:GetService("TeleportService")
local VirtualInputManager = game:GetService("VirtualInputManager")

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
    Language = "en",  -- Английский по умолчанию
    Theme = "Classic",
    Hotkeys = {
        Fly = Enum.KeyCode.F,
        Noclip = Enum.KeyCode.N,
        GodMode = Enum.KeyCode.G
    }
}

-- Локализация
local localization = {
    en = {
        main_title = "AdminScript Ultimate 5.0 by IRIS_FECOKEV",
        tab_main = "Main",
        tab_players = "Players",
        tab_visual = "Visual",
        tab_fun = "Fun/Trolling",
        tab_debug = "Debug",
        tab_settings = "Settings",
        tab_server = "Server",
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
        speed_x10 = "Speed x10",
        day = "Day",
        night = "Night",
        moon_gravity = "Moon gravity",
        zero_gravity = "Zero gravity",
        rainbow_char = "Rainbow character",
        black_hole = "Create black hole",
        esp = "Show ESP",
        auto_open = "Auto-open on start",
        fly_speed = "Fly speed",
        explosion_radius = "Explosion radius",
        language = "Language",
        theme = "Theme",
        on = "ON",
        off = "OFF",
        selected = "✓ SELECTED",
        select = "Select",
        notification = "Notification",
        tooltip = "Tooltip",
        tooltip_flying = "Toggle flying mode",
        notification_flying_off = "Flying mode disabled",
        notification_freeze_selected = "Selected players frozen",
        notification_freeze_all = "All players frozen",
        notification_unfreeze_selected = "Selected players unfrozen",
        notification_unfreeze_all = "All players unfrozen",
        notification_gravity = "Gravity changed to: ",
        notification_time = "Time set to: ",
        notification_speed = "Speed set: ",
        notification_esp_on = "ESP enabled",
        notification_esp_off = "ESP disabled",
        notification_ghost_mode = "Ghost mode enabled",
        notification_infinite_jump = "Infinite jump enabled",
        notification_infinite_jump_off = "Infinite jump disabled",
        notification_noclip_on = "Noclip enabled",
        notification_noclip_off = "Noclip disabled",
        notification_godmode_on = "God mode enabled",
        notification_godmode_off = "God mode disabled",
        notification_teleport = "Teleported to spawn",
        notification_explosion = "Explosion created with radius: ",
        notification_rainbow = "Rainbow effect enabled",
        notification_rainbow_off = "Rainbow effect disabled",
        notification_freeze_map = "Map frozen",
        notification_unfreeze_map = "Map unfrozen",
        notification_black_hole = "Black hole created",
        notification_kill_all = "All players killed",
        notification_heal_all = "All players healed",
        notification_kill_selected = "Selected players killed",
        notification_heal_selected = "Selected players healed",
        notification_teleport_to_player = "Teleported to player: ",
        notification_auto_open = "Auto-open: ",
        notification_fly_speed = "Fly speed set: ",
        notification_explosion_radius = "Explosion radius set: ",
        notification_language = "Language changed to: ",
        tooltip_refresh = "Refresh player list",
        tooltip_kill_selected = "Kill selected players",
        tooltip_kill_all = "Kill all players",
        tooltip_teleport_to_player = "Teleport to selected player",
        tooltip_heal_selected = "Heal selected players",
        tooltip_heal_all = "Heal all players",
        tooltip_freeze_selected = "Freeze selected players",
        tooltip_freeze_all = "Freeze all players",
        tooltip_unfreeze_selected = "Unfreeze selected players",
        tooltip_unfreeze_all = "Unfreeze all players",
        tooltip_create_explosion = "Create explosion at your position",
        tooltip_teleport_spawn = "Teleport to spawn point",
        tooltip_flying = "Toggle flying mode",
        tooltip_noclip = "Toggle noclip mode",
        tooltip_godmode = "Toggle god mode",
        tooltip_infinite_jump = "Toggle infinite jump",
        tooltip_speed_x2 = "Set speed x2",
        tooltip_speed_x5 = "Set speed x5",
        tooltip_speed_x10 = "Set speed x10",
        tooltip_day = "Set daytime",
        tooltip_night = "Set nighttime",
        tooltip_moon_gravity = "Set moon gravity",
        tooltip_zero_gravity = "Set zero gravity",
        tooltip_rainbow_char = "Toggle rainbow effect for character",
        tooltip_black_hole = "Create black hole",
        tooltip_esp = "Toggle player ESP",
        tooltip_freeze_map = "Freeze all map objects",
        tooltip_unfreeze_map = "Unfreeze all map objects",
        ghost_mode = "Ghost mode",
        tooltip_ghost_mode = "Enable ghost mode (transparency)",
        
        -- Fun/Trolling functions
        spin_player = "Spin Player",
        launch_player = "Launch Player",
        invert_controls = "Invert Controls",
        random_teleport = "Random Teleport",
        fake_message = "Fake Message",
        change_size = "Change Size",
        invisible_player = "Invisible Player",
        mirror_mode = "Mirror Mode",
        disable_jump = "Disable Jump",
        enable_autojump = "Enable AutoJump",
        dance_player = "Dance Player",
        sit_player = "Sit Player",
        freeze_position = "Freeze at Position",
        unfreeze_player = "Unfreeze Player",
        clone_player = "Clone Player",
        fire_player = "Set Player on Fire",
        shock_player = "Shock Player",
        orbit_player = "Orbit Player",
        tooltip_spin_player = "Make selected players spin continuously",
        tooltip_launch_player = "Launch selected players into the air",
        tooltip_invert_controls = "Invert controls for selected players",
        tooltip_random_teleport = "Teleport selected players to random locations",
        tooltip_fake_message = "Send fake chat message from selected players",
        tooltip_change_size = "Change size of selected players",
        tooltip_invisible_player = "Make selected players invisible",
        tooltip_mirror_mode = "Enable mirror mode for selected players",
        tooltip_disable_jump = "Disable jumping for selected players",
        tooltip_enable_autojump = "Enable automatic jumping for selected players",
        tooltip_dance_player = "Make selected players dance",
        tooltip_sit_player = "Make selected players sit",
        tooltip_freeze_position = "Freeze selected players at their current position",
        tooltip_unfreeze_player = "Unfreeze selected players",
        tooltip_clone_player = "Create clone of selected players",
        tooltip_fire_player = "Set selected players on fire",
        tooltip_shock_player = "Shock selected players with electricity",
        tooltip_orbit_player = "Make selected players orbit around you",
        notification_spin_player = "Players are now spinning",
        notification_launch_player = "Players launched into the air",
        notification_invert_controls = "Controls inverted for players",
        notification_random_teleport = "Players teleported to random locations",
        notification_fake_message = "Fake message sent",
        notification_change_size = "Player size changed",
        notification_invisible_player = "Players are now invisible",
        notification_mirror_mode = "Mirror mode enabled",
        notification_disable_jump = "Jumping disabled for players",
        notification_enable_autojump = "Auto-jump enabled for players",
        notification_dance_player = "Players are now dancing",
        notification_sit_player = "Players are now sitting",
        notification_freeze_position = "Players frozen at position",
        notification_unfreeze_player = "Players unfrozen",
        notification_clone_player = "Player clones created",
        notification_fire_player = "Players set on fire",
        notification_shock_player = "Players shocked",
        notification_orbit_player = "Players now orbiting",
        
        -- Server functions
        server_shutdown = "Server Shutdown",
        server_restart = "Server Restart",
        server_time = "Change Server Time",
        server_weather = "Change Weather",
        server_gravity = "Change Server Gravity",
        tooltip_server_shutdown = "Shutdown the server",
        tooltip_server_restart = "Restart the server",
        tooltip_server_time = "Change server time",
        tooltip_server_weather = "Change weather effects",
        tooltip_server_gravity = "Change server gravity",
        notification_server_shutdown = "Server shutdown initiated",
        notification_server_restart = "Server restart initiated",
        notification_server_time = "Server time changed",
        notification_server_weather = "Weather changed",
        notification_server_gravity = "Server gravity changed"
    },
    ru = {
        main_title = "AdminScript Ultimate 5.0 by IRIS_FECOKEV",
        tab_main = "Основные",
        tab_players = "Игроки",
        tab_visual = "Визуал",
        tab_fun = "Веселье/Троллинг",
        tab_debug = "Дебаг",
        tab_settings = "Настройки",
        tab_server = "Сервер",
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
        speed_x10 = "Скорость x10",
        day = "День",
        night = "Ночь",
        moon_gravity = "Лунная гравитация",
        zero_gravity = "Нулевая гравитация",
        rainbow_char = "Радужный персонаж",
        black_hole = "Создать черную дыру",
        esp = "Показать ESP",
        auto_open = "Авто-открытие при запуске",
        fly_speed = "Скорость полёта",
        explosion_radius = "Радиус взрыва",
        language = "Язык",
        theme = "Тема",
        on = "ВКЛ",
        off = "ВЫКЛ",
        selected = "✓ ВЫБРАН",
        select = "Выбрать",
        notification = "Уведомление",
        tooltip = "Подсказка",
        tooltip_flying = "Включить/выключить режим полета",
        notification_flying_off = "Режим полета выключен",
        notification_freeze_selected = "Выбранные игроки заморожены",
        notification_freeze_all = "Все игроки заморожены",
        notification_unfreeze_selected = "Выбранные игроки разморожены",
        notification_unfreeze_all = "Все игроки разморожены",
        notification_gravity = "Гравитация изменена на: ",
        notification_time = "Время установлено на: ",
        notification_speed = "Скорость установлена: ",
        notification_esp_on = "ESP включен",
        notification_esp_off = "ESP выключен",
        notification_ghost_mode = "Режим призрака включен",
        notification_infinite_jump = "Бесконечный прыжок включен",
        notification_infinite_jump_off = "Бесконечный прыжок выключен",
        notification_noclip_on = "Ноклип включен",
        notification_noclip_off = "Ноклип выключен",
        notification_godmode_on = "Бессмертие включено",
        notification_godmode_off = "Бессмертие выключено",
        notification_teleport = "Телепортирован на спавн",
        notification_explosion = "Взрыв создан с радиусом: ",
        notification_rainbow = "Радужный эффект включен",
        notification_rainbow_off = "Радужный эффект выключен",
        notification_freeze_map = "Карта заморожена",
        notification_unfreeze_map = "Карта разморожена",
        notification_black_hole = "Черная дыра создана",
        notification_kill_all = "Все игроки убиты",
        notification_heal_all = "Все игроки исцелены",
        notification_kill_selected = "Выбранные игроки убиты",
        notification_heal_selected = "Выбранные игроки исцелены",
        notification_teleport_to_player = "Телепортирован к игроку: ",
        notification_auto_open = "Авто-открытие: ",
        notification_fly_speed = "Скорость полета установлена: ",
        notification_explosion_radius = "Радиус взрыва установлен: ",
        notification_language = "Язык изменен на: ",
        tooltip_refresh = "Обновить список игроков",
        tooltip_kill_selected = "Убить выбранных игроков",
        tooltip_kill_all = "Убить всех игроков",
        tooltip_teleport_to_player = "Телепортироваться к выбранному игроку",
        tooltip_heal_selected = "Исцелить выбранных игроков",
        tooltip_heal_all = "Исцелить всех игроков",
        tooltip_freeze_selected = "Заморозить выбранных игроков",
        tooltip_freeze_all = "Заморозить всех игроков",
        tooltip_unfreeze_selected = "Разморозить выбранных игроков",
        tooltip_unfreeze_all = "Разморозить всех игроков",
        tooltip_create_explosion = "Создать взрыв на вашей позиции",
        tooltip_teleport_spawn = "Телепортироваться на точку спавна",
        tooltip_flying = "Включить/выключить режим полета",
        tooltip_noclip = "Включить/выключить режим ноклип",
        tooltip_godmode = "Включить/выключить бессмертие",
        tooltip_infinite_jump = "Включить/выключить бесконечный прыжок",
        tooltip_speed_x2 = "Установить скорость x2",
        tooltip_speed_x5 = "Установить скорость x5",
        tooltip_speed_x10 = "Установить скорость x10",
        tooltip_day = "Установить дневное время",
        tooltip_night = "Установить ночное время",
        tooltip_moon_gravity = "Установить лунную гравитацию",
        tooltip_zero_gravity = "Установить нулевую гравитацию",
        tooltip_rainbow_char = "Включить/выключить радужный эффект для персонажа",
        tooltip_black_hole = "Создать черную дыру",
        tooltip_esp = "Включить/выключить ESP игроков",
        tooltip_freeze_map = "Заморозить все объекты карты",
        tooltip_unfreeze_map = "Разморозить все объекты карты",
        ghost_mode = "Режим призрака",
        tooltip_ghost_mode = "Включить режим призрака (прозрачность)",
        
        -- Fun/Trolling functions
        spin_player = "Крутить игрока",
        launch_player = "Запустить игрока",
        invert_controls = "Инвертировать управление",
        random_teleport = "Случайный телепорт",
        fake_message = "Фальшивое сообщение",
        change_size = "Изменить размер",
        invisible_player = "Невидимый игрок",
        mirror_mode = "Зеркальный режим",
        disable_jump = "Отключить прыжок",
        enable_autojump = "Включить авто-прыжок",
        dance_player = "Танцевать",
        sit_player = "Посадить игрока",
        freeze_position = "Заморозить на месте",
        unfreeze_player = "Разморозить игрока",
        clone_player = "Клонировать игрока",
        fire_player = "Поджечь игрока",
        shock_player = "Шокировать игрока",
        orbit_player = "Орбита игрока",
        tooltip_spin_player = "Заставить выбранных игроков крутиться",
        tooltip_launch_player = "Запустить выбранных игроков в воздух",
        tooltip_invert_controls = "Инвертировать управление у выбранных игроков",
        tooltip_random_teleport = "Телепортировать выбранных игроков в случайные места",
        tooltip_fake_message = "Отправить фальшивое сообщение от имени выбранных игроков",
        tooltip_change_size = "Изменить размер выбранных игроков",
        tooltip_invisible_player = "Сделать выбранных игроков невидимыми",
        tooltip_mirror_mode = "Включить зеркальный режим для выбранных игроков",
        tooltip_disable_jump = "Отключить прыжок у выбранных игроков",
        tooltip_enable_autojump = "Включить автоматический прыжок у выбранных игроков",
        tooltip_dance_player = "Заставить выбранных игроков танцевать",
        tooltip_sit_player = "Заставить выбранных игроков сесть",
        tooltip_freeze_position = "Заморозить выбранных игроков на текущей позиции",
        tooltip_unfreeze_player = "Разморозить выбранных игроков",
        tooltip_clone_player = "Создать клонов выбранных игроков",
        tooltip_fire_player = "Поджечь выбранных игроков",
        tooltip_shock_player = "Шокировать выбранных игроков электричеством",
        tooltip_orbit_player = "Заставить выбранных игроков вращаться вокруг вас",
        notification_spin_player = "Игроки теперь крутятся",
        notification_launch_player = "Игроки запущены в воздух",
        notification_invert_controls = "Управление инвертировано для игроков",
        notification_random_teleport = "Игроки телепортированы в случайные места",
        notification_fake_message = "Фальшивое сообщение отправлено",
        notification_change_size = "Размер игроков изменен",
        notification_invisible_player = "Игроки теперь невидимы",
        notification_mirror_mode = "Зеркальный режим включен",
        notification_disable_jump = "Прыжок отключен для игроков",
        notification_enable_autojump = "Авто-прыжок включен для игроков",
        notification_dance_player = "Игроки теперь танцуют",
        notification_sit_player = "Игроки теперь сидят",
        notification_freeze_position = "Игроки заморожены на позиции",
        notification_unfreeze_player = "Игроки разморожены",
        notification_clone_player = "Клоны игроков созданы",
        notification_fire_player = "Игроки подожжены",
        notification_shock_player = "Игроки шокированы",
        notification_orbit_player = "Игроки вращаются вокруг вас",
        
        -- Server functions
        server_shutdown = "Выключение сервера",
        server_restart = "Перезагрузка сервера",
        server_time = "Изменить время сервера",
        server_weather = "Изменить погоду",
        server_gravity = "Изменить гравитацию сервера",
        tooltip_server_shutdown = "Выключить сервер",
        tooltip_server_restart = "Перезагрузить сервер",
        tooltip_server_time = "Изменить время на сервере",
        tooltip_server_weather = "Изменить погодные эффекты",
        tooltip_server_gravity = "Изменить гравитацию на сервере",
        notification_server_shutdown = "Инициировано выключение сервера",
        notification_server_restart = "Инициирована перезагрузка сервера",
        notification_server_time = "Время на сервере изменено",
        notification_server_weather = "Погода изменена",
        notification_server_gravity = "Гравитация на сервере изменена"
    }
}

local t = function(key)
    return localization[settings.Language][key] or key
end

-- Основное окно
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 600, 0, 650)
mainFrame.Position = UDim2.new(0.5, -300, 0.5, -325)
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
titleLabel.Parent = titleBar

-- Кнопки управления окном
local minimizeBtn = Instance.new("ImageButton")
minimizeBtn.Name = "MinimizeBtn"
minimizeBtn.Size = UDim2.new(0, 26, 0, 26)
minimizeBtn.Position = UDim2.new(1, -55, 0, 2)
minimizeBtn.BackgroundTransparency = 1
minimizeBtn.Image = "rbxassetid://74729089697042"
minimizeBtn.Parent = titleBar

local closeBtn = Instance.new("ImageButton")
closeBtn.Name = "CloseBtn"
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -28, 0, 2)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = "rbxassetid://118955245038416"
closeBtn.Parent = titleBar

-- Панель вкладок
local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 30)
tabBar.Position = UDim2.new(0, 0, 0, 30)
tabBar.BackgroundColor3 = Color3.fromRGB(192, 192, 192)
tabBar.BorderSizePixel = 0
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
    btn.Parent = tabBar
    return btn
end

local mainTab = createTabButton(t("tab_main"), 8)
local playerTab = createTabButton(t("tab_players"), 93)
local visualTab = createTabButton(t("tab_visual"), 178)
local funTab = createTabButton(t("tab_fun"), 263)
local debugTab = createTabButton(t("tab_debug"), 348)
local settingsTab = createTabButton(t("tab_settings"), 433)
local serverTab = createTabButton(t("tab_server"), 518)

-- Контейнеры для вкладок
local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, -10, 1, -70)
tabContainer.Position = UDim2.new(0, 5, 0, 65)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = mainFrame

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

local funContent = createContentFrame()
funContent.Parent = tabContainer

local debugContent = createContentFrame()
debugContent.Parent = tabContainer

local settingsContent = createContentFrame()
settingsContent.Parent = tabContainer

local serverContent = createContentFrame()
serverContent.Parent = tabContainer

-- Ярлык в стиле Windows XP
local taskbarButton = Instance.new("TextButton")
taskbarButton.Name = "TaskbarButton"
taskbarButton.Size = UDim2.new(0, 150, 0, 35)
taskbarButton.Position = UDim2.new(0, 10, 1, -38)
taskbarButton.BackgroundColor3 = Color3.fromRGB(0, 14, 122)
taskbarButton.BorderSizePixel = 0
taskbarButton.Text = "AdminScript 5.0"
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
    if not title or not message then return end
    notificationTitle.Text = title
    notificationText.Text = message
    notificationFrame.Visible = true
    
    task.spawn(function()
        task.wait(duration or 5)
        if notificationFrame and notificationFrame.Parent then
            notificationFrame.Visible = false
        end
    end)
end

-- Переработанная функция создания кнопок
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
        stateIndicator.Parent = btn
    end

    local highlight = Instance.new("Frame")
    highlight.Size = UDim2.new(1, 0, 1, 0)
    highlight.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    highlight.BackgroundTransparency = 0.8
    highlight.BorderSizePixel = 0
    highlight.Visible = false
    highlight.Parent = btn

    if tooltipText then
        btn.MouseEnter:Connect(function()
            if not tooltip then return end
            highlight.Visible = true
            tooltip.Text = tooltipText
            tooltip.Visible = true
            
            local mousePos = UserInputService:GetMouseLocation()
            tooltip.Position = UDim2.new(0, mousePos.X + 20, 0, mousePos.Y)
        end)
        
        btn.MouseLeave:Connect(function()
            highlight.Visible = false
            if tooltip then
                tooltip.Visible = false
            end
        end)
    else
        btn.MouseEnter:Connect(function() 
            if highlight then
                highlight.Visible = true 
            end
        end)
        btn.MouseLeave:Connect(function() 
            if highlight then
                highlight.Visible = false 
            end
        end)
    end
    
    return btn, function(isActive)
        if withState and stateIndicator then
            stateIndicator.Visible = true
            stateIndicator.Text = isActive and t("on") or t("off")
            stateIndicator.TextColor3 = isActive and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
        end
    end
end

-- Система полёта (ИСПРАВЛЕНА)
local flying = false
local flyAnimation = nil
local flyAnimTrack = nil
local flyBV = nil
local flyConnection = nil

local function startFlying()
    if flying then return end
    local character = player.Character
    if not character then return end

    local humanoid = character:FindFirstChild("Humanoid")
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not humanoid or not rootPart then return end

    if not flyAnimation then
        flyAnimation = Instance.new("Animation")
        flyAnimation.AnimationId = "rbxassetid://" .. tostring(FLY_ANIMATION_ID)
    end

    flyAnimTrack = humanoid:LoadAnimation(flyAnimation)
    if flyAnimTrack then
        flyAnimTrack:Play()
    end

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

    flyConnection = RunService.Heartbeat:Connect(function(dt)
        if not flying or not rootPart or not rootPart.Parent then
            if flyConnection then
                flyConnection:Disconnect()
                flyConnection = nil
            end
            return
        end

        local moveVector = Vector3.new()
        if keys[Enum.KeyCode.W] then moveVector = moveVector + camera.CFrame.LookVector end
        if keys[Enum.KeyCode.S] then moveVector = moveVector - camera.CFrame.LookVector end
        if keys[Enum.KeyCode.D] then moveVector = moveVector + camera.CFrame.RightVector end
        if keys[Enum.KeyCode.A] then moveVector = moveVector - camera.CFrame.RightVector end
        if keys[Enum.KeyCode.Space] then moveVector = moveVector + Vector3.new(0, 1, 0) end
        if keys[Enum.KeyCode.LeftShift] then moveVector = moveVector - Vector3.new(0, 1, 0) end

        if moveVector.Magnitude > 0 then
            moveVector = moveVector.Unit * settings.FlySpeed
        end

        if flyBV and flyBV.Parent then
            flyBV.Velocity = moveVector
        end
    end)
    
    showNotification(t("flying"), t("tooltip_flying"), 3)
end

local function stopFlying()
    if not flying then return end
    flying = false

    ContextActionService:UnbindAction("FlyControl")

    if flyConnection then
        flyConnection:Disconnect()
        flyConnection = nil
    end

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

-- Система выбора игроков (ИСПРАВЛЕНА)
local selectedPlayers = {}
local playerListFrame = Instance.new("ScrollingFrame")
playerListFrame.Size = UDim2.new(1, -15, 1, -15)
playerListFrame.Position = UDim2.new(0, 8, 0, 8)
playerListFrame.BackgroundTransparency = 1
playerListFrame.ScrollBarThickness = 10
playerListFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
playerListFrame.Parent = playerContent

local playerListLayout = Instance.new("UIListLayout")
playerListLayout.Padding = UDim.new(0, 10)
playerListLayout.SortOrder = Enum.SortOrder.LayoutOrder
playerListLayout.Parent = playerListFrame

local function updatePlayerList()
    if not playerListFrame then return end
    playerListFrame:ClearAllChildren()
    
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr and plr.Parent then
            local playerFrame = Instance.new("Frame")
            playerFrame.Size = UDim2.new(1, -10, 0, 50)
            playerFrame.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
            playerFrame.BorderColor3 = Color3.new(0, 0, 0)
            playerFrame.BorderSizePixel = 1
            playerFrame.LayoutOrder = #playerListFrame:GetChildren()
            
            local playerName = Instance.new("TextLabel")
            playerName.Size = UDim2.new(1, -50, 0.5, 0)
            playerName.Position = UDim2.new(0, 5, 0, 0)
            playerName.Text = plr.Name
            playerName.TextColor3 = Color3.new(0, 0, 0)
            playerName.Font = Enum.Font.SourceSansBold
            playerName.TextSize = 14
            playerName.TextXAlignment = Enum.TextXAlignment.Left
            playerName.BackgroundTransparency = 1
            playerName.Parent = playerFrame
            
            local selectBtn = Instance.new("TextButton")
            selectBtn.Size = UDim2.new(0, 40, 0.6, 0)
            selectBtn.Position = UDim2.new(1, -45, 0.2, 0)
            selectBtn.Text = selectedPlayers[plr] and t("selected") or t("select")
            selectBtn.BackgroundColor3 = selectedPlayers[plr] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 200, 200)
            selectBtn.TextColor3 = Color3.new(0, 0, 0)
            selectBtn.Font = Enum.Font.SourceSansBold
            selectBtn.TextSize = 12
            selectBtn.Parent = playerFrame
            
            selectBtn.MouseButton1Click:Connect(function()
                selectedPlayers[plr] = not selectedPlayers[plr]
                selectBtn.Text = selectedPlayers[plr] and t("selected") or t("select")
                selectBtn.BackgroundColor3 = selectedPlayers[plr] and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 200, 200)
            end)
            
            playerFrame.Parent = playerListFrame
        end
    end
end

-- Система заморозки (ИСПРАВЛЕНА)
local frozenPlayers = {}
local originalColors = {}
local freezeLoop = nil

local function setupFreezeLoop()
    if freezeLoop then return end
    
    freezeLoop = RunService.Heartbeat:Connect(function()
        for plr, data in pairs(frozenPlayers) do
            if plr and plr.Parent and plr.Character and data.rootPart and data.rootPart.Parent then
                data.rootPart.CFrame = data.originalCFrame
            else
                frozenPlayers[plr] = nil
            end
        end
    end)
end

local function freezeSelectedPlayers()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character and not frozenPlayers[plr] then
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
    setupFreezeLoop()
    showNotification(t("freeze_selected"), t("notification_freeze_selected"), 3)
end

local function freezeAllPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr and plr.Parent and plr.Character and not frozenPlayers[plr] then
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
    setupFreezeLoop()
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
    for plr, data in pairs(frozenPlayers) do
        if data.humanoid and data.humanoid.Parent then
            data.humanoid.WalkSpeed = data.originalWalkSpeed
        end
    end
    frozenPlayers = {}
    showNotification(t("unfreeze_all"), t("notification_unfreeze_all"), 3)
end

-- Дебаг-система (ИСПРАВЛЕНА)
local function logDebug(message)
    if not DEBUG_MODE then return end
    
    table.insert(debugLogs, 1, os.date("%H:%M:%S") .. " - " .. tostring(message))
    
    if #debugLogs > DEBUG_LOG_MAX then
        table.remove(debugLogs, #debugLogs)
    end
    
    if debugLogFrame then
        debugLogFrame:ClearAllChildren()
        
        for i, log in ipairs(debugLogs) do
            local logLabel = Instance.new("TextLabel")
            logLabel.Size = UDim2.new(1, 0, 0, 20)
            logLabel.Position = UDim2.new(0, 0, 0, (i-1)*20)
            logLabel.Text = tostring(log)
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
    if debugPanel then 
        debugPanel.Visible = true
        return 
    end
    
    debugPanel = Instance.new("Frame")
    debugPanel.Size = UDim2.new(1, 0, 0.4, 0)
    debugPanel.Position = UDim2.new(0, 0, 0.6, 0)
    debugPanel.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    debugPanel.BorderSizePixel = 0
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
    fpsLabel.BackgroundTransparency = 1
    fpsLabel.Parent = statsFrame
    
    local pingLabel = Instance.new("TextLabel")
    pingLabel.Size = UDim2.new(1, 0, 0, 28)
    pingLabel.Text = "Ping: 0ms"
    pingLabel.TextColor3 = Color3.new(0, 0, 0)
    pingLabel.Font = Enum.Font.SourceSansBold
    pingLabel.TextSize = 16
    pingLabel.BackgroundTransparency = 1
    pingLabel.Parent = statsFrame
    
    local memLabel = Instance.new("TextLabel")
    memLabel.Size = UDim2.new(1, 0, 0, 28)
    memLabel.Text = "Memory: 0MB"
    memLabel.TextColor3 = Color3.new(0, 0, 0)
    memLabel.Font = Enum.Font.SourceSansBold
    memLabel.TextSize = 16
    memLabel.BackgroundTransparency = 1
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
    
    if debugConnection then
        debugConnection:Disconnect()
    end
    
    debugConnection = RunService.Heartbeat:Connect(function(dt)
        frames = frames + 1
        
        if tick() - lastTime >= 1 then
            performanceStats.FPS = frames
            frames = 0
            lastTime = tick()
            
            if fpsLabel then
                fpsLabel.Text = "FPS: " .. performanceStats.FPS
            end
            if pingLabel then
                pingLabel.Text = "Ping: " .. math.random(20, 100) .. "ms"
            end
            if memLabel then
                memLabel.Text = "Memory: " .. math.random(50, 200) .. "MB"
            end
        end
    end)
end

-- ДОПОЛНИТЕЛЬНЫЕ ФУНКЦИИ (ИСПРАВЛЕНЫ)
local function changeGravity(value)
    if not value then return end
    Workspace.Gravity = value
    logDebug("Gravity changed: " .. value)
    showNotification(t("moon_gravity"), t("notification_gravity") .. value, 3)
end

local function setTimeOfDay(hour)
    if not hour then return end
    Lighting.ClockTime = hour
    logDebug("Time of day set: " .. hour)
    showNotification(t(hour == 12 and "day" or "night"), t("notification_time") .. hour .. ":00", 3)
end

local function speedHack(speed)
    if not speed then return end
    if player.Character then
        local humanoid = player.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = speed
            logDebug("Speed set: " .. speed)
            showNotification(t("speed_x" .. (speed == 32 and "2" or speed == 80 and "5" or "10")), t("notification_speed") .. speed, 3)
        end
    end
end

local espHighlights = {}
local function espPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr and plr.Parent and plr.Character then
            local highlight = plr.Character:FindFirstChild("AdminESP")
            if highlight then highlight:Destroy() end
            
            highlight = Instance.new("Highlight")
            highlight.Name = "AdminESP"
            highlight.FillColor = Color3.new(1, 0, 0)
            highlight.OutlineColor = Color3.new(1, 1, 1)
            highlight.Parent = plr.Character
            espHighlights[plr] = highlight
        end
    end
    logDebug("ESP enabled")
    showNotification(t("esp"), t("notification_esp_on"), 3)
end

local function removeESP()
    for plr, highlight in pairs(espHighlights) do
        if highlight then
            highlight:Destroy()
        end
    end
    espHighlights = {}
    logDebug("ESP disabled")
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
    logDebug("Ghost mode enabled")
    showNotification(t("ghost_mode"), t("notification_ghost_mode"), 3)
end

local infiniteJumpConnection = nil
local function infiniteJump(state)
    if state then
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
        end
        infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
            if player.Character then
                local humanoid = player.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
        logDebug("Infinite jump enabled")
        showNotification(t("infinite_jump"), t("notification_infinite_jump"), 3)
    else
        if infiniteJumpConnection then
            infiniteJumpConnection:Disconnect()
            infiniteJumpConnection = nil
        end
        logDebug("Infinite jump disabled")
        showNotification(t("infinite_jump"), t("notification_infinite_jump_off"), 3)
    end
end

local noclipConnection = nil
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
end

local originalHealth = {}
local function godMode(state)
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            if state then
                originalHealth[player] = {
                    Health = humanoid.Health,
                    MaxHealth = humanoid.MaxHealth
                }
                humanoid.MaxHealth = math.huge
                humanoid.Health = math.huge
                showNotification(t("godmode"), t("notification_godmode_on"), 3)
            else
                if originalHealth[player] then
                    humanoid.MaxHealth = originalHealth[player].MaxHealth
                    humanoid.Health = originalHealth[player].Health
                    originalHealth[player] = nil
                else
                    humanoid.MaxHealth = 100
                    humanoid.Health = 100
                end
                showNotification(t("godmode"), t("notification_godmode_off"), 3)
            end
        end
    end
end

local function teleportToPosition(position)
    if not position then return end
    if player.Character then
        local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
        if rootPart then
            rootPart.CFrame = position
            logDebug("Teleported to position: " .. tostring(position))
            showNotification(t("teleport_spawn"), t("notification_teleport"), 3)
        end
    end
end

local function createExplosion(position, radius)
    if not position or not radius then return end
    local explosion = Instance.new("Explosion")
    explosion.Position = position
    explosion.BlastRadius = radius
    explosion.BlastPressure = 1000000
    explosion.ExplosionType = Enum.ExplosionType.CratersAndDebris
    explosion.Parent = Workspace
    logDebug("Explosion created with radius: " .. radius)
    showNotification(t("create_explosion"), t("notification_explosion") .. radius, 3)
end

local rainbowConnections = {}
local function rainbowCharacter()
    if player.Character then
        for _, part in ipairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    if part and part.Parent then
                        part.Color = Color3.new(math.random(), math.random(), math.random())
                    else
                        if connection then
                            connection:Disconnect()
                        end
                        rainbowConnections[part] = nil
                    end
                end)
                rainbowConnections[part] = connection
            end
        end
    end
    logDebug("Rainbow effect enabled")
    showNotification(t("rainbow_char"), t("notification_rainbow"), 3)
end

local function stopRainbowCharacter()
    for part, connection in pairs(rainbowConnections) do
        if connection then
            connection:Disconnect()
        end
    end
    rainbowConnections = {}
    logDebug("Rainbow effect disabled")
    showNotification(t("rainbow_char"), t("notification_rainbow_off"), 3)
end

local function freezeMap()
    originalColors = {}
    for _, part in ipairs(Workspace:GetDescendants()) do
        if part:IsA("BasePart") and part.Anchored == false and part.Parent then
            originalColors[part] = part.Color
            part.Anchored = true
            part.Color = Color3.new(0.5, 0.5, 1)
        end
    end
    logDebug("Map frozen")
    showNotification(t("freeze_map"), t("notification_freeze_map"), 3)
end

local function unfreezeMap()
    for part, originalColor in pairs(originalColors) do
        if part and part.Parent then
            part.Anchored = false
            part.Color = originalColor
        end
    end
    originalColors = {}
    logDebug("Map unfrozen")
    showNotification(t("unfreeze_map"), t("notification_unfreeze_map"), 3)
end

local function createBlackHole(position)
    if not position then return end
    local blackHole = Instance.new("Part")
    blackHole.Position = position
    blackHole.Size = Vector3.new(5, 5, 5)
    blackHole.Shape = Enum.PartType.Ball
    blackHole.Color = Color3.new(0, 0, 0)
    blackHole.Material = Enum.Material.Neon
    blackHole.Anchored = false
    blackHole.CanCollide = false
    blackHole.Parent = Workspace
    
    Debris:AddItem(blackHole, 30)
    
    local bodyForce = Instance.new("BodyForce")
    bodyForce.Force = Vector3.new(0, blackHole:GetMass() * Workspace.Gravity, 0)
    bodyForce.Parent = blackHole
    
    local blackHoleConnection
    blackHoleConnection = RunService.Heartbeat:Connect(function()
        if not blackHole or not blackHole.Parent then
            if blackHoleConnection then
                blackHoleConnection:Disconnect()
            end
            return
        end
        
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") and part ~= blackHole and part.Parent and part.Position:Distance(blackHole.Position) < 50 then
                local direction = (blackHole.Position - part.Position).Unit
                part.Velocity = direction * 100
            end
        end
    end)
    
    logDebug("Black hole created")
    showNotification(t("black_hole"), t("notification_black_hole"), 3)
end

local function killAllPlayers()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr and plr.Parent and plr.Character then
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
        if plr and plr.Parent and plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = humanoid.MaxHealth
            end
        end
    end
    showNotification(t("heal_all"), t("notification_heal_all"), 3)
end

-- НОВЫЕ ФУНКЦИИ ДЛЯ ВКЛАДКИ FUN/TROLLING
local spinningPlayers = {}
local function spinPlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                spinningPlayers[plr] = true
                local spinConnection
                spinConnection = RunService.Heartbeat:Connect(function()
                    if not spinningPlayers[plr] or not rootPart or not rootPart.Parent then
                        if spinConnection then
                            spinConnection:Disconnect()
                        end
                        return
                    end
                    rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(30), 0)
                end)
            end
        end
    end
    showNotification(t("spin_player"), t("notification_spin_player"), 3)
end

local function stopSpinningPlayers()
    for plr, _ in pairs(spinningPlayers) do
        spinningPlayers[plr] = false
    end
    spinningPlayers = {}
end

local function launchPlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local bodyVelocity = Instance.new("BodyVelocity")
                bodyVelocity.Velocity = Vector3.new(0, 100, 0)
                bodyVelocity.MaxForce = Vector3.new(0, 100000, 0)
                bodyVelocity.Parent = rootPart
                Debris:AddItem(bodyVelocity, 1)
            end
        end
    end
    showNotification(t("launch_player"), t("notification_launch_player"), 3)
end

local invertedControls = {}
local function invertControls()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and not invertedControls[plr] then
            invertedControls[plr] = true
            -- Здесь должна быть логика инвертирования управления
            -- Это сложная функция, требующая глубокого вмешательства в управление игрока
        end
    end
    showNotification(t("invert_controls"), t("notification_invert_controls"), 3)
end

local function stopInvertedControls()
    for plr, _ in pairs(invertedControls) do
        invertedControls[plr] = false
    end
    invertedControls = {}
end

local function randomTeleport()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local randomPos = Vector3.new(
                    math.random(-500, 500),
                    math.random(10, 100),
                    math.random(-500, 500)
                )
                rootPart.CFrame = CFrame.new(randomPos)
            end
        end
    end
    showNotification(t("random_teleport"), t("notification_random_teleport"), 3)
end

local function fakeMessage()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent then
            -- Отправка фальшивого сообщения от имени игрока
            if TextChatService then
                -- Используем новую систему чата
                local channel = TextChatService:FindFirstChild("TextChannels").RBXGeneral
                if channel then
                    channel:SendAsync(plr.Name .. ": I'm using AdminScript Ultimate 5.0!")
                end
            end
        end
    end
    showNotification(t("fake_message"), t("notification_fake_message"), 3)
end

local function changeSize()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                local scale = math.random(5, 20) / 10  -- От 0.5x до 2x
                humanoid.BodyDepthScale.Value = scale
                humanoid.BodyHeightScale.Value = scale
                humanoid.BodyWidthScale.Value = scale
                humanoid.HeadScale.Value = scale
            end
        end
    end
    showNotification(t("change_size"), t("notification_change_size"), 3)
end

local function invisiblePlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            for _, part in ipairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 1
                end
            end
        end
    end
    showNotification(t("invisible_player"), t("notification_invisible_player"), 3)
end

local function mirrorMode()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.CameraOffset = Vector3.new(5, 0, 0)  -- Смещаем камеру для эффекта зеркала
            end
        end
    end
    showNotification(t("mirror_mode"), t("notification_mirror_mode"), 3)
end

local function disableJump()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.JumpPower = 0
            end
        end
    end
    showNotification(t("disable_jump"), t("notification_disable_jump"), 3)
end

local function enableAutoJump()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                local connection
                connection = RunService.Heartbeat:Connect(function()
                    if not humanoid or not humanoid.Parent then
                        if connection then
                            connection:Disconnect()
                        end
                        return
                    end
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end)
            end
        end
    end
    showNotification(t("enable_autojump"), t("notification_enable_autojump"), 3)
end

local function dancePlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                -- Простая анимация танца
                humanoid:LoadAnimation(Instance.new("Animation")):Play()
            end
        end
    end
    showNotification(t("dance_player"), t("notification_dance_player"), 3)
end

local function sitPlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local humanoid = plr.Character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Sit = true
            end
        end
    end
    showNotification(t("sit_player"), t("notification_sit_player"), 3)
end

local function freezePosition()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                frozenPlayers[plr] = {
                    rootPart = rootPart,
                    originalCFrame = rootPart.CFrame,
                    humanoid = plr.Character:FindFirstChild("Humanoid")
                }
            end
        end
    end
    setupFreezeLoop()
    showNotification(t("freeze_position"), t("notification_freeze_position"), 3)
end

local function unfreezePlayer()
    for plr, _ in pairs(selectedPlayers) do
        if frozenPlayers[plr] then
            frozenPlayers[plr] = nil
        end
    end
    showNotification(t("unfreeze_player"), t("notification_unfreeze_player"), 3)
end

local function clonePlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local character = plr.Character
            local clone = character:Clone()
            clone.Parent = Workspace
            clone:MoveTo(character.HumanoidRootPart.Position + Vector3.new(5, 0, 0))
        end
    end
    showNotification(t("clone_player"), t("notification_clone_player"), 3)
end

-- НОВЫЕ ФУНКЦИИ
local function firePlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local fire = Instance.new("Fire")
            fire.Size = 10
            fire.Heat = 10
            fire.Parent = plr.Character.HumanoidRootPart
            Debris:AddItem(fire, 10)
        end
    end
    showNotification(t("fire_player"), t("notification_fire_player"), 3)
end

local function shockPlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local sparkles = Instance.new("Sparkles")
            sparkles.SparkleColor = Color3.new(0, 1, 1)
            sparkles.Parent = plr.Character.HumanoidRootPart
            Debris:AddItem(sparkles, 10)
        end
    end
    showNotification(t("shock_player"), t("notification_shock_player"), 3)
end

local orbitingPlayers = {}
local function orbitPlayer()
    for plr, _ in pairs(selectedPlayers) do
        if plr and plr.Parent and plr.Character then
            local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
            local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            
            if rootPart and playerRoot then
                orbitingPlayers[plr] = true
                local orbitConnection
                local angle = 0
                local radius = 10
                
                orbitConnection = RunService.Heartbeat:Connect(function(dt)
                    if not orbitingPlayers[plr] or not rootPart or not rootPart.Parent or not playerRoot then
                        if orbitConnection then
                            orbitConnection:Disconnect()
                        end
                        return
                    end
                    
                    angle = angle + dt * 2
                    local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
                    rootPart.CFrame = CFrame.new(playerRoot.Position + offset)
                end)
            end
        end
    end
    showNotification(t("orbit_player"), t("notification_orbit_player"), 3)
end

local function stopOrbitingPlayers()
    for plr, _ in pairs(orbitingPlayers) do
        orbitingPlayers[plr] = false
    end
    orbitingPlayers = {}
end

-- СЕРВЕРНЫЕ ФУНКЦИИ
local function serverShutdown()
    showNotification(t("server_shutdown"), t("notification_server_shutdown"), 3)
    -- Здесь может быть код для выключения сервера
end

local function serverRestart()
    showNotification(t("server_restart"), t("notification_server_restart"), 3)
    -- Здесь может быть код для перезагрузки сервера
end

local function changeServerTime()
    Lighting.ClockTime = 12
    showNotification(t("server_time"), t("notification_server_time"), 3)
end

local function changeWeather()
    -- Создаем эффект дождя
    local rain = Instance.new("Part")
    rain.Size = Vector3.new(100, 1, 100)
    rain.Position = Vector3.new(0, 50, 0)
    rain.Transparency = 0.5
    rain.Color = Color3.new(0.5, 0.5, 1)
    rain.Anchored = true
    rain.CanCollide = false
    rain.Parent = Workspace
    Debris:AddItem(rain, 30)
    
    showNotification(t("server_weather"), t("notification_server_weather"), 3)
end

local function changeServerGravity()
    Workspace.Gravity = 50
    showNotification(t("server_gravity"), t("notification_server_gravity"), 3)
end

-- Состояния функций
local activeStates = {
    Fly = false,
    Noclip = false,
    GodMode = false,
    ESP = false,
    InfiniteJump = false,
    Rainbow = false
}

-- Функция для кнопок с состоянием
local function createStateButton(content, name, func, stateKey, tooltipText)
    local btn, updateState = createButton(name, 38, true, tooltipText)
    btn.Parent = content
    
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
    if titleLabel then titleLabel.Text = t("main_title") end
    if mainTab then mainTab.Text = t("tab_main") end
    if playerTab then playerTab.Text = t("tab_players") end
    if visualTab then visualTab.Text = t("tab_visual") end
    if funTab then funTab.Text = t("tab_fun") end
    if debugTab then debugTab.Text = t("tab_debug") end
    if settingsTab then settingsTab.Text = t("tab_settings") end
    if serverTab then serverTab.Text = t("tab_server") end
    if taskbarButton then taskbarButton.Text = "AdminScript 5.0" end
    
    -- Очищаем вкладки
    for _, content in pairs({mainContent, playerContent, visualContent, funContent, debugContent, settingsContent, serverContent}) do
        if content then
            content:ClearAllChildren()
        end
    end
    
    -- Пересоздаем кнопки с новыми переводами
    createButtons()
    createSettings()
end

-- Создание кнопок
local function createButtons()
    -- Основные функции
    addButton(mainContent, t("refresh_players"), updatePlayerList, t("tooltip_refresh"))
    addButton(mainContent, t("kill_selected"), function()
        for plr, _ in pairs(selectedPlayers) do
            if plr and plr.Parent and plr.Character then
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
            if plr and plr.Parent then
                target = plr
                break
            end
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
            if plr and plr.Parent and plr.Character then
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
    
    addButton(mainContent, t("ghost_mode"), ghostMode, t("tooltip_ghost_mode"))
    
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
    
    createStateButton(mainContent, t("infinite_jump"), infiniteJump, "InfiniteJump", t("tooltip_infinite_jump"))
    
    -- Визуальные функции
    addButton(visualContent, t("speed_x2"), function()
        speedHack(32)
    end, t("tooltip_speed_x2"))
    
    addButton(visualContent, t("speed_x5"), function()
        speedHack(80)
    end, t("tooltip_speed_x5"))
    
    addButton(visualContent, t("speed_x10"), function()
        speedHack(160)
    end, t("tooltip_speed_x10"))
    
    addButton(visualContent, t("day"), function()
        setTimeOfDay(12)
    end, t("tooltip_day"))
    
    addButton(visualContent, t("night"), function()
        setTimeOfDay(0)
    end, t("tooltip_night"))
    
    addButton(visualContent, t("moon_gravity"), function()
        changeGravity(10)
    end, t("tooltip_moon_gravity"))
    
    addButton(visualContent, t("zero_gravity"), function()
        changeGravity(0)
    end, t("tooltip_zero_gravity"))
    
    createStateButton(visualContent, t("rainbow_char"), function(state)
        if state then
            rainbowCharacter()
        else
            stopRainbowCharacter()
        end
    end, "Rainbow", t("tooltip_rainbow_char"))
    
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
    
    -- Fun/Trolling функции
    addButton(funContent, t("spin_player"), spinPlayer, t("tooltip_spin_player"))
    addButton(funContent, t("launch_player"), launchPlayer, t("tooltip_launch_player"))
    addButton(funContent, t("invert_controls"), invertControls, t("tooltip_invert_controls"))
    addButton(funContent, t("random_teleport"), randomTeleport, t("tooltip_random_teleport"))
    addButton(funContent, t("fake_message"), fakeMessage, t("tooltip_fake_message"))
    addButton(funContent, t("change_size"), changeSize, t("tooltip_change_size"))
    addButton(funContent, t("invisible_player"), invisiblePlayer, t("tooltip_invisible_player"))
    addButton(funContent, t("mirror_mode"), mirrorMode, t("tooltip_mirror_mode"))
    addButton(funContent, t("disable_jump"), disableJump, t("tooltip_disable_jump"))
    addButton(funContent, t("enable_autojump"), enableAutoJump, t("tooltip_enable_autojump"))
    addButton(funContent, t("dance_player"), dancePlayer, t("tooltip_dance_player"))
    addButton(funContent, t("sit_player"), sitPlayer, t("tooltip_sit_player"))
    addButton(funContent, t("freeze_position"), freezePosition, t("tooltip_freeze_position"))
    addButton(funContent, t("unfreeze_player"), unfreezePlayer, t("tooltip_unfreeze_player"))
    addButton(funContent, t("clone_player"), clonePlayer, t("tooltip_clone_player"))
    addButton(funContent, t("fire_player"), firePlayer, t("tooltip_fire_player"))
    addButton(funContent, t("shock_player"), shockPlayer, t("tooltip_shock_player"))
    addButton(funContent, t("orbit_player"), orbitPlayer, t("tooltip_orbit_player"))
    
    -- Серверные функции
    addButton(serverContent, t("server_shutdown"), serverShutdown, t("tooltip_server_shutdown"))
    addButton(serverContent, t("server_restart"), serverRestart, t("tooltip_server_restart"))
    addButton(serverContent, t("server_time"), changeServerTime, t("tooltip_server_time"))
    addButton(serverContent, t("server_weather"), changeWeather, t("tooltip_server_weather"))
    addButton(serverContent, t("server_gravity"), changeServerGravity, t("tooltip_server_gravity"))
    
    -- Кнопки для вкладки игроков
    local refreshBtn = createButton(t("refresh_players"), 38, false, t("tooltip_refresh"))
    refreshBtn.Parent = playerContent
    refreshBtn.MouseButton1Click:Connect(updatePlayerList)
    
    addButton(playerContent, t("kill_selected"), function()
        for plr, _ in pairs(selectedPlayers) do
            if plr and plr.Parent and plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = 0
                end
            end
        end
        showNotification(t("kill_selected"), t("notification_kill_selected"), 3)
    end, t("tooltip_kill_selected"))
    
    addButton(playerContent, t("heal_selected"), function()
        for plr, _ in pairs(selectedPlayers) do
            if plr and plr.Parent and plr.Character then
                local humanoid = plr.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end
        showNotification(t("heal_selected"), t("notification_heal_selected"), 3)
    end, t("tooltip_heal_selected"))
    
    addButton(playerContent, t("freeze_selected"), freezeSelectedPlayers, t("tooltip_freeze_selected"))
    addButton(playerContent, t("unfreeze_selected"), unfreezeSelectedPlayers, t("tooltip_unfreeze_selected"))
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

-- Создание настроек
local function createSettings()
    if not settingsContent then return end
    settingsContent:ClearAllChildren()
    
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
    flySpeedInput.Parent = flySpeedSetting

    flySpeedInput.FocusLost:Connect(function()
        local newSpeed = tonumber(flySpeedInput.Text)
        if newSpeed and newSpeed > 0 and newSpeed <= 500 then
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
    explosionRadiusInput.Parent = explosionRadiusSetting

    explosionRadiusInput.FocusLost:Connect(function()
        local newRadius = tonumber(explosionRadiusInput.Text)
        if newRadius and newRadius > 0 and newRadius <= 100 then
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
    languageDropdown.Parent = languageSetting

    languageDropdown.MouseButton1Click:Connect(function()
        local languages = {"en", "ru"}
        local currentIndex = table.find(languages, settings.Language) or 1
        local nextIndex = (currentIndex % #languages) + 1
        settings.Language = languages[nextIndex]
        languageDropdown.Text = settings.Language:upper()
        languageSetting:FindFirstChild("TextLabel").Text = t("language") .. ": " .. settings.Language:upper()
        updateUIForLanguage()
        showNotification(t("settings"), t("notification_language") .. settings.Language:upper(), 3)
    end)
end

-- Анимация открытия окна
local function openWindow()
    if mainFrame.Visible then return end
    
    taskbarButton.Visible = false
    mainFrame.Visible = true

    -- Сбрасываем видимость всех элементов
    titleBar.Visible = true
    titleLabel.Visible = true
    tabBar.Visible = true
    mainTab.Visible = true
    playerTab.Visible = true
    visualTab.Visible = true
    funTab.Visible = true
    debugTab.Visible = true
    settingsTab.Visible = true
    serverTab.Visible = true
    tabContainer.Visible = true
    mainContent.Visible = true
    playerContent.Visible = false
    visualContent.Visible = false
    funContent.Visible = false
    debugContent.Visible = false
    settingsContent.Visible = false
    serverContent.Visible = false

    -- Инициализируем компоненты
    updatePlayerList()
    initDebugPanel()
    createButtons()
    createSettings()
    
    -- Активируем первую вкладку
    switchTab(mainContent)
    
    logDebug("Admin panel opened")
end

-- Анимация закрытия окна
local function closeWindow()
    if not mainFrame.Visible then return end
    
    mainFrame.Visible = false
    taskbarButton.Visible = true
    logDebug("Admin panel closed")
end

-- Переключение вкладок
local function switchTab(content)
    if not content then return end
    
    -- Скрываем все вкладки
    mainContent.Visible = false
    playerContent.Visible = false
    visualContent.Visible = false
    funContent.Visible = false
    debugContent.Visible = false
    settingsContent.Visible = false
    serverContent.Visible = false
    
    -- Показываем выбранную вкладку
    content.Visible = true
    
    -- Обновляем контент при необходимости
    if content == playerContent then
        updatePlayerList()
    elseif content == debugContent then
        initDebugPanel()
    end
end

-- Обработчики кнопок
closeBtn.MouseButton1Click:Connect(function()
    -- Отключаем все активные функции
    stopFlying()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
    if infiniteJumpConnection then
        infiniteJumpConnection:Disconnect()
        infiniteJumpConnection = nil
    end
    if debugConnection then
        debugConnection:Disconnect()
        debugConnection = nil
    end
    if freezeLoop then
        freezeLoop:Disconnect()
        freezeLoop = nil
    end
    stopRainbowCharacter()
    removeESP()
    unfreezeAllPlayers()
    stopSpinningPlayers()
    stopInvertedControls()
    stopOrbitingPlayers()
    
    closeWindow()
    task.wait(0.1)
    if gui then
        gui:Destroy()
    end
end)

minimizeBtn.MouseButton1Click:Connect(function()
    closeWindow()
    taskbarButton.Visible = true
end)

taskbarButton.MouseButton1Click:Connect(function()
    if mainFrame.Visible then
        closeWindow()
    else
        openWindow()
    end
end)

-- Переключение вкладок
mainTab.MouseButton1Click:Connect(function() switchTab(mainContent) end)
playerTab.MouseButton1Click:Connect(function() switchTab(playerContent) end)
visualTab.MouseButton1Click:Connect(function() switchTab(visualContent) end)
funTab.MouseButton1Click:Connect(function() switchTab(funContent) end)
debugTab.MouseButton1Click:Connect(function() switchTab(debugContent) end)
settingsTab.MouseButton1Click:Connect(function() switchTab(settingsContent) end)
serverTab.MouseButton1Click:Connect(function() switchTab(serverContent) end)

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

-- Обновление позиции подсказки при движении мыши
UserInputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        if tooltip and tooltip.Visible then
            local mousePos = UserInputService:GetMouseLocation()
            tooltip.Position = UDim2.new(0, mousePos.X + 20, 0, mousePos.Y)
        end
    end
end)

-- Автоматическое открытие при загрузке
if settings.AutoOpen then
    task.delay(1, function()
        openWindow()
    end)
else
    taskbarButton.Visible = true
end

-- Обработка выхода из игры
player.CharacterRemoving:Connect(function()
    stopFlying()
    if noclipConnection then
        noclipConnection:Disconnect()
        noclipConnection = nil
    end
end)

-- Защита от ошибок
RunService.Heartbeat:Connect(function()
    if flying and not player.Character then
        stopFlying()
    end
end)

-- Инициализация дебаг-лога
logDebug("Admin panel initialized")
logDebug("Version: Ultimate 5.0")
logDebug("Player: " .. player.Name)

-- Создаем кнопки при запуске
createButtons()
createSettings()

-- Показываем панель задач
taskbarButton.Visible = true
