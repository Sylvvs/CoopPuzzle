extends CharacterBody2D
const SPEED = 100.0

var health = 100

func _physics_process(_delta: float) -> void:
	velocity = Vector2.ZERO
	
	
	look_at(get_global_mouse_position())
	
	
	if Input.is_action_pressed("up"):
		velocity.y -= SPEED
	if Input.is_action_pressed('down'):
		velocity.y += SPEED
	if Input.is_action_pressed('left'):
		velocity.x -= SPEED
	if Input.is_action_pressed('right'):
		velocity.x += SPEED
		
	if Input.is_action_just_pressed('shoot'):
		print('hej')
	
	velocity = velocity.limit_length(SPEED)
	move_and_slide()
	
		
	
	if health <= 0:
		get_tree().quit()
