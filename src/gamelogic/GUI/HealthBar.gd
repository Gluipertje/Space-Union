extends ProgressBar

func _on_Player_player_stats_changed(var player):
	size_flags_vertical = 72 * player.stamina / player.maxStamina
