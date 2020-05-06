extends Node2D

var terrain = global.terrainArray

onready var Tree1 = preload('res://src/obj/desert1/Tree1.tscn')

onready var trees = [Tree1]

func _ready() -> void:
	GenTrees1()

func GenTrees1():
	for x in range(0, terrain.size() - 16, 3):
		var randT = rand_range(0, trees.size()) 
		var rand = randi() % 5
		if rand == 1:
			if terrain[x] - terrain[x + 1] != 16 and terrain[x] - terrain[x - 1] != 16:
				var Tre = trees[randT]
				var Treein = Tre.instance()
				Treein.position = Vector2(x * 16, terrain[x] - 24)
				Treein.set_name('Tree_' + str(x))
				get_tree().get_root().add_child(Treein, true)
				#print('Tree added at ' + str(x * 16) + ' ' + str(terrain[x] * 16 - 24) + ' On round ' + str(x))
