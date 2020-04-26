extends TileMap

var tileSet: =  'res://src/tileset2.tres'
onready var seedRaw = global.rawSeed

func _ready() -> void:
	generate(seedRaw)
	
func generate(seedRaw):
	seed(seedRaw)
	set_tileset(load(tileSet))
	set_cell_size(Vector2(16, 16))
	var startGen = 0
	var endGen = 600
	genTerrain(startGen, endGen)
	setCameraLimit(startGen, endGen)
	print(global.terrainArray)

func genTerrain(startGen, endGen):
	var rand
	var prevRand
	var prevPos = startGen + 1
	var spawnRock
	for curPos in range(startGen, endGen, 1): #Generates random slices according to the worldsize
		if prevRand == 5: # This part makes it so the terrain is way less rough and more natural
			rand = rand_range(3, 5)
		elif prevRand == 0:
			rand = rand_range(0, 2)
		else:
			rand = rand_range(0, 6)
		rand = int(rand) 
		
		var randGrass = randi() % 6 # Generates random grass
		var grassDeco
		if randGrass == 0:
			grassDeco = 9
		else:
			grassDeco = 8
			
		if randGrass == 4:
			spawnRock = true
			
		if rand == 5 and curPos > startGen + 3: # If the rand returns a 5 then the terrain will go down
			set_cell(startGen + curPos, prevPos + 1, 5)
			set_cell(startGen + curPos, prevPos, 6)
			prevPos = prevPos + 1
			prevRand = rand
			genUnderground(prevPos, curPos, rand, startGen) # This makes the dirt under the grass
			set_cell(startGen + curPos, prevPos - 2, 11) # Creates grass deco
			global.terrainArray.append(map_to_world(Vector2(0, prevPos - 1)).y) # Adds this tile to the global terrainArray
		elif rand == 0 and curPos < endGen - 3: # If the rand returns a 0 then the terrain will go up
			set_cell(startGen + curPos, prevPos - 1, 1)
			prevPos = prevPos - 1
			prevRand = rand
			genUnderground(prevPos, curPos, rand, startGen)
			set_cell(startGen + curPos, prevPos + 1, 2)
			set_cell(startGen + curPos, prevPos - 1, 10)
			global.terrainArray.append(map_to_world(Vector2(0, prevPos + 1)).y)
		else:
			set_cell(startGen + curPos, prevPos, 0)
			prevRand = rand
			genUnderground(prevPos, curPos, rand, startGen)
			set_cell(startGen + curPos, prevPos - 1, grassDeco)
			global.terrainArray.append(map_to_world(Vector2(0, prevPos)).y)
	
		if curPos == startGen + 32:
			spawnPlayer(prevPos, curPos)
			
		if curPos == 0:
			global.coordinateStart = Vector2(curPos, prevPos)
			
		if curPos == endGen - 1:
			global.coordinateEnd = Vector2(curPos * 16, prevPos * 16)

func genUnderground(prevPos, curPos, rand, startGen):
	for i in range(prevPos + 1, 100):
					set_cell(startGen + curPos, i, 4)
					if rand_range(0, 10) == 0:
						set_cell(startGen + curPos, rand_range(0, 100), 3)		

func setCameraLimit(startGen, endGen):
	global._realWorldSize = map_to_world(Vector2(endGen, 0))
	global._realStartPos = map_to_world(Vector2(startGen, 0))
	$Player/Camera2D.limit_left = global._realStartPos.x + 32
	$Player/Camera2D.limit_right = global._realWorldSize.x - 32
	$Player/Camera2D.limit_top = -5000
	$Player/Camera2D.limit_bottom = 5000
	
func spawnPlayer(prevPos, curPos):
	var scene = load("res://src/actors/Player.tscn")
	var player = scene.instance()
	#var player = get_node("../Player")
	#var gui = get_node("../Player/CanvasLayer")
	add_child(player)
	player.set_position(Vector2(curPos * 16, prevPos * 16 - 32))
