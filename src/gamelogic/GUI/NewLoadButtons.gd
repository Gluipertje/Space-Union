extends Control

onready var chooseworld = 'res://src/scenes/chooseworld.tscn'
export var seedRaw: = '0'
var didSeed = false

func _on_Button2_pressed() -> void:
	if !didSeed: 
		var randSeed = getRandSeed()
		global.rawSeed = randSeed
	seed(global.rawSeed)
	get_tree().change_scene(chooseworld)
	
func _on_LineEdit_text_entered(new_text: String):
	global.rawSeed = new_text.hash()
	didSeed = true


func getRandSeed():
	randomize()
	var rawSeed = randi() % 100
	print(rawSeed)
	return rawSeed
