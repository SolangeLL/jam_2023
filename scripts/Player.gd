extends CharacterBody2D


@export var SPEED = 100.0 
<<<<<<< HEAD
const JUMP_VELOCITY = -400.0
var can_move = true
=======
@export var coins = 0
const JUMP_VELOCITY = -350.0
>>>>>>> 70e5c9b0de90d2fd4dc438ec0dda6967042d89a3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
<<<<<<< HEAD
	$AnimatedSprite2D.play("idle")
=======
	$AnimatedSprite2D.play("walk")
>>>>>>> 70e5c9b0de90d2fd4dc438ec0dda6967042d89a3

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		$AnimatedSprite2D.play("jump")
		velocity.y = JUMP_VELOCITY

	handle_movement()

func _input(event):
	if not can_move:
		return

	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		$AnimatedSprite2D.play("run")

	if event.is_action_released("move_left") or event.is_action_released("move_right"):
		$AnimatedSprite2D.play("stop")

func handle_movement():
	if not can_move:
		return

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func die():
	$AnimatedSprite2D.play("death")
	can_move = false
	pass

func respawn():
	$AnimatedSprite2D.play("idle")
	var respawn = get_parent().find_child("Respawn")
	global_position = respawn.global_position
<<<<<<< HEAD
	can_move = true

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "stop" or $AnimatedSprite2D.animation == "jump":
		$AnimatedSprite2D.play("idle")
	
	if $AnimatedSprite2D.animation == "death":
		respawn()
	pass # Replace with function body.
=======
	pass
	
>>>>>>> 70e5c9b0de90d2fd4dc438ec0dda6967042d89a3
