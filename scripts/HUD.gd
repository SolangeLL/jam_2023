extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Coins.global_position = get_parent().get_screen_center_position()
	$Coins.global_position.y -= 120
	$Coins.global_position.x += 170
	
	$Deaths.global_position = get_parent().get_screen_center_position()
	$Deaths.global_position.y += 75
	$Deaths.global_position.x += 132

func update_coins_text(value : int):
	$Coins/CoinText.text = str(value)

func update_death_text(value : int):
	$Deaths/DeathText.text = str(value)
	if value > 10:
		$Deaths/DeathImage.modulate = Color(255, 0, 0)
