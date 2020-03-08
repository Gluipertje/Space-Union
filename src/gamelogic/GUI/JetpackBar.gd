extends ColorRect

func _on_Player_player_stats_changed(var player):
	$Bar1.rect_size.x = 38 * player.JPFuel / player.maxJPFuel
