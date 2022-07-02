extends Node

# Used when the player is idle

var issuer: Player

onready var sm := get_parent() as StateManager


func enter():
	pass


func tick(_delta: float):
	var axis := issuer.get_axis()
	
	if axis != Vector2.ZERO:
		sm.change_state(1)


func exit():
	pass
