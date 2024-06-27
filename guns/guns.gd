extends Node2D
class_name GunsClass

var aim_mouse_cursor = preload("res://assets/mouse_cursor_aim.png")
var shoot_mouse_cursor = preload("res://assets/mouse_cursor_shooting.png")

@export var bullet_scene: PackedScene
@export var bullet_spawn_position: Marker2D
@export var timer: Timer
@export var delay_shoot_timer: Timer

var is_shooting := false
var is_first_bullet := true

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	delay_shoot_timer.timeout.connect(_on_delay_timer_timeout)
	delay_shoot_timer.one_shot = true

func _process(delta):
	if is_shooting:
		Input.set_custom_mouse_cursor(shoot_mouse_cursor, 0, Vector2(9, 9))
	else:
		Input.set_custom_mouse_cursor(aim_mouse_cursor, 0, Vector2(9, 9))
	
	if Input.is_action_just_pressed("click") and is_first_bullet and delay_shoot_timer.is_stopped():
		shoot()
		is_first_bullet = false
		delay_shoot_timer.start()

func shoot():
	var bullet_instance = bullet_scene.instantiate()
	bullet_instance.global_position = bullet_spawn_position.global_position
	get_tree().get_root().add_child(bullet_instance)
	

func _on_timer_timeout():
	shoot()

func _on_delay_timer_timeout():
	is_first_bullet = true

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		is_shooting = true
		timer.start()
	if event.is_action_released("click"):
		is_shooting = false
		timer.stop()
