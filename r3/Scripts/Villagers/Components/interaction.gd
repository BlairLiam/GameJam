extends Node
class_name Interaction

var nearby_interactables: Array[Interactables] = []

func try_interact(source):
	if nearby_interactables.is_empty():
		return
			
	var target = nearby_interactables[0]
	
	if target.has_method("interact"):
		target.interact(source)

func on_area_entered(area: Interactables):
	nearby_interactables.append(area)

func on_area_exited(area: Interactables):
	nearby_interactables.erase(area)
