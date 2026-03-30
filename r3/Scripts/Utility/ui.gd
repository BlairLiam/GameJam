extends Control

class_name GameUI

@onready var villager_name: RichTextLabel = $Villager/MarginContainer/VBoxContainer/Name
@onready var action: RichTextLabel = $Villager/MarginContainer/VBoxContainer/Action
@onready var food: RichTextLabel = $Food/MarginContainer/Food
@onready var level: RichTextLabel = $Exp/MarginContainer/Level
@onready var experience_points: ProgressBar = $Exp

static var ui_name: RichTextLabel
static var ui_action: RichTextLabel
static var ui_food: RichTextLabel
static var ui_level: RichTextLabel
static var ui_exp: ProgressBar

func _ready() -> void:
	ui_name = villager_name
	ui_action = action
	ui_food = food
	ui_level = level
	ui_exp = experience_points
	GameState.food_changed.connect(change_food_text)

static func change_action_text(text: String):
	ui_action.text = text
	
static func change_name_text(text: String):
	ui_name.text = text
	
static func change_food_text(amount: int):
	ui_food.text = str(amount)
	
static func change_level_text(amount: int):
	ui_food.text = str(amount)
	
static func change_exp_bar(amount: int):
	ui_exp.value = amount
	
static func apply_villager_stats(villager: Villagers):
	change_action_text("")
	change_exp_bar(villager.progression.experiece_points)
	change_name_text(villager.villager_name)
	change_level_text(villager.progression.level)
