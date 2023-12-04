extends CanvasLayer

var current_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Coins.global_position =   get_parent().get_screen_center_position()
	$Coins.global_position.y -= 120
	$Coins.global_position.x += 170
	
	$Deaths.global_position = get_parent().get_screen_center_position()
	$Deaths.global_position.y += 75
	$Deaths.global_position.x += 132
	
	$Timer.global_position = get_parent().get_screen_center_position()
	$Timer.global_position.y -= 102
	$Timer.global_position.x -= 187

func update_coins_text(value : int):
	$Coins/CoinText.text = str(value)

func update_death_text(value : int):
	$Deaths/DeathText.text = str(value)
	if value > 50:
		$Deaths/DeathImage.modulate = Color(255, 0, 0)
	elif value > 100:
		$Deaths/DeathImage.modulate = Color(255,255,0)


func _on_second_timer_timeout():
	current_time += 1
	$Timer/Label.text = "%02d:%02d" % [current_time / 60, current_time  % 60]
	pass
