extends Control

onready var newWorldAl1 = 'res://src/scenes/worldAl1.tscn'
onready var newWorldDe1 = 'res://src/scenes/worldDe1.tscn'
export var seedRaw: = '0'
var didSeed = false

func _on_Button2_pressed() -> void:
	if !didSeed: 
		var randSeed = getRandSeed()
		global.rawSeed = randSeed
	seed(global.rawSeed)
	var rand = 100
	print(rand)
	if rand == 100:
		get_tree().change_scene(newWorldAl1)
	else:
		get_tree().change_scene(newWorldDe1)
	
func _on_LineEdit_text_entered(new_text: String):
	global.rawSeed = new_text.hash()
	didSeed = true


func getRandSeed():
	randomize()
	var rawSeed = randi() % 100
	print(rawSeed)
	return rawSeed
