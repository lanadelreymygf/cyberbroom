extends Control

var settings_menu := preload("res://scenes/menu/SettingsMenu.tscn")


func _ready():
	if SettingsManager.save_file_exists():
		SettingsManager.load_settings_from_file()
	
	SettingsManager.apply_settings()


# Quit the game
func _on_Quit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)

# Enter the game
func _on_Play_pressed():
	SceneTransitionManager.change_scene("res://scenes/game/Main.tscn")

# Open the Help menu
func _on_Help_pressed():
	get_tree().change_scene("res://scenes/menu/HelpMenu.tscn")

# Open the Settings menu
func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/menu/SettingsMenu.tscn")

# Open the Credits menu
func _on_Credits_pressed():
	pass # Replace with function body.
