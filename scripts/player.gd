extends CharacterBody2D

@onready var arms = $texture/arms
@onready var player_arms = $texture/arms/player_arms


func _process(delta):
	#rotate_arms(arms, get_global_mouse_position(), 250.0, delta)
	arms.look_at(get_global_mouse_position())
	var direction = (get_global_mouse_position() - arms.global_position)
	if direction.x >= 0:
		arms.scale.y = 0.2
	else:
		arms.scale.y = -0.2
	
	
	

#funcao para rotacionar os braços. Muito parecida com a funcao look_at() da prórpia godot, mas aqui é possível definir a velocidade de rotação
func rotate_arms(self_object, target_global_posiiton: Vector2, armsRotationSpeed, delta):
	var direction = (target_global_posiiton - self_object.global_position)
	var angleTo = self_object.transform.x.angle_to(direction)
	self_object.rotate(sign(angleTo) * min(delta * armsRotationSpeed, abs(angleTo)))
	
	if direction.x >= 0:
		arms.scale.x = 0.2
	else:
		arms.scale.x = -0.2
