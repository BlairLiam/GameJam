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
