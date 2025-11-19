extends ColorRect

@onready var lblName = $lbl_name
@onready var lblDescription = $lbl_description
@onready var lblLevel = $lbl_level
@onready var itemIcon = $ColorRect/ItemIcon


var mouse_over = false
var item = null
@onready var player = get_tree().get_first_node_in_group('player')

signal selected_upgrade(upgrade)

func _ready() -> void:
	connect("selected_upgrade",Callable(player,"upgrade_character"))
	if item == null:
		item = "food"
	lblName.text = UpgradeDatabase.UPGRADES[item]["displayname"]
	lblDescription.text = UpgradeDatabase.UPGRADES[item]["details"]
	lblLevel.text = UpgradeDatabase.UPGRADES[item]["level"]
	#itemIcon.texture = load(UpgradeDatabase.UPGRADES[item]["icon"])
	

func _input(event):
	if event.is_action('click') or event.is_action('interact'):
		if mouse_over:
			emit_signal("selected_upgrade", item)

func _on_mouse_entered() -> void:
	mouse_over = true


func _on_mouse_exited() -> void:
	mouse_over = false
