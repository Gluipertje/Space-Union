extends TextureButton

func _ready() -> void:
	set_pressed(OS.window_fullscreen)

func _on_CheckBox_toggled(button_pressed: bool) -> void:
	OS.window_fullscreen = !OS.window_fullscreen

