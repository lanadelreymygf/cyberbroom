extends Node2D
class_name Main

# This node will handle between level transition

var levels := [
	preload("res://scenes/game/Level0.tscn"),
	preload("res://scenes/game/Level1.tscn"),
]
var current_level := 0
var paused := false

onready var player := get_child(0).get_node("Player")
onready var pause_menu := $PauseMenu as PauseMenu


func _ready():
	EventBus.connect("level_change", self, "level_change")
	EventBus.connect("go_to_main_menu", self, "go_to_main_menu")


func level_change(next_level: int, new_position: Vector2):
	var new_scene := (levels[next_level] as PackedScene).instance()
	var old_scene := get_child(0)
	
	MusicPlayer.stop()
	
	SceneTransitionManager.fade_to_black()
	player.set_state(3)
	yield(SceneTransitionManager, "faded_to_black")
	
	old_scene.queue_free()
	
	add_child(new_scene)
	move_child(new_scene, 0)
	current_level = next_level
	player = get_child(0).get_node("Player")
	player.global_position = new_position
	
	SceneTransitionManager.fade_to_normal()
	
	MusicPlayer.play_music_on_level(next_level)


func go_to_main_menu():
	SceneTransitionManager.change_scene("res://scenes/menu/MainMenu.tscn")
