extends Node2D

var terrain = global.terrainArray

onready var RockAl11 = preload('res://src/obj/alien1/Rock1.tscn')
onready var RockAl12 = preload('res://src/obj/alien1/Rock2.tscn')

onready var rocksAl1S = [RockAl11]
onready var rocksAl1M = [RockAl12]
onready var rocksAl1 = [rocksAl1S, rocksAl1M]

func _ready() -> void:
	GenRocks1()

func GenRocks1():
	for x in range(0, terrain.size() - 16):
		var rockC = rocksAl1[rand_range(0, rocksAl1.size())]
		var randTS = rand_range(0, rocksAl1S.size()) 
		var randTM = rand_range(0, rocksAl1M.size())
		var rand = randi() % 10
		if rand == 5:
			if rockC == rocksAl1S:
				if terrain[x] - terrain[x + 1] != 16 and terrain[x] - terrain[x - 1] != 16:
					var Rock = rocksAl1S[randTS]
					var Rockin = Rock.instance()
					Rockin.position = Vector2(x * 16, terrain[x] - 24)
					Rockin.set_name('Rock_' + str(x))
					get_tree().get_root().add_child(Rockin, true)
					print('Rock added at ' + str(x * 16) + ' ' + str(terrain[x] * 16 - 24) + ' On round ' + str(x))
			elif rockC == rocksAl1M:
				if terrain[x -1] - terrain[x] == 0 and terrain[x] - terrain[x + 1] == 0:
					var Rock = rocksAl1M[randTM]
					var Rockin = Rock.instance()
					Rockin.position = Vector2(x * 16, terrain[x] - 24)
					Rockin.set_name('Rock_' + str(x))
					get_tree().get_root().add_child(Rockin, true)
					print('Rock added at ' + str(x * 16) + ' ' + str(terrain[x] * 16 - 24) + ' On round ' + str(x))
		
			
