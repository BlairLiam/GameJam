extends Node
class_name Inventory

@export var item: Items = preload("res://Scripts/Items/nothing.tres")
@export var sprite: Sprite2D

func take() -> Items:
	var temp = item
	item = preload("res://Scripts/Items/nothing.tres")
	sprite.visible = false
	return temp

func give(new_item: Items):
	item = new_item
	sprite.texture = new_item.icon
	sprite.visible = true
