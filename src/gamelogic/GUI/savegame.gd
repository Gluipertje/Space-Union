extends Button

onready var saveState = get_node('../Label')

func _on_Button4_pressed() -> void:
	save_game()

func save_game():
	var save_game = File.new()
	save_game.open("savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	save_game.store_line(to_json(PlayerStats.playerCredits))
	save_game.store_line(to_json(global.rawSeed))
	save_game.store_line(to_json(PlayerStats.playerInventoryStone))
	save_game.close()
	saveState.text = 'Saved Succesfully!'
