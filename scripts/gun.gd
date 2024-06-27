extends Node2D

@export var bullet_scene: PackedScene

@onready var bullet_spawn_position = $bullet_spawn_position
@onready var timer = $Timer

func shoot():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = bullet_spawn_position.global_position
	get_tree().get_root().add_child(bullet_instance)
	

func _on_timer_timeout():
	shoot()
