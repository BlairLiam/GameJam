extends Node

signal minute_changed()
signal hour_changed(hour: int)
signal day_changed(day: int)

@export_range(0, 23) var sunrise_hour: int = 6
@export_range(0, 23) var sunset_hour: int = 18

@export var cycle_speed: float = 1.0 / 1440.0
var time: float = 0.0

var past_minute: int = -1
var past_hour: int = -1
var day_count: int = 0

func _process(delta: float) -> void:
	time = wrapf(time + (delta * cycle_speed), 0.0, 1.0)
	_update_clocks()

func _update_clocks() -> void:
	var total_minutes = int(time * 1440)
	
	var current_minute_of_hour: int = total_minutes % 60
	if current_minute_of_hour != past_minute:
		past_minute = current_minute_of_hour
		minute_changed.emit()
	
	var current_hour: int = total_minutes / 60.0
	if current_hour != past_hour:
		past_hour = current_hour
		hour_changed.emit(current_hour)
		
		if current_hour == 0:
			day_count += 1
			day_changed.emit(day_count)

func get_time_string() -> String:
	var total_minutes = int(time * 1440)
	var d = day_count
	var h: int = total_minutes / 60.0
	var m: int = total_minutes % 60
	
	return "%02d-%02d-%02d" % [d, h, m]

func get_hour() -> int:
	return int(time * 24)

func get_minute() -> int:
	return int(time * 1440) % 60
	
func is_day() -> bool:
	var h = get_hour() 
	return h >= sunrise_hour and h < sunset_hour

func is_night() -> bool:
	return not is_day()
