extends actor
var canExo
var _direction
var _thisPos 
var _speednew
var _playerPos
var _jumpCount = 0 #Private variables

onready var camera = get_node("Camera2D")
onready var FPSText = get_node("CanvasLayer/a/FPSText")
onready var StoneText = get_node("CanvasLayer/a/StoneText")
onready var Credits = get_node("CanvasLayer/a/Credits")
onready var planetName = get_node("CanvasLayer/a/ColorRect2/planetName") #Nodes
 
var normalJumpStrength = 180
var jetJumpStrenth = 150
var JPFuel = 500.0
var maxJPFuel = 500.0
var JPDepletion = 3.0
var JPSprintDepletion = 1.5
var JPRegeneration = 1.0 #Stats

signal player_stats_changed # Creates a signal so when the player stats change, the GUI elements get updated

func _ready():
	emit_signal("player_stats_changed", self) # Says 'Hey, the stats of the player have changed' to us in the GUI
	planetName.text = (global.wantedWorld[0])
	FPSText.text = ''

func _physics_process(delta):
	if !global.isInShip:
		_velocity = move(_velocity, _direction)
		_velocity = move_and_slide(_velocity, Vector2.UP) # Applies the velocity every frame
	checkWorldEnd()
	doZoom()
	if global.showFPS:
		FPSText.text = ('FPS: ' + str(Engine.get_frames_per_second())) # Prints FPS
	StoneText.text = ('Stone: ' + str(PlayerStats.playerInventoryStone))
	Credits.text = ('Credits: ' + str(PlayerStats.playerCredits))
	if Input.is_action_just_pressed("posDebug"):
		print(get_position())
	global.playerPos = get_position()
	
func move(_velocity, _direction):
	var moveRight = Input.is_action_pressed("move_right")
	var moveLeft = Input.is_action_pressed("move_left")
	var jump = Input.is_action_just_pressed("jump")
	var sprint = Input.is_action_pressed("sprint") # Checks if keys are pressed, if they are that specific variable gets set to 'true' in that specific frame
	
	if JPFuel >= maxJPFuel:
		canExo = true
		emit_signal("player_stats_changed", self)
	
	if is_on_floor():
		_jumpCount = 0
		_newvelocity.y = 0
	
	if !is_on_floor() and _velocity.y < maxfallvelocity:
		_newvelocity.y += gravity * get_physics_process_delta_time()
		
	if sprint and JPFuel >= 1 and (moveRight or moveLeft) and canExo:
		_speednew = speed * sprintmultiplier
		JPFuel -= JPSprintDepletion
		emit_signal("player_stats_changed", self)
	else:
		_speednew = speed
		if JPFuel < maxJPFuel and (is_on_floor() or _jumpCount < 2):
			JPFuel += JPRegeneration
			emit_signal("player_stats_changed", self)
	
	if JPFuel < 1:
		canExo = false

	if Input.is_action_just_pressed("jump") and _jumpCount == 0:
		_jumpCount += 1
		_newvelocity.y = -normalJumpStrength
	elif Input.is_action_just_pressed("jump") and JPFuel > 1 and _jumpCount >= 1:
		if canExo:
			_newvelocity.y = -normalJumpStrength
			JPFuel -= JPDepletion
			emit_signal("player_stats_changed", self)
			_jumpCount += 1
	elif Input.is_action_pressed("jump") and JPFuel > 1 and _jumpCount >= 2:
		if canExo:
			_newvelocity.y = -jetJumpStrenth
			JPFuel -= JPDepletion
			emit_signal("player_stats_changed", self)
			_jumpCount += 1
	
	if JPFuel <= maxJPFuel and (is_on_floor() or _jumpCount < 2):
		JPFuel += JPRegeneration
		emit_signal("player_stats_changed", self)
	
	if moveRight:
		_newvelocity.x = _speednew
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerWalk.tres'))
		get_node( "Sprite" ).set_flip_h( false )
		#jetpackParticle.position = Vector2(-5.614, 11.291)
	elif moveLeft:
		_newvelocity.x = -_speednew
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerWalk.tres'))
		get_node( "Sprite" ).set_flip_h( true )
		#jetpackParticle.position = Vector2(6.217, 11.291)
	else:
		_newvelocity.x = 0
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerIdle.tres'))
	
	if _velocity.y > 0:
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerFall.tres'))
	elif _velocity.y <0:
		get_node( "Sprite" ).set_texture(load('res://src/actors/Animations/playerIdle.tres'))
	print(canExo)
	print(JPFuel)
	return _newvelocity
	
func checkWorldEnd():
	_playerPos = get_position()
	if _playerPos.x > global._realWorldSize.x:
		set_position(Vector2(global.coordinateStart.x + 32, global.terrainArray[0] - 17))
		camera.set_zoom(Vector2(0.2, 0.2))
	elif _playerPos.x < global.coordinateStart.x:
		set_position(Vector2(global.coordinateEnd.x - 32, global.terrainArray[-1] - 17))
		camera.set_zoom(Vector2(0.2, 0.2))
		
func doZoom():
	var relHeight = global.minYvalue - get_position().y
	if relHeight > 128 and 0.2 * (relHeight /500) >= 0.2 and 0.2 * (relHeight /500) <= 0.5:
		camera.set_zoom(Vector2(0.2 * (relHeight /500), 0.2 * (relHeight / 500)))
	elif camera.get_zoom().x < 0.2:
		camera.set_zoom(Vector2(0.2, 0.2))
