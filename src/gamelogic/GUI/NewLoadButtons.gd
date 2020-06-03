extends Control

onready var chooseworld = 'res://src/scenes/chooseworld.tscn'
onready var fadeout = preload("res://src/misc/FadeOut.tscn")
export var seedRaw: = '0'
var didSeed = false

func _on_Button2_pressed() -> void:
	var fadeouti = fadeout.instance()
	fadeouti.set_name('fadeouti')
	add_child(fadeouti)
	var timer1 = Timer.new()
	timer1.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer1)
	timer1.set_wait_time(2.0)
	timer1.start() 

func getRandSeed():
	randomize()
	var rawSeed = int(str(randi() % 500) + str(randi() % 500) + str(randi() % 500))
	print(rawSeed)
	return rawSeed

func _on_timer_timeout():
	if !didSeed: 
		var randSeed = getRandSeed()
		global.rawSeed = randSeed
	seed(global.rawSeed)
	global.worlds.clear()
	global.wantedWorld.clear()
	global.systemName = ''
	global.playerPos = Vector2(20, 200)
	get_tree().change_scene(chooseworld)


func _on_LineEdit_text_changed(new_text: String) -> void:
	global.rawSeed = new_text.hash()
	didSeed = true
