extends Control

onready var fadeout = preload("res://src/misc/FadeOut.tscn")


func _on_Button_pressed() -> void:
	print(PlayerStats.playerCredits)
	if PlayerStats.playerCredits >= 5:
		PlayerStats.playerCredits -= 5
		var fadeouti = fadeout.instance()
		fadeouti.set_name('fadeouti')
		add_child(fadeouti)
		var timer = Timer.new()
		timer.connect("timeout",self,"_on_timer_timeout1") 
		add_child(timer)
		timer.set_wait_time(2.0)
		timer.start() 
		
	else:
		print('broke ass nigga')


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
