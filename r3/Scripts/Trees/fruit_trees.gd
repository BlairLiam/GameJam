extends Trees

class_name FruitTrees

@onready var timer: Timer = $Timer

@export var fruit: Items = preload("res://Scripts/Items/banana.tres")
@export var fruits: int = 0
@export var max_fruits: int = 1
@export var refresh_time: int = 60
@export var refresh_rate: int = 1

func _ready() -> void:
	timer.wait_time = refresh_time
	timer.start()
	update_visuals()

func interact(villager: Villagers) -> void:
	if current_condition != Condition.HEALTHY:
		if villager.inventory.item.type:
			heal_tree(villager)
			update_visuals()
		else:
			print(diagnose_current_condition(villager))
			if villager.is_selected:
				GameUI.change_action_text(diagnose_current_condition(villager))
		return

	if fruits > 0:
		fruits = max(0, fruits - villager.progression.level)
		villager.inventory.give(fruit)
		update_visuals()

		if timer.is_stopped():
				timer.start()
	else:
		print("This tree has no fruit yet...")

func heal_tree(villager: Villagers) -> void:
	var item: Items = villager.inventory.item
		
	if CURES.get(item.type) == current_condition:
		HP += villager.progression.level
		print("The tree looks better...")
		
		if HP >= max_HP:
			current_condition = Condition.HEALTHY
			timer.start()
	else:
		print("The " + item.name + " does nothing...")
			
	villager.inventory.take()

func _on_timer_timeout() -> void:
	fruits = min(max_fruits, fruits + refresh_rate)
	update_visuals()
		
	if fruits >= max_fruits:
		timer.stop()
