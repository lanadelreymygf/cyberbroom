extends Node

# Used when the player is dashing

var issuer: Player

onready var sm := get_parent() as StateManager


func enter():
	issuer.movement += issuer.movement.normalized() * 650


func tick(delta: float):
	issuer.apply_friction(issuer.acceleration * delta)
	
	issuer.movement = issuer.move_and_slide(issuer.movement)
	
	if issuer.movement.length() < 70:
		sm.change_state(1)


func exit():
	pass
