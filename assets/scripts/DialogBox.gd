extends Control
class_name DialogBox

signal dialog_finished

export(float) var text_speed := 0.05
var current_dialog := [
	{
	"text": "У меня было два барана"
	},
	{
	"text": "Потом баранов съел волк"
	},
	{
	"text": "Я нашёл волка и убил его"
	},
	{
	"text": "После этого весь город жил мирно и дружно"
	},
	{
	"text": "Слава России"
	},
]
var phrase_finished := false
var playing := false
var current_phrase := 0

onready var text_container := $VBoxContainer/Dialog/VBoxContainer/Text
onready var skip_marker    := $VBoxContainer/Dialog/VBoxContainer/Skip
onready var text_timer     := $TextTimer


func play_phrase(i: int):
	var text := current_dialog[i]["text"] as String
	
	skip_marker.visible = false
	phrase_finished = false
	text_container.text = text
	text_container.visible_characters = 0
	text_timer.wait_time = text_speed
	current_phrase = i
	
	while text_container.visible_characters < len(text) and text_container.visible_characters != -1:
		text_container.visible_characters += 1
		text_timer.start()
		yield(text_timer, "timeout")
	
	skip_marker.visible = true
	phrase_finished = true


func activate():
	visible = true
	set_process(true)


func deactivate():
	visible = false
	playing = false
	set_process(false)


func _ready():
	play_phrase(0)


func play_dialog():
	activate()
	playing = true
	current_phrase = 0
	play_phrase(0)


func _process(_delta):
	if Input.is_action_just_pressed("dash"):
		if phrase_finished:
			if current_phrase + 1 < len(current_dialog):
				play_phrase(current_phrase + 1)
			else:
				emit_signal("dialog_finished")
				deactivate()
		else:
			text_container.visible_characters = -1
