extends Resource
class_name DialogEventResource

# This event launches a dialog

export(String) var dialog_name = "dialog0"


func execute(player: Player, args: Array):
	player.trigger_dialog(dialog_name)
