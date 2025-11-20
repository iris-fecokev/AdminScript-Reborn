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

-- Key system
local correctKey = "loading..."
task.spawn(function()
	local success, response = pcall(function()
		return game:HttpGet("https://raw.githubusercontent.com/iris-fecokev/AdminScript-Key/refs/heads/main/key.txt")
	end)
	if success and response then
		correctKey = response:gsub("%s", "")  -- Remove whitespace
	else
		correctKey = "56v55rV5565RRrt6RrftFTftc56rrt567"  -- Fallback
	end
end)

-- White background
local whiteBg = Instance.new("Frame")
whiteBg.Size = UDim2.new(1, 0, 1, 0)
whiteBg.BackgroundColor3 = Color3.new(1, 1, 1)
whiteBg.ZIndex = 1
whiteBg.Parent = gui
whiteBg.BackgroundTransparency = 0.5

-- Key window (XP style, movable, smaller, semi-transparent background 0.5, responsive for mobile)
local keyWindow = Instance.new("Frame")
keyWindow.Size = UDim2.new(0.8, 0, 0.6, 0)  -- Responsive size
keyWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
keyWindow.AnchorPoint = Vector2.new(0.5, 0.5)
keyWindow.BackgroundColor3 = Color3.fromRGB(212, 208, 200)
keyWindow.BorderSizePixel = 0
keyWindow.ZIndex = 10
keyWindow.Parent = gui

-- Title bar (blue)
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(0, 14, 122)
titleBar.BorderSizePixel = 0
titleBar.Parent = keyWindow

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -70, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "Key System"
titleLabel.TextColor3 = Color3.new(1, 1, 1)
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextSize = 16
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

-- Close button
local closeBtn = Instance.new("ImageButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -28, 0, 2)
closeBtn.BackgroundTransparency = 1
closeBtn.Image = "rbxassetid://118955245038416"
closeBtn.Parent = titleBar

closeBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)

-- Main text
local mainText = Instance.new("TextLabel")
mainText.Size = UDim2.new(0.9, 0, 0.2, 0)
mainText.Position = UDim2.new(0.05, 0, 0.15, 0)
mainText.BackgroundTransparency = 1
mainText.Text = "You need a key, join discord server for key lol"
mainText.TextColor3 = Color3.new(0, 0, 0)
mainText.Font = Enum.Font.SourceSansBold
mainText.TextSize = 18
mainText.TextWrapped = true
mainText.Parent = keyWindow

-- Timer label
local timerLabel = Instance.new("TextLabel")
timerLabel.Size = UDim2.new(0.9, 0, 0.1, 0)
timerLabel.Position = UDim2.new(0.05, 0, 0.35, 0)
timerLabel.BackgroundTransparency = 1
timerLabel.Text = "Time left: 3:00"
timerLabel.TextColor3 = Color3.new(1, 0, 0)
timerLabel.Font = Enum.Font.SourceSansBold
timerLabel.TextSize = 18
timerLabel.Parent = keyWindow

-- Key input
local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8, 0, 0.15, 0)
keyBox.Position = UDim2.new(0.1, 0, 0.48, 0)
keyBox.PlaceholderText = "Enter key..."
keyBox.Text = "56v55rV5565RRrt6RrftFTftc56rrt567"
keyBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
keyBox.BorderColor3 = Color3.new(0, 0, 0)
keyBox.TextColor3 = Color3.new(0, 0, 0)
keyBox.Font = Enum.Font.SourceSans
keyBox.TextSize = 18
keyBox.Parent = keyWindow

-- Copy Discord button
local copyBtn = Instance.new("TextButton")
copyBtn.Size = UDim2.new(0.4, 0, 0.15, 0)
copyBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
copyBtn.Text = "Copy Server Link"
copyBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
copyBtn.TextColor3 = Color3.new(1, 1, 1)
copyBtn.Font = Enum.Font.SourceSansBold
copyBtn.TextSize = 16
copyBtn.Parent = keyWindow

copyBtn.MouseButton1Click:Connect(function()
	setclipboard("https://discord.gg/jU9T9Ju5Fb")
end)

-- Check button
local checkBtn = Instance.new("TextButton")
checkBtn.Size = UDim2.new(0.4, 0, 0.15, 0)
checkBtn.Position = UDim2.new(0.5, 0, 0.7, 0)
checkBtn.Text = "Check"
checkBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
checkBtn.TextColor3 = Color3.new(1, 1, 1)
checkBtn.Font = Enum.Font.SourceSansBold
checkBtn.TextSize = 16
checkBtn.Parent = keyWindow

-- Error label
local errorText = Instance.new("TextLabel")
errorText.Size = UDim2.new(0.9, 0, 0.1, 0)
errorText.Position = UDim2.new(0.05, 0, 0.88, 0)
errorText.BackgroundTransparency = 1
errorText.Text = ""
errorText.TextColor3 = Color3.new(1, 0, 0)
errorText.Font = Enum.Font.SourceSansBold
errorText.TextSize = 18
errorText.Parent = keyWindow

-- Dragging for key window (support touch for mobile)
local dragging = false
local dragOffset = Vector2.new(0, 0)

titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragOffset = Vector2.new(input.Position.X, input.Position.Y) - Vector2.new(keyWindow.AbsolutePosition.X, keyWindow.AbsolutePosition.Y)
	end
end)

titleBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
		local newPos = UDim2.new(
			0, input.Position.X - dragOffset.X,
			0, input.Position.Y - dragOffset.Y
		)
		keyWindow.Position = newPos
	end
end)

-- Timer (3 minutes = 180 seconds)
local timeLeft = 180
local timerConnection = RunService.Heartbeat:Connect(function(dt)
	timeLeft = timeLeft - dt
	local mins = math.floor(timeLeft / 60)
	local secs = math.floor(timeLeft % 60)
	timerLabel.Text = string.format("Time left: %d:%02d", mins, secs)

	if timeLeft <= 0 then
		timerConnection:Disconnect()
		errorText.Text = "Time is over"
		task.wait(2)
		gui:Destroy()
	end
end)

