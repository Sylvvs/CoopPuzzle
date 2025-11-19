extends Area2D

var FUNCT: Callable
var stats := {"Speed": 5.0, "Lifetime": 5.0, "Damage": 5.0, "Pierce": 1, "difficulty_mult" : 1}

var elapsed_time := 0.0
var arc_table := [] 
var local_pierce
var local_damage
var hit_enemies := []

var total_length := 0.0
var init_pos
var init_rot

@onready var damage_number = preload("res://scenes/UI Elements/lbl_damagenumber.tscn")




func _ready() -> void:
	init_pos = position;
	rotation = init_rot
	local_damage = stats["Damage"] * stats["difficulty_mult"]
	local_pierce = stats["Pierce"]
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
	var distance = elapsed_time * stats["Speed"]

	var x := _get_x_from_arc(distance)
	var y = FUNCT.call(x)
	
	var epsilon := 0.01
	var dy = FUNCT.call(x + epsilon) - FUNCT.call(x - epsilon)
	var dx = 2.0 * epsilon
	var slope = dy / dx
	
	var angle := atan2(-slope, 1.0)
	rotation = init_rot+angle
	
	position = init_pos+ Vector2(x * 100, -y * 100).rotated(init_rot)
	visible = true;
	
	if elapsed_time > stats["Lifetime"]:
		queue_free()
	
	if local_pierce <= 0:
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
	if body.is_in_group('enemies') and not body in hit_enemies:
		body.health -= local_damage
		body.anim.play('Hit')
		local_pierce -= 1
		hit_enemies.append(body)
		var dmg_num = damage_number.instantiate()
		dmg_num.position = global_position
		dmg_num.text = str(local_damage)
		get_parent().add_child(dmg_num)
