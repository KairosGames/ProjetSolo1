class_name UIManager extends Control

@export var comet: Comet
@export var comet_camera: CometCamera
@export var is_centered: CheckBox
@export var game_speed: Label
@export var speeds: Array[float]
@export var speeds_txt: Array[String]

var index: int = 2


func _process(_delta: float) -> void:
	detect_input()


func detect_input():
	if Input.is_action_just_pressed("Right"):
		index += 1
		if index > speeds.size() -1:
			index = speeds.size() - 1
		set_game()
	if Input.is_action_just_pressed("Left"):
		index -= 1
		if index < 0:
			index = 0
		set_game()


func set_game():
	comet.game_speed = speeds[index]
	game_speed.text = speeds_txt[index]


func _on_check_box_toggled(toggled_on: bool) -> void:
	comet_camera.is_centered = toggled_on
