extends ColorRect

func _enter_tree() -> void:
	$Bar1.color = Color(1, 1, 1, 1)

func _on_Player_player_stats_changed(var player):
	$Bar1.rect_size.x = 60 * player.JPFuel / player.maxJPFuel
	$Bar1.color = Color(1, 1, 1, 1)
	if !player.canJump or !player.canSprint:
		$Bar1.color = Color(1, 0, 0, 1)
	
