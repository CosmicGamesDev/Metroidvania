extends ColorRect

@export var player : Node2D
@export var map : TileMap

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = player.global_position/4 - Vector2(2,2)
	map.position = -position/4
