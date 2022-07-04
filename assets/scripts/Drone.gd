extends KinematicBody2D
class_name Drone

export (int) var max_speed = 300
export (int) var acceleration = 20
var movement := Vector2.ZERO

# This will be null unless the player is within sight
var player: Player

onready var sm := $StateManager as StateManager
onready var anim_player := $AnimationPlayer

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


# Gets a vector pointing from the drone to player, assuming the player is in sight
func get_direction_to_player() -> Vector2:
	return (player.global_position - global_position).normalized()


func _ready():
	anim_player.play("idle")


func _physics_process(delta):
	sm.tick(delta)


func _on_Sight_body_entered(body):
	if body.get_class() == "Player":
		player = body
		sm.change_state(1)


func _on_Sight_body_exited(body):
	if body.get_class() == "Player":
		player = null
		sm.change_state(0)
