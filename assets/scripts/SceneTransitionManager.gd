extends CanvasLayer

# This is a simple solution to the scene transition problem
# It allows for simple transition animations

onready var anim_player := $AnimationPlayer

func change_scene(target: String):
	anim_player.play("fade_to_black")
	yield(anim_player, "animation_finished")
	get_tree().change_scene(target)
	anim_player.play("fade_to_normal")
