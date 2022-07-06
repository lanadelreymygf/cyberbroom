extends Node

# This is an auto-load file containing all the dialogue in the game

var dialogs := {
	"dialog0": [
		{
			"name": "Тест",
			"text": "Это первая реплика."
		},
		{
			"name": "Тест",
			"text": "Это вторая реплика."
		},
		{
			"name": "Тест",
			"text": "Это третья реплика."
		},
	]
} setget ,get_dialogs


func get_dialogs() -> Dictionary:
	return dialogs.duplicate(true)
