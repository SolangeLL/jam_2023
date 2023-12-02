extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@export var SPEED = -100.0
@export var JUMP_VELOCITY = -400.0
var moving = 0

var facing_right = false

# Get the gravity from the project settings to be synced with RigidBody nodes.


func _physics_process(delta):
	# Add the gravity.
	
	velocity.x = SPEED
	animation.play("flying_anim")
	
	moving = moving + delta
	print_debug(moving)
	if moving > 3:
		moving = 0
		flip()
	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = scale.x * -1
	
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1
