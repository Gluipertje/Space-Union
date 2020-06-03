extends StaticBody2D

onready var ship = get_node('../ship')

func _process(delta: float) -> void:
	look_at(ship.get_position())
