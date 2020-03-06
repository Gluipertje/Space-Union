extends actor
var _direction
var speednew

func _physics_process(delta):
	_velocity = get_speed(_velocity, _direction)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
func get_speed(_velocity, _direction):
	_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0	
	) #Determine what direction the player want to go and if he want to jump
	print (_direction)
	_velocity.y += gravity * get_physics_process_delta_time() * _direction.y #Apply gravity
	if _direction.y == -1.0:
		_velocity.y = jumpstrenght * _direction.y #Do the jump thingy
	speednew = speed #Resets the speednew to the normal speed
	if !is_on_floor():
		speednew *= 0.7 #Halves the player x speed when in the air	
	_velocity.x = speednew * _direction.x #* get_physics_process_delta_time() 
	print (_velocity)
	return _velocity
