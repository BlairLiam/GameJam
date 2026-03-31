extends Area2D
class_name Villagers

signal clicked_on_me(character: Villagers)

@onready var movement: Movement = $Activity/Movement
@onready var interaction: Interaction = $Activity/Interaction
@onready var inventory: Inventory = $Activity/Inventory
@onready var activity: Activity = $Activity

func _ready():
	movement.setup(self)

# INPUT

func _input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("right_click"):
		clicked_on_me.emit(self)
		
func _input(event):
	if not is_selected:
		return
	
	if event.is_action_released("left_click"):
		movement.move_to(get_global_mouse_position())
	
	if event.is_action_pressed("right_click"):
		interaction.try_interact(self)

# AREA SIGNALS

func _on_area_entered(area: Area2D):
	if area.is_in_group("interactables"):
		interaction.on_area_entered(area)

func _on_area_exited(area: Area2D):
	if area.is_in_group("interactables"):
		interaction.on_area_exited(area)
		
# ATTRIBUTES

var is_selected: bool = false
		
@export var villager_name: String = "Villager"
@export var villager_action: String = ""

@export var level: int = 1
@export var max_level: int = 10

@export var experience_points: int = 0
@export var max_exp: int = 100

func add_exp():
	if level >= max_level:
		level = max_level
		return
	
	experience_points += 1
	
	if experience_points >= max_exp:
		level += 1
		experience_points = 0
		
	if is_selected:
		GameState.villager_inspected.emit(self)
