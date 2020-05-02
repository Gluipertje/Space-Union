extends Area2D

func _enter_tree() -> void:
	var rand = randi() % 2
	if rand == 1:
		$Sprite.set_flip_h(true)
	else:
		$Sprite.set_flip_h(false)
