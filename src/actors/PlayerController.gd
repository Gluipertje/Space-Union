extends actor
var _direction
var _thisPos 
var _speednew

onready var camera = get_node( "Camera2D" )
 
var stamina: = 100.0
export var staminaDepletion: = 5.0
export var staminaRegeneration: = 2.0
export var maxStamina = 500.0

signal player_stats_changed

func _ready():
	emit_signal("player_stats_changed", self) # Says 'Hey, the stats of the player have changed' to us in the GUI

func _physics_process(delta):
	_velocity = get_speed(_velocity, _direction)
	_velocity = move_and_slide(_velocity, Vector2.UP)
	print(Engine.get_frames_per_second())
	
func get_speed(_velocity, _direction):
	var moveRight = Input.is_action_pressed("move_right")
	var moveLeft = Input.is_action_pressed("move_left")
	var jump = Input.is_action_pressed("jump")
	var sprint = Input.is_action_pressed("sprint")
	
	if !is_on_floor():
		_newvelocity.y += gravity * get_physics_process_delta_time()
		_newvelocity.y = min(_newvelocity.y, maxfallvelocity)
		
		
	if sprint and stamina > 0 and (moveRight or moveLeft):
		_speednew = speed * sprintmultiplier
		stamina -= staminaDepletion * get_process_delta_time()
		emit_signal("player_stats_changed", self)
	else:
		_speednew = speed
		if stamina < maxStamina:
			stamina += staminaRegeneration * get_process_delta_time()
			emit_signal("player_stats_changed", self)
	
	if jump and is_on_floor():
		_newvelocity.y = -jumpstrength
	
	if moveRight:
		_newvelocity.x = _speednew
		get_node( "Sprite" ).set_flip_h( false )
	elif moveLeft:
		_newvelocity.x = -_speednew
		get_node( "Sprite" ).set_flip_h( true )
	else:
		_newvelocity.x = 0
	
	return _newvelocity
	
