extends CanvasLayer

# This is a simple solution to the scene transition problem
# It allows for simple transition animations

onready var anim_player := $AnimationPlayer

signal faded_to_black
signal faded_to_normal

var transitioning := false

# This changes the scene in-between the anitmations
func change_scene(target: String):
	anim_player.play("fade_to_black")
	transitioning = true
	yield(anim_player, "animation_finished")
	
	get_tree().change_scene(target)
	
	anim_player.play("fade_to_normal")
	yield(anim_player, "animation_finished")
	transitioning = false


func fade_to_black():
	anim_player.play("fade_to_black")
	yield(anim_player, "animation_finished")
	emit_signal("faded_to_black")


func fade_to_normal():
	anim_player.play("fade_to_normal")
	yield(anim_player, "animation_finished")
	emit_signal("faded_to_normal")
