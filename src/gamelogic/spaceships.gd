extends KinematicBody2D

var _mousepoint
var _vector

func _physics_process(delta: float) -> void:
	_mousepoint = get_global_mouse_position()
	_vector = (_mousepoint - get_position()).normalized()
	move_and_slide(_vector * 1000 * delta)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print(collision.collider.name)
		#global.wantedWorld = global.worlds[collision.collider.name[-1]]
		#print('Switching to world ' + str(global.worlds[collision.collider.name]))
		#var newScene = "res://src/scenes/" + 'world' + global.worlds[collision.collider.name][1] + '.tscn'
		#get_tree().change_scene(newScene)
	look_at(_mousepoint)
