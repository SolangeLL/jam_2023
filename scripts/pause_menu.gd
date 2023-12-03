extends Control

@onready var main_menu = $ColorRect/GridContainer
@onready var options_menu = $Options
@onready var audio_menu = $Audio
@onready var video_menu = $Video

var _is_paused:bool = false: set = set_paused

func _ready():
	hide_all_menus()

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		_is_paused = !_is_paused
		global_position = get_parent().get_node("Player").get_node("Camera2D").global_position

func set_paused(value:bool) -> void:
	_is_paused = value
	get_tree().paused = _is_paused
	visible = _is_paused
	if _is_paused:
		main_menu.visible = true
	else:
		hide_all_menus()

func _on_button_resume_pressed():
	_is_paused = false

func _on_button_options_pressed():
	hide_all_menus()
	options_menu.visible = true

func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_back_pressed():
	hide_all_menus()
	main_menu.visible = true

func hide_all_menus():
	main_menu.visible = false
	options_menu.visible = false
	audio_menu.visible = false
	video_menu.visible = false

func _on_button_back_video_pressed():
	hide_all_menus()
	options_menu.visible = true

func _on_button_back_audio_pressed():
	hide_all_menus()
	options_menu.visible = true
	
func _on_button_video_pressed():
	hide_all_menus()
	video_menu.visible = true

func _on_button_audio_pressed():
	hide_all_menus()
	audio_menu.visible = true
	
#les video settings
func _on_full_screen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		
func _on_border_less_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_v_sync_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
#sound
func _on_master_value_changed(value):
	volume(0, value)

func _on_music_value_changed(value):
	pass #volume(buf_index, value).

func volume(bus_index, value):
	AudioServer.set_bus_volume_db(bus_index, value)
