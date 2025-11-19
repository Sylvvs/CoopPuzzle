extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")

var cooldown = 0;
var stats := {"Speed": 5.0, "Lifetime": 5.0, "Damage": 5.0, "Pierce": 1, "Cooldown_Timer": 0.2, "difficulty_mult": 1.0}

var f: Callable = func(x): return sin(2*x)

func _process(delta: float) -> void:
	var mouse = get_global_mouse_position()
	var to_mouse = mouse - get_parent().global_position
	
	rotation = to_mouse.angle()
	position = Vector2(28,0).rotated(rotation)

	if cooldown > stats["Cooldown_Timer"]:
		cooldown = 0
		summon_bullet()
	
	cooldown += delta

func summon_bullet():
	var new_bullet = BULLET.instantiate()
	new_bullet.stats = stats;
	new_bullet.visible = false;
	new_bullet.FUNCT = f
	new_bullet.position = get_parent().position+Vector2(25,0).rotated(rotation)
	new_bullet.init_rot = rotation
	get_parent().get_parent().add_child(new_bullet)
