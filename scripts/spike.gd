extends Node2D

func _ready():
	visible = false

func _on_area_2d_body_entered(body: Node2D):
	if body.is_in_group("player"):
		visible = true
		body.die()


func _on_death_zone_body_entered(body):
	if body.is_in_group("player"):
		body.die()
