extends State
class_name PlayerRunning

@export var player : CharacterBody2D

var state_machine = null

func Enter():
	player.animation_player.play("run")


func Update(_delta):
	pass

func Physics_Update(delta):
	if not player.is_on_floor():
		Transitioned.emit(self, "Jump")
		return
	
	var input_direction_x: float = (
			Input.get_action_strength("move_right")
			- Input.get_action_strength("move_left")
		)
	player.velocity.x = player.SPEED * input_direction_x
	if Input.is_action_just_pressed("move_up") && player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY
		Transitioned.emit(self, "jump")
	if player.velocity == Vector2.ZERO:
		Transitioned.emit(self, "idle")
