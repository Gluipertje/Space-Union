extends KinematicBody2D

var _mousepoint
var _vector = Vector2(0,0)
var _shipSpeed
var _prevSpeed = 5000

var collidername

onready var fadeout = preload("res://src/misc/FadeOut.tscn")

func _physics_process(delta: float) -> void:
	_mousepoint = get_global_mouse_position()
	if Input.is_action_pressed("lclick"):
		_vector = (_mousepoint - get_position()).normalized()
		
	if Input.is_action_pressed("sprint") and Input.is_action_pressed("lclick"):
		_shipSpeed = 10000
	else:
		_shipSpeed = _prevSpeed
	
	if !Input.is_action_pressed("sprint") and Input.is_action_pressed("lclick"):
		_shipSpeed = 5000
		
	move_and_slide(_vector * _shipSpeed * delta)
	_prevSpeed = _shipSpeed
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print(collision.collider.name)
		if collision.collider.name == 'Station':
			var fadeouti = fadeout.instance()
			fadeouti.set_name('fadeouti')
			add_child(fadeouti)
			var timer1 = Timer.new()
			timer1.connect("timeout",self,"_on_timer_timeout1") 
			add_child(timer1)
			timer1.set_wait_time(2.0)
			timer1.start() 
			return
		if collision.collider.name == 'sun':
			return
		collidername = collision.collider.name
		global.wantedWorld = global.worlds[int(collision.collider.name)]
		var fadeouti = fadeout.instance()
		fadeouti.set_name('fadeouti')
		add_child(fadeouti)
		var timer = Timer.new()
		timer.connect("timeout",self,"_on_timer_timeout") 
		add_child(timer)
		timer.set_wait_time(2.0)
		timer.start() 
	
	if get_position() != _mousepoint:
		look_at(_mousepoint)
	
func _on_timer_timeout():
	print('Switching to world ' + str(global.worlds[int(collidername)]))
	var newScene = "res://src/scenes/" + 'world' + global.worlds[int(collidername)][1] + '.tscn'
	get_tree().change_scene(newScene)

func _on_timer_timeout1():
	global.wantedWorld = [0, 0, 0, 0, 0, Vector2(get_position())]
	get_tree().change_scene('res://src/scenes/stationInside.tscn')
