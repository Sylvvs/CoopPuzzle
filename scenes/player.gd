extends CharacterBody2D
const SPEED = 100.0

var health = 100

var xp = 0
var level = 1
var level_up_requirement = 10
var level_up_scaling = 1.8
var functions = ["Quadratic", "Exponential", "Potential", "Sine"]


@onready var animation_tree = $AnimationTree
@onready var levelPanel = $CanvasLayer/LevelUp
@onready var upgradeOptions = $CanvasLayer/LevelUp/upgradeOptions
@onready var itemOptions = preload("res://scenes/UI Elements/item_option.tscn")
@onready var gun = $Gun
@onready var graph = $CanvasLayer/GraphEditingWindow


func _ready() -> void:
	graph.graph_updated.connect(graf_changed)

func graf_changed(func_ref: Callable):
	gun.f = func_ref
	

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
		if xp >= level_up_requirement:
			level_up()


func level_up():
	level += 1
	xp -= level_up_requirement
	level_up_requirement *= level_up_scaling
	if level % 5 == 0 and not level > 20:
		graph.load_graph(functions[(level/5)-1], {"A": 1, "B": 0, "C": 1, "D": 0})
	else:
		var tween = levelPanel.create_tween()
		tween.tween_property(levelPanel,"position", Vector2(284,91),0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
		tween.play()
		levelPanel.visible = true
		var options = 0
		var optionsmax = 3
		while options < optionsmax:
			var option_choice = itemOptions.instantiate()
			upgradeOptions.add_child(option_choice)
			options = options + 1
	get_tree().paused = true
	
func upgrade_character(upgrade):
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	levelPanel.visible = false
	levelPanel.position = Vector2(800,50)
	get_tree().paused = false
