extends Node

# Used when the drone is idle

var issuer: Drone

onready var sm := get_parent() as StateManager


func enter():
	pass


func tick(delta: float):
	issuer.apply_friction(0.1 * issuer.acceleration * delta)
	
	issuer.movement = issuer.move_and_slide(issuer.movement)


func exit():
	pass
