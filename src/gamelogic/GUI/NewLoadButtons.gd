extends Control

onready var newWorld = 'res://src/scenes/worldAl1.tscn'
export var seedRaw: = '0'

func _on_Button2_pressed() -> void:
	get_tree().change_scene(newWorld)
	
func _on_LineEdit_text_entered(new_text: String):
	global.rawSeed = new_text.hash()
