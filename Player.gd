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
	move_and_slide()



func _on_hurtbox_area_entered(area):
	if area.is_in_group("enemy_hitbox"):
		current_hp -= area.damage
		emit_signal("hp_changed", -area.damage)


