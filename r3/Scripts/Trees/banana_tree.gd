extends FruitTrees

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func update_visuals() -> void:
	if fruits > 0:
		animated_sprite_2d.frame = 1
	else:
		animated_sprite_2d.frame = 0
