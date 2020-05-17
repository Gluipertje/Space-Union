extends Area2D

onready var panel = get_node("Node2D/Panel")
var panelSee = false

func _ready() -> void:
	panel.set_visible(false)

func _input_event(viewport, event, shape_idx):
	if event.is_action_pressed('lclick'):
		if !panelSee:
			panel.set_visible(true)
			panelSee = true
		elif panelSee:
			panel.set_visible(false)
			panelSee = false

func _process(delta: float) -> void:
	if global.playerPos.x - get_position().x < 0:
		$Sprite.set_flip_h(true)
		panel.set_position(Vector2(18, -50))
	if global.playerPos.x - get_position().x > 0:
		$Sprite.set_flip_h(false)
		panel.set_position(Vector2(-105, -50))

