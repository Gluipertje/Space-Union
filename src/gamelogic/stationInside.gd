extends Control

onready var fadeout = preload("res://src/misc/FadeOut.tscn")
onready var creditsText = get_node("TextureRect2/ColorRect/credits")

func _ready() -> void:
	creditsText.text = 'Your Credits: ' + str(PlayerStats.playerCredits)
	if PlayerStats.playerCredits < 500:
		creditsText.set("custom_colors/font_color", Color(1,0,0,1))
	else:
		creditsText.set("custom_colors/font_color", Color(1,1,1,1))

func _on_Button_pressed() -> void:
	print(PlayerStats.playerCredits)
	if PlayerStats.playerCredits >= 500:
		PlayerStats.playerCredits -= 500
		var fadeouti = fadeout.instance()
		fadeouti.set_name('fadeouti')
		add_child(fadeouti)
		var timer = Timer.new()
		timer.connect("timeout",self,"_on_timer_timeout1") 
		add_child(timer)
		timer.set_wait_time(2.0)
		timer.start() 
		
	else:
		return


func _on_Button2_pressed() -> void:
	var fadeouti = fadeout.instance()
	fadeouti.set_name('fadeouti')
	add_child(fadeouti)
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.set_wait_time(2.0)
	timer.start() 
	

func _on_timer_timeout():
	get_tree().change_scene("res://src/scenes/chooseworld.tscn")

func _on_timer_timeout1():
	get_tree().change_scene("res://src/scenes/credits.tscn")
