extends Node2D

func _ready():
	visible = false

func _on_area_2d_area_entered(area):
	if area.get_parent() is Player:
		visible = true
		area.get_parent().die()
