extends Node2D

const BULLET = preload("res://scenes/bullet.tscn")

var cooldown = 0;

func f(x):
	return x**1.5

func _process(delta: float) -> void:
	if cooldown>0.2:
		cooldown = 0
		summon_bullet()
	
	cooldown += delta

func summon_bullet():
	var new_bullet = BULLET.instantiate()
	new_bullet.FUNCT = Callable(self, "f")
	new_bullet.position = get_parent().position
	new_bullet.rotation = get_parent().rotation
	get_parent().get_parent().add_child(new_bullet)
