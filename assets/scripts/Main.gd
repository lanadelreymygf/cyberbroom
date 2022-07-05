extends Node2D
class_name Main

# This node will handle between level transition

var levels := [
	preload("res://scenes/game/Level0.tscn"),
]
var current_level := 0
var paused := false

onready var player := get_child(0).get_node("Player")
onready var pause_menu := $PauseMenu as PauseMenu


# Pause when opening the PauseMenu
func _input(event):
	if event.is_action_pressed("back") and not paused and not SceneTransitionManager.transitioning:
		get_tree().set_pause(true)
		paused = true
		pause_menu.open()


func change_levels(next_level: int):
	var new_scene := (levels[next_level] as PackedScene).instance()
	var old_scene := get_child(0)
	
	SceneTransitionManager.fade_to_black()
	player.set_state(3)
	yield(SceneTransitionManager, "faded_to_black")
	
	old_scene.queue_free()
	
	add_child(new_scene)
	move_child(new_scene, 0)
	current_level = next_level
	player = get_child(0).get_node("Player")
	
	SceneTransitionManager.fade_to_normal()


func _on_PauseMenu_menu_closed():
	get_tree().set_pause(false)
	paused = false


func _on_PauseMenu_main_menu_request():
	get_tree().set_pause(false)
	player.set_state(3)
	SceneTransitionManager.change_scene("res://scenes/menu/MainMenu.tscn")
