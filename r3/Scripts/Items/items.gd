extends Resource

class_name Items

enum Item {
	NOTHING = 0,
	BANANA,
	COCONUT,
	LYCHEE,
	MANGO,
	FERTILIZER,
	PESTICIDE,
	WATER,
	FISH
}

@export var name: String
@export var description: String
@export var icon: Texture2D
@export var type: Items.Item

const FOOD_ITEMS = [Item.BANANA, Item.COCONUT, Item.LYCHEE, Item.MANGO, Item.FISH]

static func is_food(item: Item) -> bool:
	return item in FOOD_ITEMS
