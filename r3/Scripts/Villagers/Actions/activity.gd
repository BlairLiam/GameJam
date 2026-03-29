extends Node
class_name Activity

@onready var villager: Villagers = get_parent()

@onready var movement: Movement = $Movement
@onready var inventory: Inventory = $Inventory
@onready var interaction: Interaction = $Interaction
@onready var progression: Progression = $Progression

@onready var movement_timer: Timer = $"Movement Timer"
@onready var interaction_timer: Timer = $"Interaction Timer"

func _ready() -> void:
	TimeManager.hour_changed.connect(_on_hour_changed)
	
	movement.movement_finished.connect(_on_movement_reached_target)
		
	movement_timer.wait_time = 2.5
	interaction_timer.wait_time = 2.5
	
	movement_timer.start()
	
func start() -> void:
	movement_timer.stop()
	
	if villager.inventory.item.type != Items.Item.NOTHING:
		storing()
	else:
		var hour: int = TimeManager.get_hour()
		
		if hour >= 22 or hour < 6:
			go_to_sleep_area()
		else:
			harvesting()
			
func stop() -> void:
	movement_timer.stop()
	interaction_timer.stop()
	
	print(movement_timer.is_stopped())
	print(interaction_timer.is_stopped())

func harvesting() -> void:
	var fruit_tree = get_tree().get_nodes_in_group("fruit_trees").pick_random()
	if fruit_tree: movement.move_to(fruit_tree.global_position)

func storing() -> void:
	var storage = get_tree().get_first_node_in_group("storage_area")
	if storage: movement.move_to(storage.global_position)

func go_to_sleep_area() -> void:
	var kubo = get_tree().get_nodes_in_group("kubo").pick_random()
	if kubo: movement.move_to(kubo.global_position)

func _on_movement_reached_target() -> void:
	interaction_timer.start()

func _on_interaction_timer_timeout() -> void:
	movement_timer.start()
	interaction_timer.stop()
	
	interaction.try_interact(villager)

func _on_movement_timer_timeout() -> void:
	movement_timer.stop()
	start()
	
func _on_hour_changed(hour: int) -> void:
	if hour == 6:
		villager.visible = true
		start()
