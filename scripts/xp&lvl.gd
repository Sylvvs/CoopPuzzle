extends Control

var player: Node = null
@onready var progress_bar = $CanvasLayer/ProgressBar
@onready var label = $CanvasLayer/CenterContainer/RichTextLabel

func _ready():
	# Wait a tiny bit so Level1 finishes adding Player to the tree
	await get_tree().process_frame
	var players = get_tree().get_nodes_in_group("player")
	if players.size() > 0:
		player = players[0]

func _process(_delta: float) -> void:
	progress_bar.max_value = player.level_up_requirement
	progress_bar.value = player.xp
	label.text = JSON.stringify(player.level)
