extends CharacterBody2D


@export var SPEED = 100.0
@export var coins = 0
var nb_deaths = 10
var can_move = true
var on_ground = true
var is_moving = false
var current_ground_type = ""
const JUMP_VELOCITY = -350.0

var jump_sound : AudioStreamPlayer
var landing_sound : AudioStreamPlayer
var walk_sound : AudioStreamPlayer
var death_sound : AudioStreamPlayer

var detect_type_ground : Area2D

var footsteps = [
	preload("res://assets/sounds/footsteps_grass.ogg"),
	preload("res://assets/sounds/footsteps_wood.ogg")
]

enum FOOTSTEPS_TYPES {GRASS, WOOD}

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$AnimatedSprite2D.play("idle")
	jump_sound = $SoundEffects/JumpSound
	landing_sound = $SoundEffects/LandingSound
	walk_sound = $SoundEffects/WalkSound
	death_sound = $SoundEffects/DeathSound
	detect_type_ground = $DetectTypeZone

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		on_ground = false
		current_ground_type = ""
		walk_sound.stop()
	
	check_is_landing()

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		$AnimatedSprite2D.play("jump")
		jump_sound.play()
		velocity.y = JUMP_VELOCITY

	handle_movement()

func check_is_landing():
	if is_on_floor():
		check_type_ground()
		if not on_ground:	
			landing_sound.play()
			on_ground = true
			if is_moving:
				walk_sound.play()
	

func check_type_ground():
	if detect_type_ground.get_overlapping_areas().size() > 0:
		var overlapping_area = detect_type_ground.get_overlapping_areas()[0]
		var ground_type = overlapping_area.get_groups()
		
		if "grass" in ground_type and current_ground_type != "grass":
			walk_sound.stream = footsteps[FOOTSTEPS_TYPES.GRASS]
			current_ground_type = "grass"
		elif "wood" in ground_type and current_ground_type != "wood":
			walk_sound.stream = footsteps[FOOTSTEPS_TYPES.WOOD]
			current_ground_type = "wood"

func handle_movement():
	if not can_move:
		return

	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		go_move()		
		velocity.x = direction * SPEED
		if velocity.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		go_stop()		
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func go_move():
	if not is_moving:
		$AnimatedSprite2D.play("run")
		walk_sound.play()
		is_moving = true

func go_stop():
	if is_moving:
		$AnimatedSprite2D.play("stop")
		walk_sound.stop()
		is_moving = false

func die():
	$AnimatedSprite2D.play("death")
	death_sound.play()
	walk_sound.stop()
	can_move = false
	nb_deaths += 1
	$Camera2D/HUD.update_death_text(nb_deaths)
	pass

func respawn():
	$AnimatedSprite2D.play("idle")
	var respawn_node = get_parent().find_child("Respawn")
	global_position = respawn_node.global_position
	can_move = true

func _on_animated_sprite_2d_animation_finished():
	if $AnimatedSprite2D.animation == "stop":
		$AnimatedSprite2D.play("idle")
	
	if $AnimatedSprite2D.animation == "jump":
		if is_moving:
			$AnimatedSprite2D.play("run")
		else:
			$AnimatedSprite2D.play("idle")

	if $AnimatedSprite2D.animation == "death":
		respawn()

func add_coin():
	coins += 1
	$Camera2D/HUD.update_coins_text(coins)
