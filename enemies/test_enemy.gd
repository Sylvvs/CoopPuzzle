extends CharacterBody2D

var player
var health = 25


func _ready() -> void:
	player = get_tree().get_first_node_in_group('player')
	
	
func _physics_process(_delta: float) -> void:
	var body = null;
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		body = collision.get_collider()
	if body == null or !body.is_in_group('player'):
		position.x = move_toward(position.x,player.global_position.x,_delta*25)
		position.y = move_toward(position.y,player.global_position.y,_delta*25)
	if body != null and body.is_in_group('player'):
		body.health -= 10
		print(body.health)
	move_and_slide()

func _process(_delta: float) -> void:
	pass
	if health <= 0:
		self.queue_free()
