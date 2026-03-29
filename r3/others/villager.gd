extends Node2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D

var tile_size: float = 64.0
var is_moving: bool = false

func _physics_process(_delta: float) -> void:
	if is_moving:
		return

	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")

	if input_dir != Vector2.ZERO:
		if abs(input_dir.x) > abs(input_dir.y):
			move(Vector2(sign(input_dir.x), 0))
		else:
			move(Vector2(0, sign(input_dir.y)))
	else:
		animated_sprite_2d.play("idle")

func move(direction: Vector2):
	ray_cast_2d.target_position = direction * tile_size
	ray_cast_2d.force_raycast_update()

	if not ray_cast_2d.is_colliding():
		is_moving = true
		animated_sprite_2d.play("walk")
		
		if direction.x != 0:
			animated_sprite_2d.flip_h = direction.x < 0

		var tween = create_tween()
		tween.tween_property(self, "position", position + direction * tile_size, 0.1).set_trans(Tween.TRANS_LINEAR)
		tween.finished.connect(func(): is_moving = false)
	else:
		animated_sprite_2d.play("idle")
