extends CharacterBody2D

enum CharacterState {
	RUN,
	JUMP
}

var movement_speed = 200
const SPEED = 200.0
const JUMP_VELOCITY = -150.0
const GRAVITY = 300  
var character_state = CharacterState.RUN
var animated_sprite

func _ready():
	animated_sprite = $AnimatedSprite2D

func _physics_process(delta):
	var move_direction = 0
	if Input.is_action_just_pressed("jump2") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		character_state = CharacterState.JUMP
	if Input.is_action_pressed("move2_right"):
		move_direction += 1
		character_state = CharacterState.RUN
	if Input.is_action_pressed("move2_left"):
		move_direction -= 1
		character_state = CharacterState.RUN
		
	var direction = Input.get_axis("move2_left", "move2_right")
	if direction < 0 && animated_sprite.scale.x > 0:
		animated_sprite.scale.x = -animated_sprite.scale.x
	if direction > 0 && animated_sprite.scale.x < 0:
		animated_sprite.scale.x = -animated_sprite.scale.x
	
	velocity.x = move_direction * movement_speed  
	move_and_slide()

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	#animated_sprite.play("run")  
	if is_on_floor():
		animated_sprite.play("run")  
	else:
		animated_sprite.play("jump")  
