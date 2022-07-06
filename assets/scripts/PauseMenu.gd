extends CanvasLayer
class_name PauseMenu

# Handles the pause menu

onready var container = $CenterContainer

func _input(event):
	if event.is_action_pressed("back"):
		open()


func open():
	get_tree().set_pause(true)
	container.visible = true


func close():
	get_tree().set_pause(false)
	container.visible = false


func _ready():
	close()


func _on_Continue_pressed():
	close()


func _on_Main_Menu_pressed():
	close()
	MusicPlayer.stop()
	
	get_tree().set_pause(false)
	
	EventBus.emit_signal("player_state_change", 3)
	EventBus.emit_signal("go_to_main_menu")


func _on_Quit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
