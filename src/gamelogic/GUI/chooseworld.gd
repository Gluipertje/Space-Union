extends Control

onready var button = preload("res://src/misc/Button.tscn")

var randWord1
var words = ['Valkse', 'Merenu', 'Tharasa', 'Zeus', 'Kanrakyo', 'Cancri', 'Pegas', 'Galileo', 'Ursae Majoris', 'Draconis', 'Delphini', 'Andromedae']
var letters = ['a', 'b', 'c', 'd', 'e', 'x', 'y', 'z']
var worldsAmount = 5
var yButton = 60

func _ready() -> void:
	seed(global.rawSeed)
	for i in range(worldsAmount):
		var worldSeed = str(randi() % 500) + str(randi() % 500) + str(randi() % 500)
		var randBiome = randi() % global.biomes.size()
		var height = randi() % 100
		var worldSize = (randi() % 500) + 200
		var worldSizeName = ''
		if worldSize > 500:
			worldSizeName = 'Major'
		elif worldSize < 400:
			worldSizeName = 'Minor'
		
		var randWord = randi() % words.size()
		var randLetter = randi() % letters.size()
		var buttoni = button.instance()
		
		var name = str(height) + ' ' + words[randWord] + ' ' + global.biomes[randBiome][0] + ' ' + worldSizeName
		
		buttoni.set_name("Button" + str(i))
		buttoni.set_position(Vector2(40, yButton))
		buttoni.set_text(name)
		add_child(buttoni)
		buttoni.connect("pressed", self, "_on_Button_id_pressed", [i])
		yButton += 60
		
		
		global.worlds.append([name, global.biomes[randBiome], worldSeed, height, worldSize])
		words.erase(words[randWord])
	

func _on_Button_id_pressed(id):
	global.wantedWorld = global.worlds[id]
	print('Switching to world ' + str(global.worlds[id]))
	var newScene = "res://src/scenes/" + 'world' + global.worlds[id][1] + '.tscn'
	get_tree().change_scene(newScene)
	
