class_name CometCamera extends Camera3D

@export var comet: Comet
@export var following_strength: float = 1.0
@export var lerp_speed = 0.5

var center: Vector3
var is_centered: bool = true


func _ready() -> void:
	center = comet.global_position


func _physics_process(delta: float) -> void:
	if is_centered:
		lerp1(delta)
		return
	lerp2(delta)


func lerp1(delta: float):
	var mid_pos: Vector3 = (comet.global_position + center) / 2.0
	var target: Vector3 = Vector3(mid_pos.x, global_position.y, mid_pos.z)
	global_position = lerp(global_position, target, lerp_speed * delta)


func lerp2(delta: float):
	var mid_pos: Vector3 = (comet.global_position + comet.current_target.global_position) / 2.0
	var target: Vector3 = Vector3(mid_pos.x, global_position.y, mid_pos.z)
	global_position = lerp(global_position, target, lerp_speed * delta)
