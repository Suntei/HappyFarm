extends CharacterBody2D

@export var speed = 200
@onready var sprite = $AnimatedSprite2D

func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")

	velocity = direction * speed
	move_and_slide()

	if direction.length() == 0:
		sprite.stop()
		sprite.frame = 0
	else:
		sprite.play("default")
		# Flip only when moving RIGHT
		sprite.flip_h = direction.x > 0
