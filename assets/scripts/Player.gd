extends KinematicBody2D
class_name Player

export (int) var max_speed = 300
export (int) var acceleration = 20
var movement := Vector2.ZERO
var can_dash := true

onready var sm := $StateManager
onready var dash_timer := $DashTimer
onready var anim_player := $AnimationPlayer


func get_axis() -> Vector2:
	var axis := Vector2.ZERO
	
	axis.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
	axis.y = int(Input.is_action_pressed("ui_down"))  - int(Input.is_action_pressed("ui_up"))
	
	return axis.normalized()


func apply_friction(value: float):
	if movement.length() < value:
		movement = Vector2.ZERO
	else:
		movement -= movement.normalized() * value


func apply_acceleration(value: Vector2):
	movement += value
	movement = movement.clamped(max_speed)


func dash():
	if sm.current_state == 1 and can_dash:
		sm.change_state(2)
		can_dash = false
		dash_timer.start()


func _physics_process(delta):
	# Dashing
	if Input.is_action_just_pressed("ui_accept"):
		dash()
	
	sm.tick(delta)


func _on_DashTimer_timeout():
	can_dash = true


func get_class(): return "Player"


func _on_StateManager_state_changed(new_state):
	match new_state:
		0:
			anim_player.play("idle")
		1: 
			anim_player.play("walk")
		2:
			anim_player.play("dash")


func _on_Interactable_interact():
	print("pressed E on the wall")
