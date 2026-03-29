extends CanvasModulate

@export var day_night_gradient: Gradient

func _process(_delta: float) -> void:
	color = day_night_gradient.sample(TimeManager.time)
