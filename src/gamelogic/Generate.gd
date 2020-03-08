extends TileMap

export var worldSize: = 600
export var smoothness: = 1
var tileSet: =  'res://src/tileset2.tres'
onready var seedRaw = global.rawSeed
var startPos: = Vector2(0 ,0)
var startGen: = Vector2(0, 0)
var curPos: = Vector2(0, 0)
var curPosx : = curPos.x

func _ready() -> void:
	generate(seedRaw)
	setCameraLimit()
	
	
func generate(seedRaw):
	seed(seedRaw)
	set_tileset(load(tileSet))
	var rand
	var prevRand
	var prevPosy = startGen.y + 1
	set_cell_size(Vector2(16, 16))
	for curPosx in range(startGen.x, worldSize, smoothness): #Generates random slices according to the worldsize
		if prevRand == 5:
			rand = rand_range(3, 5)
		elif prevRand == 0:
			rand = rand_range(0, 2)
		else:
			rand = rand_range(0, 6)
		rand = int(rand) # This part makes it so the terrain is way less rough and more natural
					
		if rand == 5: # If the rand returns a 5 then the terrain will go down
			set_cell(startGen.x + curPosx, prevPosy + 1, 5)
			set_cell(startGen.x + curPosx, prevPosy, 6)
			prevPosy = prevPosy + 1
			prevRand = rand
			for i in range(prevPosy + 1, 100):
				set_cell(startGen.x + curPosx, i, 4) # This makes the dirt under the grass
		if rand == 0: # If the rand returns a 0 then the terrain will go up
			set_cell(startGen.x + curPosx, prevPosy - 1, 1)
			prevPosy = prevPosy - 1
			prevRand = rand
			for i in range(prevPosy + 1, 100):
				set_cell(startGen.x + curPosx, i, 4)
			set_cell(startGen.x + curPosx, prevPosy + 1, 2)
		if rand < 5 and rand > 0: # If it's neither then it will just stay flat
			set_cell(startGen.x + curPosx, prevPosy, 0)
			prevRand = rand
			for i in range(prevPosy + 1, 100):
				set_cell(startGen.x + curPosx, i, 4)
		
		if curPosx == worldSize - 32:
			spawnPlayer(prevPosy, curPosx)
			
		if curPosx == 0:
			global.coordinateStart = Vector2(curPosx, prevPosy)
			print(global.coordinateStart)
			
		if curPosx == worldSize - 1:
			global.coordinateEnd = Vector2(curPosx * 16, prevPosy * 16)
			print(global.coordinateEnd)
	
	

func setCameraLimit():
	global._realWorldSize = map_to_world(Vector2(worldSize, 0))
	global._realStartPos = map_to_world(startPos)
	$Player/Camera2D.limit_left = global._realStartPos.x + 32
	$Player/Camera2D.limit_right = global._realWorldSize.x - 32
	$Player/Camera2D.limit_top = -5000
	$Player/Camera2D.limit_bottom = 5000
	
func spawnPlayer(prevPosy, curPosx):
	var scene = load("res://src/actors/Player.tscn")
	var player = scene.instance()
	#var player = get_node("../Player")
	#var gui = get_node("../Player/CanvasLayer")
	add_child(player)
	player.set_position(Vector2(curPosx * 16, prevPosy * 16 - 32))
