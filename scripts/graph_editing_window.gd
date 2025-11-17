extends Control

@onready var preview := $MarginContainer/HBoxContainer/Preview
@onready var params_container := $MarginContainer/HBoxContainer/LeftPanel/Params
@onready var graph_type_label := $MarginContainer/HBoxContainer/LeftPanel/Func
@onready var close_button := $MarginContainer/Close
@onready var error_label := $Warning

var current_graph_type := ""
var current_params := {}
var param_base := {"A": 1, "B": 1, "C": 1, "D": 1}

const COL_A = "#ff6666"  # red-ish
const COL_B = "#66aaff"  # blue
const COL_C = "#aaff66"  # green
const COL_D = "#ffaa66"  # orange


signal graph_updated(fun_ref: Callable)

func _ready():
	visible = true;
	close_button.pressed.connect(_close)
	_show_popup()
	load_graph("Linear", {"A": 1, "B": 1})

func load_graph(graph_type: String, params: Dictionary):
	current_graph_type = graph_type
	current_params = params.duplicate()

	graph_type_label.text = _get_function_string()
	_build_param_ui()
	_update_preview()

func _show_popup():
	modulate = Color(1,1,1,0)
	position.y += 20
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color(1,1,1,1), 0.15)
	tween.tween_property(self, "position", position - Vector2(0,20), 0.15)

func _close():
	if not _graph_is_centered(0.5):
		_show_error_message()
		return
	
	emit_signal("graph_updated", preview.func_ref)
	queue_free()


func _build_param_ui():
	for child in params_container.get_children():
		child.queue_free()

	for key in current_params.keys():
		var h := HBoxContainer.new()

		var lbl := Label.new()
		lbl.text = key
		lbl.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		var box := SpinBox.new()
		box.value = current_params[key]
		box.min_value = -50
		box.max_value = 50
		box.step = 0.1
		box.size_flags_horizontal = Control.SIZE_EXPAND_FILL

		box.value_changed.connect(_on_param_changed.bind(key))

		h.add_child(lbl)
		h.add_child(box)
		params_container.add_child(h)


func _on_param_changed(new_val: float, key: String):
	current_params[key] = new_val
	error_label.visible = false;
	graph_type_label.text = _get_function_string()
	_update_preview()


func _update_preview():
	var A = current_params.get("A", 1.0)
	var B = current_params.get("B", 1.0)
	var C = current_params.get("C", 0.0)
	var D = current_params.get("D", 0.0)

	match current_graph_type:
		"Sine":
			preview.set_function(func(x): return A * sin(B*x + C) + D)
		"Quadratic":
			preview.set_function(func(x): return A*(x-C)*(x-C) + D)
		"Exponential":
			preview.set_function(func(x): return A * exp(B*x + C) + D)
		"Linear":
			preview.set_function(func(x): return A*x + B)
		_:
			preview.set_function(func(x): return 0)

func _graph_is_centered(tolerance := 0.5) -> bool:
	var y = 0.0
	var f = null

	match current_graph_type:
		"Sine":
			f = func(x): return current_params["A"] * sin(current_params["B"] * x + current_params["C"]) + current_params["D"]
		"Quadratic":
			f = func(x): return current_params["A"] * (x - current_params["C"])**2 + current_params["D"]
		"Exponential":
			f = func(x): return current_params["A"] * exp(current_params["B"] * x + current_params["C"]) + current_params["D"]
		"Linear":
			f = func(x): return current_params["A"] * x + current_params["B"]

	if f == null:
		return true 

	y = f.call(0.0)

	return abs(y) <= tolerance

func _get_function_string() -> String:
	var p = current_params

	match current_graph_type:
		"Linear":
			return "f(x) = %s·x + %s" % [
				_c(p["A"], COL_A),
				_c(p["B"], COL_B)
			]

		"Quadratic":
			return "f(x) = %s(x - %s)² + %s" % [
				_c(p["A"], COL_A),
				_c(p["C"], COL_C),
				_c(p["D"], COL_D)
			]

		"Sine":
			return "f(x) = %s·sin(%sx + %s) + %s" % [
				_c(p["A"], COL_A),
				_c(p["B"], COL_B),
				_c(p["C"], COL_C),
				_c(p["D"], COL_D)
			]

		"Exponential":
			return "f(x) = %s·e^(%sx + %s) + %s" % [
				_c(p["A"], COL_A),
				_c(p["B"], COL_B),
				_c(p["C"], COL_C),
				_c(p["D"], COL_D)
			]

		_:
			return "f(x) = ?"


func _c(num: float, color: String) -> String:
	return "[color=%s]%.1f[/color]" % [color, num]


func _show_error_message():
	error_label.visible = true
	error_label.modulate = Color(1,1,1,1)

	if error_label.has_meta("fade_tween"):
		var old = error_label.get_meta("fade_tween")
		if old.is_valid():
			old.kill()

	var tween = create_tween()
	error_label.set_meta("fade_tween", tween)
	
	tween.tween_property(error_label, "modulate", Color(1,1,1), 1)
	tween.tween_callback(func(): error_label.visible = false)
	
