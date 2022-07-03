extends Node
class_name StateManager

# A generally applicable StateManager
# All children nodes are expected to have "enter", "exit" and "tick" functions
# As well as to have a field "issuer"

# "enter" and "exit" are called once in the times of change of state
# "tick" is called every (physics) frame

# It is up to the state to change to another state

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


# Sets the issuer of all states, so that they can modify it directly
func _ready():
	for state in states:
		state.issuer = issuer
