extends Control

var _is_paused:bool = false:
	set = set_paused

func _ready():
	visible = false

func _unhandled_input(event : InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused
		global_position = get_parent().get_node("Player").get_node("Camera2D").position

func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused
	

func _on_button_resume_pressed():
	_is_paused = false


func _on_button_options_pressed():
	pass #


func _on_button_quit_pressed():
	get_tree().quit()
