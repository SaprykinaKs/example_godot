extends CharacterBody2D

# Параметры движения
var movement_speed = 50  # Постоянная скорость движения вправо
var jump_force = -200  # Сила прыжка

# Гравитация
const GRAVITY = 300  # Гравитация

# Состояние персонажа
enum CharacterState {
	IDLE,
	RUN,
	#JUMP
}

var character_state = CharacterState.RUN

# Функция для обработки физики
func _physics_process(delta):
	# Постоянное движение вправо
	velocity.x = movement_speed

	# Обработка прыжка
	if is_on_floor() and Input.is_action_just_pressed("jump_space"):
		apply_jump_impulse()

	# Применение гравитации
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Движение и столкновения
	move_and_slide()

	# Управление анимациями
	update_animation()

# Применение прыжка
func apply_jump_impulse():
	velocity.y = jump_force  # Устанавливаем вертикальную скорость
	#character_state = CharacterState.JUMP

# Управление анимациями
func update_animation():
	#if not is_on_floor():
		#character_state = CharacterState.JUMP
		#$AnimatedSprite2D.play("jump")
	#elif velocity.x != 0:
	if is_on_floor() && velocity.x != 0:
		character_state = CharacterState.RUN
		$AnimatedSprite2D.play("run")
	else:
		character_state = CharacterState.IDLE
		$AnimatedSprite2D.play("idle")
