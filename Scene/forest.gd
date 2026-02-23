extends Node2D

@export var mob_scenes: Array[PackedScene]
@export var max_mobs: int = 5
@export var respawn_time: float = 600.0

@onready var spawn_area: CollisionShape2D = $SpawnArea/CollisionShape2D
@onready var mob_container: Node2D = $Mobs

func _ready():
	randomize()
	_spawn_mobs()
	_start_respawn_cycle()

func _spawn_mobs():
	var rect: RectangleShape2D = spawn_area.shape as RectangleShape2D
	if rect == null:
		push_error("SpawnArea needs RectangleShape2D!")
		return

	if mob_scenes.is_empty():
		push_error("No mob scenes assigned!")
		return

	var extents: Vector2 = rect.extents
	var center: Vector2 = spawn_area.global_position

	for i in range(max_mobs):
		var random_scene: PackedScene = mob_scenes.pick_random()
		var mob = random_scene.instantiate()

		var random_pos = Vector2(
			randf_range(-extents.x, extents.x),
			randf_range(-extents.y, extents.y)
		)

		mob.global_position = center + random_pos
		mob_container.add_child(mob)

func _despawn_all():
	for child in mob_container.get_children():
		child.queue_free()

func _start_respawn_cycle():
	while true:
		await get_tree().create_timer(respawn_time).timeout
		_despawn_all()
		_spawn_mobs()
