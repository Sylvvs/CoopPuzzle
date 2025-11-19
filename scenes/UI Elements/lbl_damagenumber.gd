extends Label

var timer = 0

func _process(delta: float) -> void:
	timer += delta
	if timer > 0.5:
		self.queue_free()
