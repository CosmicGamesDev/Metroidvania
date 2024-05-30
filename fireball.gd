extends Sprite2D

@onready var animation_player = $AnimationPlayer
var direction = Vector2.ZERO
@export var is_moving = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_moving:
		position += direction * 2


func _on_timer_timeout():
	animation_player.play("burnout")


func _on_hitbox_body_entered(body):
	if body.is_in_group("terrain"):
		animation_player.play("burnout")
