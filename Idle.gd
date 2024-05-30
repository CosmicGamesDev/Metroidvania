extends State
class_name PlayerIdle

@export var player : CharacterBody2D
@export var move_speed := 10.0


var state_machine = null

func Enter():
	player.animation_player.play("idle")


func Update(_delta):
	pass

func Physics_Update(_delta):
	if not player.is_on_floor():
		Transitioned.emit(self, "Jump")
		return
	if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		Transitioned.emit(self, "Running")
	if Input.is_action_just_pressed("move_up") && player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY
		Transitioned.emit(self, "jump")
