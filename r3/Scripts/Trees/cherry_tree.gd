extends FruitTrees

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func update_visuals() -> void:
	if current_condition != Condition.HEALTHY:
		animated_sprite_2d.frame = 0
	elif fruits > 0:
		animated_sprite_2d.frame = 3
	else:
		animated_sprite_2d.frame = 2
