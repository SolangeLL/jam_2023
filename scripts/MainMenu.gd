extends Control

func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://scenes/game_scenes/world.tscn")

func _on_button_options_pressed():
	pass # Replace with function body.

func _on_button_quit_pressed():
	get_tree().quit()
