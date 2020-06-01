extends ColorRect

func _on_Timer_timeout() -> void:
	$AnimationPlayer.play("fadein")


func _on_Timer2_timeout() -> void:
	queue_free()
