extends CanvasLayer

# This Node completely controls the Dialogue system in the game
# It is deactivated by default, and can be started with "play_dialog"

export(float) var text_speed := 0.05
var current_dialog := ""
var dialogs := Dialogs.get_dialogs()
var phrase_finished := false
var playing := false
var current_phrase := 0

onready var text_container := $Control/VBoxContainer/Dialog/VBoxContainer/Text
onready var character_name_label := $Control/VBoxContainer/Dialog/VBoxContainer/Name
onready var skip_marker    := $Control/VBoxContainer/Dialog/VBoxContainer/Skip
onready var text_timer     := $TextTimer


func play_phrase(i: int):
	var text := dialogs[current_dialog][i]["text"] as String
	var character_name := dialogs[current_dialog][i]["name"] as String
	
	skip_marker.visible_characters = 0
	phrase_finished = false
	text_container.bbcode_text = text
	character_name_label.text = character_name + ":"
	text_container.visible_characters = 0 
	text_timer.wait_time = text_speed
	current_phrase = i
	
	while text_container.visible_characters < len(text) and text_container.visible_characters != -1:
		text_container.visible_characters += 1
		text_timer.start()
		yield(text_timer, "timeout")
	
	skip_marker.visible_characters = -1
	phrase_finished = true


func activate():
	EventBus.emit_signal("player_state_change", 3)
	
	$Control.visible = true
	set_process(true)


func deactivate():
	EventBus.emit_signal("player_state_change", 0)
	
	$Control.visible = false
	playing = false
	set_process(false)


func _ready():
	EventBus.connect("play_dialog", self, "play_dialog")
	deactivate()


func play_dialog(name: String):
	if playing:
		return
	
	activate()
	playing = true
	current_dialog = name
	current_phrase = 0
	
	play_phrase(0)


func _process(_delta):
	if Input.is_action_just_pressed("dash"):
		if phrase_finished:
			if current_phrase + 1 < len(dialogs[current_dialog]):
				play_phrase(current_phrase + 1)
			else:
				deactivate()
		else:
			text_container.visible_characters = -1
