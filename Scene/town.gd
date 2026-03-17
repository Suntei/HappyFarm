extends Node2D

@export var forest_scene_path: String = "res://Scene/forest.tscn"
@export var farm_scene_path: String = "res://Scene/farm.tscn"

@onready var player = find_child("Mc", true, false)
@onready var enter_area = find_child("EnterArea", true, false)

func _ready():
	print("Entered Town 🏘️")

	if player and enter_area:
		player.global_position = enter_area.global_position
	else:
		print("⚠️ Missing Mc or EnterArea")

# 🌲 EXIT TO FOREST
func _on_exit_to_forest_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("Going to forest 🌲")
		call_deferred("_go_to_forest")

func _go_to_forest():
	get_tree().change_scene_to_file(forest_scene_path)

# 🌾 EXIT TO FARM
func _on_exit_to_farm_body_entered(body: Node2D) -> void:
	print("Entered ExitToFarm:", body.name)

	if body.is_in_group("player") or body.name == "Mc":
		print("Going to farm 🌾")
		call_deferred("_go_to_farm")

func _go_to_farm():
	get_tree().change_scene_to_file("res://Scene/farm.tscn")
