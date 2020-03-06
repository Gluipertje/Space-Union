extends KinematicBody2D


export var speed: = 1000.0
export var gravity: = 3000.0
export var jumpstrenght: = 500.0
var _velocity: = Vector2.ZERO


func _physics_process(delta):
	var _direction
	get_speed(_velocity, _direction)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	
func get_speed(_velocity, _direction):
	_direction = Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0	
	)
	_velocity.x = speed * _direction.x
	_velocity.y += gravity * get_physics_process_delta_time()
	if _direction.y == -1.0:
		_velocity.y -= jumpstrenght
	return _velocity
