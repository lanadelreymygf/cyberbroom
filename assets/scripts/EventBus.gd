extends Node

# This node acts as the main interaction hub between other nodes
# It defines game-wide signals, to which all other nodes are free to subscribe
# EventBus is global, and therefore is accessible from everywhere

# new_state: int
# Makes the player update its state
signal player_state_change(new_state)

# new_level: int
# new_player_coordinates: Vector2
# Makes the game change its level
signal level_change(new_level, new_player_coordinates)

# dialog_name: String
# Opens up the specified dialog
signal play_dialog(dialog_name)

# Returns the player to the main menu
signal go_to_main_menu


func _ready():
	print("EventBus loaded")
	
	connect("player_state_change", self, "player_state_change_log")
	connect("level_change", self, "level_change_log")
	connect("play_dialog", self, "play_dialog_log")
	connect("go_to_main_menu", self, "go_to_main_menu_log")


func player_state_change_log(new_state):
	print("[Event] player_state_changed -> ", new_state)


func level_change_log(new_level, new_position):
	print("[Event] level_change -> ", new_level, " ", new_position)


func play_dialog_log(dialog_name):
	print("[Event] play_dialog -> ", dialog_name)


func go_to_main_menu_log():
	print("[Event] go_to_main_menu")
