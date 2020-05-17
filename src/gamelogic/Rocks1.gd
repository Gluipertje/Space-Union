extends Node2D

var terrain = global.terrainArray

onready var Rock1 = preload('res://src/obj/alien1/Rock1.tscn')
onready var Rock2 = preload('res://src/obj/alien1/Rock2.tscn')

onready var rocks = [Rock1, Rock2]

func _ready() -> void:
	GenRocks1()

func GenRocks1():
	for x in range(0, terrain.size() - 1, 2):
		var randT = rand_range(0, rocks.size()) 
		var rand = randi() % 6
		if rand == 5:
				if terrain[x] - terrain[x + 1] >= 0 and terrain[x] - terrain[x - 1] >= 0:
					var Rock = rocks[randT]
					var Rockin = Rock.instance()
					Rockin.position = Vector2(x * 16, terrain[x] - 24)
					Rockin.set_name('Rock_' + str(x))
					get_tree().get_root().add_child(Rockin, true)
		
		
			
