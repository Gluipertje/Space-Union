extends Control

onready var fadeout = preload("res://src/misc/FadeOut.tscn")
onready var creditsText = get_node("Control/TextureRect2/ColorRect/credits")

func _ready() -> void:
	creditsText.text = 'Your Credits: ' + str(PlayerStats.playerCredits)
	if PlayerStats.playerCredits < 500:
		creditsText.set("custom_colors/font_color", Color(1,0,0,1))
	else:
		creditsText.set("custom_colors/font_color", Color(1,1,1,1))

func _on_Button_pressed() -> void:
	print(PlayerStats.playerCredits)
	if PlayerStats.playerCredits >= 500:
		PlayerStats.playerCredits -= 500
		$Control2.set_visible(true)
		global.startScroll = true
	else:
		return


func _on_Button2_pressed() -> void:
	get_tree().change_scene("res://src/scenes/chooseworld.tscn")
