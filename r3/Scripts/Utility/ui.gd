extends Control

class_name GameUI

@onready var action_text_node: RichTextLabel = $Panel/RichTextLabel

static var action_text: RichTextLabel

func _ready() -> void:
	action_text = action_text_node

static func change_action_text(text: String):
	action_text.text = text
