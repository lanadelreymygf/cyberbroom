extends CanvasLayer
class_name PauseMenu

# Handles the pause menu

signal menu_closed
signal main_menu_request

onready var container = $CenterContainer


func open():
	container.visible = true
	container.set_process(true) 


func close():
	container.visible = false
	container.set_process(false)


func _ready():
	close()


func _on_Continue_pressed():
	close()
	emit_signal("menu_closed")


func _on_Main_Menu_pressed():
	close()
	emit_signal("main_menu_request")


func _on_Quit_pressed():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
