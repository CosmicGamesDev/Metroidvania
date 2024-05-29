
extends State
class_name PlayerJump

@export var player : CharacterBody2D
@export var move_speed := 10.0


var state_machine = null

func Enter():
	player.animation_player.play("jump")


func Update(_delta):
	pass

func Physics_Update(delta):
	if not player.is_on_floor():
		player.velocity.y += player.gravity * delta
	else:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			Transitioned.emit(self, "running")
		else:
			Transitioned.emit(self, "idle")
	
	if player.velocity == Vector2.ZERO:
		Transitioned.emit(self, "idle")
