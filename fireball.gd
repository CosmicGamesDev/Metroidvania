extends Sprite2D

@onready var animation_player = $AnimationPlayer
var direction = Vector2.ZERO
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * 2


func _on_timer_timeout():
	animation_player.play("burnout")
