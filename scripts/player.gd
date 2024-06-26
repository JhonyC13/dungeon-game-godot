extends CharacterBody2D

@onready var arms = $texture/arms
@onready var player_arms = $texture/arms/player_arms

var aim_mouse_cursor = preload("res://assets/mouse_cursor_aim.png")
var shoot_mouse_cursor = preload("res://assets/mouse_cursor_shooting.png")

var is_shooting := false

func _process(delta):
	#rotate_arms(arms, get_global_mouse_position(), 250.0, delta)
	arms.look_at(get_global_mouse_position())
	var direction = (get_global_mouse_position() - arms.global_position)
	if direction.x >= 0:
		arms.scale.y = 0.2
	else:
		arms.scale.y = -0.2
	
	if is_shooting:
		Input.set_custom_mouse_cursor(shoot_mouse_cursor, 0, Vector2(9, 9))
	else:
		Input.set_custom_mouse_cursor(aim_mouse_cursor, 0, Vector2(9, 9))


func _unhandled_input(event):
	if event.is_action_pressed("click"):
		is_shooting = true
	if event.is_action_released("click"):
		is_shooting = false
	
#funcao para rotacionar os braços. Muito parecida com a funcao look_at() da prórpia godot, mas aqui é possível definir a velocidade de rotação
func rotate_arms(self_object, target_global_posiiton: Vector2, armsRotationSpeed, delta):
	var direction = (target_global_posiiton - self_object.global_position)
	var angleTo = self_object.transform.x.angle_to(direction)
	self_object.rotate(sign(angleTo) * min(delta * armsRotationSpeed, abs(angleTo)))
	
	if direction.x >= 0:
		arms.scale.x = 0.2
	else:
		arms.scale.x = -0.2
