extends Node2D

@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation.play("coins")


func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		body.add_coin()
		print("player coins: ", body.coins)
		visible = false
		$PickUpCoinSound.play()


func _on_pick_up_coin_sound_finished():
	queue_free()
