extends Control


func _ready():
	if SettingsManager.save_file_exists():
		SettingsManager.load_settings_from_file()
	
	SettingsManager.apply_settings()
	
	# This should fix camera jittering, until the benevolent Godot devs update it
	Engine.set_target_fps(Engine.get_iterations_per_second())
	
	MusicPlayer.play_main_menu_music()


# Quit the game
func _on_Quit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


# Enter the game
func _on_Play_pressed():
	for child in $VBoxContainer.get_children():
		child.disabled = true
	
	SceneTransitionManager.change_scene("res://scenes/game/Main.tscn")
	MusicPlayer.play_music_on_level(0)


# Open the Help menu
func _on_Help_pressed():
	get_tree().change_scene("res://scenes/menu/HelpMenu.tscn")


# Open the Settings menu
func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/menu/SettingsMenu.tscn")


# Open the Credits menu
func _on_Credits_pressed():
	pass # Replace with function body.
