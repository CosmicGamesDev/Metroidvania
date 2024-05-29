extends TileMap

@export var level : TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	var used_tiles = level.get_used_cells(1)
	set_cells_terrain_connect(0,used_tiles,0,0)
	#BetterTerrain.set_cells(self,0,used_tiles,0)
	#BetterTerrain.update_terrain_cells(self,0,used_tiles,false)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
