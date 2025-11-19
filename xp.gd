extends Area2D;
@export var xp_value = 25

var picked_up = false

var player

func _ready() -> void:
	player = get_tree().get_first_node_in_group('player')



func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group('xp_pickuprange'):
		picked_up = true

func _process(_delta: float) -> void:
	if picked_up:
		position.x = move_toward(position.x,player.global_position.x,_delta*150)
		position.y = move_toward(position.y,player.global_position.y,_delta*150)
