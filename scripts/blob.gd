extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@export var SPEED = -100.0
@export var JUMP_VELOCITY = -400.0

var facing_right = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	if !$RayCast2D.is_colliding() && is_on_floor():
		flip()
	velocity.x = SPEED
	animation.play("blob_anim")

	move_and_slide()

func flip():
	facing_right = !facing_right
	
	scale.x = scale.x * -1
	
	if facing_right:
		SPEED = abs(SPEED)
	else:
		SPEED = abs(SPEED) * -1


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.die()
