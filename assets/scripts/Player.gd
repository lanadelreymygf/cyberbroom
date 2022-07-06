extends KinematicBody2D
class_name Player

export (int) var max_speed = 300
export (int) var acceleration = 20
var movement := Vector2.ZERO
var can_dash := true

onready var sm := $StateManager
onready var dash_timer := $DashTimer
onready var anim_player := $AnimationPlayer


func _ready():
	anim_player.play("idle")
	
	EventBus.connect("player_state_change", self, "set_state")


# Get the normalized movement axis based on the key input
func get_axis() -> Vector2:
	var axis := Vector2.ZERO
	
	axis.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	axis.y = int(Input.is_action_pressed("down"))  - int(Input.is_action_pressed("up"))
	
	return axis.normalized()


# Applies friction in the opposite direction of the movement
func apply_friction(value: float):
	if movement.length() < value:
		movement = Vector2.ZERO
	else:
		movement -= movement.normalized() * value


# Applies acceleration in the direction of the movement
func apply_acceleration(value: Vector2):
	movement += value
	movement = movement.clamped(max_speed)


# Perform a dash, if able to
func dash():
	if get_state() == 1 and can_dash:
		set_state(2)
		can_dash = false
		dash_timer.start()


func _physics_process(delta):
	# Dashing
	if Input.is_action_just_pressed("dash"):
		dash()
	
	sm.tick(delta)


func _on_DashTimer_timeout():
	can_dash = true


# Globally modify the class name
func get_class(): return "Player"


func get_state(): return sm.current_state


func set_state(new_state: int):
	sm.change_state(new_state)


# Animation handling
func _on_StateManager_state_changed(new_state):
	match new_state:
		0:
			anim_player.play("idle")
		1: 
			anim_player.play("walk")
		2:
			anim_player.play("dash")
		3:
			anim_player.play("idle")
