extends Control

func _input(event: InputEvent):
	if event.is_action_pressed("back"):
		get_tree().change_scene("res://scenes/menu/MainMenu.tscn")
