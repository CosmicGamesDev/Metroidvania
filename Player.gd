extends CharacterBody2D

@export var base_hp = 100
var current_hp = base_hp

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
signal hp_changed(amount)

@export var character_sprite : Sprite2D
@export var animation_player : AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	if velocity.x < 0: 
		character_sprite.flip_h = true
	else:
		character_sprite.flip_h = false

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)


	move_and_slide()


func _on_hurtbox_area_entered(area):
	if area.is_in_group("enemy_hitbox"):
		current_hp -= area.damage
		emit_signal("hp_changed", -area.damage)
