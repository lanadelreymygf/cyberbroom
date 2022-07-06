extends Resource
class_name DialogEventResource

# This event launches a dialog

export(String) var dialog_name = "dialog0"


func execute():
	EventBus.emit_signal("play_dialog", dialog_name)
