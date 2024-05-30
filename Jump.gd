
extends State
class_name PlayerJump

@export var player : CharacterBody2D
@export var move_speed := 10.0
var can_double_jump := true

var state_machine = null

func Enter():
	player.animation_player.play("jump")

func Exit():
	can_double_jump = true

func Update(_delta):
	pass

func Physics_Update(delta):
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
		var input_direction_x: float = (
			Input.get_action_strength("move_right")
			- Input.get_action_strength("move_left")
		)
		player.velocity.x = player.SPEED * input_direction_x
		if Input.is_action_just_pressed("move_up") and can_double_jump:
			player.animation_player.play("double_jump")
			player.velocity.y = player.JUMP_VELOCITY
	else:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			Transitioned.emit(self, "running")
		else:
			Transitioned.emit(self, "idle")
	
	if player.velocity == Vector2.ZERO:
		Transitioned.emit(self, "idle")
