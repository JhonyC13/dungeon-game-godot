extends CharacterBody2D

@onready var anim = $anim
@onready var arms = $anim/arms
@onready var player_arms = $anim/arms/player_arms

var move_speed := 230.0
var acceleration := 0.3
var friction := 0.25

func _process(delta):
	move()
	arms.look_at(get_global_mouse_position())
	var direction = (get_global_mouse_position() - arms.global_position)
	if direction.x >= 0:
		arms.scale.y = 0.2
	else:
		arms.scale.y = -0.2
	

func move():
	var direction := Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if direction != Vector2.ZERO:
		velocity.x = lerp(velocity.x, direction.normalized().x * move_speed, acceleration)
		velocity.y = lerp(velocity.y, direction.normalized().y * move_speed, acceleration)
		anim.play("walking")
	else: 
		velocity.x = lerp(velocity.x, direction.normalized().x * move_speed, friction)
		velocity.y = lerp(velocity.y, direction.normalized().y * move_speed, friction)
		anim.play("idle")
	
	move_and_slide()


#funcao para rotacionar os braços. Muito parecida com a funcao look_at() da prórpia godot, mas aqui é possível definir a velocidade de rotação
func rotate_arms(self_object, target_global_posiiton: Vector2, armsRotationSpeed, delta):
	var direction = (target_global_posiiton - self_object.global_position)
	var angleTo = self_object.transform.x.angle_to(direction)
	self_object.rotate(sign(angleTo) * min(delta * armsRotationSpeed, abs(angleTo)))
	
	if direction.x >= 0:
		arms.scale.x = 0.2
	else:
		arms.scale.x = -0.2
