extends TileMap

export var tileSet: =  'res://src/tileset2.tres'
onready var seedRaw = global.rawSeed
onready var camera = get_node('../Player/Camera2D')
onready var player = get_node('../Player')

func _ready() -> void:
	clearDeco()
	generate(seedRaw)

func clearDeco():
	var children = get_tree().get_root().get_children()
	for i in range(children.size()):
		if 'Rock_' in children[i].get_name() or 'Tree_' in children[i].get_name():
			children[i].queue_free()

func generate(seedRaw):
	seed(seedRaw)
	set_tileset(load(tileSet))
	set_cell_size(Vector2(16, 16))
	var startGen = 0
	var endGen = 200
	genTerrain(startGen, endGen)
	setCameraLimit(startGen, endGen)
	spawnPlayer()
	#setupBg()
	

func genTerrain(startGen, endGen):
	var noise = OpenSimplexNoise.new()
	noise.set_seed(seedRaw)
	var rand
	var prevRand
	var prevPos = startGen + 1
	var spawnRock
	for curPos in range(startGen, endGen, 1): #Generates random slices according to the worldsize		
		var randGrass = randi() % 6 # Generates random grass texture
		var grassDeco
		if randGrass == 0:
			grassDeco = 9
		else:
			grassDeco = 8
		
		var blockY = noise.get_noise_1d(curPos) * 5 # Creates a new noise map
		blockY = int(blockY) # Rounds the float to an int
		set_cell(startGen + curPos, blockY, 0)
		genUnderground(blockY, curPos, rand, startGen)
		global.terrainArray.append(blockY * 16)
		if global.terrainArray[curPos] < global.terrainArray[curPos - 1]: #Terrain goes up
			set_cell(startGen + curPos, blockY, 1)
			set_cell(startGen + curPos, global.terrainArray[curPos - 1] / 16, 2)
			set_cell(startGen + curPos, blockY - 1, 10)
		elif global.terrainArray[curPos] > global.terrainArray[curPos - 1]: #Terrain goes down
			set_cell(startGen + curPos - 1, blockY, 5)
			set_cell(startGen + curPos - 1, global.terrainArray[curPos - 1] / 16, 6)
			set_cell(startGen + curPos - 1,  global.terrainArray[curPos - 1] / 16 - 1, 11)
			set_cell(startGen + curPos, blockY - 1, grassDeco)
		else:
			set_cell(startGen + curPos, blockY - 1, grassDeco)	
			
		if curPos == 0:
			global.coordinateStart = Vector2(curPos, prevPos)
			
		if curPos == endGen - 1:
			global.coordinateEnd = Vector2(curPos * 16, prevPos * 16)

func genUnderground(prevPos, curPos, rand, startGen):
	for i in range(prevPos + 1, 300):
					set_cell(startGen + curPos, i, 4)
					if rand_range(0, 10) == 0:
						set_cell(startGen + curPos, rand_range(0, 100), 3)		

func setCameraLimit(startGen, endGen):
	global._realWorldSize = map_to_world(Vector2(endGen, 0))
	global._realStartPos = map_to_world(Vector2(startGen, 0))
	camera.limit_left = global._realStartPos.x + 32
	camera.limit_right = global._realWorldSize.x - 32
	camera.limit_top = -5000
	camera.limit_bottom = 5000
	
func spawnPlayer():
	player.set_position(Vector2(100 * 16, global.terrainArray[100] - 16))
	
func setupBg():
	var sortTerrainArray = []
	var bruh = []
	bruh = global.terrainArray
	sortTerrainArray = bruh
	sortTerrainArray.sort()
	global.minYvalue = sortTerrainArray[-1]
	print(global.minYvalue)
	print(global.terrainArray)
	print(bruh)
	print(sortTerrainArray)
	var pl1 = get_node('../ParallaxBackground/ParallaxLayer2')
	pl1.set_position(Vector2(0, global.minYvalue))
