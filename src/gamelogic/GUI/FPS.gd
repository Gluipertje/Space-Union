extends TextureButton

func _ready() -> void:
	set_pressed(global.showFPS)

func _on_FPS_pressed() -> void:
	global.showFPS = !global.showFPS
