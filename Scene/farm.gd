extends Node2D

func _ready():
	print("Entered Farm 🌾")

	var player = get_node_or_null("Mc")
	var enter = get_node_or_null("EnterArea")

	if player and enter:
		player.global_position = enter.global_position
	else:
		print("⚠️ Missing Mc or EnterArea in Farm")
