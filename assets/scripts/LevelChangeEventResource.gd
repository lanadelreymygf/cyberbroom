extends Resource
class_name LevelChangeEventResource

# This event changes the current level

export(int) var new_level = 0
export(Vector2) var new_player_position = Vector2.ZERO


func execute():
	EventBus.emit_signal("level_change", new_level, new_player_position)
