extends Node2D

var terrain = global.terrainArray

onready var Tree1 = preload('res://src/obj/desert1/Tree1.tscn')

onready var trees = [Tree1]

func _ready() -> void:
	GenTrees1()

func GenTrees1():
	for x in range(0, terrain.size() - 16, 3):
		var randT = rand_range(0, trees.size()) 
		var rand = randi() % 3
		if rand == 1:
			if terrain[x] - terrain[x + 1] >= 0 and terrain[x] - terrain[x - 1] >= 0:
				var Tre = trees[randT]
				var Treein = Tre.instance()
				Treein.position = Vector2(x * 16, terrain[x] - 16)
				Treein.set_name('Tree_' + str(x))
				get_tree().get_root().add_child(Treein, true)
