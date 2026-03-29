extends Camera2D

@export var drag_sensitivity = 1.0
@export var follow_speed: float = 5.0
var target_character: Area2D = null

func _process(delta: float) -> void:
	if target_character:
		global_position = global_position.lerp(target_character.global_position, follow_speed * delta)

func _unhandled_input(event):
	# Check if we are moving the mouse AND the left button is currently down
	if target_character == null:
		if event is InputEventMouseMotion and event.button_mask & MOUSE_BUTTON_MASK_LEFT:
			position -= event.relative * drag_sensitivity / zoom.x
