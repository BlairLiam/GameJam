extends FruitTrees

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func update_visuals() -> void:
	if current_condition != Condition.HEALTHY:
		animated_sprite_2d.frame = 1
	else:
		animated_sprite_2d.frame = 4

func interact(villager: Villagers) -> void:
	if current_condition != Condition.HEALTHY:
		if villager.inventory.item.type:
			heal_tree(villager)
			update_visuals()
		else:
			print(diagnose_current_condition(villager))
		return

	if fruits > 0:
		fruits = max(0, fruits - villager.progression.level)
		villager.inventory.give(fruit)
		update_visuals()

		if timer.is_stopped():
				timer.start()
	else:
		print("This tree has no fish around it yet...")
