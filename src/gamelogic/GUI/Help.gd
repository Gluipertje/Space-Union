extends TextureButton

onready var panel = get_node("ColorRect")
var panelSee = false

func _on_TextureButton_pressed() -> void:
	if !panelSee:
		panel.set_visible(true)
		panelSee = true
	elif panelSee:
		panel.set_visible(false)
		panelSee = false
