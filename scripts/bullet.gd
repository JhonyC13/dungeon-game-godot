extends Node2D

var direction
var speed := 2

func _ready():
	look_at(get_global_mouse_position())
	direction = (get_global_mouse_position() - global_position)
	

func _process(delta):
	translate(direction * speed * delta)

func _on_exit_screen_notifier_screen_exited():
	queue_free()
