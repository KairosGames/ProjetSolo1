class_name Comet extends Node3D

@export var planets: Array[Planet]
@export var first_target: Planet
@export var mass: float = 2.0
@export var GRAV: float = 9.80665

var current_target: Planet
var targetted_index: int = 1
var applied_strength: Vector3 = Vector3.ZERO
var speed: Vector3 = Vector3.ZERO


func _ready() -> void:
	switch_target(1)

func _process(delta: float) -> void:
	get_inputs(delta)

func _physics_process(delta: float) -> void:
	var dir: Vector3 = (current_target.global_position - global_position).normalized()
	var dist: float = (global_position - current_target.global_position).length()
	applied_strength = (GRAV * (mass * current_target.mass) / (dist * dist)) * dir
	speed = speed + (applied_strength / mass) * delta
	global_position += speed * delta

func get_inputs(_delta: float):
	if Input.is_action_just_pressed("Previous"):
		targetted_index += 1
		if targetted_index > planets.size() - 1 :
			targetted_index = planets.size() -1
			return
	if Input.is_action_just_pressed("Next"):
		targetted_index -= 1
		if targetted_index < 0:
			targetted_index = 0
			return
	switch_target(targetted_index)

func switch_target(index: int) -> void:
	if planets[index] == current_target:
		return
	if current_target != null:
		current_target.mesh.get_active_material(0).emission_enabled = false
	current_target = planets[index]
	current_target.mesh.get_active_material(0).emission_enabled = true
