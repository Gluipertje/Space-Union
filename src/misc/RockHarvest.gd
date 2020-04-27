extends Area2D

var maxHealth = 3
var health = 3 

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed('lclick'):
		print("Clicked")
		if health > 0:
			health -= 1
		
		if health == 0:
			global.playerInventoryStone += 3
			queue_free()
