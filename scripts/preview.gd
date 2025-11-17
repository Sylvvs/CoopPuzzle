extends Control

var func_ref: Callable = func(_x): return 0

func set_function(f: Callable):
	func_ref = f
	queue_redraw()

func _draw():
	var w = size.x
	var h = size.y

	# axis
	draw_line(Vector2(0, h/2), Vector2(w, h/2), Color.WHITE, 1)
	draw_line(Vector2(w/2, 0), Vector2(w/2, h), Color.WHITE, 1)

	# graph
	var last = null
	for i in range(w):
		var x = (i - w/2) / 50.0  # scale
		var y = func_ref.call(x)
		var py = h/2 - y * 50

		var pt = Vector2(i, py)
		if last != null:
			draw_line(last, pt, Color.RED, 2)
		last = pt
