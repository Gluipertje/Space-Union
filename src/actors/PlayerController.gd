extends actor
var _direction
var _thisPos 

onready var camera = get_node( "Camera2D" )

func _physics_process(delta):
	_velocity = get_speed(_velocity, _direction)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
func get_speed(_velocity, _direction):
	var moveRight = Input.is_action_pressed("move_right")
	var moveLeft = Input.is_action_pressed("move_left")
	var jump = Input.is_action_pressed("jump")
	
	if !is_on_floor():
		_newvelocity.y += gravity * get_physics_process_delta_time()
		_newvelocity.y = min(_newvelocity.y, maxfallvelocity)
		print (_newvelocity.y)
	
	if jump and is_on_floor():
		_newvelocity.y = -jumpstrength
	
	if moveRight:
		_newvelocity.x = speed
		get_node( "Sprite" ).set_flip_h( false )
	elif moveLeft:
		_newvelocity.x = -speed
		get_node( "Sprite" ).set_flip_h( true )
	else:
		_newvelocity.x = 0
	
	return _newvelocity
	
