extends Node2D

@export var speed = 350.0
var  current_speed = 0.0

func _ready():
	visible = false
	$Sprite2D.scale.y = scale.y * -1 

func _physics_process(delta):
	position.y += current_speed * delta

		
func fall():
	current_speed = speed


func _on_kill_area_body_entered(body):
	if body.is_in_group("player"):
		body.die()
		queue_free()


func _on_detect_area_body_entered(body):
	if body.is_in_group("player"):
		visible = true
		fall()
