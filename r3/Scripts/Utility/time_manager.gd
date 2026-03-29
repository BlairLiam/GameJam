extends Node

signal hour_changed(hour: int)
signal day_changed(day: int)

@export_range(0, 23) var sunrise_hour: int = 6
@export_range(0, 23) var sunset_hour: int = 18

@export var cycle_speed: float = 1.0 / 1440.0 # 24 mins cycle
var time: float = 0.0
var past_minute: int = -1
var day_count: int = 1

func _process(delta: float) -> void:
	time = wrapf(time + (delta * cycle_speed), 0.0, 1.0)
	
	_update_clocks()

func _update_clocks() -> void:
	var total_minutes = int(time * 1440)
	var current_hour: int = total_minutes / 60.0
	
	if current_hour != past_minute: # Using 'past_minute' to track hour changes
		past_minute = current_hour
		hour_changed.emit(current_hour)
		
		# If hour hits 0 again, a new day has started
		if current_hour == 0:
			day_count += 1
			day_changed.emit(day_count)

func get_time_string() -> String:
	var total_minutes = int(time * 1440)
	var h: int = total_minutes / 60.0
	var m = total_minutes % 60
	return "%02d:%02d" % [h, m]
	
func get_hour() -> int:
	return int(time * 24)

func is_day() -> bool:
	var h = get_hour()
	return h >= sunrise_hour and h < sunset_hour

func is_night() -> bool:
	return not is_day()
