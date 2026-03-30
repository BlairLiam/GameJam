extends Control


func _on_hide_ui_pressed() -> void:
	visible = !visible


func _on_achievements_button_pressed() -> void:
	if(!visible):
		visible = !visible;
	else:
		visible = !visible;
