extends TileMap

@onready var hero: Character = $Hero
@onready var sceleton: Mob = $Sceleton
@export_category('Procedural Navigation')
@export var navigation_layer: int = 1
@export var floor_layer: int = 0
@export var baked: bool = false

func _ready():
	if not baked:
		generate_nav_map()

func generate_nav_map():
	var cells: = get_used_cells(floor_layer)
	add_layer(-1)
	set_layer_enabled(get_layers_count() - 1, true)
	set_cells_terrain_connect(get_layers_count() - 1, cells.filter(cell_has_no_collision), 1, 0)

func cell_has_no_collision(coords: Vector2i)-> bool:
	for layer in get_layers_count():
		var tile_data: = get_cell_tile_data(layer, coords)
		if tile_data != null && tile_data.get_collision_polygons_count(layer) != 0:
			return false
	return true


func _process(delta):
	sceleton.nav_agent.target_position = hero.position

