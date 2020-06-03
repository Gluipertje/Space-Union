extends Button

onready var fadeout = preload("res://src/misc/FadeOut.tscn")

func _on_Button_pressed() -> void:
	var fadeouti = fadeout.instance()
	fadeouti.set_name('fadeouti')
	add_child(fadeouti)
	var timer = Timer.new()
	timer.connect("timeout",self,"_on_timer_timeout") 
	add_child(timer)
	timer.set_wait_time(2.0)
	timer.start() 
	

func _on_timer_timeout():
	get_tree().change_scene("res://src/scenes/menu.tscn")
