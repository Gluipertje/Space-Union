extends Control

var pos

func _process(delta: float) -> void:
	pos = get_position()
	set_position(Vector2(pos.x, pos.y - 2))
	print(pos)
	if pos.y < -3777:
		get_tree().change_scene("res://src/scenes/menu.tscn")
