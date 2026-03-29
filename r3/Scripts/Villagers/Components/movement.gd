extends Node
class_name Movement

signal movement_finished
signal movement_interrupted

var path_grid: AStarGrid2D
var tile_layer: TileMapLayer

@export var body: AnimatedSprite2D
var owner_node: Villagers

var path: PackedVector2Array = []
var path_index: int = 0
var speed: float = 250.0
var is_moving: bool = false

func setup(actor: Villagers):
	owner_node = actor

func move_to(target_position: Vector2):
	if is_moving:
		interrupt()
		
	var start_cell = tile_layer.local_to_map(owner_node.global_position)
	var end_cell = tile_layer.local_to_map(target_position)
	
	path = path_grid.get_point_path(start_cell, end_cell)
	path_index = 1
		
	if path.size() > 1:
		is_moving = true
		if body.animation != "walk":
			body.play("walk")
	else:
		emit_signal("movement_finished")

func _physics_process(delta: float) -> void:
	if !is_moving or path_index >= path.size():
		return
	
	var target_pos = path[path_index]
	var current_pos = owner_node.global_position
	
	var diff_x = target_pos.x - current_pos.x
	body.flip_h = diff_x < 0
	
	owner_node.global_position = current_pos.move_toward(target_pos, speed * delta)
	
	if owner_node.global_position.distance_to(target_pos) < 1.0:
		path_index += 1
	
	if path_index >= path.size():
		stop_movement()

func stop_movement():
	is_moving = false
	path.clear()
	path_index = 0
	
	body.play("idle")
	emit_signal("movement_finished")

func interrupt():
	path.clear()
	path_index = 0
	
	emit_signal("movement_interrupted")
