extends Node2D

var terrain = global.terrainArray

onready var Tree1 = preload('res://src/obj/alien1/Tree3.tscn')
onready var Tree2 = preload('res://src/obj/alien1/Tree2.tscn')
onready var Tree3 = preload('res://src/obj/alien1/Tree4.tscn')
onready var Tree4 = preload('res://src/obj/alien1/Tree5.tscn')
onready var Tree5 = preload('res://src/obj/alien1/Tree6.tscn')
onready var Tree6 = preload('res://src/obj/alien1/Tree7.tscn')

onready var trees = [Tree1, Tree2, Tree3, Tree4, Tree5, Tree6]

func _ready() -> void:
	GenTrees1()

func GenTrees1():
	for x in range(0, terrain.size() - 16, 3):
		var randT = rand_range(0, trees.size()) 
		var rand = randi() % 3
		if rand == 1:
			if terrain[x] - terrain[x + 1] != 16 and terrain[x] - terrain[x - 1] != 16:
				var Tre = trees[randT]
				var Treein = Tre.instance()
				Treein.position = Vector2(x * 16, terrain[x] - 24)
				Treein.set_name('Tree_' + str(x))
				get_tree().get_root().add_child(Treein, true)
				#print('Tree added at ' + str(x * 16) + ' ' + str(terrain[x] * 16 - 24) + ' On round ' + str(x))
