extends Control

# Get default settings from the SettingsManager
var settings := SettingsManager.get_settings()

# Collects settings data from the menu elements
func get_settings_from_menu() -> Dictionary:
	var new_settings := {}
	
	new_settings["volume"] = $VBoxContainer/Audio/MasterSlider.value
	
	var il := $VBoxContainer/Resolution/ItemList as ItemList
	var si := il.get_selected_items()
	if len(si) != 0:
		new_settings["selected_res"] = il.get_selected_items()[0]
	else:
		new_settings["selected_res"] = settings["selected_res"]
	
	new_settings["vsync"] = $VBoxContainer/VSync/CheckButton.pressed
	
	new_settings["fullscreen"] = $VBoxContainer/Fullscreen/CheckButton.pressed
	
	return new_settings


# Synchronizes the menu elements to show values of the settings
func synchronize_menu():
	$VBoxContainer/Audio/MasterSlider.set_value(settings["volume"])
	
	$VBoxContainer/Resolution/ItemList.select(settings["selected_res"])
	
	$VBoxContainer/VSync/CheckButton.set_pressed(settings["vsync"])

	$VBoxContainer/Fullscreen/CheckButton.set_pressed(settings["fullscreen"])


# Upon entering a scene, it loads the settings from the SettingsManager
# And synchronizes its elements
func _ready():
	if SettingsManager.save_file_exists():
		SettingsManager.load_settings_from_file()
	
	settings = SettingsManager.get_settings()
	
	synchronize_menu()

# Return to Main menu upon pressing Esc
func _input(event: InputEvent):
	if event.is_action_pressed("back"):
		get_tree().change_scene("res://scenes/menu/MainMenu.tscn")


# Apply settings and save them to file 
func _on_Apply_pressed():
	settings = get_settings_from_menu()
	SettingsManager.set_settings(settings)
	SettingsManager.apply_settings()
	SettingsManager.save_settings_to_file()
