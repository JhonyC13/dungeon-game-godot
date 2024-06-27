extends Node2D

var direction
var speed := 2000.0

func _ready():
	direction = (get_global_mouse_position() - get_tree().get_first_node_in_group("arms").global_position).normalized()
	look_at(get_global_mouse_position())

func _process(delta):
	translate(direction * speed * delta)

func _on_exit_screen_notifier_screen_exited():
	queue_free()
