extends Area2D

var is_reached = true

func activate_checkpoint():
	is_reached = false
	print("point activé test")

func desactivate_checkpoint():
	is_reached = true

func _on_body_entered(body : Node):
	if body.is_in_group("player") and not is_reached:
		is_reached = true;
		$ReachCheckpointSound.play()
		get_parent().get_parent().get_node("Respawn").global_position = global_position
