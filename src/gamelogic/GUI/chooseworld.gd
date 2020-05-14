extends Control

onready var button = preload("res://src/misc/Button.tscn")

var randWord1
var words = ['Valkse', 'Merenu', 'Tharasa', 'Zeus', 'Kanrakyo']
var worldsAmount = 5
var yButton = 60

func _ready() -> void:
	seed(global.rawSeed)
	for i in range(worldsAmount):
		var randName = randi() % words.size()
		var buttoni = button.instance()
		buttoni.set_name("Button" + str(i))
		buttoni.set_position(Vector2(40, yButton))
		buttoni.set_text(words[randName])
		add_child(buttoni)
		buttoni.connect("pressed", self, "_on_Button_id_pressed", [i])
		yButton += 60
		
		var worldSeed = str(randi() % 500) + str(randi() % 500) + str(randi() % 500)
		var randBiome = randi() % global.biomes.size()
		var height = randi() % 100
		global.worlds.append([words[randName], global.biomes[randBiome], worldSeed, height])
		words.erase(words[randName])
	

func _on_Button_id_pressed(id):
	global.wantedWorld = global.worlds[id]
	print('Switching to world ' + str(global.worlds[id]))
	var newScene = "res://src/scenes/" + 'world' + global.worlds[id][1] + '.tscn'
	get_tree().change_scene(newScene)
	
