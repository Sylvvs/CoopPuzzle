extends CharacterBody2D

var player
@export var health = 25
@export var speed = 25
@export var XP: PackedScene
@export var damage = 10

func _ready() -> void:
	player = get_tree().get_first_node_in_group('player')
	
	
func _physics_process(_delta: float) -> void:
	var body = null;
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		body = collision.get_collider()
	if body == null or !body.is_in_group('player'):
		position.x = move_toward(position.x,player.global_position.x,_delta*speed)
		position.y = move_toward(position.y,player.global_position.y,_delta*speed)
	if body != null and body.is_in_group('player'):
		#body.health -= damage
		pass
	move_and_slide()

func _process(_delta: float) -> void:
	if health <= 0:
		var xp = XP.instantiate()
		xp.position = global_position
		get_parent().get_parent().add_child(xp)
		self.queue_free()
