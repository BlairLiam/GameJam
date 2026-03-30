extends Interactables

@onready var sprite: Sprite2D = $Sprite2D

var repaired: float = 0.0
var is_repaired: bool = true

func interact(villager: Villagers) -> void:
	var item_type: Items.Item = villager.inventory.item.type
		
	if Items.is_food(item_type):
		GameState.add_food(villager.progression.level)

	villager.inventory.take()
	
	print(GameState.food_supply)
	
