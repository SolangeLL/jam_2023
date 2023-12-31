extends CharacterBody2D

@onready var animation = $AnimationPlayer
@onready var sprite = $Sprite2D
@export var SPEED = -2.0
@export var newspeed = -20.0
@export var JUMP_VELOCITY = -800.0

var facing_right = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		velocity.x = 0
	if !$MoveCast.is_colliding() && is_on_floor():
		flip()
	if $JumpCast.is_colliding() && is_on_floor():
		jump()
	velocity.x = newspeed
	animation.play("plante_cul")

	move_and_slide()

		
func flip():
	facing_right = !facing_right
	
	scale.x = scale.x * -1
	
	if facing_right:
		newspeed = abs(newspeed)
	else:
		newspeed = abs(newspeed) * -1

func jump():
	velocity.y = JUMP_VELOCITY


func _on_jump_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		jump()


func _on_kill_area_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.is_in_group("player"):
		body.die()
