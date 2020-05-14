extends Area2D

onready var particles = load("res://src/misc/rockMinePartAl1.tscn")

var maxHealth = 3
var health = 3 
var isAlive = true

func _enter_tree() -> void:
	var rand = randi() % 2
	if rand == 1:
		$Sprite.set_flip_h(true)
	else:
		$Sprite.set_flip_h(false)

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed('lclick'):
		print("Clicked")
		var particles_inst = particles.instance()
		add_child(particles_inst)
				
		if health == 0 and isAlive:
			add_child(particles_inst)
			print("bruh")
			global.playerInventoryStone += randi() % 6
			if is_instance_valid($Sprite):
				$Sprite.queue_free()
			isAlive = false
			
		
		if health > 0:
			health -= 1
