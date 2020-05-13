extends Area2D

onready var particles = load("res://src/misc/rockMinePartDe1.tscn")

var maxHealth = 3
var health = 3 

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
		particles_inst.set_position(get_viewport().get_mouse_position())
		p(get_viewport().get_mouse_position())
		add_child(particles_inst)

		if health == 0:
			particles_inst.set_position(get_viewport().get_mouse_position())
			add_child(particles_inst)
			print("bruh")
			global.playerInventoryStone += randi() % 6
			if is_instance_valid($Sprite):
				$Sprite.queue_free()

		if health > 0:
			health -= 1
