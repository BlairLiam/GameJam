extends Interactables

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var repaired: int = 0

@export var max_repaired: int = 10
@export var is_repaired: bool = false

func _ready() -> void:
	if is_repaired:
		sprite.play("repaired")
	else:
		sprite.play("destroyed")

func interact(_villager: Villagers) -> void:
	if TimeManager.is_night():
		if _villager.is_selected:
			_villager.clicked_on_me.emit(_villager)
		
		_villager.activity.stop()
		_villager.visible = false
	
	if !is_repaired:
		repair()
		
func repair() -> void:
	repaired += 1
	
	if repaired > 0:
		sprite.play("repairing")
		
	if repaired >= max_repaired:
		sprite.play("repaired")
		is_repaired = true
