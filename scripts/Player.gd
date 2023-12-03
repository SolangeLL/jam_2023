extends CharacterBody2D


@export var SPEED = 100.0
@export var coins = 0
var can_move = true
var on_ground = false
const JUMP_VELOCITY = -350.0

var jump_sound : AudioStreamPlayer
var landing_sound : AudioStreamPlayer
var walk_sound : AudioStreamPlayer

var detect_type_ground : Area2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimatedSprite2D.play("idle")
	jump_sound = $SoundEffects/JumpSound
	landing_sound = $SoundEffects/LandingSound
	walk_sound = $SoundEffects/WalkSound
	detect_type_ground = $DetectTypeZone/CollisionShape2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		on_ground = false
	
	if is_on_floor() and not on_ground:
		landing_sound.play()
		on_ground = true

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		jump_sound.play()
		velocity.y = JUMP_VELOCITY

	handle_movement()

func _input(event):
	if not can_move:
		return

	if event.is_action_pressed("move_left") or event.is_action_pressed("move_right"):
		$AnimatedSprite2D.play("run")

	if event.is_action_released("move_left") or event.is_action_released("move_right"):
		$AnimatedSprite2D.play("stop")

func check_type_ground():
	if detect_type_ground.get_overlapping_areas().size() > 0:
		var overlapping_area = detect_type_ground.get_overlapping_areas()[0]
		var ground_type = overlapping_area.get_groups()
		
		if "grass" in ground_type:
			$SoundEffects/WalkSound.stream = "res://assets/sounds/footsteps_grass.ogg"
	pass

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
	can_move = true

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "stop" or $AnimatedSprite2D.animation == "jump":
		$AnimatedSprite2D.play("idle")

	if $AnimatedSprite2D.animation == "death":
		respawn()
	pass # Replace with function body.
