extends Node

# This Node handles all setting/game interaction, such as load from disk, save to disk and apply to current window

# These are the default settings that will be applied if no settings save was detected in the save directory
var settings := {
	"volume": 69,
	"selected_res": 0,
	"vsync": false,
	"fullscreen": true,
} setget set_settings, get_settings

# Array which links the selected item index with resolutions
const res_modes := [
	"1920x1080",
	"1280x720",
]

const SAVE_FILE_PATH := "user://settings.dat"


# Returns a duplicate of the current settings, so that they cannot be modified from elsewhere
func get_settings() -> Dictionary:
	return settings.duplicate()


# Sets the current settings to a copy of the passed value to avoid accidentaly changing it from elsewhere
func set_settings(value: Dictionary):
	settings = value.duplicate()


# Determines if a save file already in place
func save_file_exists() -> bool:
	var file := File.new()
	
	if file.file_exists(SAVE_FILE_PATH):
		file.close()
		return true
	
	file.close()
	return false


# Loads the settings from the save file assuming it exists
func load_settings_from_file():
	var save_file := File.new()
	save_file.open(SAVE_FILE_PATH, File.READ)
	set_settings(save_file.get_var(true))
	save_file.close()


# Saves the settings to the save file, creating it if it doesn't exist
func save_settings_to_file():
	var save_file := File.new()
	save_file.open(SAVE_FILE_PATH, File.WRITE)
	save_file.store_var(get_settings(), true)
	save_file.close()


# Applies current settings to the app window
func apply_settings():
	var resolution := res_modes[settings["selected_res"]] as String
	var w = resolution.split("x")[0]
	var h = resolution.split("x")[1]
	OS.set_window_size(Vector2(int(w), int(h)))
	
	OS.set_use_vsync(settings["vsync"])
	
	OS.set_window_fullscreen(settings["fullscreen"])

