extends Node
class_name Progression

@export var level: int = 1
@export var max_level: int = 10

@export var experiece_points: int = 0
@export var max_exp: int = 100

func add_exp():
	if level >= max_level:
		return
	
	experiece_points += 1
	
	if experiece_points >= max_exp:
		level += 1
		experiece_points = 0
