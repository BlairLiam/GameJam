extends Interactables

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var timer: Timer = $Timer

var fuel: float = 0.0

func _ready() -> void:
	sprite.play("off")

func interact() -> void:
	fuel += 1.0
	
	sprite.play("on")
	timer.start()
	
	print(fuel)
	if fuel > 100.0:
		fuel = 100.0
		return

func _on_timer_timeout() -> void:
	fuel -= 1
	
	print(fuel)
	if fuel <= 0.0:
		sprite.play("off")
		timer.stop()
		return
