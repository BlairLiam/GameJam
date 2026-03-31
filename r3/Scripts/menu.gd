extends Control

@onready var button: Button = $Button
@export var regular_button_icon: Texture2D
@export var pressed_button_icon: Texture2D

func _on_button_button_up() -> void:
	button.icon = regular_button_icon

func _on_button_button_down() -> void:
	button.icon = pressed_button_icon

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")
	GameState.food_supply = 100
	
	TimeManager.day_count = 0
	TimeManager.past_hour = -1
	TimeManager.past_minute = -1
	TimeManager.time = 0.5
