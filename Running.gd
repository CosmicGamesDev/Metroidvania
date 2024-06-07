extends State
class_name PlayerRunning

@export var player : CharacterBody2D
var can_jump = true
@onready var coyote_timer = $CoyoteTimer


var state_machine = null

func Enter():
	player.animation_player.play("run")
	coyote_timer.stop()
	can_jump = true
	coyote_timer.wait_time = .125


func Update(_delta):
	pass

func Physics_Update(delta):
	player.velocity.y += player.gravity * delta
	if not player.is_on_floor() and can_jump and coyote_timer.is_stopped():
		coyote_timer.start()
	if not player.is_on_floor() and !can_jump:
		Transitioned.emit(self, "Jump")
		return
	
	var input_direction_x: float = (
			Input.get_action_strength("move_right")
			- Input.get_action_strength("move_left")
		)
	player.velocity.x = player.SPEED * input_direction_x
	if Input.is_action_just_pressed("move_up") && (player.is_on_floor() || can_jump):
		player.velocity.y = player.JUMP_VELOCITY
		Transitioned.emit(self, "jump")
	if player.velocity.x == 0:
		Transitioned.emit(self, "idle")


func _on_coyote_timer_timeout():
	can_jump = false
