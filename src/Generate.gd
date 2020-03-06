extends TileMap

export var worldSize: = 300
export var smoothness: = 1
var tileSet: = "res://src/tileset1.tres"
var startPos: = Vector2(0,0)
var startGen: = Vector2(16, 0)
var curPos: = Vector2(0, 0)
var curPosx : = curPos.x

func _ready() -> void:
	generate()
	
func generate():
	set_cell_size(Vector2(16, 16))
	for curPosx in range(startGen.x, worldSize, smoothness):
		set_cell(startGen.x + curPos.x, startGen.y + curPos.y, 2)
		

