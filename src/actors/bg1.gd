extends Node2D

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("posDebug"):
			print( 'bg pos: ' + str(get_position()))
