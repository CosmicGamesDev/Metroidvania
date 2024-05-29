extends Node2D
@onready var fire_point = $FirePoint

var fire_scene = preload("res://fireball.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("fire"):
		var fire_ball = fire_scene.instantiate()
		get_tree().root.add_child(fire_ball)
		fire_ball.global_position = fire_point.global_position
		fire_ball.direction = global_position.direction_to(get_global_mouse_position())
