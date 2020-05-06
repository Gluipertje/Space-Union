extends Node2D

var terrain = global.terrainArray

onready var Rock1 = preload('res://src/obj/alien1/Rock1.tscn')
onready var Rock2 = preload('res://src/obj/alien1/Rock2.tscn')

onready var rocksS = [Rock1]
onready var rocksM = [Rock2]
onready var rocks = [rocksS, rocksM]

func _ready() -> void:
	GenRocks1()

func GenRocks1():
	for x in range(0, terrain.size() - 16):
		var rockC = rocks[rand_range(0, rocks.size())]
		var randTS = rand_range(0, rocksS.size()) 
		var randTM = rand_range(0, rocksM.size())
		var rand = randi() % 10
		if rand == 5:
			if rockC == rocksS:
				if terrain[x] - terrain[x + 1] != 16 and terrain[x] - terrain[x - 1] != -16:
					var Rock = rocksS[randTS]
					var Rockin = Rock.instance()
					Rockin.position = Vector2(x * 16, terrain[x] - 24)
					Rockin.set_name('Rock_' + str(x))
					get_tree().get_root().add_child(Rockin, true)
					#print('Rock added at ' + str(x * 16) + ' ' + str(terrain[x] * 16 - 24) + ' On round ' + str(x))
			elif rockC == rocksM:
				if terrain[x -1] - terrain[x] == 0 and terrain[x] - terrain[x + 1] == 0:
					var Rock = rocksM[randTM]
					var Rockin = Rock.instance()
					Rockin.position = Vector2(x * 16, terrain[x] - 24)
					Rockin.set_name('Rock_' + str(x))
					get_tree().get_root().add_child(Rockin, true)
					#print('Rock added at ' + str(x * 16) + ' ' + str(terrain[x] * 16 - 24) + ' On round ' + str(x))
		
			
