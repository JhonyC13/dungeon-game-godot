extends Node2D

var gun_scene: PackedScene =  preload("res://guns/test_gun/test_gun.tscn")

func _ready():
	var gun_instance = gun_scene.instantiate()
	gun_instance.position = get_gun_instatiate_position()
	add_child(gun_instance)

func get_gun_instatiate_position():
	return $gun_instantiate_position.position
