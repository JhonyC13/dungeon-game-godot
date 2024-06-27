extends Node2D

@export var bullet_scene: PackedScene
@onready var bullet_spawn_position = $bullet_spawn_position
@onready var timer = $Timer

var is_shooting := false
var is_first_bullet := true

func shoot():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = bullet_spawn_position.global_position
	get_tree().get_root().add_child(bullet_instance)
	

func _on_timer_timeout():
	shoot()

func _unhandled_input(event):
	if event.is_action_pressed("click") and is_first_bullet:
		is_shooting = true
		if is_first_bullet:
			shoot()
			is_first_bullet = false
		timer.start()
		
	if event.is_action_released("click"):
		is_shooting = false
		get_tree().get_first_node_in_group("guns").timer.stop()
		if !is_first_bullet:
			is_first_bullet = true
