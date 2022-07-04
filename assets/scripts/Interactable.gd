extends Node

# Interactable is a property that most of the puzzle objects will have
# It simply adds a sprite to show when the player can interact with it
# As well as a signal, which is emitted once an interaction has been registered

export(Resource) var event

var player_near := false
var player: Player

onready var key := $Sprite
onready var main := get_node("/root/Main")

signal interact


func execute(player: Player, args: Array = []):
	event.execute(player, args)


func _process(_delta):
	if Input.is_action_just_pressed("interact") and player_near:
		emit_signal("interact")
		execute(player, [main])


func _on_Area2D_body_entered(body):
	if body.get_class() == "Player":
		player = body
		player_near = true
		key.visible = true


func _on_Area2D_body_exited(body):
	if body.get_class() == "Player":
		player = null
		player_near = false
		key.visible = false
