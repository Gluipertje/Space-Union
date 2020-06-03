extends LineEdit

var validNumber = true
var numbers = ['0', '2', '3', '4', '5', '6', '7', '8', '9', '1']

func _on_LineEdit_text_changed(new_text: String) -> void:
	
	for i in new_text.length():
		if !(new_text[i] in numbers):
			validNumber = false
			return
	
	if validNumber:
		if int(new_text) > 0:
			global.maxWorldSize = int(new_text)
