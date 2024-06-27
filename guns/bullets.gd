extends Node2D
class_name BulletsClass

@export var exit_scrren_notifier: VisibleOnScreenNotifier2D
@export var speed := 1500.0

var direction


func _ready():
	exit_scrren_notifier.screen_exited.connect(_on_exit_screen_notifier_screen_exited)
	direction = (get_global_mouse_position() - get_tree().get_first_node_in_group("arms").global_position).normalized()
	look_at(get_global_mouse_position())

func _process(delta):
	translate(direction * speed * delta)

func _on_exit_screen_notifier_screen_exited():
	queue_free()

