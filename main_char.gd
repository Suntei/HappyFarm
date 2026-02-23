extends CharacterBody2D

@export var speed: float = 80.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var input_direction: Vector2 = Vector2.ZERO
var last_direction: Vector2 = Vector2.DOWN
var current_anim: String = ""

func _physics_process(delta):

	input_direction = Vector2.ZERO
	
	input_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_direction.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	input_direction = input_direction.normalized()
	
	velocity = input_direction * speed
	move_and_slide()
	
	_update_animation()

func _update_animation():

	var new_anim = ""

	if input_direction != Vector2.ZERO:
		last_direction = input_direction

	# Idle
	if input_direction == Vector2.ZERO:
		if abs(last_direction.x) > abs(last_direction.y):
			new_anim = "Idle"
		else:
			if last_direction.y > 0:
				new_anim = "face down"
			else:
				new_anim = "face up"
	else:
		if abs(input_direction.x) > abs(input_direction.y):
			new_anim = "left-right"
			sprite.flip_h = input_direction.x < 0
		else:
			sprite.flip_h = false
			if input_direction.y > 0:
				new_anim = "face down"
			else:
				new_anim = "face up"

	if new_anim != current_anim:
		sprite.play(new_anim)
		current_anim = new_anim
