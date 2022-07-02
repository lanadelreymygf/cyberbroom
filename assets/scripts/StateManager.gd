extends Node
class_name StateManager

# States are children nodes, which have function "tick"

var current_state := 0

onready var states := get_children()
onready var issuer := get_parent()

signal state_changed(new_state)


# Needed to switch between "tick" functions of different states
func change_state(new_state: int):
	states[current_state].exit()
	states[new_state].enter()
	
	current_state = new_state
	emit_signal("state_changed", new_state)


# Executes the current state's tick function
func tick(delta: float):
	states[current_state].tick(delta)


func _ready():
	for state in states:
		state.issuer = issuer
