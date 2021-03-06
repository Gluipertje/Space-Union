extends TileMap

export var tileSet: =  'res://src/tileset2.tres'
onready var seedRaw = int(global.wantedWorld[2])
onready var camera = get_node('../Player/Camera2D')
onready var player = get_node('../Player')
onready var bot = get_node('../Area2D')
onready var ship = get_node('../Area2D2')
onready var shipc = get_node('../Area2D2/Camera2D')

func _ready() -> void:
	cleanUp()
	generate(seedRaw)

func cleanUp(): # cleans up all previous objects
	player.hide()
	camera.clear_current()
	shipc.make_current()
	global.isInShip = true
	clear()
	global.terrainArray.clear()
	var children = get_tree().get_root().get_children()
	for i in range(children.size()):
		if 'Rock_' in children[i].get_name() or 'Tree_' in children[i].get_name():
			children[i].queue_free()


func generate(seedRaw):
	seed(seedRaw)
	set_tileset(load(tileSet))
	set_cell_size(Vector2(16, 16))
	var startGen = 0
	var endGen = int(global.wantedWorld[4])
	genTerrain(startGen, endGen)
	setCameraLimit(startGen, endGen)
	setupBg()
	spawnPlayer()		

func genTerrain(startGen, endGen): # Generates the terrain
	var noise = OpenSimplexNoise.new()
	noise.set_seed(int(global.wantedWorld[2]))
	noise.set_octaves(3)
	var rand
	var prevPos = startGen + 1
	var botPos = int(rand_range(20, endGen - 20))
	for curPos in range(startGen, endGen, 1): #Generates random slices according to the worldsize		
		var randGrass = randi() % 6 
		var grassDeco
		var genStructure
		
		if randGrass == 0: # Generates random grass texture
			grassDeco = 9
		else:
			grassDeco = 8
		
		var blockY = noise.get_noise_1d(curPos) * global.wantedWorld[3] # Creates a new noise map
		blockY = int(blockY) # Rounds the float to an int
		
		if curPos > 15 and curPos < endGen - 15: # If current x is within world boundaries, it creates random terrain
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
		
		elif curPos <= 15: #If the current x is outside world boundaries, it creates flat terrain (to land on and prevent out of screen glitches)
			blockY = noise.get_noise_1d(16) * global.wantedWorld[3]
			blockY = int(blockY)
			global.terrainArray.append(blockY * 16)
			set_cell(startGen + curPos, blockY, 0)
			genUnderground(blockY, curPos, rand, startGen)
			set_cell(startGen + curPos, blockY - 1, grassDeco)
		
		elif curPos >= endGen - 15: # Same as above but other side
			blockY = noise.get_noise_1d(endGen - 16) * global.wantedWorld[3]
			blockY = int(blockY)
			global.terrainArray.append(blockY * 16)
			set_cell(startGen + curPos, blockY, 0)
			genUnderground(blockY, curPos, rand, startGen)
			set_cell(startGen + curPos, blockY - 1, grassDeco)
		
		if curPos == botPos:
			bot.set_position(Vector2(curPos * 16, global.terrainArray[curPos] - 24))
			
		if curPos == 0: # Defines absolute world boundaries
			global.coordinateStart = Vector2(curPos, prevPos)
		
		if curPos == 10:
			ship.set_position(Vector2(curPos * 16, global.terrainArray[curPos] - 16))
		
		if curPos == endGen - 1:
			global.coordinateEnd = Vector2(curPos * 16, prevPos * 16)

func genUnderground(prevPos, curPos, rand, startGen): # Generates tiles under the top of the terrain
	for i in range(prevPos + 1, 300):
					set_cell(startGen + curPos, i, 4)
					if randi() % 50 == 25:
						set_cell(startGen + curPos, int(rand_range(prevPos + 1, 200)) , 3)

func setCameraLimit(startGen, endGen): # Defines where the camera should stop moving 
	global._realWorldSize = map_to_world(Vector2(endGen, 0))
	global._realStartPos = map_to_world(Vector2(startGen, 0))
	camera.limit_left = global._realStartPos.x + 32
	camera.limit_right = global._realWorldSize.x - 32
	camera.limit_top = -5000
	camera.limit_bottom = 5000
	
func spawnPlayer(): # Teleports player to middel of the world
	player.set_position(Vector2(10 * 16, global.terrainArray[10] - 16))
	
func setupBg(): # Sets bg's to 'correct' position
	global.minYvalue = global.terrainArray.max()
	global.maxYvalue = global.terrainArray.min()
	if global.wantedWorld[1] == "Desert1":
		var pl2 = get_node('../ParallaxBackground/ParallaxLayer3/Sprite')
		var pl3 = get_node('../ParallaxBackground/ParallaxLayer4/Sprite')
		pl2.set_position(Vector2(0, global.minYvalue  - 40))
		pl3.set_position(Vector2(0, global.maxYvalue  - 40))
		
	
	if global.wantedWorld[1] == "Alien1":
		var pl1 = get_node('../ParallaxBackground/ParallaxLayer2/Sprite')
		var pl2 = get_node('../ParallaxBackground/ParallaxLayer3/Sprite')
		var pl3 = get_node('../ParallaxBackground/ParallaxLayer4/Sprite')
		pl1.set_position(Vector2(0, global.minYvalue  - 40))
		pl2.set_position(Vector2(0, global.minYvalue  - 40))
		pl3.set_position(Vector2(0, global.maxYvalue  - 40))
	
	if global.wantedWorld[1] == "Jungle1":
		var pl2 = get_node('../ParallaxBackground/ParallaxLayer3/Sprite')
		var pl3 = get_node('../ParallaxBackground/ParallaxLayer4/Sprite')
		pl2.set_position(Vector2(0, global.minYvalue  - 40))
		pl3.set_position(Vector2(0, global.maxYvalue  - 40))
