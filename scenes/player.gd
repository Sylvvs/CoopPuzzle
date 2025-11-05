extends CharacterBody2D
const SPEED = 100.0

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
	print(velocity.length())
	move_and_slide()
