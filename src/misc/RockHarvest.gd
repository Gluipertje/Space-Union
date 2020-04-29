extends Area2D

onready var particles = get_node("Particles2D")

var maxHealth = 3
var health = 3 

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed('lclick'):
		print("Clicked")
		particles.set_emitting(true)
		if health > 0:
			health -= 1
		
		if health == 0:
			global.playerInventoryStone += randi() % 6
			queue_free()
