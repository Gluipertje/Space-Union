extends Control

var pos

func _process(delta: float) -> void:
	pos = get_position()
	set_position(Vector2(pos.x, pos.y - 0.05))


func _on_Timer_timeout() -> void:
	get_tree().change_scene("res://src/scenes/menu.tscn")
