extends Control

var settings_menu := preload("res://scenes/menu/SettingsMenu.tscn")


func _ready():
	var smi := settings_menu.instance() as SettingsMenu
	smi.settings = smi.get_saved_settings()
	smi.apply_settings()
	

# Quit the game
func _on_Quit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_Play_pressed():
	get_tree().change_scene("res://scenes/game/Main.tscn")


func _on_Help_pressed():
	get_tree().change_scene("res://scenes/menu/HelpMenu.tscn")


func _on_Settings_pressed():
	get_tree().change_scene("res://scenes/menu/SettingsMenu.tscn")


func _on_Credits_pressed():
	pass # Replace with function body.
