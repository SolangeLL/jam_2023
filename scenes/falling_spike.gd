extends Node2D

@export var speed = 160.0
var  current_speed = 0.0

func _ready():
	visible = false
	scale.y = scale.y * -1 

func _physics_process(delta):
	position.y += current_speed * delta

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		area.get_parent().die()

func _on_area_2d_2_area_entered(area):
	if area.get_parent() is Player:
		visible = true
		fall()
		
		
func fall():
	current_speed = speed
