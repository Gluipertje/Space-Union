extends OptionButton



func _ready() -> void:
	add_item('1920x1080')
	add_item('1280x720')
	add_item('1280x1024')


func _on_OptionButton_item_selected(id: int) -> void:
	if get_selected_id() == 0:
		OS.set_window_size(Vector2(1920,1080))
	if get_selected_id() == 1:
		OS.set_window_size(Vector2(1280,720))
	if get_selected_id() == 2:
		OS.set_window_size(Vector2(1280,1024))
