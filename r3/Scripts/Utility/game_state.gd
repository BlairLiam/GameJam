extends Node

signal food_changed(current_amount: int)
signal game_over
signal villager_inspected(villager: Villagers)

@export var food_supply: int = 100
@export var is_game_active: bool = false

func _ready() -> void:
	TimeManager.hour_changed.connect(_on_hour_passed)
	
func start() -> void:
	is_game_active = true
	
func stop() -> void:
	is_game_active = false
	
func add_food(food: int):
	food_supply += food
	food_changed.emit(int(food_supply))

func _on_hour_passed(_hour: int) -> void:
	if not is_game_active: return
	
	var consumption: int = calculate_total_consumption()
	food_supply -= consumption
	
	food_supply = max(0, food_supply)
	food_changed.emit(int(food_supply))
	
	if food_supply <= 0:
		trigger_game_over()

func calculate_total_consumption() -> int:
	var total: float = 0.0
	var villagers = get_tree().get_nodes_in_group("villagers")
	
	for v in villagers:
		var new_level = v.level
		total += (1 * new_level)
	
	return int(total)

func trigger_game_over():
	is_game_active = false
	game_over.emit()
	get_tree().paused = true
	print("The colony has collapsed!")
