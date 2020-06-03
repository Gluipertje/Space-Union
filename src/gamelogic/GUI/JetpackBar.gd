extends ColorRect

var sizex

func _ready() -> void:
	$Bar1.color = Color(1, 1, 1, 1)
	sizex = $Bar1.rect_size.x

func _on_Player_player_stats_changed(var player):
	$Bar1.rect_size.x = sizex * player.JPFuel / player.maxJPFuel
	$Bar1.color = Color(1, 1, 1, 1)
	if !player.canExo:
		$Bar1.color = Color(1, 0, 0, 1)
	
