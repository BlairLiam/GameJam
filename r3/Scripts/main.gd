extends Node2D

class_name Main

static var food: int = 0

@export var character_scene: PackedScene = preload("res://Scenes/Villagers/Villagers.tscn")

@onready var camera: Camera2D = $Camera2D

@onready var tile_layer: TileMapLayer = $MainMap/Obstacles
var path_grid: AStarGrid2D = AStarGrid2D.new()

@onready var villagers_layer: Node2D = $MainMap/Sorting/Villagers

var selected_character: Area2D = null

const TILE_SIZE = 64.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("right_click"):
		var click = get_global_mouse_position()
		var end = tile_layer.local_to_map(click)
		print(end)
		
	if event.is_action_pressed("debug"):
		TimeManager.time += 0.1
		TimeManager.emit_signal("hour_changed", TimeManager.get_hour())
		print(TimeManager.get_hour())   
		
func _ready() -> void:
	spawn_character(Vector2(32, 32))
	spawn_character(Vector2(32, 544))
	
func setup_grid() -> void:
	path_grid.region = tile_layer.get_used_rect()
	path_grid.cell_size = Vector2(TILE_SIZE, TILE_SIZE)
	path_grid.offset = Vector2(TILE_SIZE / 2.0, TILE_SIZE / 2.0)
	path_grid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	path_grid.default_compute_heuristic = AStarGrid2D.HEURISTIC_EUCLIDEAN
	path_grid.update()

	# IMPORTANT: Only set tiles as solid if they are actually obstacles (like walls)
	# If you want ALL used cells to be walkable, leave this loop out.
	for cell in tile_layer.get_used_cells():
		path_grid.set_point_solid(cell, true)

func spawn_character(new_position: Vector2):
	var created_character: Villagers = character_scene.instantiate()
	villagers_layer.add_child(created_character)
		
	created_character.global_position = new_position
	created_character.clicked_on_me.connect(_on_character_clicked)

	created_character.movement.path_grid = path_grid
	created_character.movement.tile_layer = tile_layer
	setup_grid()

func _on_character_clicked(character: Villagers) -> void:
	if selected_character == character:
		character.is_selected = false
		camera.target_character = null
		selected_character = null
		return
		
	if selected_character != null:
		selected_character.is_selected = false
		selected_character = character
		selected_character.is_selected = true
	else:
		selected_character = character
		selected_character.is_selected = true

	camera.target_character = selected_character
