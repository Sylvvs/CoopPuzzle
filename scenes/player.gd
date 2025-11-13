extends CharacterBody2D
const SPEED = 100.0

var health = 100

var xp = 0
var level = 1
var level_up_requirement = 10
var level_up_scaling = 1.8


@onready var animation_tree = $AnimationTree

func _process(_delta: float) -> void:
	if xp >= level_up_requirement:
		level_up()

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("up"):
		velocity.y -= SPEED
	if Input.is_action_pressed('down'):
		velocity.y += SPEED
	if Input.is_action_pressed('left'):
		velocity.x -= SPEED
	if Input.is_action_pressed('right'):
		velocity.x += SPEED
	
	velocity = velocity.limit_length(SPEED)
	move_and_slide()
	
	if velocity.length() > 0:
		animation_tree["parameters/conditions/walking"] = true
		animation_tree["parameters/conditions/idle"] = false
	else:
		animation_tree["parameters/conditions/walking"] = false
		animation_tree["parameters/conditions/idle"] = true
	
	var mouse_dir = (get_global_mouse_position() - global_position).normalized()
	animation_tree["parameters/Walking/blend_position"] = Vector2(mouse_dir.x, -mouse_dir.y)
	animation_tree["parameters/Idle/blend_position"] = Vector2(mouse_dir.x, -mouse_dir.y)
	
	if health <= 0:
		get_tree().quit()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group('xp'):
		xp += area.xp_value
		area.queue_free()
		print(xp)


func level_up():
	xp -= level_up_requirement
	level_up_requirement *= level_up_scaling
	print('Level Up!')
