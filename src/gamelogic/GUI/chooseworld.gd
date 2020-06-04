extends Control

onready var button = preload("res://src/misc/Button.tscn")
onready var planetAl = preload("res://src/obj/alien1/planetAl.tscn")
onready var planetDe = preload("res://src/obj/desert1/planetDe.tscn")
onready var planetJu = preload("res://src/obj/jungle1/planetJu.tscn")
onready var systemNameText = get_node("ColorRect/Label")
onready var sun = get_node("sun")
onready var station = get_node("Station")

var randWord1
var words = ['Valkse', 'Merenu', 'Tharasa', 'Zeus', 'Kanrakyo', 'Cancri', 'Pegas', 'Galileo', 'Ursae Majoris', 'Draconis', 'Delphini', 'Andromedae']
var letters = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
var worldsAmount = 7
#var yButton = 60

func _ready() -> void:
	sun.set_position(Vector2(get_viewport().size.x / 2, get_viewport().size.y / 2))
	station.set_position(Vector2((randi() % int(get_viewport().size.x - 200)) + 100, (randi() % int(get_viewport().size.y))))
	
	if global.wantedWorld.empty():
		$ship.set_position(Vector2(100, 100))
	else:
		$ship.set_position(Vector2(global.wantedWorld[5].x  - 10, global.wantedWorld[5].y - 10))
	seed(global.rawSeed)
	global.systemName = letters[randi() % letters.size()].capitalize() + letters[randi() % letters.size()].capitalize() + ' ' + str(randi() % 1000)
	systemNameText.text = global.systemName + ' | ' + 'Region: ' + str(randi() % 10000) + letters[randi() % letters.size()].capitalize()
	for i in range(worldsAmount):
		var worldSeed = str(randi() % 500) + str(randi() % 500) + str(randi() % 500)
		var randBiome = randi() % global.biomes.size()
		var height = randi() % 100
		var worldSize = (randi() % global.maxWorldSize) + 200
		var worldSizeName = ''
		if worldSize > 500:
			worldSizeName = 'Major'
		elif worldSize < 400:
			worldSizeName = 'Minor'
		
		var randWord = randi() % words.size()
		var randLetter = randi() % letters.size()
		var randPos = Vector2((randi() % int(get_viewport().size.x - 200)) + 100, (randi() % int(get_viewport().size.y - 200)) + 100)
		if randPos.distance_to(sun.get_position()) <= 100:
			randPos = Vector2((randi() % int(get_viewport().size.x - 200)) + 100, (randi() % int(get_viewport().size.y - 200)) + 100)
		var planetAli = planetAl.instance()
		var planetDei = planetDe.instance()
		var planetJui = planetJu.instance()
#		var buttoni = button.instance()
		
		var name = str(height) + ' ' + words[randWord] + ' ' + global.biomes[randBiome][0] + ' ' + worldSizeName
		
		if global.biomes[randBiome] == 'Alien1':
			planetAli.set_name(str(i))
			planetAli.set_position(randPos)
			planetAli.z_index = 0
			add_child(planetAli)
		elif global.biomes[randBiome] == 'Desert1':
			planetDei.set_name(str(i))
			planetDei.set_position(randPos)
			planetDei.z_index = 0
			add_child(planetDei)
		elif global.biomes[randBiome] == 'Jungle1':
			planetJui.set_name(str(i))
			planetJui.set_position(randPos)
			planetJui.z_index = 0
			add_child(planetJui)
		else:
			planetAli.set_name(str(i))
			planetAli.set_position(randPos)
			add_child(planetAli)
		
		global.worlds.append([name, global.biomes[randBiome], worldSeed, height, worldSize, randPos])
		words.erase(words[randWord])
