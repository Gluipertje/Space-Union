extends Control


func _on_Button2_pressed() -> void:
	var worldGenPack = load("res://src/gamelogic/WorldGen.tscn")
	var saveButtonPack = load("res://src/gamelogic/GUI/SaveButton.tscn")
	var worldGen = worldGenPack.instance()
	get_tree().get_root().add_child(worldGen)
	get_parent().remove_child(self)


func _on_Button_pressed() -> void:
	var packed_scene = load("res://savedscene.tscn")
	var my_scene = packed_scene.instance()
	add_child(my_scene)
