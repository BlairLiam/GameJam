extends Node

signal food_changed(current_amount: int)
signal game_over

@export var food_supply: float = 100.0
@export var is_game_active: bool = true

func _ready() -> void:
	TimeManager.hour_changed.connect(_on_hour_passed)
	
func add_food(food: int):
	food_supply += food
	food_changed.emit(int(food_supply))

func _on_hour_passed(_hour: int) -> void:
	if not is_game_active: return
	
	var consumption = calculate_total_consumption()
	food_supply -= consumption
	
	food_supply = max(0, food_supply)
	food_changed.emit(int(food_supply))
	
	if food_supply <= 0:
		trigger_game_over()

func calculate_total_consumption() -> float:
	var total: float = 0.0
	var villagers = get_tree().get_nodes_in_group("villagers")
	
	for v in villagers:
		var level = v.activity.progression.level
		total += (1 * level) 
	
	return total

func trigger_game_over():
	is_game_active = false
	game_over.emit()
	get_tree().paused = true
	print("The colony has collapsed!")
