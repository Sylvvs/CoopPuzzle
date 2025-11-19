extends CharacterBody2D
var SPEED = 100.0

var health = 100
var max_health = 100

var xp = 0
var level = 1
var level_up_requirement = 10
var level_up_scaling = 1.8
var functions = ["Quadratic", "Exponential", "Potential", "Sine"]
var func_params = {"Quadratic": {"A": 1, "B": 0, "C": 1}, "Exponential": {"A": 2, "B": 0.5}, "Potential": {"A": 1, "B": 1}, "Sine": {"A": 1, "B": 1, "C": 1, "D": 1}}

var collected_upgrades = []
var upgrade_options = []
var armor = 0
var spell_cooldown = 0


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
	gun.stats["Damage"] *= graph.difficulty_mult
	#gun.stats["Pierce"] = 1+(level/5)
	print("Damage is now ", gun.stats["Damage"])
	print("Pierce is now ", gun.stats["Pierce"])
	

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
	level_up_requirement = level ** level_up_scaling
	if level % 5 == 0 and not level > 20:
		var graph_name = functions[(level/5)-1]
		graph.load_graph(graph_name, func_params[graph_name])
		gun.stats["Damage"] += 5
	else:
		var tween = levelPanel.create_tween()
		tween.tween_property(levelPanel,"position", Vector2(284,91),0.2).set_trans(Tween.TRANS_QUINT).set_ease(Tween.EASE_IN)
		tween.play()
		levelPanel.visible = true
		var options = 0
		var optionsmax = 3
		while options < optionsmax:
			var option_choice = itemOptions.instantiate()
			option_choice.item = get_random_item()
			upgradeOptions.add_child(option_choice)
			options = options + 1
	get_tree().paused = true
	
func upgrade_character(upgrade):
	match upgrade:
		"magictome1","magictome2","magictome3","magictome4","magictome5":
			gun.stats["Cooldown_Timer"] *= 0.8
		"speed1","speed2","speed3","speed4","speed5":
			SPEED += 20
		"damage1","damage2","damage3","damage4","damage5":
			gun.stats["Damage"] += 5
		"health1","health2","health3","health4","health5":
			max_health *= 1.2
			health += max_health / 6
		"armor1","armor2","armor3","armor4","armor5":
			armor += 0.1
		"pierce1","pierce2","pierce3","pierce4","pierce5":
			gun.stats["Pierce"] += 1
	
	var option_children = upgradeOptions.get_children()
	for i in option_children:
		i.queue_free()
	upgrade_options.clear()
	collected_upgrades.append(upgrade)
	levelPanel.visible = false
	levelPanel.position = Vector2(800,50)
	get_tree().paused = false

func get_random_item():
	var dblist = []
	for i in UpgradeDatabase.UPGRADES:
		if i in collected_upgrades: 
			pass
		elif i in upgrade_options:
			pass
		elif UpgradeDatabase.UPGRADES[i]["type"] == "item":
			pass
		elif UpgradeDatabase.UPGRADES[i]["prerequisite"].size() > 0:
			for n in UpgradeDatabase.UPGRADES[i]["prerequisite"]:
				if not n in collected_upgrades:
					pass
				else: 
					dblist.append(i)
		else:
			dblist.append(i)
	if dblist.size() > 0:
		var randomitem = dblist.pick_random()
		upgrade_options.append(randomitem)
		return randomitem
	else:
		return null
