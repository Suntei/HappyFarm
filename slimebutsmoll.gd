extends CharacterBody2D

@export var speed: float = 50.0
@export var roam_time_min: float = 1.5
@export var roam_time_max: float = 3.5

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var direction: Vector2 = Vector2.ZERO
var timer: float = 0.0

func _ready():
	randomize()
	_set_new_direction()

func _physics_process(delta):
	timer -= delta

	if timer <= 0 or is_on_wall():
		_set_new_direction()

	velocity = direction * speed
	move_and_slide()

	# 🔒 FORCE the sprite to face movement direction
	if abs(direction.x) > 0.1:
		sprite.scale.x = abs(sprite.scale.x) * sign(direction.x)

func _set_new_direction():
	timer = randf_range(roam_time_min, roam_time_max)

	# Pick a random movement direction
	var angle = randf_range(0, TAU)
	direction = Vector2(cos(angle), sin(angle)).normalized()
