extends Label

var time_elapsed = 0.0
var displayed_seconds = 0.0;
var displayed_minutes = 0.0;
var new_song = false;

func _process(delta: float) -> void:
	pass
	time_elapsed += delta

	var total_seconds = int(time_elapsed)
	displayed_minutes = total_seconds / 60.0
	displayed_seconds = total_seconds % 60
	$".".text = "%02d:%02d" % [displayed_minutes, displayed_seconds]
	
	if time_elapsed > 300 and not new_song:
		new_song = true;
		get_parent().get_parent().get_parent().get_node("AudioStreamPlayer").stop()
		get_parent().get_parent().get_parent().get_node("AudioStreamPlayer2").play()
