extends Control
class_name SettingsMenu

var settings := {
	"volume": 50,
	"selected_res": 0,
	"vsync": false,
	"fullscreen": true,
}


func save_settings():
	var save_file := File.new()
	save_file.open("user://settings.dat", File.WRITE)
	save_file.store_var(settings, true)
	print(save_file.get_path_absolute())


func get_saved_settings():
	var save_file := File.new()
	save_file.open("user://settings.dat", File.READ)
	return save_file.get_var(true)


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


func apply_settings():
	#ProjectSettings.set_setting("global/Volume", settings.volume)
	
	var il := $VBoxContainer/Resolution/ItemList as ItemList
	var resolution := il.get_item_text(settings["selected_res"])
	var w = resolution.split("x")[0]
	var h = resolution.split("x")[1]
	OS.set_window_size(Vector2(int(w), int(h)))
	
	OS.set_use_vsync(settings["vsync"])
	
	OS.set_window_fullscreen(settings["fullscreen"])


func synchronize_menu():
	$VBoxContainer/Audio/MasterSlider.set_value(settings["volume"])
	
	$VBoxContainer/Resolution/ItemList.select(settings["selected_res"])
	
	$VBoxContainer/VSync/CheckButton.set_pressed(settings["vsync"])

	$VBoxContainer/Fullscreen/CheckButton.set_pressed(settings["fullscreen"])

func _ready():
	settings = get_saved_settings()
	apply_settings()
	synchronize_menu()


func _input(event: InputEvent):
	if event.is_action_pressed("back"):
		get_tree().change_scene("res://scenes/menu/MainMenu.tscn")


func _on_Apply_pressed():
	settings = get_settings_from_menu()
	apply_settings()
	save_settings()
