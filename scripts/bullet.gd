extends Area2D

var FUNCT: Callable
var speed := 5.0
var lifetime := 5.0
var damage = 5
var pierce = 1

var elapsed_time := 0.0
var arc_table := [] 

var total_length := 0.0
var init_pos
var init_rot

func _ready() -> void:
	init_pos = position;
	rotation = init_rot
	if FUNCT.is_valid():
		_precompute_arc_length()

func _precompute_arc_length():
	var step := 0.01
	var s := 0.0
	var last_y = FUNCT.call(0.0)
	
	for x in range(0, 1000):
		var xf := x * step
		var y = FUNCT.call(xf)
		var dx := step
		var dy = y - last_y
		s += sqrt(dx * dx + dy * dy)
		last_y = y
		arc_table.append({ "x": xf, "s": s })
	
	total_length = s

func _process(delta: float) -> void:
	if not FUNCT.is_valid():
		return

	elapsed_time += delta
	var distance := elapsed_time * speed

	var x := _get_x_from_arc(distance)
	var y = FUNCT.call(x)
	
	var epsilon := 0.01
	var dy = FUNCT.call(x + epsilon) - FUNCT.call(x - epsilon)
	var dx = 2.0 * epsilon
	var slope = dy / dx
	
	var angle := atan2(-slope, 1.0)
	rotation = init_rot+angle
	
	position = init_pos+ Vector2(x * 100, -y * 100).rotated(init_rot)
	
	
	if elapsed_time > lifetime:
		queue_free()
	
	if pierce <= 0:
		queue_free()

func _get_x_from_arc(s: float) -> float:
	if s <= 0.0:
		return 0.0
	if s >= total_length:
		return arc_table[-1]["x"]

	var low := 0
	var high := arc_table.size() - 1
	while low < high:
		var mid = (low + high) / 2.0
		if arc_table[mid]["s"] < s:
			@warning_ignore("narrowing_conversion")
			low = mid + 1.0
		else:
			@warning_ignore("narrowing_conversion")
			high = mid
	return arc_table[low]["x"]


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group('enemies'):
		body.health -= damage
		pierce -= 1
