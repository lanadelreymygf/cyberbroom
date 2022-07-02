extends Node

# Used when the player is walking

var issuer: Player

onready var sm := get_parent() as StateManager


func enter():
	pass


func tick(delta: float):
	var axis := issuer.get_axis()
	
	if axis == Vector2.ZERO:
		issuer.apply_friction(issuer.acceleration * delta)
	else:
		issuer.apply_acceleration(axis * issuer.acceleration * delta)
	
	issuer.movement = issuer.move_and_slide(issuer.movement)
	
	if issuer.movement.length() < 30:
		sm.change_state(0)


func exit():
	pass
