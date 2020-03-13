extends actor
var _direction
var _thisPos 
var _speednew
var _playerPos
var _jumpCount = 0 # This portion declares all 'private' variables which cant be accessed by other scripts

onready var GUI = get_node("Control")
onready var camera = get_node( "Camera2D" )
onready var FPSText = get_node("Camera2D/Control/FPSText")
onready var jetpackParticle = get_node( "Particles2D") # This portion gets some other nodes which are attached to the player
 
var stamina: = 500.0
var JPFuel = 500.0
export var staminaDepletion: = 100.0
export var staminaRegeneration: = 50.0
export var maxStamina = 500.0
export var maxJPFuel = 500.0
export var JPDepletion = 5.0
export var JPRegeneration = 2.0 # This portion declares some variables specific to only the player such as stamina, etc.

signal player_stats_changed # Creates a signal so when the player stats change, the GUI elements get updated

func _ready():
	emit_signal("player_stats_changed", self) # Says 'Hey, the stats of the player have changed' to us in the GUI
	jetpackParticle.set_one_shot(true) # Makes it so the particles dont constantly emit but only in bursts

func _physics_process(delta):
	_velocity = move(_velocity, _direction)
	_velocity = move_and_slide(_velocity, Vector2.UP) # Applies the velocity every frame
	checkWorldEnd()
	FPSText.text = ('FPS: ' + str(Engine.get_frames_per_second())) # Prints FPS
	
func move(_velocity, _direction):
	var moveRight = Input.is_action_pressed("move_right")
	var moveLeft = Input.is_action_pressed("move_left")
	var jump = Input.is_action_just_pressed("jump")
	var sprint = Input.is_action_pressed("sprint") # Checks if keys are pressed, if they are that specific variable gets set to 'true' in that specific frame
	
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
	
	
	
	if jump and _jumpCount == 0:
		_newvelocity.y = -jumpstrength
		_jumpCount += 1
	if jump and _jumpCount > 0 and JPFuel > 0:
		_newvelocity.y = -jumpstrength
		JPFuel -= JPDepletion
		emit_signal("player_stats_changed", self)
		_jumpCount += 1
		jetpackParticle.emitting = true
		
	if !jump and JPFuel < maxJPFuel and is_on_floor():
		JPFuel += JPRegeneration
		emit_signal("player_stats_changed", self)
		
	
	if is_on_floor():
		_jumpCount = 0
		
	if moveRight:
		_newvelocity.x = _speednew
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerWalk.tres'))
		get_node( "Sprite" ).set_flip_h( false )
		jetpackParticle.position = Vector2(-5.614, 11.291)
	elif moveLeft:
		_newvelocity.x = -_speednew
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerWalk.tres'))
		get_node( "Sprite" ).set_flip_h( true )
		jetpackParticle.position = Vector2(6.217, 11.291)
	else:
		_newvelocity.x = 0
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerIdle.tres'))
	
	if _velocity.y > 0:
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerFall.tres'))
	elif _velocity.y <0:
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerIdle.tres'))
	return _newvelocity
	
func checkWorldEnd():
	_playerPos = get_position()
	print(_playerPos)
	if _playerPos.x > global._realWorldSize.x:
		set_position(global.coordinateStart)
	elif _playerPos.x < global.coordinateStart.x:
		set_position(global.coordinateEnd)
