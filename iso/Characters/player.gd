extends CharacterBody2D

# Связываем анимации с направлениями
const ANIM_IDLE_RIGHT = "idle_right"
const ANIM_IDLE_LEFT = "idle_left"
const ANIM_IDLE_FORWARD = "idle_forward"
const ANIM_IDLE_BACK = "idle_back"
const ANIM_MOVE_RIGHT = "move_right"
const ANIM_MOVE_LEFT = "move_left"
const ANIM_MOVE_FORWARD = "move_forward"
const ANIM_MOVE_BACK = "move_back"
const ANIM_AX_RIGHT = "ax_right"
const ANIM_AX_LEFT = "ax_left"
const ANIM_AX_FORWARD = "ax_forward"
const ANIM_AX_BACK = "ax_back"
const ANIM_WATER_RIGHT = "water_right"
const ANIM_WATER_LEFT = "water_left"
const ANIM_WATER_FORWARD = "water_forward"
const ANIM_WATER_BACK = "water_back"

# Скорость персонажа
const SPEED = 200
# Переменная для хранения текущего направления движения
var current_animation = ANIM_IDLE_FORWARD

func _ready():
	# Запускаем анимацию "idle" при запуске
	$AnimatedSprite2D.play(current_animation)

func _process(delta):
	# Обрабатываем движение персонажа
	var motion = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		motion.x += 1
	if Input.is_action_pressed("move_left"):
		motion.x -= 1
	if Input.is_action_pressed("move_back"):
		motion.y -= 1
	if Input.is_action_pressed("move_forward"):
		motion.y += 1
		
	# Нормализуем вектор движения, чтобы персонаж не двигался быстрее по диагонали
	motion = motion.normalized() * SPEED
	velocity = motion

	# Обновляем анимацию в зависимости от направления движения
	update_animation(motion)
	
	# Перемещаем персонажа с учетом коллизий
	move_and_slide()

func update_animation(motion: Vector2):
	if motion == Vector2.ZERO:
		if Input.is_action_pressed("ax"): 
			if current_animation == ANIM_IDLE_RIGHT:
				set_animation(ANIM_AX_RIGHT)
			elif current_animation == ANIM_IDLE_LEFT:
				set_animation(ANIM_AX_LEFT)
			elif current_animation == ANIM_IDLE_FORWARD:
				set_animation(ANIM_AX_FORWARD)	
			elif current_animation == ANIM_IDLE_BACK:
				set_animation(ANIM_AX_BACK)
		if Input.is_action_pressed("water"): 
			if current_animation == ANIM_IDLE_RIGHT:
				set_animation(ANIM_WATER_RIGHT)
			elif current_animation == ANIM_IDLE_LEFT:
				set_animation(ANIM_WATER_LEFT)
			elif current_animation == ANIM_IDLE_FORWARD:
				set_animation(ANIM_WATER_FORWARD)	
			elif current_animation == ANIM_IDLE_BACK:
				set_animation(ANIM_WATER_BACK)
		elif current_animation == ANIM_MOVE_RIGHT:
			set_animation(ANIM_IDLE_RIGHT)
		elif current_animation == ANIM_MOVE_LEFT:
			set_animation(ANIM_IDLE_LEFT)
		elif current_animation == ANIM_MOVE_FORWARD:
			set_animation(ANIM_IDLE_FORWARD)
		elif current_animation == ANIM_MOVE_BACK:
			set_animation(ANIM_IDLE_BACK)
	else:
		if motion.x > 0:
			set_animation(ANIM_MOVE_RIGHT)
		elif motion.x < 0:
			set_animation(ANIM_MOVE_LEFT)
		elif motion.y > 0:
			set_animation(ANIM_MOVE_FORWARD)
		elif motion.y < 0:
			set_animation(ANIM_MOVE_BACK)
			
func set_animation(animation: String):
	if $AnimatedSprite2D.get_animation() != animation:
		current_animation = animation
		$AnimatedSprite2D.play(animation)
