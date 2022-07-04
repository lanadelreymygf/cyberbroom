extends Resource
class_name LevelChangeEventResource

# This event launches a dialog

export(int) var new_level = 0

func execute(player: Player, args: Array):
	var main = args[0]
	main.change_levels(new_level)
