extends Interactables
class_name Trees

enum Condition { HEALTHY, DEHYDRATED, INFESTED, MALNOURISHED }

@export var HP: int
@export var max_HP: int = 100
@export var current_condition: Condition

const DIAGNOSIS = {
	Condition.HEALTHY: " spots a healthy tree.",
	Condition.DEHYDRATED: " spots a dehydrated tree...",
	Condition.INFESTED: " spots an infested tree...",
	Condition.MALNOURISHED: " spots a malnourished tree..."
}

const CURES = {
	Items.Item.PESTICIDE: Condition.INFESTED,
	Items.Item.FERTILIZER: Condition.MALNOURISHED,
	Items.Item.WATER: Condition.DEHYDRATED
}

func update_visuals() -> void:
	push_error("Method 'update_visuals' must be overridden in child class!")

func interact(villager: Villagers) -> void:
	if current_condition != Condition.HEALTHY:
		if villager.inventory.item.type:
			heal_tree(villager)
			update_visuals()
		else:
			print(diagnose_current_condition(villager))
			

func diagnose_current_condition(villager: Villagers) -> String:
	var text = DIAGNOSIS.get(current_condition, " does nothing.")
	return villager.villager_name + text

func heal_tree(villager: Villagers) -> void:
	var item: Items = villager.inventory.item
		
	if CURES.get(item.type) == current_condition:
		HP += villager.progression.level
		print("The tree looks better...")
		
		if HP >= max_HP:
			current_condition = Condition.HEALTHY
	else:
		print("The " + item.name + " does nothing...")
			
	villager.inventory.take()
