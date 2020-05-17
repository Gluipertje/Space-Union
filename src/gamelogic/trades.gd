extends Panel

onready var button = preload("res://src/gamelogic/GUI/tradeButton.tscn")
var trades = []

func _ready() -> void:
	seed(int(global.wantedWorld[2]))
	addStCrTrade()
	addCrStTrade()
	
	
func addStCrTrade():
	trades.append([(randi() % 5) + 1,(randi() % 10) + 5, 'Stone', 'Credits'])
	var buttoni = button.instance()
	buttoni.set_text(str(trades[0][0]) + ' stone for ' + str(trades[0][1]) + ' credits')
	buttoni.set_position(Vector2(5, 10))
	buttoni.set_scale(Vector2(0.3, 0.3))
	add_child(buttoni)
	buttoni.connect("pressed", self, "_on_Button_id_pressed", [0])

func addCrStTrade():
	var buttoni = button.instance()
	buttoni.set_text(str(trades[0][1]) + ' credits for ' + str(trades[0][0]) + ' stone')
	buttoni.set_position(Vector2(5, 18))
	buttoni.set_scale(Vector2(0.3, 0.3))
	add_child(buttoni)
	buttoni.connect("pressed", self, "_on_Button_id_pressed", [1])
	
	
func _on_Button_id_pressed(id):
	print('bruh')
	if id == 0:
		var trade = trades[0]
		if PlayerStats.playerInventoryStone >= trade[0]:
			PlayerStats.playerInventoryStone -= trade[0]
			PlayerStats.playerCredits += trade[1]
	if id == 1:
		var trade = trades[0]
		if PlayerStats.playerCredits >= trade[1]:
			PlayerStats.playerCredits -= trade[1]
			PlayerStats.playerInventoryStone += trade[0]

	
