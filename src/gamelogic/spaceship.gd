extends Area2D

var timerOn = false

onready var player = get_node('../Player')
onready var players = get_node('../Player/Sprite')
onready var playerc = get_node('../Player/Camera2D')

func _process(delta: float) -> void:
	var jump = Input.is_action_just_pressed("jump")
	if jump and global.isInShip:
		$AnimationPlayer.play("flyUp")
		$Timer.start()
		timerOn = true
		print('goin up')

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed('lclick'):
		if !timerOn:
			if global.isInShip:
				player.show()
				$Camera2D.clear_current()
				playerc.make_current()
				global.isInShip = false
			elif !global.isInShip:
				player.hide()
				playerc.clear_current()
				$Camera2D.make_current()
				global.isInShip = true


func _on_Timer_timeout() -> void:
	get_tree().change_scene('res://src/scenes/chooseworld.tscn')
