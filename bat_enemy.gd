extends Sprite2D

var rest_locations : Array[Vector2]
var target : Vector2
var has_target = false
var speed = 120
@onready var animation_player = $AnimationPlayer
var hp = 10



func _on_detect_area_area_entered(area):
	if area.get_parent().is_in_group("player") && !has_target:
		animation_player.play("flying")
		target = area.global_position
		has_target = true
		var target_distance = global_position.distance_to(target)
		var distance_between_third = (target - global_position)/3
		var tween = get_tree().create_tween()
		tween.tween_property(self, "global_position", global_position + distance_between_third + Vector2(0,-32), target_distance/speed)
		tween.tween_property(self, "global_position", global_position + distance_between_third * 2 + Vector2(0,32), target_distance/speed)
		tween.chain().tween_property(self, "global_position", target + Vector2(0,-32), target_distance/speed)
		tween.tween_callback(find_rest_position)

func find_rest_position():
	animation_player.play("rest")
	has_target = false
	#target = Vector2.ZERO


func _on_hurtbox_area_entered(area):
	if area.is_in_group("player_damage"):
		hp -= area.damage
		if hp <= 0:
			queue_free()
