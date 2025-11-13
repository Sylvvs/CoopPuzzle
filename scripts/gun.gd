extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")

var cooldown = 0;

func f(x):
	return sin(2*x)

func _process(delta: float) -> void:
	var mouse = get_global_mouse_position()
	var to_mouse = mouse - get_parent().global_position
	
	# Rotate around origin relative to parent
	rotation = to_mouse.angle()
	position = Vector2(28,0).rotated(rotation)

	if cooldown>0.2:
		cooldown = 0
		summon_bullet()
	
	cooldown += delta

func summon_bullet():
	var new_bullet = BULLET.instantiate()
	new_bullet.FUNCT = Callable(self, "f")
	new_bullet.position = get_parent().position+Vector2(25,0).rotated(rotation)
	new_bullet.init_rot = rotation
	get_parent().get_parent().add_child(new_bullet)
