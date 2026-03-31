extends Control

class_name GameUI

@onready var population: RichTextLabel = $Population/MarginContainer/Population
@onready var clock: RichTextLabel = $Clock/MarginContainer/Clock
@onready var villager_name: RichTextLabel = $Villager/MarginContainer/VBoxContainer/Name
@onready var action: RichTextLabel = $Villager/MarginContainer/VBoxContainer/Action
@onready var food: RichTextLabel = $Food/MarginContainer/Food
@onready var level: RichTextLabel = $Exp/MarginContainer/Level
@onready var experience_points: ProgressBar = $Exp

func _ready() -> void:
	GameState.villager_inspected.connect(_on_villager_inspected)
	GameState.food_changed.connect(change_food_text)
	
	TimeManager.minute_changed.connect(change_time_text)
	
	change_food_text(GameState.food_supply)

func _on_villager_inspected(villager: Villagers):
	villager_name.text = villager.villager_name
	experience_points.value = villager.experience_points
	level.text = str(villager.level)
	
func change_food_text(amount: int):
	food.text = str(amount)

func change_exp_text(amount: int):
	experience_points.text = str(amount)
	
func change_level_text(amount: int) -> void:
	level.text = str(amount)
	
func change_population_text(amount: int) -> void:
	population.text = str(amount)
	
func change_time_text() -> void:
	clock.text = TimeManager.get_time_string()