-- Key check with animation (smooth shrink)
local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
local goal = {Size = UDim2.new(0, 0, 0, 0)}
checkBtn.MouseButton1Click:Connect(function()
	local enteredKey = keyBox.Text:gsub("%s", "")
	if enteredKey == correctKey then
		timerConnection:Disconnect()
		TweenService:Create(keyWindow, tweenInfo, goal):Play()
		task.wait(0.5)
		whiteBg:Destroy()
		keyWindow:Destroy()

		-- Launch main script
		local ANIMATION_STEPS = 8
		local ANIMATION_STEP_DELAY = 0.03
		local FLY_ANIMATION_ID = 93954221593805
		local DEBUG_MODE = true
		local DEBUG_LOG_MAX = 50
		local MIN_WINDOW_SIZE = Vector2.new(400, 300)

		local debugLogs = {}
		local debugPanel
		local debugLogFrame
		local debugConnection
		local performanceStats = {
			FPS = 0,
			Ping = 0,
			Memory = 0
		}

		local settings = {
			AutoOpen = true,
			FlySpeed = 50,
			ExplosionRadius = 20,
			Language = "en",
			Theme = "Classic",
			Hotkeys = {
				Fly = Enum.KeyCode.F,
				Noclip = Enum.KeyCode.N,
				GodMode = Enum.KeyCode.G
			}
		}

		local localization = {
			en = {
				main_title = "AdminScript Ultimate 6.0 by IRIS_FECOKEV",
				tab_main = "Main",
				tab_players = "Players",
				tab_visual = "Visual",
				tab_fun = "Fun/Trolling",
				tab_debug = "Debug",
				tab_settings = "Settings",
				tab_server = "Server",
				tab_fe_effects = "FE Effects",
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
				black_hole = "Create FE black hole",
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
				notification_ghost_mode_on = "Ghost mode enabled",
				notification_ghost_mode_off = "Ghost mode disabled",
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
				tooltip_ghost_mode = "Toggle ghost mode (transparency)",

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
				notification_server_gravity = "Server gravity changed",

				-- New functions
				anti_afk = "Anti-AFK",
				tooltip_anti_afk = "Toggle Anti-AFK (spins character)",
				notification_anti_afk_on = "Anti-AFK enabled",
				notification_anti_afk_off = "Anti-AFK disabled",
				teleport_random_player = "Teleport to Random Player",
				tooltip_teleport_random_player = "Teleport to a random player",
				notification_teleport_random_player = "Teleported to random player",
				super_jump = "Super Jump",
				tooltip_super_jump = "Toggle super jump",
				notification_super_jump_on = "Super jump enabled",
				notification_super_jump_off = "Super jump disabled",
				invisible_self = "Invisible Self",
				tooltip_invisible_self = "Toggle invisibility for yourself",
				notification_invisible_self_on = "You are now invisible",
				notification_invisible_self_off = "You are now visible",
				change_team = "Change Team",
				tooltip_change_team = "Change your team (if applicable)",
				notification_change_team = "Team changed",
				give_weapon = "Give Weapon",
				tooltip_give_weapon = "Give yourself a weapon",
				notification_give_weapon = "Weapon given",
				fake_lag = "Fake Lag",
				tooltip_fake_lag = "Toggle fake lag",
				notification_fake_lag_on = "Fake lag enabled",
				notification_fake_lag_off = "Fake lag disabled",
				auto_farm = "Auto Farm",
				tooltip_auto_farm = "Toggle auto farming (if game supports)",
				notification_auto_farm_on = "Auto farm enabled",
				notification_auto_farm_off = "Auto farm disabled",
				speed_boost = "Speed Boost",
				tooltip_speed_boost = "Give speed boost",
				notification_speed_boost = "Speed boosted",
				health_regen = "Health Regen",
				tooltip_health_regen = "Toggle health regeneration",
				notification_health_regen_on = "Health regen enabled",
				notification_health_regen_off = "Health regen disabled",
				no_clip_objects = "No Clip Objects",
				tooltip_no_clip_objects = "Toggle no clip for objects",
				notification_no_clip_objects_on = "No clip objects enabled",
				notification_no_clip_objects_off = "No clip objects disabled",
				player_esp_names = "Player ESP Names",
				tooltip_player_esp_names = "Toggle player names ESP",
				notification_player_esp_names_on = "Player names ESP enabled",
				notification_player_esp_names_off = "Player names ESP disabled",
				night_vision = "Night Vision",
				tooltip_night_vision = "Toggle night vision",
				notification_night_vision_on = "Night vision enabled",
				notification_night_vision_off = "Night vision disabled",
				fog_remove = "Remove Fog",
				tooltip_fog_remove = "Remove fog",
				notification_fog_remove = "Fog removed",
				bright_mode = "Bright Mode",
				tooltip_bright_mode = "Toggle bright mode",
				notification_bright_mode_on = "Bright mode enabled",
				notification_bright_mode_off = "Bright mode disabled",
				rainbow_sky = "Rainbow Sky",
				tooltip_rainbow_sky = "Toggle rainbow sky",
				notification_rainbow_sky_on = "Rainbow sky enabled",
				notification_rainbow_sky_off = "Rainbow sky disabled",
				spawn_item = "Spawn Item",
				tooltip_spawn_item = "Spawn an item",
				notification_spawn_item = "Item spawned",
				duplicate_self = "Duplicate Self",
				tooltip_duplicate_self = "Duplicate your character",
				notification_duplicate_self = "Self duplicated",
				teleport_home = "Teleport Home",
				tooltip_teleport_home = "Teleport to home base",
				notification_teleport_home = "Teleported home",
				increase_jump = "Increase Jump Power",
				tooltip_increase_jump = "Increase jump power",
				notification_increase_jump = "Jump power increased",
				decrease_gravity = "Decrease Gravity",
				tooltip_decrease_gravity = "Decrease gravity",
				notification_decrease_gravity = "Gravity decreased",
				player_tracker = "Player Tracker",
				tooltip_player_tracker = "Toggle player tracker",
				notification_player_tracker_on = "Player tracker enabled",
				notification_player_tracker_off = "Player tracker disabled",
				auto_heal = "Auto Heal",
				tooltip_auto_heal = "Toggle auto heal",
				notification_auto_heal_on = "Auto heal enabled",
				notification_auto_heal_off = "Auto heal disabled",
				no_damage = "No Damage",
				tooltip_no_damage = "Toggle no damage",
				notification_no_damage_on = "No damage enabled",
				notification_no_damage_off = "No damage disabled",
				fly_boost = "Fly Boost",
				tooltip_fly_boost = "Boost fly speed temporarily",
				notification_fly_boost = "Fly boosted",
				esp_items = "ESP Items",
				tooltip_esp_items = "Toggle ESP for items",
				notification_esp_items_on = "Items ESP enabled",
				notification_esp_items_off = "Items ESP disabled",
				chat_spam = "Chat Spam",
				tooltip_chat_spam = "Toggle chat spam",
				notification_chat_spam_on = "Chat spam enabled",
				notification_chat_spam_off = "Chat spam disabled",
				character_size = "Change Character Size",
				tooltip_character_size = "Change your character size",
				notification_character_size = "Character size changed",
				teleport_selected = "Teleport Selected",
				tooltip_teleport_selected = "Teleport selected players to you",
				notification_teleport_selected = "Selected players teleported",

				-- Even more new functions (added many as requested)
				teleport_all_to_me = "Teleport All to Me",
				tooltip_teleport_all_to_me = "Teleport all players to your position",
				notification_teleport_all_to_me = "All players teleported to you",
				mass_resurrect = "Mass Resurrect",
				tooltip_mass_resurrect = "Resurrect all dead players",
				notification_mass_resurrect = "All dead players resurrected",
				invisible_all = "Invisible All",
				tooltip_invisible_all = "Make all players invisible",
				notification_invisible_all = "All players invisible",
				visible_all = "Visible All",
				tooltip_visible_all = "Make all players visible",
				notification_visible_all = "All players visible",
				speed_all_x2 = "Speed All x2",
				tooltip_speed_all_x2 = "Double speed for all players",
				notification_speed_all_x2 = "All players speed doubled",
				gravity_invert = "Invert Gravity",
				tooltip_gravity_invert = "Invert gravity for server",
				notification_gravity_invert = "Gravity inverted",
				rainbow_all_chars = "Rainbow All Chars",
				tooltip_rainbow_all_chars = "Rainbow effect for all characters",
				notification_rainbow_all_chars = "Rainbow all enabled",
				spawn_monsters = "Spawn Monsters",
				tooltip_spawn_monsters = "Spawn monsters around",
				notification_spawn_monsters = "Monsters spawned",
				remove_all_tools = "Remove All Tools",
				tooltip_remove_all_tools = "Remove tools from all players",
				notification_remove_all_tools = "Tools removed",
				give_all_tools = "Give All Tools",
				tooltip_give_all_tools = "Give tools to all players",
				notification_give_all_tools = "Tools given",
				flood_map = "Flood Map",
				tooltip_flood_map = "Flood the map with water",
				notification_flood_map = "Map flooded",
				earthquake = "Earthquake",
				tooltip_earthquake = "Simulate earthquake",
				notification_earthquake = "Earthquake started",
				fire_all = "Fire All",
				tooltip_fire_all = "Set all players on fire",
				notification_fire_all = "All on fire",
				electrify_all = "Electrify All",
				tooltip_electrify_all = "Electrify all players",
				notification_electrify_all = "All electrified",
				teleport_to_spawn_all = "Teleport All to Spawn",
				tooltip_teleport_to_spawn_all = "Teleport all to spawn",
				notification_teleport_to_spawn_all = "All teleported to spawn",
				lock_all_doors = "Lock All Doors",
				tooltip_lock_all_doors = "Lock all doors in game",
				notification_lock_all_doors = "Doors locked",
				unlock_all_doors = "Unlock All Doors",
				tooltip_unlock_all_doors = "Unlock all doors",
				notification_unlock_all_doors = "Doors unlocked",
				spawn_vehicle = "Spawn Vehicle",
				tooltip_spawn_vehicle = "Spawn a vehicle",
				notification_spawn_vehicle = "Vehicle spawned",
				destroy_map = "Destroy Map",
				tooltip_destroy_map = "Destroy parts of the map",
				notification_destroy_map = "Map destroyed",
				heal_self = "Heal Self",
				tooltip_heal_self = "Heal yourself fully",
				notification_heal_self = "You are healed",
				kill_self = "Kill Self",
				tooltip_kill_self = "Kill yourself",
				notification_kill_self = "You died",
				respawn_self = "Respawn Self",
				tooltip_respawn_self = "Respawn yourself",
				notification_respawn_self = "Respawned",
				change_weather_rain = "Change Weather to Rain",
				tooltip_change_weather_rain = "Set weather to rain",
				notification_change_weather_rain = "Raining",
				change_weather_snow = "Change Weather to Snow",
				tooltip_change_weather_snow = "Set weather to snow",
				notification_change_weather_snow = "Snowing",
				change_weather_clear = "Clear Weather",
				tooltip_change_weather_clear = "Clear weather",
				notification_change_weather_clear = "Weather cleared",
				increase_fog = "Increase Fog",
				tooltip_increase_fog = "Increase fog density",
				notification_increase_fog = "Fog increased",
				decrease_fog = "Decrease Fog",
				tooltip_decrease_fog = "Decrease fog density",
				notification_decrease_fog = "Fog decreased",
				set_time_dawn = "Set Time to Dawn",
				tooltip_set_time_dawn = "Set time to dawn",
				notification_set_time_dawn = "Time set to dawn",
				set_time_dusk = "Set Time to Dusk",
				tooltip_set_time_dusk = "Set time to dusk",
				notification_set_time_dusk = "Time set to dusk",
				enable_flight_all = "Enable Flight All",
				tooltip_enable_flight_all = "Enable flight for all",
				notification_enable_flight_all = "Flight enabled for all",
				disable_flight_all = "Disable Flight All",
				tooltip_disable_flight_all = "Disable flight for all",
				notification_disable_flight_all = "Flight disabled for all",
				make_all_jump_high = "Make All Jump High",
				tooltip_make_all_jump_high = "Increase jump for all",
				notification_make_all_jump_high = "All jump high",
				make_all_jump_low = "Make All Jump Low",
				tooltip_make_all_jump_low = "Decrease jump for all",
				notification_make_all_jump_low = "All jump low",
				spawn_powerup = "Spawn Powerup",
				tooltip_spawn_powerup = "Spawn a powerup",
				notification_spawn_powerup = "Powerup spawned",
				remove_powerups = "Remove Powerups",
				tooltip_remove_powerups = "Remove all powerups",
				notification_remove_powerups = "Powerups removed",
				change_size_all = "Change Size All",
				tooltip_change_size_all = "Change size for all players",
				notification_change_size_all = "All sizes changed",
				reset_size_all = "Reset Size All",
				tooltip_reset_size_all = "Reset size for all",
				notification_reset_size_all = "Sizes reset",
				create_forcefield = "Create Forcefield",
				tooltip_create_forcefield = "Create forcefield around self",
				notification_create_forcefield = "Forcefield created",
				remove_forcefield = "Remove Forcefield",
				tooltip_remove_forcefield = "Remove forcefield",
				notification_remove_forcefield = "Forcefield removed",
				teleport_to_waypoint = "Teleport to Waypoint",
				tooltip_teleport_to_waypoint = "Teleport to set waypoint",
				notification_teleport_to_waypoint = "Teleported to waypoint",
				set_waypoint = "Set Waypoint",
				tooltip_set_waypoint = "Set a waypoint",
				notification_set_waypoint = "Waypoint set",
				clear_waypoints = "Clear Waypoints",
				tooltip_clear_waypoints = "Clear all waypoints",
				notification_clear_waypoints = "Waypoints cleared",

				-- FE Effects
				fe_black_hole = "Create FE Black Hole",
				tooltip_fe_black_hole = "Create FE black hole with orbit and kill",
				notification_fe_black_hole = "FE Black Hole created",
				fe_fire_aura = "FE Fire Aura",
				tooltip_fe_fire_aura = "Surround with fire aura",
				notification_fe_fire_aura = "Fire aura activated",
				fe_lightning_strike = "FE Lightning Strike",
				tooltip_fe_lightning_strike = "Strike lightning on selected",
				notification_fe_lightning_strike = "Lightning struck",
				fe_explosion_wave = "FE Explosion Wave",
				tooltip_fe_explosion_wave = "Create explosion wave",
				notification_fe_explosion_wave = "Explosion wave created",
				fe_invisibility_cloak = "FE Invisibility Cloak",
				tooltip_fe_invisibility_cloak = "Toggle invisibility cloak",
				notification_fe_invisibility_cloak_on = "Invisibility cloak on",
				notification_fe_invisibility_cloak_off = "Invisibility cloak off",
				fe_time_warp = "FE Time Warp",
				tooltip_fe_time_warp = "Warp time for effects",
				notification_fe_time_warp = "Time warped",
				fe_portal = "FE Portal",
				tooltip_fe_portal = "Create portal to location",
				notification_fe_portal = "Portal created",
				fe_energy_blast = "FE Energy Blast",
				tooltip_fe_energy_blast = "Shoot energy blast",
				notification_fe_energy_blast = "Energy blast shot",
				fe_gravity_field = "FE Gravity Field",
				tooltip_fe_gravity_field = "Create gravity field",
				notification_fe_gravity_field = "Gravity field created",
				fe_shadow_clone = "FE Shadow Clone",
				tooltip_fe_shadow_clone = "Create shadow clones",
				notification_fe_shadow_clone = "Shadow clones created",
				fe_meteor_shower = "FE Meteor Shower",
				tooltip_fe_meteor_shower = "Summon meteor shower",
				notification_fe_meteor_shower = "Meteor shower started",
				fe_wind_gust = "FE Wind Gust",
				tooltip_fe_wind_gust = "Create wind gust to push",
				notification_fe_wind_gust = "Wind gust created",
				fe_earth_spike = "FE Earth Spike",
				tooltip_fe_earth_spike = "Spike from ground",
				notification_fe_earth_spike = "Earth spike created",
				fe_water_wave = "FE Water Wave",
				tooltip_fe_water_wave = "Create water wave",
				notification_fe_water_wave = "Water wave created",
				fe_poison_cloud = "FE Poison Cloud",
				tooltip_fe_poison_cloud = "Create poison cloud",
				notification_fe_poison_cloud = "Poison cloud created",
				fe_healing_aura = "FE Healing Aura",
				tooltip_fe_healing_aura = "Healing aura around self",
				notification_fe_healing_aura = "Healing aura activated",
				fe_speed_trail = "FE Speed Trail",
				tooltip_fe_speed_trail = "Leave speed trail",
				notification_fe_speed_trail = "Speed trail activated",
				fe_fireball = "FE Fireball",
				tooltip_fe_fireball = "Shoot fireball",
				notification_fe_fireball = "Fireball shot",
				fe_ice_freeze = "FE Ice Freeze",
				tooltip_fe_ice_freeze = "Freeze area with ice",
				notification_fe_ice_freeze = "Ice freeze activated",
				fe_telekinesis = "FE Telekinesis",
				tooltip_fe_telekinesis = "Lift objects with mind",
				notification_fe_telekinesis = "Telekinesis activated",
				fe_summon_minion = "FE Summon Minion",
				tooltip_fe_summon_minion = "Summon a minion",
				notification_fe_summon_minion = "Minion summoned",
				fe_darkness_shroud = "FE Darkness Shroud",
				tooltip_fe_darkness_shroud = "Shroud area in darkness",
				notification_fe_darkness_shroud = "Darkness shroud created",
				fe_light_beam = "FE Light Beam",
				tooltip_fe_light_beam = "Shoot light beam",
				notification_fe_light_beam = "Light beam shot",
				fe_vortex = "FE Vortex",
				tooltip_fe_vortex = "Create vortex to suck in",
				notification_fe_vortex = "Vortex created",
				fe_exploding_clone = "FE Exploding Clone",
				tooltip_fe_exploding_clone = "Create exploding clone",
				notification_fe_exploding_clone = "Exploding clone created",
				fe_rainbow_trail = "FE Rainbow Trail",
				tooltip_fe_rainbow_trail = "Leave rainbow trail",
				notification_fe_rainbow_trail = "Rainbow trail activated",
				fe_levitation = "FE Levitation",
				tooltip_fe_levitation = "Levitate selected players",
				notification_fe_levitation = "Levitation activated",
				fe_shrink_ray = "FE Shrink Ray",
				tooltip_fe_shrink_ray = "Shrink selected players",
				notification_fe_shrink_ray = "Shrink ray used",
				fe_grow_ray = "FE Grow Ray",
				tooltip_fe_grow_ray = "Grow selected players",
				notification_fe_grow_ray = "Grow ray used",
				fe_confuse = "FE Confuse",
				tooltip_fe_confuse = "Confuse selected players",
				notification_fe_confuse = "Players confused",
				fe_blind = "FE Blind",
				tooltip_fe_blind = "Blind selected players",
				notification_fe_blind = "Players blinded",
				fe_mute = "FE Mute",
				tooltip_fe_mute = "Mute selected players",
				notification_fe_mute = "Players muted",
				fe_unmute = "FE Unmute",
				tooltip_fe_unmute = "Unmute selected players",
				notification_fe_unmute = "Players unmuted",
				fe_slow_motion = "FE Slow Motion",
				tooltip_fe_slow_motion = "Slow motion for server",
				notification_fe_slow_motion = "Slow motion activated",
				fe_fast_forward = "FE Fast Forward",
				tooltip_fe_fast_forward = "Fast forward for server",
				notification_fe_fast_forward = "Fast forward activated"
			},
			ru = {
				-- ... (add all ru translations if needed)
			}
		}

		local t = function(key)
			return localization[settings.Language][key] or key
		end

		-- Main window (responsive for mobile)
		local mainFrame = Instance.new("Frame")
		mainFrame.Size = UDim2.new(0, 600, 0, 400)  -- Fixed initial size
		mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		mainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		mainFrame.BackgroundColor3 = Color3.fromRGB(212, 208, 200)
		mainFrame.BorderSizePixel = 0
		mainFrame.ClipsDescendants = true
		mainFrame.Visible = false
		mainFrame.Parent = gui

		-- Resize handle
		local resizeHandle = Instance.new("Frame")
		resizeHandle.Size = UDim2.new(0, 20, 0, 20)
		resizeHandle.Position = UDim2.new(1, -20, 1, -20)
		resizeHandle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
		resizeHandle.Parent = mainFrame

		local resizing = false
		local resizeOffset = Vector2.new(0, 0)

		resizeHandle.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				resizing = true
				resizeOffset = Vector2.new(input.Position.X, input.Position.Y)
			end
		end)

		resizeHandle.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				resizing = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if resizing and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local delta = Vector2.new(input.Position.X - resizeOffset.X, input.Position.Y - resizeOffset.Y)
				local newSizeX = mainFrame.AbsoluteSize.X + delta.X
				local newSizeY = mainFrame.AbsoluteSize.Y + delta.Y
				if newSizeX > 200 and newSizeY > 200 then  -- Minimum size
					mainFrame.Size = UDim2.new(0, newSizeX, 0, newSizeY)
					resizeOffset = Vector2.new(input.Position.X, input.Position.Y)
				end
			end
		end)

		-- Title bar
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

		-- Window controls
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

		-- Tab bar (scrollable for mobile if many tabs)
		local tabBar = Instance.new("ScrollingFrame")
		tabBar.Size = UDim2.new(1, 0, 0, 30)
		tabBar.Position = UDim2.new(0, 0, 0, 30)
		tabBar.BackgroundColor3 = Color3.fromRGB(192, 192, 192)
		tabBar.BorderSizePixel = 0
		tabBar.ScrollBarThickness = 5
		tabBar.AutomaticCanvasSize = Enum.AutomaticSize.X
		tabBar.CanvasSize = UDim2.new(0, 0, 0, 0)
		tabBar.Parent = mainFrame

		local tabLayout = Instance.new("UIListLayout")
		tabLayout.FillDirection = Enum.FillDirection.Horizontal
		tabLayout.SortOrder = Enum.SortOrder.LayoutOrder
		tabLayout.Parent = tabBar

		local function createTabButton(name)
			local btn = Instance.new("TextButton")
			btn.Size = UDim2.new(0, 80, 0, 26)
			btn.BackgroundColor3 = Color3.fromRGB(236, 233, 216)
			btn.BorderColor3 = Color3.new(0, 0, 0)
			btn.Text = name
			btn.TextColor3 = Color3.new(0, 0, 0)
			btn.Font = Enum.Font.SourceSansBold
			btn.TextSize = 14
			btn.Parent = tabBar
			return btn
		end

		local mainTab = createTabButton(t("tab_main"))
		local playerTab = createTabButton(t("tab_players"))
		local visualTab = createTabButton(t("tab_visual"))
		local funTab = createTabButton(t("tab_fun"))
		local debugTab = createTabButton(t("tab_debug"))
		local settingsTab = createTabButton(t("tab_settings"))
		local serverTab = createTabButton(t("tab_server"))
		local feEffectsTab = createTabButton(t("tab_fe_effects")) -- New tab

		-- Tab containers
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

		local feEffectsContent = createContentFrame()
		feEffectsContent.Parent = tabContainer

		-- Taskbar button
		local taskbarButton = Instance.new("TextButton")
		taskbarButton.Name = "TaskbarButton"
		taskbarButton.Size = UDim2.new(0, 150, 0, 35)
		taskbarButton.Position = UDim2.new(0, 10, 1, -38)
		taskbarButton.BackgroundColor3 = Color3.fromRGB(0, 14, 122)
		taskbarButton.BorderSizePixel = 0
		taskbarButton.Text = "AdminScript 6.0"
		taskbarButton.TextColor3 = Color3.new(1, 1, 1)
		taskbarButton.Font = Enum.Font.SourceSansBold
		taskbarButton.TextSize = 14
		taskbarButton.Visible = false
		taskbarButton.Parent = gui

		-- Tooltip
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

		-- Notification
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

		local funcs = {}

		funcs.showNotification = function(title, message, duration)
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

		-- Button creation function
		funcs.createButton = function(name, sizeY, withState, tooltipText)
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

			local function updateState(isActive)
				if withState and stateIndicator then
					stateIndicator.Visible = true
					stateIndicator.Text = isActive and t("on") or t("off")
					stateIndicator.TextColor3 = isActive and Color3.new(0, 0.5, 0) or Color3.new(0.5, 0, 0)
				end
			end

			return btn, updateState
		end

		-- Flying system
		local flying = false
		local flyAnimation = nil
		local flyAnimTrack = nil
		local flyBV = nil
		local flyConnection = nil

		funcs.startFlying = function()
			if flying then return end
			local character = player.Character
			if not character then return end

			local humanoid = character:FindFirstChildOfClass("Humanoid")
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
			flyBV.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
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

			funcs.showNotification(t("flying"), t("tooltip_flying"), 3)
		end

		funcs.stopFlying = function()
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

			funcs.showNotification(t("flying"), t("notification_flying_off"), 3)
		end

		-- Player selection system
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

		funcs.updatePlayerList = function()
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

		-- Freeze system
		local frozenPlayers = {}
		local originalColors = {}
		local freezeLoop = nil

		funcs.setupFreezeLoop = function()
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

		funcs.freezeSelectedPlayers = function()
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
			funcs.setupFreezeLoop()
			funcs.showNotification(t("freeze_selected"), t("notification_freeze_selected"), 3)
		end

		funcs.freezeAllPlayers = function()
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
			funcs.setupFreezeLoop()
			funcs.showNotification(t("freeze_all"), t("notification_freeze_all"), 3)
		end

		funcs.unfreezeSelectedPlayers = function()
			for plr, _ in pairs(selectedPlayers) do
				if frozenPlayers[plr] then
					local data = frozenPlayers[plr]
					if data.humanoid and data.humanoid.Parent then
						data.humanoid.WalkSpeed = data.originalWalkSpeed
					end
					frozenPlayers[plr] = nil
				end
			end
			funcs.showNotification(t("unfreeze_selected"), t("notification_unfreeze_selected"), 3)
		end

		funcs.unfreezeAllPlayers = function()
			for plr, data in pairs(frozenPlayers) do
				if data.humanoid and data.humanoid.Parent then
					data.humanoid.WalkSpeed = data.originalWalkSpeed
				end
			end
			frozenPlayers = {}
			funcs.showNotification(t("unfreeze_all"), t("notification_unfreeze_all"), 3)
		end

		-- Debug system
		funcs.logDebug = function(message)
			if not DEBUG_MODE then return end

			local dt = DateTime.now():ToLocalTime()
			local timeStr = string.format("%02d:%02d:%02d", dt.Hour, dt.Minute, dt.Second)

			table.insert(debugLogs, 1, timeStr .. " - " .. tostring(message))

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

		funcs.initDebugPanel = function()
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

			-- Stats update
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

		funcs.changeGravity = function(value)
			if not value then return end
			Workspace.Gravity = value
			funcs.logDebug("Gravity changed: " .. value)
			funcs.showNotification(t("moon_gravity"), t("notification_gravity") .. value, 3)
		end

		funcs.setTimeOfDay = function(hour)
			if not hour then return end
			Lighting.ClockTime = hour
			funcs.logDebug("Time of day set: " .. hour)
			funcs.showNotification(t(hour == 12 and "day" or "night"), t("notification_time") .. hour .. ":00", 3)
		end

		funcs.speedHack = function(speed)
			if not speed then return end
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.WalkSpeed = speed
					funcs.logDebug("Speed set: " .. speed)
					funcs.showNotification(t("speed_x" .. (speed == 32 and "2" or speed == 80 and "5" or "10")), t("notification_speed") .. speed, 3)
				end
			end
		end

		local espHighlights = {}
		funcs.espPlayers = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr ~= player and plr.Character then
					local highlight = Instance.new("Highlight")
					highlight.Parent = plr.Character
					espHighlights[plr] = highlight
				end
			end
			funcs.showNotification(t("esp"), t("notification_esp_on"), 3)
		end

		funcs.removeESP = function()
			for plr, highlight in pairs(espHighlights) do
				highlight:Destroy()
			end
			espHighlights = {}
			funcs.showNotification(t("esp"), t("notification_esp_off"), 3)
		end

		local rainbowConnections = {}
		funcs.rainbowCharacter = function(state)
			if state then
				local character = player.Character
				if character then
					local connection = RunService.Heartbeat:Connect(function()
						for _, part in ipairs(character:GetDescendants()) do
							if part:IsA("BasePart") then
								part.Color = Color3.fromHSV(tick() % 1, 1, 1)
							end
						end
					end)
					rainbowConnections[character] = connection
				end
				funcs.showNotification(t("rainbow_char"), t("notification_rainbow"), 3)
			else
				for _, connection in pairs(rainbowConnections) do
					connection:Disconnect()
				end
				rainbowConnections = {}
				funcs.showNotification(t("rainbow_char"), t("notification_rainbow_off"), 3)
			end
		end

		local noclipConnection = nil
		funcs.noclip = function(state)
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
				funcs.showNotification(t("noclip"), t("notification_noclip_on"), 3)
			else
				if noclipConnection then
					noclipConnection:Disconnect()
					noclipConnection = nil
				end
				if player.Character then
					for _, part in ipairs(player.Character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.CanCollide = true
						end
					end
				end
				funcs.showNotification(t("noclip"), t("notification_noclip_off"), 3)
			end
		end

		local infiniteJumpConnection = nil
		funcs.infiniteJump = function(state)
			if state then
				infiniteJumpConnection = UserInputService.JumpRequest:Connect(function()
					if player.Character then
						local humanoid = player.Character:FindFirstChild("Humanoid")
						if humanoid then
							humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
						end
					end
				end)
				funcs.showNotification(t("infinite_jump"), t("notification_infinite_jump"), 3)
			else
				if infiniteJumpConnection then
					infiniteJumpConnection:Disconnect()
					infiniteJumpConnection = nil
				end
				funcs.showNotification(t("infinite_jump"), t("notification_infinite_jump_off"), 3)
			end
		end

		local godModeActive = false
		funcs.godMode = function(state)
			godModeActive = state
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.MaxHealth = state and math.huge or 100
					humanoid.Health = state and math.huge or 100
				end
			end
			funcs.showNotification(t("godmode"), state and t("notification_godmode_on") or t("notification_godmode_off"), 3)
		end

		local ghostModeActive = false
		local originalTransparency = {}
		funcs.ghostMode = function(state)
			ghostModeActive = state
			local character = player.Character
			if character then
				if state then
					for _, part in ipairs(character:GetDescendants()) do
						if part:IsA("BasePart") then
							originalTransparency[part] = part.Transparency
							part.Transparency = 0.5
						end
					end
					funcs.showNotification(t("ghost_mode"), t("notification_ghost_mode_on"), 3)
				else
					for part, trans in pairs(originalTransparency) do
						if part and part.Parent then
							part.Transparency = trans
						end
					end
					originalTransparency = {}
					funcs.showNotification(t("ghost_mode"), t("notification_ghost_mode_off"), 3)
				end
			end
		end

		funcs.killAllPlayers = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr and plr.Parent and plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.Health = 0
					end
				end
			end
			funcs.showNotification(t("kill_all"), t("notification_kill_all"), 3)
		end

		funcs.healAllPlayers = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr and plr.Parent and plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.Health = humanoid.MaxHealth
					end
				end
			end
			funcs.showNotification(t("heal_all"), t("notification_heal_all"), 3)
		end

		funcs.createExplosion = function(position, radius)
			local explosion = Instance.new("Explosion")
			explosion.Position = position
			explosion.BlastRadius = radius or 20
			explosion.BlastPressure = 500000
			explosion.Parent = Workspace
			funcs.showNotification(t("create_explosion"), t("notification_explosion") .. radius, 3)
		end

		funcs.teleportToPosition = function(cframe)
			if player.Character then
				local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
				if rootPart then
					rootPart.CFrame = cframe
				end
			end
			funcs.showNotification(t("teleport_spawn"), t("notification_teleport"), 3)
		end

		local frozenMapParts = {}
		funcs.freezeMap = function()
			for _, part in ipairs(Workspace:GetDescendants()) do
				if part:IsA("BasePart") and not part.Anchored then
					part.Anchored = true
					frozenMapParts[part] = true
				end
			end
			funcs.showNotification(t("freeze_map"), t("notification_freeze_map"), 3)
		end

		funcs.unfreezeMap = function()
			for part, _ in pairs(frozenMapParts) do
				if part and part.Parent then
					part.Anchored = false
				end
			end
			frozenMapParts = {}
			funcs.showNotification(t("unfreeze_map"), t("notification_unfreeze_map"), 3)
		end

		local blackHoleConnections = {}
		funcs.createBlackHole = function(position)
			local blackHole = Instance.new("Part")
			blackHole.Size = Vector3.new(5, 5, 5)
			blackHole.Position = position
			blackHole.Anchored = true
			blackHole.Shape = Enum.PartShape.Ball
			blackHole.Color = Color3.new(0, 0, 0)
			blackHole.Transparency = 0.3
			blackHole.Parent = Workspace
			Debris:AddItem(blackHole, 30)

			local connection = RunService.Heartbeat:Connect(function(dt)
				for _, obj in ipairs(Workspace:GetChildren()) do
					if obj:IsA("BasePart") and not obj.Anchored and (obj.Position - blackHole.Position).Magnitude < 50 then
						local direction = (blackHole.Position - obj.Position).Unit
						obj.Velocity = direction * 50
						if (obj.Position - blackHole.Position).Magnitude < 5 then
							if obj.Parent and obj.Parent:FindFirstChild("Humanoid") then
								obj.Parent.Humanoid.Health = 0
							else
								obj:Destroy()
							end
						else
							-- Orbit and time effect
							local angle = tick() * 2
							obj.CFrame = CFrame.new(blackHole.Position + Vector3.new(math.cos(angle) * 10, 0, math.sin(angle) * 10))
							-- Simulate time slow/fast
							if math.random(1, 10) > 5 then
								obj.Velocity = obj.Velocity * 0.5  -- Slow
							else
								obj.Velocity = obj.Velocity * 2  -- Fast
							end
						end
					end
				end
			end)
			blackHoleConnections[blackHole] = connection

			task.delay(30, function()
				if connection then connection:Disconnect() end
			end)

			funcs.showNotification(t("fe_black_hole"), t("notification_fe_black_hole"), 3)
		end

		funcs.spinPlayer = function(state)
			if state then
				for plr, _ in pairs(selectedPlayers) do
					if plr and plr.Parent and plr.Character then
						local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
						if rootPart then
							local connection = RunService.Heartbeat:Connect(function(dt)
								rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(360 * dt), 0)
							end)
							spinConnections[plr] = connection
						end
					end
				end
				funcs.showNotification(t("spin_player"), t("notification_spin_player"), 3)
			else
				for _, connection in pairs(spinConnections) do
					connection:Disconnect()
				end
				spinConnections = {}
			end
		end

		local spinConnections = {}

		funcs.launchPlayer = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
					if rootPart then
						rootPart.Velocity = Vector3.new(0, 200, 0)
					end
				end
			end
			funcs.showNotification(t("launch_player"), t("notification_launch_player"), 3)
		end

		local invertControlsConnections = {}
		funcs.invertControls = function(state)
			if state then
				for plr, _ in pairs(selectedPlayers) do
					if plr and plr.Parent and plr.Character then
						local humanoid = plr.Character:FindFirstChild("Humanoid")
						if humanoid then
							local connection = humanoid:GetPropertyChangedSignal("MoveDirection"):Connect(function()
								humanoid.MoveDirection = -humanoid.MoveDirection
							end)
							invertControlsConnections[plr] = connection
						end
					end
				end
				funcs.showNotification(t("invert_controls"), t("notification_invert_controls"), 3)
			else
				for _, connection in pairs(invertControlsConnections) do
					connection:Disconnect()
				end
				invertControlsConnections = {}
			end
		end

		funcs.randomTeleport = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
					if rootPart then
						rootPart.CFrame = CFrame.new(math.random(-1000, 1000), 100, math.random(-1000, 1000))
					end
				end
			end
			funcs.showNotification(t("random_teleport"), t("notification_random_teleport"), 3)
		end

		funcs.fakeMessage = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent then
					local message = "im using AdminScript 6.0, join me!"
					if TextChatService then
						local channel = TextChatService:FindFirstChild("TextChannels").RBXGeneral
						if channel then
							channel:SendAsync(message)
						end
					end
				end
			end
			funcs.showNotification(t("fake_message"), t("notification_fake_message"), 3)
		end

		funcs.changeSize = function()
			local scale = math.random(5, 20) / 10
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.BodyDepthScale.Value = scale
						humanoid.BodyHeightScale.Value = scale
						humanoid.BodyWidthScale.Value = scale
						humanoid.HeadScale.Value = scale
					end
				end
			end
			funcs.showNotification(t("change_size"), t("notification_change_size"), 3)
		end

		funcs.invisiblePlayer = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					for _, part in ipairs(plr.Character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.Transparency = 1
						end
					end
				end
			end
			funcs.showNotification(t("invisible_player"), t("notification_invisible_player"), 3)
		end

		funcs.mirrorMode = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.CameraOffset = Vector3.new(5, 0, 0)
					end
				end
			end
			funcs.showNotification(t("mirror_mode"), t("notification_mirror_mode"), 3)
		end

		funcs.disableJump = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.JumpPower = 0
					end
				end
			end
			funcs.showNotification(t("disable_jump"), t("notification_disable_jump"), 3)
		end

		local autoJumpConnections = {}
		funcs.enableAutoJump = function(state)
			if state then
				for plr, _ in pairs(selectedPlayers) do
					if plr and plr.Parent and plr.Character then
						local humanoid = plr.Character:FindFirstChild("Humanoid")
						if humanoid then
							local connection = RunService.Heartbeat:Connect(function()
								if not humanoid or not humanoid.Parent then
									connection:Disconnect()
									return
								end
								humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
							end)
							autoJumpConnections[plr] = connection
						end
					end
				end
				funcs.showNotification(t("enable_autojump"), t("notification_enable_autojump"), 3)
			else
				for _, connection in pairs(autoJumpConnections) do
					connection:Disconnect()
				end
				autoJumpConnections = {}
			end
		end

		funcs.dancePlayer = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						local animation = Instance.new("Animation")
						animation.AnimationId = "rbxassetid://117654709418244"  -- Dance animation ID
						local track = humanoid:LoadAnimation(animation)
						track:Play()
					end
				end
			end
			funcs.showNotification(t("dance_player"), t("notification_dance_player"), 3)
		end

		funcs.sitPlayer = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.Sit = true
					end
				end
			end
			funcs.showNotification(t("sit_player"), t("notification_sit_player"), 3)
		end

		funcs.freezePosition = function()
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
			funcs.setupFreezeLoop()
			funcs.showNotification(t("freeze_position"), t("notification_freeze_position"), 3)
		end

		funcs.unfreezePlayer = function()
			for plr, _ in pairs(selectedPlayers) do
				if frozenPlayers[plr] then
					frozenPlayers[plr] = nil
				end
			end
			funcs.showNotification(t("unfreeze_player"), t("notification_unfreeze_player"), 3)
		end

		funcs.clonePlayer = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local clone = plr.Character:Clone()
					clone.Parent = Workspace
					clone:MoveTo(plr.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 0))
				end
			end
			funcs.showNotification(t("clone_player"), t("notification_clone_player"), 3)
		end

		funcs.firePlayer = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local fire = Instance.new("Fire")
					fire.Size = 10
					fire.Heat = 10
					fire.Parent = plr.Character.HumanoidRootPart
					Debris:AddItem(fire, 10)
				end
			end
			funcs.showNotification(t("fire_player"), t("notification_fire_player"), 3)
		end

		funcs.shockPlayer = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr and plr.Parent and plr.Character then
					local sparkles = Instance.new("Sparkles")
					sparkles.SparkleColor = Color3.new(0, 1, 1)
					sparkles.Parent = plr.Character.HumanoidRootPart
					Debris:AddItem(sparkles, 10)
				end
			end
			funcs.showNotification(t("shock_player"), t("notification_shock_player"), 3)
		end

		local orbitingPlayers = {}
		funcs.orbitPlayer = function(state)
			if state then
				for plr, _ in pairs(selectedPlayers) do
					if plr and plr.Parent and plr.Character then
						local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
						local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

						if rootPart and playerRoot then
							local angle = 0
							local radius = 10
							local connection = RunService.Heartbeat:Connect(function(dt)
								if not orbitingPlayers[plr] or not rootPart or not rootPart.Parent or not playerRoot then
									connection:Disconnect()
									return
								end
								angle = angle + dt * 2
								local offset = Vector3.new(math.cos(angle) * radius, 0, math.sin(angle) * radius)
								rootPart.CFrame = CFrame.new(playerRoot.Position + offset)
							end)
							orbitingPlayers[plr] = connection
						end
					end
				end
				funcs.showNotification(t("orbit_player"), t("notification_orbit_player"), 3)
			else
				for _, connection in pairs(orbitingPlayers) do
					connection:Disconnect()
				end
				orbitingPlayers = {}
			end
		end

		-- Server functions
		funcs.serverShutdown = function()
			-- Simulation (not real in Roblox)
			funcs.showNotification(t("server_shutdown"), t("notification_server_shutdown"), 3)
		end

		funcs.serverRestart = function()
			-- Simulation
			funcs.showNotification(t("server_restart"), t("notification_server_restart"), 3)
		end

		funcs.changeServerTime = function()
			Lighting.ClockTime = 12
			funcs.showNotification(t("server_time"), t("notification_server_time"), 3)
		end

		funcs.changeWeather = function()
			local rain = Instance.new("Part")
			rain.Size = Vector3.new(100, 1, 100)
			rain.Position = Vector3.new(0, 50, 0)
			rain.Transparency = 0.5
			rain.Color = Color3.new(0.5, 0.5, 1)
			rain.Anchored = true
			rain.CanCollide = false
			rain.Parent = Workspace
			Debris:AddItem(rain, 30)
			funcs.showNotification(t("server_weather"), t("notification_server_weather"), 3)
		end

		funcs.changeServerGravity = function()
			Workspace.Gravity = 50
			funcs.showNotification(t("server_gravity"), t("notification_server_gravity"), 3)
		end

		-- New functions
		local antiAfkConnection = nil
		funcs.antiAfk = function(state)
			if state then
				antiAfkConnection = RunService.Heartbeat:Connect(function(dt)
					if player.Character then
						local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
						if rootPart then
							rootPart.CFrame = rootPart.CFrame * CFrame.Angles(0, math.rad(1), 0)
						end
					end
				end)
				funcs.showNotification(t("anti_afk"), t("notification_anti_afk_on"), 3)
			else
				if antiAfkConnection then
					antiAfkConnection:Disconnect()
					antiAfkConnection = nil
				end
				funcs.showNotification(t("anti_afk"), t("notification_anti_afk_off"), 3)
			end
		end

		funcs.teleportRandomPlayer = function()
			local players = Players:GetPlayers()
			if #players > 1 then
				local randomIndex = math.random(1, #players)
				local randomPlr = players[randomIndex]
				if randomPlr ~= player and randomPlr.Character then
					local rootPart = randomPlr.Character:FindFirstChild("HumanoidRootPart")
					if rootPart then
						funcs.teleportToPosition(rootPart.CFrame)
					end
				end
			end
			funcs.showNotification(t("teleport_random_player"), t("notification_teleport_random_player"), 3)
		end

		local superJumpActive = false
		local originalJumpPower = 50
		funcs.superJump = function(state)
			superJumpActive = state
			local character = player.Character
			if character then
				local humanoid = character:FindFirstChild("Humanoid")
				if humanoid then
					if state then
						originalJumpPower = humanoid.JumpPower
						humanoid.JumpPower = 100
						funcs.showNotification(t("super_jump"), t("notification_super_jump_on"), 3)
					else
						humanoid.JumpPower = originalJumpPower
						funcs.showNotification(t("super_jump"), t("notification_super_jump_off"), 3)
					end
				end
			end
		end

		local invisibleSelfActive = false
		local originalSelfTransparency = {}
		funcs.invisibleSelf = function(state)
			invisibleSelfActive = state
			local character = player.Character
			if character then
				if state then
					for _, part in ipairs(character:GetDescendants()) do
						if part:IsA("BasePart") then
							originalSelfTransparency[part] = part.Transparency
							part.Transparency = 1
						end
					end
					funcs.showNotification(t("invisible_self"), t("notification_invisible_self_on"), 3)
				else
					for part, trans in pairs(originalSelfTransparency) do
						if part and part.Parent then
							part.Transparency = trans
						end
					end
					originalSelfTransparency = {}
					funcs.showNotification(t("invisible_self"), t("notification_invisible_self_off"), 3)
				end
			end
		end

		funcs.changeTeam = function()
			-- Game dependent
			funcs.showNotification(t("change_team"), t("notification_change_team"), 3)
		end

		funcs.giveWeapon = function()
			-- Game dependent
			funcs.showNotification(t("give_weapon"), t("notification_give_weapon"), 3)
		end

		local fakeLagActive = false
		local fakeLagConnection = nil
		funcs.fakeLag = function(state)
			fakeLagActive = state
			if state then
				fakeLagConnection = RunService.Heartbeat:Connect(function()
					task.wait(math.random(0.1, 0.5))
				end)
				funcs.showNotification(t("fake_lag"), t("notification_fake_lag_on"), 3)
			else
				if fakeLagConnection then
					fakeLagConnection:Disconnect()
					fakeLagConnection = nil
				end
				funcs.showNotification(t("fake_lag"), t("notification_fake_lag_off"), 3)
			end
		end

		local autoFarmActive = false
		local autoFarmConnection = nil
		funcs.autoFarm = function(state)
			autoFarmActive = state
			if state then
				autoFarmConnection = RunService.Heartbeat:Connect(function()
					-- Game dependent
				end)
				funcs.showNotification(t("auto_farm"), t("notification_auto_farm_on"), 3)
			else
				if autoFarmConnection then
					autoFarmConnection:Disconnect()
					autoFarmConnection = nil
				end
				funcs.showNotification(t("auto_farm"), t("notification_auto_farm_off"), 3)
			end
		end

		funcs.speedBoost = function()
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.WalkSpeed = humanoid.WalkSpeed * 2
					task.delay(10, function()
						humanoid.WalkSpeed = humanoid.WalkSpeed / 2
					end)
				end
			end
			funcs.showNotification(t("speed_boost"), t("notification_speed_boost"), 3)
		end

		local healthRegenActive = false
		local healthRegenConnection = nil
		funcs.healthRegen = function(state)
			healthRegenActive = state
			if state then
				healthRegenConnection = RunService.Heartbeat:Connect(function()
					if player.Character then
						local humanoid = player.Character:FindFirstChild("Humanoid")
						if humanoid and humanoid.Health < humanoid.MaxHealth then
							humanoid.Health = math.min(humanoid.Health + 1, humanoid.MaxHealth)
						end
					end
				end)
				funcs.showNotification(t("health_regen"), t("notification_health_regen_on"), 3)
			else
				if healthRegenConnection then
					healthRegenConnection:Disconnect()
					healthRegenConnection = nil
				end
				funcs.showNotification(t("health_regen"), t("notification_health_regen_off"), 3)
			end
		end

		local noClipObjectsActive = false
		funcs.noClipObjects = function(state)
			noClipObjectsActive = state
			if state then
				for _, part in ipairs(Workspace:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = false
					end
				end
				funcs.showNotification(t("no_clip_objects"), t("notification_no_clip_objects_on"), 3)
			else
				for _, part in ipairs(Workspace:GetDescendants()) do
					if part:IsA("BasePart") then
						part.CanCollide = true
					end
				end
				funcs.showNotification(t("no_clip_objects"), t("notification_no_clip_objects_off"), 3)
			end
		end

		local playerEspNames = {}
		funcs.playerEspNames = function(state)
			if state then
				for _, plr in ipairs(Players:GetPlayers()) do
					if plr ~= player and plr.Character then
						local billGui = Instance.new("BillboardGui")
						billGui.Adornee = plr.Character.Head
						billGui.Size = UDim2.new(0, 100, 0, 50)
						billGui.StudsOffset = Vector3.new(0, 2, 0)
						billGui.AlwaysOnTop = true
						local textLabel = Instance.new("TextLabel")
						textLabel.Size = UDim2.new(1, 0, 1, 0)
						textLabel.Text = plr.Name
						textLabel.BackgroundTransparency = 1
						textLabel.TextColor3 = Color3.new(1, 1, 1)
						textLabel.Parent = billGui
						billGui.Parent = player:WaitForChild("PlayerGui")
						playerEspNames[plr] = billGui
					end
				end
				funcs.showNotification(t("player_esp_names"), t("notification_player_esp_names_on"), 3)
			else
				for _, gui in pairs(playerEspNames) do
					gui:Destroy()
				end
				playerEspNames = {}
				funcs.showNotification(t("player_esp_names"), t("notification_player_esp_names_off"), 3)
			end
		end

		local nightVisionActive = false
		funcs.nightVision = function(state)
			nightVisionActive = state
			if state then
				Lighting.Brightness = 1
				Lighting.Ambient = Color3.new(1, 1, 1)
				funcs.showNotification(t("night_vision"), t("notification_night_vision_on"), 3)
			else
				Lighting.Brightness = 0
				Lighting.Ambient = Color3.new(0, 0, 0)
				funcs.showNotification(t("night_vision"), t("notification_night_vision_off"), 3)
			end
		end

		funcs.fogRemove = function()
			Lighting.FogEnd = math.huge
			funcs.showNotification(t("fog_remove"), t("notification_fog_remove"), 3)
		end

		local brightModeActive = false
		funcs.brightMode = function(state)
			brightModeActive = state
			if state then
				Lighting.Brightness = 2
				funcs.showNotification(t("bright_mode"), t("notification_bright_mode_on"), 3)
			else
				Lighting.Brightness = 1
				funcs.showNotification(t("bright_mode"), t("notification_bright_mode_off"), 3)
			end
		end

		local rainbowSkyActive = false
		local rainbowSkyConnection = nil
		funcs.rainbowSky = function(state)
			rainbowSkyActive = state
			if state then
				rainbowSkyConnection = RunService.Heartbeat:Connect(function()
					Lighting.Ambient = Color3.fromHSV(tick() % 1, 1, 1)
				end)
				funcs.showNotification(t("rainbow_sky"), t("notification_rainbow_sky_on"), 3)
			else
				if rainbowSkyConnection then
					rainbowSkyConnection:Disconnect()
					rainbowSkyConnection = nil
				end
				Lighting.Ambient = Color3.new(0.5, 0.5, 0.5)
				funcs.showNotification(t("rainbow_sky"), t("notification_rainbow_sky_off"), 3)
			end
		end

		funcs.spawnItem = function()
			-- Game dependent
			funcs.showNotification(t("spawn_item"), t("notification_spawn_item"), 3)
		end

		funcs.duplicateSelf = function()
			if player.Character then
				local clone = player.Character:Clone()
				clone.Parent = Workspace
				clone:MoveTo(player.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 0))
			end
			funcs.showNotification(t("duplicate_self"), t("notification_duplicate_self"), 3)
		end

		funcs.teleportHome = function()
			-- Game dependent
			funcs.teleportToPosition(CFrame.new(0, 0, 0))
			funcs.showNotification(t("teleport_home"), t("notification_teleport_home"), 3)
		end

		funcs.increaseJump = function()
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.JumpPower = humanoid.JumpPower + 10
				end
			end
			funcs.showNotification(t("increase_jump"), t("notification_increase_jump"), 3)
		end

		funcs.decreaseGravity = function()
			Workspace.Gravity = Workspace.Gravity - 10
			funcs.showNotification(t("decrease_gravity"), t("notification_decrease_gravity"), 3)
		end

		local playerTrackerActive = false
		funcs.playerTracker = function(state)
			playerTrackerActive = state
			if state then
				-- Simulation
				funcs.showNotification(t("player_tracker"), t("notification_player_tracker_on"), 3)
			else
				funcs.showNotification(t("player_tracker"), t("notification_player_tracker_off"), 3)
			end
		end

		local autoHealActive = false
		local autoHealConnection = nil
		funcs.autoHeal = function(state)
			autoHealActive = state
			if state then
				autoHealConnection = RunService.Heartbeat:Connect(function()
					if player.Character then
						local humanoid = player.Character:FindFirstChild("Humanoid")
						if humanoid and humanoid.Health < humanoid.MaxHealth then
							humanoid.Health = humanoid.MaxHealth
						end
					end
				end)
				funcs.showNotification(t("auto_heal"), t("notification_auto_heal_on"), 3)
			else
				if autoHealConnection then
					autoHealConnection:Disconnect()
					autoHealConnection = nil
				end
				funcs.showNotification(t("auto_heal"), t("notification_auto_heal_off"), 3)
			end
		end

		local noDamageActive = false
		funcs.noDamage = function(state)
			noDamageActive = state
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					if state then
						humanoid:TakeDamage(0)
						funcs.showNotification(t("no_damage"), t("notification_no_damage_on"), 3)
					else
						funcs.showNotification(t("no_damage"), t("notification_no_damage_off"), 3)
					end
				end
			end
		end

		funcs.flyBoost = function()
			if flying then
				settings.FlySpeed = settings.FlySpeed * 2
				task.delay(10, function()
					settings.FlySpeed = settings.FlySpeed / 2
				end)
			end
			funcs.showNotification(t("fly_boost"), t("notification_fly_boost"), 3)
		end

		local espItems = {}
		funcs.espItemsFunc = function(state)
			if state then
				for _, item in ipairs(Workspace:GetDescendants()) do
					if item:IsA("Tool") then
						local highlight = Instance.new("Highlight")
						highlight.Parent = item
						espItems[item] = highlight
					end
				end
				funcs.showNotification(t("esp_items"), t("notification_esp_items_on"), 3)
			else
				for _, highlight in pairs(espItems) do
					highlight:Destroy()
				end
				espItems = {}
				funcs.showNotification(t("esp_items"), t("notification_esp_items_off"), 3)
			end
		end

		local chatSpamActive = false
		local chatSpamConnection = nil
		funcs.chatSpam = function(state)
			chatSpamActive = state
			if state then
				chatSpamConnection = RunService.Heartbeat:Connect(function()
					if TextChatService then
						local channel = TextChatService:FindFirstChild("TextChannels").RBXGeneral
						if channel then
							channel:SendAsync("Spam message")
						end
					end
					task.wait(1)
				end)
				funcs.showNotification(t("chat_spam"), t("notification_chat_spam_on"), 3)
			else
				if chatSpamConnection then
					chatSpamConnection:Disconnect()
					chatSpamConnection = nil
				end
				funcs.showNotification(t("chat_spam"), t("notification_chat_spam_off"), 3)
			end
		end

		funcs.characterSize = function()
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					local scale = math.random(5, 20) / 10
					humanoid.BodyDepthScale.Value = scale
					humanoid.BodyHeightScale.Value = scale
					humanoid.BodyWidthScale.Value = scale
					humanoid.HeadScale.Value = scale
				end
			end
			funcs.showNotification(t("character_size"), t("notification_character_size"), 3)
		end

		funcs.teleportSelected = function()
			local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if playerRoot then
				for plr, _ in pairs(selectedPlayers) do
					if plr and plr.Parent and plr.Character then
						local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
						if rootPart then
							rootPart.CFrame = playerRoot.CFrame
						end
					end
				end
			end
			funcs.showNotification(t("teleport_selected"), t("notification_teleport_selected"), 3)
		end

		-- Many new functions as requested
		funcs.teleportAllToMe = function()
			local playerRoot = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if playerRoot then
				for _, plr in ipairs(Players:GetPlayers()) do
					if plr ~= player and plr.Character then
						local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
						if rootPart then
							rootPart.CFrame = playerRoot.CFrame * CFrame.new(math.random(-5, 5), 0, math.random(-5, 5))
						end
					end
				end
			end
			funcs.showNotification(t("teleport_all_to_me"), t("notification_teleport_all_to_me"), 3)
		end

		funcs.massResurrect = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid and humanoid.Health <= 0 then
						plr:LoadCharacter()
					end
				end
			end
			funcs.showNotification(t("mass_resurrect"), t("notification_mass_resurrect"), 3)
		end

		funcs.invisibleAll = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					for _, part in ipairs(plr.Character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.Transparency = 1
						end
					end
				end
			end
			funcs.showNotification(t("invisible_all"), t("notification_invisible_all"), 3)
		end

		funcs.visibleAll = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					for _, part in ipairs(plr.Character:GetDescendants()) do
						if part:IsA("BasePart") then
							part.Transparency = 0
						end
					end
				end
			end
			funcs.showNotification(t("visible_all"), t("notification_visible_all"), 3)
		end

		funcs.speedAllX2 = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.WalkSpeed = humanoid.WalkSpeed * 2
					end
				end
			end
			funcs.showNotification(t("speed_all_x2"), t("notification_speed_all_x2"), 3)
		end

		funcs.gravityInvert = function()
			Workspace.Gravity = -Workspace.Gravity
			funcs.showNotification(t("gravity_invert"), t("notification_gravity_invert"), 3)
		end

		funcs.rainbowAllChars = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local connection = RunService.Heartbeat:Connect(function()
						for _, part in ipairs(plr.Character:GetDescendants()) do
							if part:IsA("BasePart") then
								part.Color = Color3.fromHSV(tick() % 1, 1, 1)
							end
						end
					end)
					rainbowConnections[plr] = connection
				end
			end
			funcs.showNotification(t("rainbow_all_chars"), t("notification_rainbow_all_chars"), 3)
		end

		funcs.spawnMonsters = function()
			for i = 1, 10 do
				local monster = Instance.new("Part")
				monster.Size = Vector3.new(2, 4, 2)
				monster.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 0, math.random(-50, 50))
				monster.Color = Color3.new(1, 0, 0)
				monster.Parent = Workspace
			end
			funcs.showNotification(t("spawn_monsters"), t("notification_spawn_monsters"), 3)
		end

		funcs.removeAllTools = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Backpack then
					plr.Backpack:ClearAllChildren()
				end
				if plr.Character then
					for _, tool in ipairs(plr.Character:GetChildren()) do
						if tool:IsA("Tool") then
							tool:Destroy()
						end
					end
				end
			end
			funcs.showNotification(t("remove_all_tools"), t("notification_remove_all_tools"), 3)
		end

		funcs.giveAllTools = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				local tool = Instance.new("Tool")
				tool.Name = "Admin Tool"
				tool.Parent = plr.Backpack
			end
			funcs.showNotification(t("give_all_tools"), t("notification_give_all_tools"), 3)
		end

		funcs.floodMap = function()
			local water = Instance.new("Part")
			water.Size = Vector3.new(1000, 10, 1000)
			water.Position = Vector3.new(0, 5, 0)
			water.Transparency = 0.5
			water.Color = Color3.new(0, 0, 1)
			water.Anchored = true
			water.Parent = Workspace
			funcs.showNotification(t("flood_map"), t("notification_flood_map"), 3)
		end

		funcs.earthquake = function()
			local connection = RunService.Heartbeat:Connect(function(dt)
				for _, part in ipairs(Workspace:GetDescendants()) do
					if part:IsA("BasePart") and not part.Anchored then
						part.Position = part.Position + Vector3.new(math.random(-1,1), 0, math.random(-1,1))
					end
				end
			end)
			funcs.shakeCamera(0.5, 10)
			task.delay(10, function()
				connection:Disconnect()
			end)
			funcs.showNotification(t("earthquake"), t("notification_earthquake"), 3)
		end

		funcs.fireAll = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local fire = Instance.new("Fire")
					fire.Parent = plr.Character.HumanoidRootPart
				end
			end
			funcs.showNotification(t("fire_all"), t("notification_fire_all"), 3)
		end

		funcs.electrifyAll = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local sparkles = Instance.new("Sparkles")
					sparkles.Parent = plr.Character.HumanoidRootPart
				end
			end
			funcs.showNotification(t("electrify_all"), t("notification_electrify_all"), 3)
		end

		funcs.teleportToSpawnAll = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(0, 100, 0)
				end
			end
			funcs.showNotification(t("teleport_to_spawn_all"), t("notification_teleport_to_spawn_all"), 3)
		end

		funcs.lockAllDoors = function()
			-- Game dependent
			funcs.showNotification(t("lock_all_doors"), t("notification_lock_all_doors"), 3)
		end

		funcs.unlockAllDoors = function()
			-- Game dependent
			funcs.showNotification(t("unlock_all_doors"), t("notification_unlock_all_doors"), 3)
		end

		funcs.spawnVehicle = function()
			-- Game dependent
			funcs.showNotification(t("spawn_vehicle"), t("notification_spawn_vehicle"), 3)
		end

		funcs.destroyMap = function()
			for _, part in ipairs(Workspace:GetDescendants()) do
				if part:IsA("BasePart") and math.random(1, 10) > 5 then
					part:Destroy()
				end
			end
			funcs.showNotification(t("destroy_map"), t("notification_destroy_map"), 3)
		end

		funcs.healSelf = function()
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.Health = humanoid.MaxHealth
				end
			end
			funcs.showNotification(t("heal_self"), t("notification_heal_self"), 3)
		end

		funcs.killSelf = function()
			if player.Character then
				local humanoid = player.Character:FindFirstChild("Humanoid")
				if humanoid then
					humanoid.Health = 0
				end
			end
			funcs.showNotification(t("kill_self"), t("notification_kill_self"), 3)
		end

		funcs.respawnSelf = function()
			player:LoadCharacter()
			funcs.showNotification(t("respawn_self"), t("notification_respawn_self"), 3)
		end

		funcs.changeWeatherRain = function()
			-- Simulation
			funcs.showNotification(t("change_weather_rain"), t("notification_change_weather_rain"), 3)
		end

		funcs.changeWeatherSnow = function()
			-- Simulation
			funcs.showNotification(t("change_weather_snow"), t("notification_change_weather_snow"), 3)
		end

		funcs.changeWeatherClear = function()
			-- Simulation
			funcs.showNotification(t("change_weather_clear"), t("notification_change_weather_clear"), 3)
		end

		funcs.increaseFog = function()
			Lighting.FogEnd = Lighting.FogEnd - 50
			funcs.showNotification(t("increase_fog"), t("notification_increase_fog"), 3)
		end

		funcs.decreaseFog = function()
			Lighting.FogEnd = Lighting.FogEnd + 50
			funcs.showNotification(t("decrease_fog"), t("notification_decrease_fog"), 3)
		end

		funcs.setTimeDawn = function()
			Lighting.ClockTime = 6
			funcs.showNotification(t("set_time_dawn"), t("notification_set_time_dawn"), 3)
		end

		funcs.setTimeDusk = function()
			Lighting.ClockTime = 18
			funcs.showNotification(t("set_time_dusk"), t("notification_set_time_dusk"), 3)
		end

		funcs.enableFlightAll = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid:ChangeState(Enum.HumanoidStateType.Flying)
					end
				end
			end
			funcs.showNotification(t("enable_flight_all"), t("notification_enable_flight_all"), 3)
		end

		funcs.disableFlightAll = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
					end
				end
			end
			funcs.showNotification(t("disable_flight_all"), t("notification_disable_flight_all"), 3)
		end

		funcs.makeAllJumpHigh = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.JumpPower = 100
					end
				end
			end
			funcs.showNotification(t("make_all_jump_high"), t("notification_make_all_jump_high"), 3)
		end

		funcs.makeAllJumpLow = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.JumpPower = 10
					end
				end
			end
			funcs.showNotification(t("make_all_jump_low"), t("notification_make_all_jump_low"), 3)
		end

		funcs.spawnPowerup = function()
			-- Simulation
			funcs.showNotification(t("spawn_powerup"), t("notification_spawn_powerup"), 3)
		end

		funcs.removePowerups = function()
			-- Simulation
			funcs.showNotification(t("remove_powerups"), t("notification_remove_powerups"), 3)
		end

		funcs.changeSizeAll = function()
			local scale = math.random(5, 20) / 10
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.BodyDepthScale.Value = scale
						humanoid.BodyHeightScale.Value = scale
						humanoid.BodyWidthScale.Value = scale
						humanoid.HeadScale.Value = scale
					end
				end
			end
			funcs.showNotification(t("change_size_all"), t("notification_change_size_all"), 3)
		end

		funcs.resetSizeAll = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.BodyDepthScale.Value = 1
						humanoid.BodyHeightScale.Value = 1
						humanoid.BodyWidthScale.Value = 1
						humanoid.HeadScale.Value = 1
					end
				end
			end
			funcs.showNotification(t("reset_size_all"), t("notification_reset_size_all"), 3)
		end

		funcs.createForcefield = function()
			if player.Character then
				local forcefield = Instance.new("ForceField")
				forcefield.Parent = player.Character
			end
			funcs.showNotification(t("create_forcefield"), t("notification_create_forcefield"), 3)
		end

		funcs.removeForcefield = function()
			if player.Character then
				for _, ff in ipairs(player.Character:GetChildren()) do
					if ff:IsA("ForceField") then
						ff:Destroy()
					end
				end
			end
			funcs.showNotification(t("remove_forcefield"), t("notification_remove_forcefield"), 3)
		end

		local waypoints = {}
		funcs.teleportToWaypoint = function()
			if #waypoints > 0 then
				funcs.teleportToPosition(waypoints[1])
			end
			funcs.showNotification(t("teleport_to_waypoint"), t("notification_teleport_to_waypoint"), 3)
		end

		funcs.setWaypoint = function()
			if player.Character then
				table.insert(waypoints, player.Character.HumanoidRootPart.CFrame)
			end
			funcs.showNotification(t("set_waypoint"), t("notification_set_waypoint"), 3)
		end

		funcs.clearWaypoints = function()
			waypoints = {}
			funcs.showNotification(t("clear_waypoints"), t("notification_clear_waypoints"), 3)
		end

		-- FE Effects (many as requested)
		funcs.feFireAura = function(state)
			if state then
				if player.Character then
					local fire = Instance.new("Fire")
					fire.Parent = player.Character.HumanoidRootPart
				end
				funcs.showNotification(t("fe_fire_aura"), t("notification_fe_fire_aura"), 3)
			end
		end

		funcs.feLightningStrike = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr.Character then
					local lightning = Instance.new("Part")
					lightning.Size = Vector3.new(1, 10, 1)
					lightning.Position = plr.Character.HumanoidRootPart.Position + Vector3.new(0, 20, 0)
					lightning.Color = Color3.new(1, 1, 0)
					lightning.Transparency = 0.5
					lightning.Parent = Workspace
					Debris:AddItem(lightning, 1)
					funcs.createExplosion(plr.Character.HumanoidRootPart.Position, 5)
				end
			end
			funcs.showNotification(t("fe_lightning_strike"), t("notification_fe_lightning_strike"), 3)
		end

		funcs.feExplosionWave = function()
			if player.Character then
				for i = 1, 5 do
					funcs.createExplosion(player.Character.HumanoidRootPart.Position + Vector3.new(0, 0, i*10), 10)
				end
			end
			funcs.showNotification(t("fe_explosion_wave"), t("notification_fe_explosion_wave"), 3)
		end

		local feInvisibilityCloakActive = false
		funcs.feInvisibilityCloak = function(state)
			feInvisibilityCloakActive = state
			funcs.invisibleSelf(state)
			funcs.showNotification(t("fe_invisibility_cloak"), state and t("notification_fe_invisibility_cloak_on") or t("notification_fe_invisibility_cloak_off"), 3)
		end

		funcs.feTimeWarp = function()
			-- Simulation: change time scale
			Lighting.ClockTime = Lighting.ClockTime + 6
			funcs.showNotification(t("fe_time_warp"), t("notification_fe_time_warp"), 3)
		end

		funcs.fePortal = function()
			-- Simulation: create portal
			local portal = Instance.new("Part")
			portal.Size = Vector3.new(10, 10, 1)
			portal.Position = player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 10
			portal.Color = Color3.new(0, 0, 1)
			portal.Transparency = 0.5
			portal.Anchored = true
			portal.Parent = Workspace
			Debris:AddItem(portal, 30)
			funcs.showNotification(t("fe_portal"), t("notification_fe_portal"), 3)
		end

		funcs.feEnergyBlast = function()
			if player.Character then
				local blast = Instance.new("Part")
				blast.Size = Vector3.new(2, 2, 2)
				blast.Position = player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 5
				blast.Color = Color3.new(0, 1, 0)
				blast.Parent = Workspace
				local bv = Instance.new("BodyVelocity")
				bv.Velocity = player.Character.HumanoidRootPart.CFrame.LookVector * 100
				bv.Parent = blast
				Debris:AddItem(blast, 5)
			end
			funcs.showNotification(t("fe_energy_blast"), t("notification_fe_energy_blast"), 3)
		end

		funcs.feGravityField = function()
			local field = Instance.new("Part")
			field.Size = Vector3.new(20, 20, 20)
			field.Position = player.Character.HumanoidRootPart.Position
			field.Transparency = 0.8
			field.Anchored = true
			field.Parent = Workspace
			Debris:AddItem(field, 10)
			local connection = RunService.Heartbeat:Connect(function()
				for _, obj in ipairs(Workspace:GetChildren()) do
					if obj:IsA("BasePart") and not obj.Anchored and (obj.Position - field.Position).Magnitude < 20 then
						obj.Velocity = Vector3.new(0, -50, 0)
					end
				end
			end)
			task.delay(10, function()
				connection:Disconnect()
			end)
			funcs.showNotification(t("fe_gravity_field"), t("notification_fe_gravity_field"), 3)
		end

		funcs.feShadowClone = function()
			for i = 1, 5 do
				funcs.duplicateSelf()
			end
			funcs.showNotification(t("fe_shadow_clone"), t("notification_fe_shadow_clone"), 3)
		end

		funcs.feMeteorShower = function()
			for i = 1, 10 do
				local meteor = Instance.new("Part")
				meteor.Size = Vector3.new(5, 5, 5)
				meteor.Position = player.Character.HumanoidRootPart.Position + Vector3.new(math.random(-50, 50), 100, math.random(-50, 50))
				meteor.Color = Color3.new(1, 0.5, 0)
				meteor.Parent = Workspace
				local bv = Instance.new("BodyVelocity")
				bv.Velocity = Vector3.new(0, -100, 0)
				bv.Parent = meteor
				Debris:AddItem(meteor, 5)
			end
			funcs.showNotification(t("fe_meteor_shower"), t("notification_fe_meteor_shower"), 3)
		end

		funcs.feWindGust = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
					if rootPart then
						rootPart.Velocity = Vector3.new(math.random(-100, 100), 50, math.random(-100, 100))
					end
				end
			end
			funcs.showNotification(t("fe_wind_gust"), t("notification_fe_wind_gust"), 3)
		end

		funcs.feEarthSpike = function()
			for _, plr in pairs(selectedPlayers) do
				if plr.Character then
					local spike = Instance.new("Part")
					spike.Size = Vector3.new(2, 10, 2)
					spike.Position = plr.Character.HumanoidRootPart.Position - Vector3.new(0, 5, 0)
					spike.Color = Color3.new(0.5, 0.25, 0)
					spike.Anchored = true
					spike.Parent = Workspace
					TweenService:Create(spike, TweenInfo.new(0.5), {Position = spike.Position + Vector3.new(0, 10, 0)}):Play()
					Debris:AddItem(spike, 2)
				end
			end
			funcs.showNotification(t("fe_earth_spike"), t("notification_fe_earth_spike"), 3)
		end

		funcs.feWaterWave = function()
			local wave = Instance.new("Part")
			wave.Size = Vector3.new(20, 5, 20)
			wave.Position = player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 10
			wave.Color = Color3.new(0, 0, 1)
			wave.Transparency = 0.5
			wave.Anchored = false
			wave.Parent = Workspace
			local bv = Instance.new("BodyVelocity")
			bv.Velocity = player.Character.HumanoidRootPart.CFrame.LookVector * 50
			bv.Parent = wave
			Debris:AddItem(wave, 10)
			funcs.showNotification(t("fe_water_wave"), t("notification_fe_water_wave"), 3)
		end

		funcs.fePoisonCloud = function()
			local cloud = Instance.new("Part")
			cloud.Size = Vector3.new(20, 20, 20)
			cloud.Position = player.Character.HumanoidRootPart.Position
			cloud.Color = Color3.new(0, 1, 0)
			cloud.Transparency = 0.7
			cloud.Anchored = true
			cloud.Parent = Workspace
			local connection = RunService.Heartbeat:Connect(function()
				for _, plr in ipairs(Players:GetPlayers()) do
					if plr.Character and (plr.Character.HumanoidRootPart.Position - cloud.Position).Magnitude < 10 then
						local humanoid = plr.Character:FindFirstChild("Humanoid")
						if humanoid then
							humanoid:TakeDamage(1)
						end
					end
				end
			end)
			task.delay(15, function()
				connection:Disconnect()
				cloud:Destroy()
			end)
			funcs.showNotification(t("fe_poison_cloud"), t("notification_fe_poison_cloud"), 3)
		end

		funcs.feHealingAura = function()
			local aura = Instance.new("Part")
			aura.Size = Vector3.new(20, 20, 20)
			aura.Position = player.Character.HumanoidRootPart.Position
			aura.Color = Color3.new(0, 1, 0)
			aura.Transparency = 0.8
			aura.Anchored = true
			aura.Parent = Workspace
			local connection = RunService.Heartbeat:Connect(function()
				for _, plr in ipairs(Players:GetPlayers()) do
					if plr.Character and (plr.Character.HumanoidRootPart.Position - aura.Position).Magnitude < 10 then
						local humanoid = plr.Character:FindFirstChild("Humanoid")
						if humanoid and humanoid.Health < humanoid.MaxHealth then
							humanoid.Health = humanoid.Health + 1
						end
					end
				end
			end)
			task.delay(15, function()
				connection:Disconnect()
				aura:Destroy()
			end)
			funcs.showNotification(t("fe_healing_aura"), t("notification_fe_healing_aura"), 3)
		end

		funcs.feSpeedTrail = function()
			local trail = Instance.new("Trail")
			trail.Attachment0 = Instance.new("Attachment", player.Character.HumanoidRootPart)
			trail.Attachment1 = Instance.new("Attachment", player.Character.HumanoidRootPart)
			trail.Parent = player.Character
			funcs.showNotification(t("fe_speed_trail"), t("notification_fe_speed_trail"), 3)
		end

		funcs.feFireball = function()
			local fireball = Instance.new("Part")
			fireball.Size = Vector3.new(3, 3, 3)
			fireball.Position = player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 5
			fireball.Color = Color3.new(1, 0, 0)
			fireball.Parent = Workspace
			local bv = Instance.new("BodyVelocity")
			bv.Velocity = player.Character.HumanoidRootPart.CFrame.LookVector * 100
			bv.Parent = fireball
			fireball.Touched:Connect(function(hit)
				if hit.Parent:FindFirstChild("Humanoid") then
					hit.Parent.Humanoid:TakeDamage(50)
				end
				funcs.createExplosion(fireball.Position, 5)
				fireball:Destroy()
			end)
			Debris:AddItem(fireball, 5)
			funcs.showNotification(t("fe_fireball"), t("notification_fe_fireball"), 3)
		end

		funcs.feIceFreeze = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr.Character then
					local ice = Instance.new("Part")
					ice.Size = Vector3.new(5, 5, 5)
					ice.Position = plr.Character.HumanoidRootPart.Position
					ice.Color = Color3.new(0, 1, 1)
					ice.Transparency = 0.5
					ice.Anchored = true
					ice.Parent = Workspace
					plr.Character.Humanoid.WalkSpeed = 0
					task.delay(5, function()
						ice:Destroy()
						plr.Character.Humanoid.WalkSpeed = 16
					end)
				end
			end
			funcs.showNotification(t("fe_ice_freeze"), t("notification_fe_ice_freeze"), 3)
		end

		funcs.feTelekinesis = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr.Character then
					local rootPart = plr.Character.HumanoidRootPart
					rootPart.Anchored = true
					task.delay(5, function()
						rootPart.Anchored = false
					end)
				end
			end
			funcs.showNotification(t("fe_telekinesis"), t("notification_fe_telekinesis"), 3)
		end

		funcs.feSummonMinion = function()
			local minion = player.Character:Clone()
			minion.Parent = Workspace
			minion.HumanoidRootPart.Position = player.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 0)
			funcs.showNotification(t("fe_summon_minion"), t("notification_fe_summon_minion"), 3)
		end

		funcs.feDarknessShroud = function()
			Lighting.Brightness = 0
			task.delay(10, function()
				Lighting.Brightness = 1
			end)
			funcs.showNotification(t("fe_darkness_shroud"), t("notification_fe_darkness_shroud"), 3)
		end

		funcs.feLightBeam = function()
			local beam = Instance.new("Part")
			beam.Size = Vector3.new(1, 1, 50)
			beam.Position = player.Character.HumanoidRootPart.Position + player.Character.HumanoidRootPart.CFrame.LookVector * 25
			beam.Orientation = player.Character.HumanoidRootPart.CFrame.LookVector * Vector3.new(0, 0, 1)
			beam.Color = Color3.new(1, 1, 0)
			beam.Transparency = 0.5
			beam.Parent = Workspace
			Debris:AddItem(beam, 2)
			funcs.showNotification(t("fe_light_beam"), t("notification_fe_light_beam"), 3)
		end

		funcs.feVortex = function()
			local vortex = Instance.new("Part")
			vortex.Size = Vector3.new(10, 10, 10)
			vortex.Position = player.Character.HumanoidRootPart.Position
			vortex.Color = Color3.new(0.5, 0, 0.5)
			vortex.Transparency = 0.5
			vortex.Anchored = true
			vortex.Parent = Workspace
			local connection = RunService.Heartbeat:Connect(function()
				for _, obj in ipairs(Workspace:GetChildren()) do
					if obj:IsA("BasePart") and not obj.Anchored and (obj.Position - vortex.Position).Magnitude < 20 then
						obj.Velocity = (vortex.Position - obj.Position).Unit * 50
					end
				end
			end)
			task.delay(10, function()
				connection:Disconnect()
				vortex:Destroy()
			end)
			funcs.showNotification(t("fe_vortex"), t("notification_fe_vortex"), 3)
		end

		funcs.feExplodingClone = function()
			local clone = player.Character:Clone()
			clone.Parent = Workspace
			clone.HumanoidRootPart.Position = player.Character.HumanoidRootPart.Position + Vector3.new(5, 0, 0)
			task.delay(5, function()
				funcs.createExplosion(clone.HumanoidRootPart.Position, 20)
				clone:Destroy()
			end)
			funcs.showNotification(t("fe_exploding_clone"), t("notification_fe_exploding_clone"), 3)
		end

		funcs.feRainbowTrail = function()
			local trail = Instance.new("Trail")
			trail.Color = ColorSequence.new(Color3.fromHSV(tick() % 1, 1, 1), Color3.fromHSV(tick() % 1, 1, 1))
			trail.Attachment0 = Instance.new("Attachment", player.Character.HumanoidRootPart)
			trail.Attachment1 = Instance.new("Attachment", player.Character.HumanoidRootPart)
			trail.Parent = player.Character
			funcs.showNotification(t("fe_rainbow_trail"), t("notification_fe_rainbow_trail"), 3)
		end

		funcs.feLevitation = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr.Character then
					local rootPart = plr.Character.HumanoidRootPart
					rootPart.Velocity = Vector3.new(0, 50, 0)
				end
			end
			funcs.showNotification(t("fe_levitation"), t("notification_fe_levitation"), 3)
		end

		funcs.feShrinkRay = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.BodyDepthScale.Value = 0.5
						humanoid.BodyHeightScale.Value = 0.5
						humanoid.BodyWidthScale.Value = 0.5
						humanoid.HeadScale.Value = 0.5
					end
				end
			end
			funcs.showNotification(t("fe_shrink_ray"), t("notification_fe_shrink_ray"), 3)
		end

		funcs.feGrowRay = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.BodyDepthScale.Value = 2
						humanoid.BodyHeightScale.Value = 2
						humanoid.BodyWidthScale.Value = 2
						humanoid.HeadScale.Value = 2
					end
				end
			end
			funcs.showNotification(t("fe_grow_ray"), t("notification_fe_grow_ray"), 3)
		end

		funcs.feConfuse = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.WalkSpeed = -humanoid.WalkSpeed
						task.delay(5, function()
							humanoid.WalkSpeed = -humanoid.WalkSpeed
						end)
					end
				end
			end
			funcs.showNotification(t("fe_confuse"), t("notification_fe_confuse"), 3)
		end

		funcs.feBlind = function()
			for plr, _ in pairs(selectedPlayers) do
				if plr.PlayerGui then
					local blind = Instance.new("ScreenGui")
					local frame = Instance.new("Frame")
					frame.Size = UDim2.new(1, 0, 1, 0)
					frame.BackgroundColor3 = Color3.new(0, 0, 0)
					frame.Parent = blind
					blind.Parent = plr.PlayerGui
					task.delay(5, function()
						blind:Destroy()
					end)
				end
			end
			funcs.showNotification(t("fe_blind"), t("notification_fe_blind"), 3)
		end

		funcs.feMute = function()
			for plr, _ in pairs(selectedPlayers) do
				-- Simulation, can't really mute
			end
			funcs.showNotification(t("fe_mute"), t("notification_fe_mute"), 3)
		end

		funcs.feUnmute = function()
			-- Simulation
			funcs.showNotification(t("fe_unmute"), t("notification_fe_unmute"), 3)
		end

		funcs.feSlowMotion = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.WalkSpeed = humanoid.WalkSpeed / 2
					end
				end
			end
			task.delay(10, function()
				for _, plr in ipairs(Players:GetPlayers()) do
					if plr.Character then
						local humanoid = plr.Character:FindFirstChild("Humanoid")
						if humanoid then
							humanoid.WalkSpeed = humanoid.WalkSpeed * 2
						end
					end
				end
			end)
			funcs.showNotification(t("fe_slow_motion"), t("notification_fe_slow_motion"), 3)
		end

		funcs.feFastForward = function()
			for _, plr in ipairs(Players:GetPlayers()) do
				if plr.Character then
					local humanoid = plr.Character:FindFirstChild("Humanoid")
					if humanoid then
						humanoid.WalkSpeed = humanoid.WalkSpeed * 2
					end
				end
			end
			task.delay(10, function()
				for _, plr in ipairs(Players:GetPlayers()) do
					if plr.Character then
						local humanoid = plr.Character:FindFirstChild("Humanoid")
						if humanoid then
							humanoid.WalkSpeed = humanoid.WalkSpeed / 2
						end
					end
				end
			end)
			funcs.showNotification(t("fe_fast_forward"), t("notification_fe_fast_forward"), 3)
		end

		-- Active states
		local activeStates = {
			Fly = false,
			Noclip = false,
			GodMode = false,
			ESP = false,
			InfiniteJump = false,
			Rainbow = false,
			GhostMode = false,
			AntiAfk = false,
			SuperJump = false,
			InvisibleSelf = false,
			FakeLag = false,
			AutoFarm = false,
			HealthRegen = false,
			NoClipObjects = false,
			PlayerEspNames = false,
			NightVision = false,
			BrightMode = false,
			RainbowSky = false,
			PlayerTracker = false,
			AutoHeal = false,
			NoDamage = false,
			EspItems = false,
			ChatSpam = false,
			SpinPlayer = false,
			InvertControls = false,
			EnableAutoJump = false,
			OrbitPlayer = false,
			FeInvisibilityCloak = false
		}

		-- State button creator
		funcs.createStateButton = function(content, name, func, stateKey, tooltipText)
			local btn, updateState = funcs.createButton(name, 38, true, tooltipText)
			btn.Parent = content

			updateState(activeStates[stateKey])

			btn.MouseButton1Click:Connect(function()
				activeStates[stateKey] = not activeStates[stateKey]
				func(activeStates[stateKey])
				updateState(activeStates[stateKey])
			end)

			return btn
		end

		-- Regular button creator
		funcs.addButton = function(content, name, func, tooltipText)
			local btn = funcs.createButton(name, 38, false, tooltipText)
			btn.Parent = content
			btn.MouseButton1Click:Connect(func)
			return btn
		end

		-- Update UI for language
		funcs.updateUIForLanguage = function()
			titleLabel.Text = t("main_title")
			mainTab.Text = t("tab_main")
			playerTab.Text = t("tab_players")
			visualTab.Text = t("tab_visual")
			funTab.Text = t("tab_fun")
			debugTab.Text = t("tab_debug")
			settingsTab.Text = t("tab_settings")
			serverTab.Text = t("tab_server")
			feEffectsTab.Text = t("tab_fe_effects")
			taskbarButton.Text = "AdminScript 6.0"

			for _, content in pairs({mainContent, playerContent, visualContent, funContent, debugContent, settingsContent, serverContent, feEffectsContent}) do
				content:ClearAllChildren()
			end

			funcs.createButtons()
			funcs.createSettings()
		end

		-- Split button creation to avoid register limit
		funcs.createMainButtons = function()
			funcs.addButton(mainContent, t("refresh_players"), funcs.updatePlayerList, t("tooltip_refresh"))
			funcs.addButton(mainContent, t("kill_selected"), function()
				for plr, _ in pairs(selectedPlayers) do
					if plr.Character then
						plr.Character.Humanoid.Health = 0
					end
				end
				funcs.showNotification(t("kill_selected"), t("notification_kill_selected"), 3)
			end, t("tooltip_kill_selected"))

			funcs.addButton(mainContent, t("kill_all"), funcs.killAllPlayers, t("tooltip_kill_all"))

			funcs.addButton(mainContent, t("teleport_to_player"), function()
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
						funcs.showNotification(t("teleport_to_player"), t("notification_teleport_to_player") .. target.Name, 3)
					end
				end
			end, t("tooltip_teleport_to_player"))

			funcs.addButton(mainContent, t("heal_selected"), function()
				for plr, _ in pairs(selectedPlayers) do
					if plr.Character then
						local humanoid = plr.Character:FindFirstChild("Humanoid")
						if humanoid then
							humanoid.Health = humanoid.MaxHealth
						end
					end
				end
				funcs.showNotification(t("heal_selected"), t("notification_heal_selected"), 3)
			end, t("tooltip_heal_selected"))

			funcs.addButton(mainContent, t("heal_all"), funcs.healAllPlayers, t("tooltip_heal_all"))
			funcs.addButton(mainContent, t("freeze_selected"), funcs.freezeSelectedPlayers, t("tooltip_freeze_selected"))
			funcs.addButton(mainContent, t("freeze_all"), funcs.freezeAllPlayers, t("tooltip_freeze_all"))
			funcs.addButton(mainContent, t("unfreeze_selected"), funcs.unfreezeSelectedPlayers, t("tooltip_unfreeze_selected"))
			funcs.addButton(mainContent, t("unfreeze_all"), funcs.unfreezeAllPlayers, t("tooltip_unfreeze_all"))

			funcs.addButton(mainContent, t("create_explosion"), function()
				if player.Character then
					local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
					if rootPart then
						funcs.createExplosion(rootPart.Position, settings.ExplosionRadius)
					end
				end
			end, t("tooltip_create_explosion"))

			funcs.addButton(mainContent, t("teleport_spawn"), function()
				funcs.teleportToPosition(CFrame.new(0, 100, 0))
			end, t("tooltip_teleport_spawn"))

			funcs.addButton(mainContent, t("freeze_map"), funcs.freezeMap, t("tooltip_freeze_map"))
			funcs.addButton(mainContent, t("unfreeze_map"), funcs.unfreezeMap, t("tooltip_unfreeze_map"))

			funcs.createStateButton(mainContent, t("flying"), function(state)
				if state then funcs.startFlying() else funcs.stopFlying() end
			end, "Fly", t("tooltip_flying"))

			funcs.createStateButton(mainContent, t("noclip"), funcs.noclip, "Noclip", t("tooltip_noclip"))
			funcs.createStateButton(mainContent, t("godmode"), funcs.godMode, "GodMode", t("tooltip_godmode"))
			funcs.createStateButton(mainContent, t("infinite_jump"), funcs.infiniteJump, "InfiniteJump", t("tooltip_infinite_jump"))

			funcs.createStateButton(mainContent, t("ghost_mode"), funcs.ghostMode, "GhostMode", t("tooltip_ghost_mode"))
			funcs.createStateButton(mainContent, t("anti_afk"), funcs.antiAfk, "AntiAfk", t("tooltip_anti_afk"))
			funcs.addButton(mainContent, t("teleport_random_player"), funcs.teleportRandomPlayer, t("tooltip_teleport_random_player"))
			funcs.createStateButton(mainContent, t("super_jump"), funcs.superJump, "SuperJump", t("tooltip_super_jump"))
			funcs.createStateButton(mainContent, t("invisible_self"), funcs.invisibleSelf, "InvisibleSelf", t("tooltip_invisible_self"))
			funcs.addButton(mainContent, t("change_team"), funcs.changeTeam, t("tooltip_change_team"))
			funcs.addButton(mainContent, t("give_weapon"), funcs.giveWeapon, t("tooltip_give_weapon"))
			funcs.createStateButton(mainContent, t("fake_lag"), funcs.fakeLag, "FakeLag", t("tooltip_fake_lag"))
			funcs.createStateButton(mainContent, t("auto_farm"), funcs.autoFarm, "AutoFarm", t("tooltip_auto_farm"))
			funcs.addButton(mainContent, t("speed_boost"), funcs.speedBoost, t("tooltip_speed_boost"))
			funcs.createStateButton(mainContent, t("health_regen"), funcs.healthRegen, "HealthRegen", t("tooltip_health_regen"))
			funcs.createStateButton(mainContent, t("no_clip_objects"), funcs.noClipObjects, "NoClipObjects", t("tooltip_no_clip_objects"))
			funcs.createStateButton(mainContent, t("player_esp_names"), funcs.playerEspNames, "PlayerEspNames", t("tooltip_player_esp_names"))
			funcs.createStateButton(mainContent, t("night_vision"), funcs.nightVision, "NightVision", t("tooltip_night_vision"))
			funcs.addButton(mainContent, t("fog_remove"), funcs.fogRemove, t("tooltip_fog_remove"))
			funcs.createStateButton(mainContent, t("bright_mode"), funcs.brightMode, "BrightMode", t("tooltip_bright_mode"))
			funcs.createStateButton(mainContent, t("rainbow_sky"), funcs.rainbowSky, "RainbowSky", t("tooltip_rainbow_sky"))
			funcs.addButton(mainContent, t("spawn_item"), funcs.spawnItem, t("tooltip_spawn_item"))
			funcs.addButton(mainContent, t("duplicate_self"), funcs.duplicateSelf, t("tooltip_duplicate_self"))
			funcs.addButton(mainContent, t("teleport_home"), funcs.teleportHome, t("tooltip_teleport_home"))
			funcs.addButton(mainContent, t("increase_jump"), funcs.increaseJump, t("tooltip_increase_jump"))
			funcs.addButton(mainContent, t("decrease_gravity"), funcs.decreaseGravity, t("tooltip_decrease_gravity"))
			funcs.createStateButton(mainContent, t("player_tracker"), funcs.playerTracker, "PlayerTracker", t("tooltip_player_tracker"))
			funcs.createStateButton(mainContent, t("auto_heal"), funcs.autoHeal, "AutoHeal", t("tooltip_auto_heal"))
			funcs.createStateButton(mainContent, t("no_damage"), funcs.noDamage, "NoDamage", t("tooltip_no_damage"))
			funcs.addButton(mainContent, t("fly_boost"), funcs.flyBoost, t("tooltip_fly_boost"))
			funcs.createStateButton(mainContent, t("esp_items"), funcs.espItemsFunc, "EspItems", t("tooltip_esp_items"))
			funcs.createStateButton(mainContent, t("chat_spam"), funcs.chatSpam, "ChatSpam", t("tooltip_chat_spam"))
			funcs.addButton(mainContent, t("character_size"), funcs.characterSize, t("tooltip_character_size"))
			funcs.addButton(mainContent, t("teleport_selected"), funcs.teleportSelected, t("tooltip_teleport_selected"))
			funcs.addButton(mainContent, t("teleport_all_to_me"), funcs.teleportAllToMe, t("tooltip_teleport_all_to_me"))
			funcs.addButton(mainContent, t("mass_resurrect"), funcs.massResurrect, t("tooltip_mass_resurrect"))
			funcs.addButton(mainContent, t("invisible_all"), funcs.invisibleAll, t("tooltip_invisible_all"))
			funcs.addButton(mainContent, t("visible_all"), funcs.visibleAll, t("tooltip_visible_all"))
			funcs.addButton(mainContent, t("speed_all_x2"), funcs.speedAllX2, t("tooltip_speed_all_x2"))
			funcs.addButton(mainContent, t("gravity_invert"), funcs.gravityInvert, t("tooltip_gravity_invert"))
			funcs.addButton(mainContent, t("rainbow_all_chars"), funcs.rainbowAllChars, t("tooltip_rainbow_all_chars"))
			funcs.addButton(mainContent, t("spawn_monsters"), funcs.spawnMonsters, t("tooltip_spawn_monsters"))
			funcs.addButton(mainContent, t("remove_all_tools"), funcs.removeAllTools, t("tooltip_remove_all_tools"))
			funcs.addButton(mainContent, t("give_all_tools"), funcs.giveAllTools, t("tooltip_give_all_tools"))
			funcs.addButton(mainContent, t("flood_map"), funcs.floodMap, t("tooltip_flood_map"))
			funcs.addButton(mainContent, t("earthquake"), funcs.earthquake, t("tooltip_earthquake"))
			funcs.addButton(mainContent, t("fire_all"), funcs.fireAll, t("tooltip_fire_all"))
			funcs.addButton(mainContent, t("electrify_all"), funcs.electrifyAll, t("tooltip_electrify_all"))
			funcs.addButton(mainContent, t("teleport_to_spawn_all"), funcs.teleportToSpawnAll, t("tooltip_teleport_to_spawn_all"))
			funcs.addButton(mainContent, t("lock_all_doors"), funcs.lockAllDoors, t("tooltip_lock_all_doors"))
			funcs.addButton(mainContent, t("unlock_all_doors"), funcs.unlockAllDoors, t("tooltip_unlock_all_doors"))
			funcs.addButton(mainContent, t("spawn_vehicle"), funcs.spawnVehicle, t("tooltip_spawn_vehicle"))
			funcs.addButton(mainContent, t("destroy_map"), funcs.destroyMap, t("tooltip_destroy_map"))
			funcs.addButton(mainContent, t("heal_self"), funcs.healSelf, t("tooltip_heal_self"))
			funcs.addButton(mainContent, t("kill_self"), funcs.killSelf, t("tooltip_kill_self"))
			funcs.addButton(mainContent, t("respawn_self"), funcs.respawnSelf, t("tooltip_respawn_self"))
			funcs.addButton(mainContent, t("change_weather_rain"), funcs.changeWeatherRain, t("tooltip_change_weather_rain"))
			funcs.addButton(mainContent, t("change_weather_snow"), funcs.changeWeatherSnow, t("tooltip_change_weather_snow"))
			funcs.addButton(mainContent, t("change_weather_clear"), funcs.changeWeatherClear, t("tooltip_change_weather_clear"))
			funcs.addButton(mainContent, t("increase_fog"), funcs.increaseFog, t("tooltip_increase_fog"))
			funcs.addButton(mainContent, t("decrease_fog"), funcs.decreaseFog, t("tooltip_decrease_fog"))
			funcs.addButton(mainContent, t("set_time_dawn"), funcs.setTimeDawn, t("tooltip_set_time_dawn"))
			funcs.addButton(mainContent, t("set_time_dusk"), funcs.setTimeDusk, t("tooltip_set_time_dusk"))
			funcs.addButton(mainContent, t("enable_flight_all"), funcs.enableFlightAll, t("tooltip_enable_flight_all"))
			funcs.addButton(mainContent, t("disable_flight_all"), funcs.disableFlightAll, t("tooltip_disable_flight_all"))
			funcs.addButton(mainContent, t("make_all_jump_high"), funcs.makeAllJumpHigh, t("tooltip_make_all_jump_high"))
			funcs.addButton(mainContent, t("make_all_jump_low"), funcs.makeAllJumpLow, t("tooltip_make_all_jump_low"))
			funcs.addButton(mainContent, t("spawn_powerup"), funcs.spawnPowerup, t("tooltip_spawn_powerup"))
			funcs.addButton(mainContent, t("remove_powerups"), funcs.removePowerups, t("tooltip_remove_powerups"))
			funcs.addButton(mainContent, t("change_size_all"), funcs.changeSizeAll, t("tooltip_change_size_all"))
			funcs.addButton(mainContent, t("reset_size_all"), funcs.resetSizeAll, t("tooltip_reset_size_all"))
			funcs.addButton(mainContent, t("create_forcefield"), funcs.createForcefield, t("tooltip_create_forcefield"))
			funcs.addButton(mainContent, t("remove_forcefield"), funcs.removeForcefield, t("tooltip_remove_forcefield"))
			funcs.addButton(mainContent, t("teleport_to_waypoint"), funcs.teleportToWaypoint, t("tooltip_teleport_to_waypoint"))
			funcs.addButton(mainContent, t("set_waypoint"), funcs.setWaypoint, t("tooltip_set_waypoint"))
			funcs.addButton(mainContent, t("clear_waypoints"), funcs.clearWaypoints, t("tooltip_clear_waypoints"))
		end

		funcs.createVisualButtons = function()
			funcs.addButton(visualContent, t("speed_x2"), function() funcs.speedHack(32) end, t("tooltip_speed_x2"))
			funcs.addButton(visualContent, t("speed_x5"), function() funcs.speedHack(80) end, t("tooltip_speed_x5"))
			funcs.addButton(visualContent, t("speed_x10"), function() funcs.speedHack(160) end, t("tooltip_speed_x10"))
			funcs.addButton(visualContent, t("day"), function() funcs.setTimeOfDay(12) end, t("tooltip_day"))
			funcs.addButton(visualContent, t("night"), function() funcs.setTimeOfDay(0) end, t("tooltip_night"))
			funcs.addButton(visualContent, t("moon_gravity"), function() funcs.changeGravity(10) end, t("tooltip_moon_gravity"))
			funcs.addButton(visualContent, t("zero_gravity"), function() funcs.changeGravity(0) end, t("tooltip_zero_gravity"))
			funcs.createStateButton(visualContent, t("rainbow_char"), funcs.rainbowCharacter, "Rainbow", t("tooltip_rainbow_char"))

			funcs.addButton(visualContent, t("black_hole"), function()
				if player.Character then
					local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
					if rootPart then
						funcs.createBlackHole(rootPart.Position + rootPart.CFrame.LookVector * 10)
					end
				end
			end, t("tooltip_black_hole"))

			funcs.createStateButton(visualContent, t("esp"), function(state)
				if state then funcs.espPlayers() else funcs.removeESP() end
			end, "ESP", t("tooltip_esp"))
		end

		funcs.createFunButtons = function()
			funcs.createStateButton(funContent, t("spin_player"), funcs.spinPlayer, "SpinPlayer", t("tooltip_spin_player"))
			funcs.addButton(funContent, t("launch_player"), funcs.launchPlayer, t("tooltip_launch_player"))
			funcs.createStateButton(funContent, t("invert_controls"), funcs.invertControls, "InvertControls", t("tooltip_invert_controls"))
			funcs.addButton(funContent, t("random_teleport"), funcs.randomTeleport, t("tooltip_random_teleport"))
			funcs.addButton(funContent, t("fake_message"), funcs.fakeMessage, t("tooltip_fake_message"))
			funcs.addButton(funContent, t("change_size"), funcs.changeSize, t("tooltip_change_size"))
			funcs.addButton(funContent, t("invisible_player"), funcs.invisiblePlayer, t("tooltip_invisible_player"))
			funcs.addButton(funContent, t("mirror_mode"), funcs.mirrorMode, t("tooltip_mirror_mode"))
			funcs.addButton(funContent, t("disable_jump"), funcs.disableJump, t("tooltip_disable_jump"))
			funcs.createStateButton(funContent, t("enable_autojump"), funcs.enableAutoJump, "EnableAutoJump", t("tooltip_enable_autojump"))
			funcs.addButton(funContent, t("dance_player"), funcs.dancePlayer, t("tooltip_dance_player"))
			funcs.addButton(funContent, t("sit_player"), funcs.sitPlayer, t("tooltip_sit_player"))
			funcs.addButton(funContent, t("freeze_position"), funcs.freezePosition, t("tooltip_freeze_position"))
			funcs.addButton(funContent, t("unfreeze_player"), funcs.unfreezePlayer, t("tooltip_unfreeze_player"))
			funcs.addButton(funContent, t("clone_player"), funcs.clonePlayer, t("tooltip_clone_player"))
			funcs.addButton(funContent, t("fire_player"), funcs.firePlayer, t("tooltip_fire_player"))
			funcs.addButton(funContent, t("shock_player"), funcs.shockPlayer, t("tooltip_shock_player"))
			funcs.createStateButton(funContent, t("orbit_player"), funcs.orbitPlayer, "OrbitPlayer", t("tooltip_orbit_player"))
		end

		funcs.createServerButtons = function()
			funcs.addButton(serverContent, t("server_shutdown"), funcs.serverShutdown, t("tooltip_server_shutdown"))
			funcs.addButton(serverContent, t("server_restart"), funcs.serverRestart, t("tooltip_server_restart"))
			funcs.addButton(serverContent, t("server_time"), funcs.changeServerTime, t("tooltip_server_time"))
			funcs.addButton(serverContent, t("server_weather"), funcs.changeWeather, t("tooltip_server_weather"))
			funcs.addButton(serverContent, t("server_gravity"), funcs.changeServerGravity, t("tooltip_server_gravity"))
		end

		funcs.createPlayerButtons = function()
			local refreshBtn, _ = funcs.createButton(t("refresh_players"), 38, false, t("tooltip_refresh"))
			refreshBtn.Parent = playerContent
			refreshBtn.MouseButton1Click:Connect(funcs.updatePlayerList)

			funcs.addButton(playerContent, t("kill_selected"), function()
				for plr, _ in pairs(selectedPlayers) do
					if plr.Character then
						plr.Character.Humanoid.Health = 0
					end
				end
				funcs.showNotification(t("kill_selected"), t("notification_kill_selected"), 3)
			end, t("tooltip_kill_selected"))

			funcs.addButton(playerContent, t("heal_selected"), function()
				for plr, _ in pairs(selectedPlayers) do
					if plr.Character then
						local humanoid = plr.Character:FindFirstChild("Humanoid")
						if humanoid then
							humanoid.Health = humanoid.MaxHealth
						end
					end
				end
				funcs.showNotification(t("heal_selected"), t("notification_heal_selected"), 3)
			end, t("tooltip_heal_selected"))

			funcs.addButton(playerContent, t("freeze_selected"), funcs.freezeSelectedPlayers, t("tooltip_freeze_selected"))
			funcs.addButton(playerContent, t("unfreeze_selected"), funcs.unfreezeSelectedPlayers, t("tooltip_unfreeze_selected"))
		end

		funcs.createFEEffectsButtons = function()
			funcs.addButton(feEffectsContent, t("fe_black_hole"), function()
				if player.Character then
					local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
					if rootPart then
						funcs.createBlackHole(rootPart.Position + rootPart.CFrame.LookVector * 10)
					end
				end
			end, t("tooltip_fe_black_hole"))

			funcs.createStateButton(feEffectsContent, t("fe_fire_aura"), funcs.feFireAura, "FeFireAura", t("tooltip_fe_fire_aura"))
			funcs.addButton(feEffectsContent, t("fe_lightning_strike"), funcs.feLightningStrike, t("tooltip_fe_lightning_strike"))
			funcs.addButton(feEffectsContent, t("fe_explosion_wave"), funcs.feExplosionWave, t("tooltip_fe_explosion_wave"))
			funcs.createStateButton(feEffectsContent, t("fe_invisibility_cloak"), funcs.feInvisibilityCloak, "FeInvisibilityCloak", t("tooltip_fe_invisibility_cloak"))
			funcs.addButton(feEffectsContent, t("fe_time_warp"), funcs.feTimeWarp, t("tooltip_fe_time_warp"))
			funcs.addButton(feEffectsContent, t("fe_portal"), funcs.fePortal, t("tooltip_fe_portal"))
			funcs.addButton(feEffectsContent, t("fe_energy_blast"), funcs.feEnergyBlast, t("tooltip_fe_energy_blast"))
			funcs.addButton(feEffectsContent, t("fe_gravity_field"), funcs.feGravityField, t("tooltip_fe_gravity_field"))
			funcs.addButton(feEffectsContent, t("fe_shadow_clone"), funcs.feShadowClone, t("tooltip_fe_shadow_clone"))
			funcs.addButton(feEffectsContent, t("fe_meteor_shower"), funcs.feMeteorShower, t("tooltip_fe_meteor_shower"))
			funcs.addButton(feEffectsContent, t("fe_wind_gust"), funcs.feWindGust, t("tooltip_fe_wind_gust"))
			funcs.addButton(feEffectsContent, t("fe_earth_spike"), funcs.feEarthSpike, t("tooltip_fe_earth_spike"))
			funcs.addButton(feEffectsContent, t("fe_water_wave"), funcs.feWaterWave, t("tooltip_fe_water_wave"))
			funcs.addButton(feEffectsContent, t("fe_poison_cloud"), funcs.fePoisonCloud, t("tooltip_fe_poison_cloud"))
			funcs.addButton(feEffectsContent, t("fe_healing_aura"), funcs.feHealingAura, t("tooltip_fe_healing_aura"))
			funcs.addButton(feEffectsContent, t("fe_speed_trail"), funcs.feSpeedTrail, t("tooltip_fe_speed_trail"))
			funcs.addButton(feEffectsContent, t("fe_fireball"), funcs.feFireball, t("tooltip_fe_fireball"))
			funcs.addButton(feEffectsContent, t("fe_ice_freeze"), funcs.feIceFreeze, t("tooltip_fe_ice_freeze"))
			funcs.addButton(feEffectsContent, t("fe_telekinesis"), funcs.feTelekinesis, t("tooltip_fe_telekinesis"))
			funcs.addButton(feEffectsContent, t("fe_summon_minion"), funcs.feSummonMinion, t("tooltip_fe_summon_minion"))
			funcs.addButton(feEffectsContent, t("fe_darkness_shroud"), funcs.feDarknessShroud, t("tooltip_fe_darkness_shroud"))
			funcs.addButton(feEffectsContent, t("fe_light_beam"), funcs.feLightBeam, t("tooltip_fe_light_beam"))
			funcs.addButton(feEffectsContent, t("fe_vortex"), funcs.feVortex, t("tooltip_fe_vortex"))
			funcs.addButton(feEffectsContent, t("fe_exploding_clone"), funcs.feExplodingClone, t("tooltip_fe_exploding_clone"))
			funcs.addButton(feEffectsContent, t("fe_rainbow_trail"), funcs.feRainbowTrail, t("tooltip_fe_rainbow_trail"))
			funcs.addButton(feEffectsContent, t("fe_levitation"), funcs.feLevitation, t("tooltip_fe_levitation"))
			funcs.addButton(feEffectsContent, t("fe_shrink_ray"), funcs.feShrinkRay, t("tooltip_fe_shrink_ray"))
			funcs.addButton(feEffectsContent, t("fe_grow_ray"), funcs.feGrowRay, t("tooltip_fe_grow_ray"))
			funcs.addButton(feEffectsContent, t("fe_confuse"), funcs.feConfuse, t("tooltip_fe_confuse"))
			funcs.addButton(feEffectsContent, t("fe_blind"), funcs.feBlind, t("tooltip_fe_blind"))
			funcs.addButton(feEffectsContent, t("fe_mute"), funcs.feMute, t("tooltip_fe_mute"))
			funcs.addButton(feEffectsContent, t("fe_unmute"), funcs.feUnmute, t("tooltip_fe_unmute"))
			funcs.addButton(feEffectsContent, t("fe_slow_motion"), funcs.feSlowMotion, t("tooltip_fe_slow_motion"))
			funcs.addButton(feEffectsContent, t("fe_fast_forward"), funcs.feFastForward, t("tooltip_fe_fast_forward"))
		end

		funcs.createButtons = function()
			funcs.createMainButtons()
			funcs.createVisualButtons()
			funcs.createFunButtons()
			funcs.createServerButtons()
			funcs.createPlayerButtons()
			funcs.createFEEffectsButtons()
		end

		-- Settings creation
		funcs.createSettingFrame = function(text)
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

		funcs.createSettings = function()
			if not settingsContent then return end
			settingsContent:ClearAllChildren()

			local autoOpenSetting = funcs.createSettingFrame(t("auto_open"))
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
				funcs.showNotification(t("settings"), t("notification_auto_open") .. (settings.AutoOpen and t("on") or t("off")), 3)
			end)

			local flySpeedSetting = funcs.createSettingFrame(t("fly_speed") .. ": " .. settings.FlySpeed)
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
					funcs.showNotification(t("settings"), t("notification_fly_speed") .. newSpeed, 3)
				else
					flySpeedInput.Text = tostring(settings.FlySpeed)
				end
			end)

			local explosionRadiusSetting = funcs.createSettingFrame(t("explosion_radius") .. ": " .. settings.ExplosionRadius)
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
					funcs.showNotification(t("settings"), t("notification_explosion_radius") .. newRadius, 3)
				else
					explosionRadiusInput.Text = tostring(settings.ExplosionRadius)
				end
			end)

			local languageSetting = funcs.createSettingFrame(t("language") .. ": " .. settings.Language:upper())
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
				funcs.updateUIForLanguage()
				funcs.showNotification(t("settings"), t("notification_language") .. settings.Language:upper(), 3)
			end)
		end

		-- Open window
		funcs.openWindow = function()
			if mainFrame.Visible then return end

			taskbarButton.Visible = false
			mainFrame.Visible = true

			funcs.updatePlayerList()
			funcs.initDebugPanel()
			funcs.createButtons()
			funcs.createSettings()

			funcs.switchTab(mainContent)

			funcs.logDebug("Admin panel opened")
		end

		-- Close window
		funcs.closeWindow = function()
			if not mainFrame.Visible then return end

			mainFrame.Visible = false
			taskbarButton.Visible = true
			funcs.logDebug("Admin panel closed")
		end

		-- Switch tab
		funcs.switchTab = function(content)
			mainContent.Visible = false
			playerContent.Visible = false
			visualContent.Visible = false
			funContent.Visible = false
			debugContent.Visible = false
			settingsContent.Visible = false
			serverContent.Visible = false
			feEffectsContent.Visible = false

			content.Visible = true

			if content == playerContent then
				funcs.updatePlayerList()
			elseif content == debugContent then
				funcs.initDebugPanel()
			end
		end

		-- Event handlers
		closeBtn.MouseButton1Click:Connect(function()
			funcs.stopFlying()
			funcs.noclip(false)
			funcs.infiniteJump(false)
			if debugConnection then debugConnection:Disconnect() end
			if freezeLoop then freezeLoop:Disconnect() end
			funcs.rainbowCharacter(false)
			funcs.removeESP()
			funcs.unfreezeAllPlayers()
			-- ... (disconnect all other connections)
			funcs.closeWindow()
			task.wait(0.1)
			if gui then gui:Destroy() end
		end)

		minimizeBtn.MouseButton1Click:Connect(function()
			funcs.closeWindow()
			taskbarButton.Visible = true
		end)

		taskbarButton.MouseButton1Click:Connect(function()
			if mainFrame.Visible then
				funcs.closeWindow()
			else
				funcs.openWindow()
			end
		end)

		mainTab.MouseButton1Click:Connect(function() funcs.switchTab(mainContent) end)
		playerTab.MouseButton1Click:Connect(function() funcs.switchTab(playerContent) end)
		visualTab.MouseButton1Click:Connect(function() funcs.switchTab(visualContent) end)
		funTab.MouseButton1Click:Connect(function() funcs.switchTab(funContent) end)
		debugTab.MouseButton1Click:Connect(function() funcs.switchTab(debugContent) end)
		settingsTab.MouseButton1Click:Connect(function() funcs.switchTab(settingsContent) end)
		serverTab.MouseButton1Click:Connect(function() funcs.switchTab(serverContent) end)
		feEffectsTab.MouseButton1Click:Connect(function() funcs.switchTab(feEffectsContent) end)

		-- Dragging (with touch support)
		local dragging = false
		local dragOffset = Vector2.new(0, 0)

		titleBar.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragOffset = Vector2.new(input.Position.X, input.Position.Y) - Vector2.new(mainFrame.AbsolutePosition.X, mainFrame.AbsolutePosition.Y)
			end
		end)

		titleBar.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local newPos = UDim2.new(
					0, input.Position.X - dragOffset.X,
					0, input.Position.Y - dragOffset.Y
				)
				mainFrame.Position = newPos
			end
		end)

		-- Tooltip update
		UserInputService.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				if tooltip and tooltip.Visible then
					local mousePos = UserInputService:GetMouseLocation()
					tooltip.Position = UDim2.new(0, mousePos.X + 20, 0, mousePos.Y)
				end
			end
		end)

		-- Auto open
		if settings.AutoOpen then
			task.delay(1, funcs.openWindow)
		else
			taskbarButton.Visible = true
		end

		-- Character removing
		player.CharacterRemoving:Connect(function()
			funcs.stopFlying()
			funcs.noclip(false)
			funcs.infiniteJump(false)
		end)

		-- Heartbeat safety
		RunService.Heartbeat:Connect(function()
			if flying and not player.Character then
				funcs.stopFlying()
			end
		end)

		-- Init
		funcs.logDebug("Admin panel initialized")
		funcs.logDebug("Version: Ultimate 6.0")
		funcs.logDebug("Player: " .. player.Name)

		funcs.createButtons()
		funcs.createSettings()

		taskbarButton.Visible = true
	else
		errorText.Text = "Incorrect key"
	end
end)

-- Key window animation
local tweenInfo = TweenInfo.new(0.5, Enum.EasingDirection.Out, Enum.EasingStyle.Quad)
local goal = {Size = UDim2.new(0.8, 0, 0.6, 0)}
keyWindow.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(keyWindow, tweenInfo, goal):Play()
