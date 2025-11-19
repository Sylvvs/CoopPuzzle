extends Label

var time_elapsed = 0.0
var displayed_seconds = 0.0;
var displayed_minutes = 0.0;

func _process(delta: float) -> void:
	pass
	time_elapsed += delta

	var total_seconds = int(time_elapsed)
	displayed_minutes = total_seconds / 60
	displayed_seconds = total_seconds % 60
	$".".text = "%02d:%02d" % [displayed_minutes, displayed_seconds]
