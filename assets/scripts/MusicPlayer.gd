extends AudioStreamPlayer

# This node manages music play

# Defines music paths for different levels
var music_paths := [
	"res://assets/audio/isitexit.wav"
]
var current_level: int
var is_in_main_menu = false

# Specifies the delay between looping in seconds
export(int) var loop_delay = 5


# Plays the music of according level
func play_music_on_level(level: int):
	stop()
	
	var resource := load(music_paths[level])
	current_level = level
	is_in_main_menu = false
	
	volume_db = (SettingsManager.get_settings()["volume"] - 100) / 10.0
	
	stream = resource
	
	play()


func play_main_menu_music():
	stop()
	
	var resource := load("res://assets/audio/mainMenuVer2.mp3")
	is_in_main_menu = true
	
	volume_db = (SettingsManager.get_settings()["volume"] - 100) / 10.0
	
	stream = resource
	
	play()


func _on_AudioSystem_finished():
	yield(get_tree().create_timer(loop_delay), "timeout")
	if is_in_main_menu:
		play_main_menu_music()
	else:
		play_music_on_level(current_level)
