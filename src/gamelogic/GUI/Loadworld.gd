extends Button

onready var fadeout = preload("res://src/misc/FadeOut.tscn")
onready var ertext = get_node("Label")
var save = []

func _on_Button_pressed() -> void:
	load_game()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("savegame.save"):
		ertext.text = 'No save game detected!'
		return

	save_game.open("savegame.save", File.READ)
	while save_game.get_position() < save_game.get_len():
			var save_data = parse_json(save_game.get_line())
			save.append(save_data)

	save_game.close()
	PlayerStats.playerCredits = save[0]
	global.rawSeed = save[1]
	PlayerStats.playerInventoryStone = save[2]
	var fadeouti = fadeout.instance()
	fadeouti.set_name('fadeouti')
	add_child(fadeouti)
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.set_wait_time(2.0)
	timer.start() 

func _on_timer_timeout():
	get_tree().change_scene("res://src/scenes/chooseworld.tscn")
	pass
