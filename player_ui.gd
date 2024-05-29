extends Control

@export var player : CharacterBody2D
@onready var hp_bar = $CanvasLayer/HpBar

# Called when the node enters the scene tree for the first time.
func _ready():
	player.hp_changed.connect(_on_hp_changed)
	hp_bar.value = player.current_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_hp_changed(amount):
	hp_bar.value += amount
