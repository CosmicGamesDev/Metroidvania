extends State
class_name PlayerJump

@onready var fire_jump_timer = $FireJumpTimer
@onready var fire_direction = $FireRotation/FireDirection
@onready var fire_rotation = $FireRotation

@export var player : CharacterBody2D
@export var move_speed := 10.0
var can_double_jump := true
var can_fire_jump := true
var state_machine = null

func Enter():
	player.animation_player.play("jump")

func Exit():
	can_double_jump = true
	can_fire_jump = true
	fire_direction.visible = false
	fire_jump_timer.stop()
	fire_jump_timer.wait_time = 1

func Update(_delta):
	pass

#func _input(event):
	#if event is InputEventMouse:
		#fire_rotation.look_at(get_global_mouse_position())
	#else:
		#var right_stick_direction = Input.get_vector("jump_fire_left","jump_fire_right","jump_fire_up","jump_fire_down")
		#look_at(global_position + right_stick_direction)

func Physics_Update(delta):
	var right_stick_direction = Input.get_vector("jump_fire_left","jump_fire_right","jump_fire_up","jump_fire_down")
	look_at(global_position + right_stick_direction)
	if not player.is_on_floor():
		if fire_jump_timer.is_stopped():
			player.velocity.y += player.gravity * delta
			var input_direction_x: float = (
				Input.get_action_strength("move_right")
				- Input.get_action_strength("move_left")
			)
			player.velocity.x = player.SPEED * input_direction_x
		fire_dash()
		fire_stall(delta)
		double_jump()
	else:
		if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			Transitioned.emit(self, "running")
		else:
			Transitioned.emit(self, "idle")


func double_jump():
	if Input.is_action_just_pressed("move_up") and can_double_jump:
		can_double_jump = false
		player.animation_player.play("double_jump")
		player.velocity.y = player.JUMP_VELOCITY

func fire_stall(delta):
	if Input.is_action_just_pressed("move_up") and !can_double_jump and fire_jump_timer.is_stopped() and can_fire_jump:
		var input_direction = Input.get_vector("jump_fire_left","jump_fire_right","jump_fire_up","jump_fire_down")
		player.velocity = player.SPEED/4 * input_direction
		fire_jump_timer.start()
		fire_direction.visible = true

func fire_dash():
	if Input.is_action_just_pressed("move_up") and !fire_jump_timer.is_stopped() and can_fire_jump:
		can_fire_jump = false
		player.animation_player.play("double_jump")
		var input_direction = Input.get_vector("jump_fire_left","jump_fire_right","jump_fire_up","jump_fire_down")
		player.velocity= player.SPEED * 2 * input_direction
		fire_direction.visible = false
		fire_jump_timer.stop()
		fire_jump_timer.wait_time = 1


func _on_fire_jump_timer_timeout():
	can_fire_jump = false
	player.animation_player.play("double_jump")
	var input_direction = Input.get_vector("jump_fire_left","jump_fire_right","jump_fire_up","jump_fire_down")
	player.velocity= player.SPEED * 2 * input_direction
	fire_direction.visible = false
	fire_jump_timer.stop()
	fire_jump_timer.wait_time = 1
