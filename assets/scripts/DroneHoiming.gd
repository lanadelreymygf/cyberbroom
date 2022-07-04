extends Node

# Used when the drone is homing at a player

var issuer: Drone

onready var sm := get_parent() as StateManager


func enter():
	pass


func tick(delta: float):
	var direction := issuer.get_direction_to_player()
	
	issuer.apply_acceleration(direction * issuer.acceleration * delta)
	
	issuer.movement = issuer.move_and_slide(issuer.movement)


func exit():
	pass
