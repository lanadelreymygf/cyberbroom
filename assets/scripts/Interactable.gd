extends Node

var player_near := false

onready var key := $Sprite

signal interact


func _process(_delta):
	if Input.is_action_just_pressed("ui_select") and player_near:
		emit_signal("interact")


func _on_Area2D_body_entered(body):
	if body.get_class() == "Player":
		player_near = true
		key.visible = true


func _on_Area2D_body_exited(body):
	if body.get_class() == "Player":
		player_near = false
		key.visible = false
